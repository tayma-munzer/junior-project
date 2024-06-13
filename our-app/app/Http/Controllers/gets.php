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
use App\Models\course;
use App\Models\courses_type;
use App\Models\job;
use App\Models\languages;
use App\Models\media;
use Illuminate\Queue\Jobs\Job as JobsJob;

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

    static function get_course_types () {
        return courses_type::all();
    }

    static function get_home_page_services(){
        $services = services::take(8)->get();
        $path = storage_path('images\\');
        foreach ($services as $service) {
            $fullpath = $path.''.$service->s_img;
            $image = file_get_contents($fullpath);
            $base64image = base64_encode($image);
            $service->image = $base64image;
        }
        return $services;
    }

    static function get_home_page_jobs(){
        return job::all()->take(8);
    }

    static function get_home_page_courses(){
        return course::all()->take(8);
    }

    static function course_type_id(string $type){
        $type = DB::table('courses_types')->where('ct_type','=',$type)->first();
        return $type->ct_id;
    }
    
    
}
