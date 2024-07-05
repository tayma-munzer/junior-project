<?php

use App\Events\ServiceCreated;
use App\Http\Controllers\authenticationController;
use App\Http\Controllers\gets;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\VideoUploadController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/login',[authenticationController::class,'login']);//added
Route::post('/switch_account',[authenticationController::class,'switch_account']);
Route::post('/logout',[authenticationController::class,'logout'])->middleware('auth:sanctum');
Route::post('/delete_account',[authenticationController::class,'delete_account'])->middleware('auth:sanctum');
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
Route::post('/get_course_detils',[authenticationController::class,'get_course_detils'] );
Route::post('/get_course_for_user',[authenticationController::class,'get_course_for_user'] );


Route::post('/get_skill',[authenticationController::class,'get_skill'] );
Route::post('/get_project',[authenticationController::class,'get_project'] );
Route::post('/get_user_jobs',[authenticationController::class,'get_user_jobs'] );
Route::post('/get_cv_lang',[authenticationController::class,'get_cv_lang'] );
Route::post('/get_profile',[authenticationController::class,'get_profile'] );

Route::post('/send-message', [MessageController::class, 'sendMessage']);
Route::get('/get_home_page_services', [gets::class, 'get_home_page_services']);
Route::get('/get_home_page_jobs', [gets::class, 'get_home_page_jobs']);
Route::get('/get_home_page_courses', [gets::class, 'get_home_page_courses']);



Route::post('/upload-chunk', [VideoUploadController::class, 'uploadChunk']);
Route::post('/requestvideo', [VideoUploadController::class, 'sendVideoChunks']);

Route::post('/test_add_media',[authenticationController::class,'test_add_media'] );
Route::post('/test_get_media',[authenticationController::class,'test_get_media'] );

Route::post('/add_course_rating',[authenticationController::class, 'add_course_rating']);
Route::post('/add_job_rating',[authenticationController::class, 'add_job_rating']);
Route::post('/add_service_rating',[authenticationController::class, 'add_service_rating']);
Route::post('/add_training_courses_rating',[authenticationController::class, 'add_training_courses_rating']);

Route::get('/get_all_services',[gets::class, 'services']);
Route::get('/get_all_courses',[gets::class, 'courses']);
Route::get('/get_all_jobs',[gets::class, 'jobs']);


Route::post('/get_user_services',[authenticationController::class,'get_user_services'] );//added
Route::post('/add_service_enrollment',[authenticationController::class,'add_service_enrollment'] );//added
Route::post('/add_course_enrollment',[authenticationController::class,'add_course_enrollment']); //added    
Route::post('/add_not_found_service',[authenticationController::class,'add_not_found_service'] );//added
Route::post('/register',[authenticationController::class,'register'] );//added
Route::get('/get_common_questions',[gets::class,'common_questions'] );//added
Route::post('/delete_work',[authenticationController::class,'delete_work'] );//
Route::post('/add_work',[authenticationController::class,'add_work'] );//
Route::post('/get_works',[authenticationController::class,'get_works'] );//
Route::post('/edit_work',[authenticationController::class,'edit_work'] );//

Route::post('/add_job_complaint', [authenticationController::class, 'add_job_complaint']);
Route::post('/add_service_complaint', [authenticationController::class, 'add_service_complaint']);
Route::post('/add_course_complaint', [authenticationController::class, 'add_course_complaint']);

Route::get('/get_course_ratings/{id}', [authenticationController::class, 'get_course_rating']);
Route::get('/get_training_course_rating/{id}', [authenticationController::class, 'get_training_course_rating']);
Route::get('/get_job_ratings/{id}', [authenticationController::class, 'get_job_rating']);
Route::get('/get_service_ratings/{id}', [authenticationController::class, 'get_service_rating']);

Route::get('get_enrollments_last_7_days', [authenticationController::class, 'get_enrollments_last_7_days']);
Route::post('/is_user_course_enrolled', [authenticationController::class, 'is_user_course_enrolled']);
Route::post('/is_user_service_enrolled', [authenticationController::class, 'is_user_service_enrolled']);
Route::post('/is_user_job_applied', [authenticationController::class, 'is_user_job_applied']);
Route::get('/get_preservations', [gets::class, 'get_preservations']);



Route::controller(\App\Http\Controllers\AdminDashboardController::class)->prefix('/admin')->group(function (){
    Route::get('/get_profiles', 'get_profiles');
    Route::get('/get_complaints', 'get_complaints');
    Route::get('/get_profits', 'get_profits');
    Route::get('/get_service_requests', 'get_service_requests');
    Route::get('/get_courses_count/{id}', 'get_courses_count');
    Route::get('/get_services_count/{id}', 'get_services_count');
    Route::get('/get_jobs_count/{id}', 'get_jobs_count');
    Route::post('/accept_job/{id}', 'accept_job');
    Route::post('/reject_job/{id}', 'reject_job');
    Route::post('/accept_course/{id}', 'accept_course');
    Route::post('/reject_course/{id}', 'reject_course');
    Route::post('/accept_service/{id}', 'accept_service');
    Route::post('/reject_service/{id}', 'reject_service');
    Route::post('/delete_user/{id}', 'delete_user');

    Route::post('/delete_coursee/{id}', 'delete_coursee');
    Route::post('/delete_jobb/{id}', 'delete_jobb');
    Route::post('/delete_servicee/{id}', 'delete_servicee');

    Route::get('/get_service_user/{id}', 'get_service_user');
    Route::get('/get_course_user/{id}', 'get_course_user');
    Route::get('/get_job_user/{id}', 'get_job_user');

    Route::get('/get_courses_requests', 'get_courses_requests');
    Route::get('/get_jobs_requests', 'get_jobs_requests');
    Route::get('/get_user_profile/{id}', 'get_user_profile');
    Route::post('/add_common_question', 'add_common_question');
});



