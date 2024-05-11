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
Route::get('/getlanguages',[gets::class,'languages']);//added
Route::get('/getroles/{u_id}',[gets::class,'user_role']);
Route::post('/addjob',[authenticationController::class,'addjob']); //added
Route::post('/addservice',[authenticationController::class,'addservice']); //added
Route::get('/getsec_types',[gets::class,'sec_types']); // added
Route::post('/get_type_services',[authenticationController::class,'get_type_services']); //added
Route::post('/add_discount',[authenticationController::class,'add_discount']);//added 
Route::post('/edit_discount',[authenticationController::class,'add_discount']);//added
Route::post('/delete_discount',[authenticationController::class,'delete_discount']);//added
Route::post('/edit_profile',[authenticationController::class,'edit_profile']);//added
Route::post('/add_course',[authenticationController::class,'add_course']);//added
Route::post('/add_media',[authenticationController::class,'add_media']);//added
Route::post('/add_cv',[authenticationController::class,'add_cv']);//added
Route::post('/add_skills',[authenticationController::class,'add_skills']);//added
Route::post('/add_language',[authenticationController::class,'add_language']);//added
Route::post('/add_projects',[authenticationController::class,'add_projects']);//added
Route::post('/add_exp',[authenticationController::class,'add_exp']);//added
Route::post('/add_training_courses',[authenticationController::class,'add_training_courses']);//added
Route::post('/add_education',[authenticationController::class,'add_education']);//added
Route::post('/edit_job',[authenticationController::class,'edit_job']);//added
Route::post('/edit_media',[authenticationController::class,'edit_media']);//added
Route::post('/edit_service',[authenticationController::class,'edit_service']);//added
Route::post('/edit_cv',[authenticationController::class,'edit_cv']);//added
Route::post('/delete_job',[authenticationController::class,'delete_job']);//added
Route::post('/delete_service',[authenticationController::class,'delete_service']);//added
Route::post('/delete_media',[authenticationController::class,'delete_media']);//added
Route::get('/get_all_jobs',[gets::class,'get_all_jobs']);//added
Route::post('/get_job',[authenticationController::class,'get_job']);//added
Route::post('/get_media',[authenticationController::class,'get_media']);//added
Route::post('/get_all_media',[authenticationController::class,'get_all_media']);//added
Route::post('/get_service',[authenticationController::class,'get_service']);//added
Route::post('/get_all_cv',[authenticationController::class,'get_all_cv']);//added
Route::post('/delete_all_cv',[authenticationController::class,'delete_all_cv']);//added
Route::post('/get_cv_projects',[authenticationController::class,'get_projects']);//added
Route::post('/get_cv_languages',[authenticationController::class,'get_languages']);//added
Route::post('/get_cv_skills',[authenticationController::class,'get_skills']);//added
Route::post('/get_all_alt_services',[authenticationController::class,'get_all_alt_services']);//added
Route::post('/delete_project',[authenticationController::class,'delete_project']);//added
Route::post('/delete_cv_language',[authenticationController::class,'delete_cv_language']);//added
Route::post('/delete_skill',[authenticationController::class,'delete_skill']);//added
Route::post('/delete_alt_service',[authenticationController::class,'delete_alt_service']);//added
Route::post('/edit_experience',[authenticationController::class,'edit_experience']);//added
Route::post('/edit_projects',[authenticationController::class,'edit_projects']);//added
Route::post('/edit_language',[authenticationController::class,'edit_language']);//added
Route::post('/edit_skills',[authenticationController::class,'edit_skills']);//added
Route::post('/edit_alt_service',[authenticationController::class,'edit_alt_service']);//added
//
Route::post('/delete_exp',[authenticationController::class,'delete_exp'] );
Route::post('/get_exp',[authenticationController::class,'get_exp'] );
Route::post('/edit_course',[authenticationController::class,'edit_course'] );
Route::post('/delete_course',[authenticationController::class,'delete_course'] );
Route::post('/get_course',[authenticationController::class,'get_course'] );
Route::post('/edit_training_courses',[authenticationController::class,'edit_training_courses'] );
Route::post('/delete_training_courses',[authenticationController::class,'delete_training_courses'] );
Route::post('/get_training_courses',[authenticationController::class,'get_training_courses'] );
Route::post('/edit_education',[authenticationController::class,'edit_education'] );
Route::post('/delete_education',[authenticationController::class,'delete_education'] );
Route::post('/get_education',[authenticationController::class,'get_education'] );
Route::get('/get_course_types',[gets::class,'get_course_types'] );
Route::post('/get_courses_for_type',[authenticationController::class,'get_courses_for_type'] );
Route::get('/get_course_details',[gets::class,'get_course_details'] );
Route::post('/get_course_for_user',[authenticationController::class,'get_course_for_user'] );


Route::post('/get_skill',[authenticationController::class,'get_skill'] );
