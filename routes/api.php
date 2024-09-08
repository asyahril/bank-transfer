<?php

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
    Route::post('register', 'AuthController@register');
    Route::post('login', 'AuthController@login');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::post('me', 'AuthController@me');
});

Route::group(['middleware' => 'auth:api', 'controller' => 'TransaksiTransferController'], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'transfer'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'transfer');
    });
});

Route::group(['middleware' => 'auth:api', 'controller' => 'BankController'], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'bank'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'insert');
        Route::put('/{id}', 'update');
        Route::delete('/{id}', 'delete');
    });
});

Route::group(['middleware' => 'auth:api', 'controller' => 'RekeningAdminController'], function() {
    Route::group(['middleware' => 'auth:api', 'prefix' => 'rekening-admin'], function() {
        Route::get('/', 'getAll');
        Route::post('/', 'insert');
        Route::put('/{id}', 'update');
        Route::delete('/{id}', 'delete');
    });
});