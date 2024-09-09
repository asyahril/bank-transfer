<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RekeningAdmin extends Model
{
    use HasFactory;
    protected $table = 'rekening_admin';
    protected $primaryKey = 'bank';
    public $incrementing = false;


    public static function primaryKey()
    {
        return (new static())->primaryKey;
    }
}
