<?php

namespace App\Http\Controllers;

use App\Models\services;
use App\Models\user;
use App\Models\services_type;
use App\Models\sec_type;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\user_id;
use App\Models\languages;

class gets extends Controller
{
    //
    function services (){
        return services::all();
    }
    function users (){
        return user::all();
    }
    function first_types(){
        return services_type::all();
    }
    function languages(){
        return languages::all();
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
    static function sec_service_type_id(string $secondry_type){
        $type = DB::table('secondry_type')->where('sec_type','=',$secondry_type)->first();
        return $type->st_id;
    }


}
