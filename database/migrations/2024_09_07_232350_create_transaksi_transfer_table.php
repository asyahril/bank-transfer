<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('transaksi_transfer', function (Blueprint $table) {
            $table->string('id_transaksi', 20)->primary();
            $table->integer('nilai_transfer');
            $table->string('bank_tujuan', 20);
            $table->string('rekening_tujuan', 30);
            $table->string('atasnama_tujuan', 30);
            $table->string('bank_pengirim', 20);
            $table->integer('kode_unik');
            $table->integer('biaya_admin');
            $table->integer('total_transfer');
            $table->string('bank_perantara', 20);
            $table->string('rekening_perantara', 30);
            $table->dateTime('berlaku_hingga');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaksi_transfer');
    }
};
