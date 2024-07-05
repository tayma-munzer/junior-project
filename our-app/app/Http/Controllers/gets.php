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
use App\Models\preservations;
use App\Models\rates_reviews;
use App\Models\role;
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

    function jobs(){
        return job::all();
    }

    static function get_course_types () {
        return courses_type::all();
    }
    static function get_home_page_services(){
        $minimum_high_rate = 4;
        $top_services = rates_reviews::where('ratable_type','=', 'App\Models\services')
        ->selectRaw('ratable_id, COUNT(CASE WHEN rate >= ? THEN 1 END) as high_rate_count, MAX(rate) as max_rate', [$minimum_high_rate])
                        ->groupBy('ratable_id')
                        ->orderBy('high_rate_count', 'desc')
                        ->orderBy('max_rate', 'desc')
                        ->get();
                        $path = storage_path('images\\');
                        $serviceData = [];
                        foreach ($top_services as $rating) {
                            $service = services::where('s_id', $rating->ratable_id)->first();
                            if ($service) {
                                $fullpath = $path.''.$service->s_img;
                                $image = file_get_contents($fullpath);
                                $base64image = base64_encode($image);
                                $service->image = $base64image;
                                array_push($serviceData, $service);
                            }
                        }
        return $serviceData;
    }

    static function get_home_page_jobs(){
        return job::all()->take(8);
    }

    static function get_home_page_courses(){
        $minimum_high_rate = 4;
        $top_courses = rates_reviews::where('ratable_type','=', 'App\Models\course')
        ->selectRaw('ratable_id, COUNT(CASE WHEN rate >= ? THEN 1 END) as high_rate_count, MAX(rate) as max_rate', [$minimum_high_rate])
                        ->groupBy('ratable_id')
                        ->orderBy('high_rate_count', 'desc')
                        ->orderBy('max_rate', 'desc')
                        ->get();
                        $path = storage_path('images\\');
                        $courseData = [];
                        foreach ($top_courses as $rating) {
                            $course = course::where('c_id', $rating->ratable_id)->first();
                            if ($course) {
                                $fullpath = $path.''.$course->c_img;
                                $image = file_get_contents($fullpath);
                                $base64image = base64_encode($image);
                                $course->image = $base64image;
                                array_push($courseData, $course);
                            }
                        }
        return $courseData;
    }

    static function course_type_id(string $type){
        $type = DB::table('courses_types')->where('ct_type','=',$type)->first();
        return $type->ct_id;
    }

    function courses (){
        return course::all();
    }

    static function preservation_id(string $preservation){
        $preservation = preservations::where('p_name','=',$preservation)->first();
        return $preservation->p_id;
    }

    static function role_id(string $role){
        $role = role::where('role','=',$role)->first();
        return $role->r_id;
    }

    static function get_preservation(string $p_id){
        $preservation = preservations::where('p_id','=',$p_id)->first();
        return $preservation->p_name;
    }
    
    function get_preservations(){
        return preservations::all();
    }
    
}
