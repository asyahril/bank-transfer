<?php

namespace App\Http\Controllers;

use App\Models\RekeningAdmin;
use Illuminate\Http\Request;
use Validator;

class TransaksiTransferController extends Controller
{
    public function transfer(Request $request) {
        $input = $request->all();
        $result = [];
        $ok = true;

        // Validasi input data
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

        // Ambil dan validasi data rekening admin
        $rekeningAdmin = null;

        if ($ok) {
            $rekeningAdmin = RekeningAdmin::where('bank', $input['bank_pengirim'])->first();

            if (!isset($rekeningAdmin)) {
                $ok = false;
                $result['message'] = sprintf('Bank perantara tidak tersedia: %s', $input['bank_pengirim']);
            }
        }

        return $result;
    }
}
