<?php

namespace App\Http\Controllers;

use App\Models\services;
use App\Models\user;
use App\Models\services_type;
use App\Models\sec_type;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\user_id;
use App\Models\common_questions;
use App\Models\job;
use App\Models\languages;
use App\Models\media;

class gets extends Controller
{
    //
    function services (){
        return services::all();
    }
    function users (){
        return User::all();
    }
    function sec_types() {
        return sec_type::all() ;
    }
    function first_types(){
        return services_type::all();
    }
    function languages(){
        return languages::all();
    }
    function common_questions(){
        return common_questions::all();
    }
    function user_role(int $u_id){
        $roles = DB::table('user_roles')->where('u_id','=',$u_id);
        return $roles->get('r_id') ;
    }
    
    static function user_id (string $email){
        $user = DB::table('user')->where('email','=', $email)->first();
        $user_id = $user->u_id;
        return $user_id;
    }
    // takes the language and return the language id 
    static function lang_id (string $language){
        $lang = DB::table('languages')->where('language','=',$language)->first();
        $lang_id = $lang->l_id;
        return $lang_id;
    }
    static function user_data (int $u_id){
        $user_data = DB::table('user')->where('u_id','=',$u_id);
        // adding the peservation process
        return $user_data ;
    }
    static function sec_service_type_id(string $secondry_type){
        $type = DB::table('secondry_type')->where('sec_type','=',$secondry_type)->first();
        return $type->st_id;
    }

    function get_all_jobs(){
        $jobs = job::all();
        return $jobs;
    }

    static function courses(string  $courses_type){
        $type = DB::table('courses_type')->where('ct_type','=',$courses_type)->first();
        return $type->ct_id;
    }

    function get_all_media(){
        $media = media::all();
        return $media;
    }

    
}
