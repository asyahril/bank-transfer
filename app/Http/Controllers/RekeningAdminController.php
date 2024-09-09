<?php

namespace App\Http\Controllers;

use App\Models\RekeningAdmin;
use Illuminate\Http\Request;
use Validator;

class RekeningAdminController extends Controller
{
    public function getAll(Request $request)
    {
        $data = RekeningAdmin::all();

        return $data;
    }

    public function insert(Request $request)
    {
        $ok = true;
        $input = $request->all();
        $result = [];

        // Validasi data
        $result = $this->validateInput($input, $ok);

        if ($ok) {
            if (!RekeningAdmin::insert($input)) {
                $ok = false;
            }

            $result['message'] = $ok ? 'Data berhasil ditambahkan!' : 'Data gagal ditambahkan!';
        }

        $result['success'] = $ok;

        return $result;
    }

    public function update(Request $request, $id)
    {
        $ok = true;
        $input = $request->all();
        $result = [];

        // Validasi data
        $result = $this->validateInput($input, $ok);

        if ($ok) {
            $ok = RekeningAdmin::where(RekeningAdmin::primaryKey(), $id)->update($input) > 0;

            $result['message'] = $ok ? 'Data berhasil diubah!' : 'Data gagal diubah!';
        }

        $result['success'] = $ok;

        return $result;
    }

    public function delete(Request $request, $id)
    {
        $result = [];
        $ok = RekeningAdmin::where(RekeningAdmin::primaryKey(), $id)->delete() > 0;

        $result['message'] = $ok ? 'Data berhasil dihapus!' : 'Data gagal dihapus!';
        $result['success'] = $ok;

        return $result;
    }

    private function validateInput($input, &$ok)
    {
        $result = [];
        $validator = Validator::make($input, [
            'bank' => 'required|max:20',
            'rekening' => 'required|max:30',
            'atasnama' => 'required|max:30'
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
}
