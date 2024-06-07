<?php

use App\Http\Controllers\authenticationController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\VideoUploadController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::post('/send-message', [MessageController::class, 'sendMessage']);
Route::post('/upload-chunk', [VideoUploadController::class, 'uploadChunk']);