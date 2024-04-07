<?php

use App\Http\Controllers\authenticationController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
