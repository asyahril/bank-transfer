<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\BankController;
use App\Http\Controllers\RekeningAdminController;
use App\Http\Controllers\TransaksiTransferController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::group(['middleware' => 'api', 'prefix' => 'auth'], function ($router) {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::post('update-token', [AuthController::class, 'updateToken']);
    Route::post('logout', [AuthController::class, 'logout']);
    Route::post('me', [AuthController::class, 'me']);
});

Route::group(['middleware' => 'auth:api', 'controller' => TransaksiTransferController::class], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'transfer'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'transfer');
    });
});

Route::group(['middleware' => 'auth:api', 'controller' => BankController::class], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'bank'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'insert');
        Route::put('/{id}', 'update');
        Route::delete('/{id}', 'delete');
    });
});

Route::group(['middleware' => 'auth:api', 'controller' => RekeningAdminController::class], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'rekening-admin'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'insert');
        Route::put('/{id}', 'update');
        Route::delete('/{id}', 'delete');
    });
});