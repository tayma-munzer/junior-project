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
Route::post('/add_course',[authenticationController::class,'add_course']);
Route::post('/add_media',[authenticationController::class,'add_media']);
Route::post('/add_cv',[authenticationController::class,'add_cv']);
Route::post('/add_skills',[authenticationController::class,'add_skills']);
Route::post('/add_language',[authenticationController::class,'add_language']);
Route::post('/add_projects',[authenticationController::class,'add_projects']);
Route::post('/add_exp',[authenticationController::class,'add_exp']);
Route::post('/add_training_courses',[authenticationController::class,'add_training_courses']);
Route::post('/add_education',[authenticationController::class,'add_education']);
Route::post('/edit_job',[authenticationController::class,'edit_job']);
Route::post('/edit_media',[authenticationController::class,'edit_media']);
Route::post('/edit_service',[authenticationController::class,'edit_service']);
Route::post('/edit_cv',[authenticationController::class,'edit_cv']);
Route::post('/delete_job',[authenticationController::class,'delete_job']);
Route::post('/delete_service',[authenticationController::class,'delete_service']);
Route::post('/delete_media',[authenticationController::class,'delete_media']);
Route::get('/get_all_jobs',[gets::class,'get_all_jobs']);
Route::post('/get_job',[authenticationController::class,'get_job']);
Route::post('/get_media',[authenticationController::class,'get_media']);
Route::post('/get_all_media',[authenticationController::class,'get_all_media']);
Route::post('/get_service',[authenticationController::class,'get_service']);

