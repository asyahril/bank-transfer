<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use App\Models\Counter;
use App\Models\RekeningAdmin;
use App\Models\TransaksiTransfer;
use DB;
use Illuminate\Http\Request;
use Validator;

class TransaksiTransferController extends Controller
{
    public function getAll(Request $request)
    {
        $data = TransaksiTransfer::all();

        return $data;
    }

    public function transfer(Request $request)
    {
        $ok = true;
        $input = $request->all();
        $result = [];

        // Validasi input data
        $result = $this->validateInput($input, $ok);

        // Ambil dan validasi data rekening admin
        $rekeningAdmin = null;

        if ($ok) {
            $rekeningAdmin = RekeningAdmin::where('bank', $input['bank_pengirim'])->first()?->toArray();

            if (!isset($rekeningAdmin)) {
                $ok = false;
                $result['message'] = sprintf('Rekening perantara tidak tersedia: %s', $input['bank_pengirim']);
            }
        }

        // Validasi data bank dan ambil biaya admin
        $adminCost = 0;

        if ($ok && $input['bank_pengirim'] != $input['bank_tujuan']) {
            $bank = Bank::where('bank', $input['bank_pengirim'])->first()?->toArray();

            if (!isset($bank)) {
                $ok = false;
                $result['message'] = sprintf('Bank tidak tersedia: %s', $input['bank_pengirim']);
            } else {
                $adminCost = $bank['biaya_admin'];
            }
        }

        // Tambah data transaksi transfer
        if ($ok) {
            DB::beginTransaction();

            $input['id_transaksi'] = $this->generateId();
            $input['kode_unik'] = $this->generateUniqueCode();
            $input['biaya_admin'] = $adminCost;
            $input['total_transfer'] = $input['nilai_transfer'] + $input['kode_unik'] + $input['biaya_admin'];
            $input['bank_perantara'] = $rekeningAdmin['bank'];
            $input['rekening_perantara'] = $rekeningAdmin['rekening'];
            $input['berlaku_hingga'] = date('Y-m-d H:i:s', strtotime('+3 day', time()));

            if (!TransaksiTransfer::insert($input)) {
                $ok = false;
                $result['message'] = 'Transaksi transfer gagal ditambahkan!';
            }

            if ($ok) {
                DB::commit();
                $result = $input;
            } else {
                DB::rollBack();
            }    
        }


        return $result;
    }

    private function validateInput($input, &$ok)
    {
        $result = [];
        $validator = Validator::make($input, [
            'nilai_transfer' => 'required|integer',
            'bank_tujuan' => 'required|max:20',
            'rekening_tujuan' => 'required|max:20',
            'atasnama_tujuan' => 'required|max:30',
            'bank_pengirim' => 'required|max:20'
        ]);

        if ($validator->fails()) {
            $errorList = $validator->errors()->toArray();
            $message = '';

            foreach ($errorList as $field => $value) {
                $message .= sprintf("%s: %s", $field, $value[0]);
            }

            $ok = false;
            $result['message'] = $message;
        }

        return $result;
    }

    private function generateId()
    {
        $prefix = 'TF'.date('ymd');
        $query = Counter::where('prefix', $prefix);
        $nextNumber = 1;

        if ($query->count() > 0) {
            $nextNumber = $query->first()->value + 1;
            $data = [
                'value' => $nextNumber
            ];
            $query->update($data);
        } else {
            $data = [
                'prefix' => $prefix,
                'value' => $nextNumber
            ];
            $query->insert($data);
        }

        return $prefix.str_pad($nextNumber, 5, '0', STR_PAD_LEFT);
    }

    private function generateUniqueCode()
    {
        $code = rand(100, 999);
        $codeIsExist = TransaksiTransfer::where('kode_unik', $code)
            ->where('berlaku_hingga', '>=', date('Y-m-d H:i:s'))->count() > 0;

        if ($codeIsExist) {
            return $this->generateUniqueCode();
        } else {
            return $code;
        }
    }
}
