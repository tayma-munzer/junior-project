<?php

use App\Http\Controllers\authenticationController;
use App\Http\Controllers\gets;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/login',[authenticationController::class,'login']);
Route::get('/getservices',[gets::class,'services']);
Route::post('/getfirst_type',[gets::class,'first_types']);
Route::post('/getsec_type',[authenticationController::class,'sec_types']);
Route::post('/addalt_service',[authenticationController::class,'addalt_service']);
Route::get('/getlanguages',[gets::class,'languages']);
Route::get('/getroles/{u_id}',[gets::class,'user_role']);
Route::post('/addjob',[authenticationController::class,'addjob']);
Route::post('/addservice',[authenticationController::class,'addservice']);
Route::get('/getsec_types',[gets::class,'sec_types']);