<?php

use App\Http\Controllers\authenticationController;
use App\Http\Controllers\gets;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/login',[authenticationController::class,'login']);//added
Route::get('/getservices',[gets::class,'services']);
Route::get('/getfirst_type',[gets::class,'first_types']);//added
Route::post('/getsec_type',[authenticationController::class,'sec_types']);//added
Route::post('/addalt_service',[authenticationController::class,'addalt_service']); //added
Route::get('/getlanguages',[gets::class,'languages']);
Route::get('/getroles/{u_id}',[gets::class,'user_role']);
Route::post('/addjob',[authenticationController::class,'addjob']); //added
Route::post('/addservice',[authenticationController::class,'addservice']); //added
Route::get('/getsec_types',[gets::class,'sec_types']); // added
Route::post('/get_type_services',[authenticationController::class,'get_type_services']); //added
Route::post('/add_discount',[authenticationController::class,'add_discount']);//added 
Route::post('/edit_discount',[authenticationController::class,'add_discount']);//added
Route::post('/delete_discount',[authenticationController::class,'delete_discount']);//added
Route::post('/edit_profile',[authenticationController::class,'edit_profile']);//added
