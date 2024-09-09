<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransaksiTransfer extends Model
{
    use HasFactory;
    protected $table = 'transaksi_transfer';
    protected $primaryKey = 'id_transaksi';
    public $incrementing = false;

    public static function primaryKey()
    {
        return (new static())->primaryKey;
    }
}
