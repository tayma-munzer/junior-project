<?php

namespace App\Http\Controllers;

use App\Http\Requests\addserviceRequest;
use App\Http\Requests\loginRequest;
use App\Http\Requests\addjobRequest;
use Illuminate\Support\Facades\DB;
use App\Models\services;
use App\Models\job;
use App\Http\Controllers\gets;
use App\Http\Requests\addalt_serviceRequest;
use App\Http\Requests\deleteRequest;
use App\Http\Requests\discountRequest;
use App\Http\Requests\getsectype;
use App\Models\alt_services;
use Illuminate\Support\Facades\Validator;


class authenticationController extends Controller
{
    //
    public function login(loginRequest $request) {

        $validator = Validator::make($request->all(), [
            'email' => 'required|email:rfc,dns',
            'password' => 'required|min:5',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'min:5'=> 'the :attribute field should be minimum 5 chars'
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user = DB::table('user')->where('email','=', $request->email)->first();
        if(empty($user) || !($request->password === $user->password)){
            return response([
                'message'=> 'username or password are wrong'
            ],422);
        }
        else 
        return response([
            'message'=> 'logged in',
            //'token'=>$user->createToken("API TOKEN")->plainTextToken
        ],200);
        
    }
        
    }
    public function sec_types (getsectype $request){
        $types = DB::table('secondry_type')->where('t_id','=',$request->t_id);
        return $types->get() ;
    }

    public function addservice(addserviceRequest $request){
        $validator = Validator::make($request->all(), [
            'service_name' => 'required|string',
            'service_price' => 'required|gte:50000',
            'service_desc' => 'required|string',
            'service_duration' => 'required|string',
            'service_sec_type' => 'required|exists:secondry_type,sec_type',
            'email'=>'required|email:rfc,dns|exists:user,email'
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'gte:50000'=> 'the :attribute field should be minimum 50000',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $service = services::create([ 
        's_name' => $request->service_name,
        's_price' => $request->service_price,
        'num_of_buyers' => 0,
        's_desc' => $request->service_desc,
        's_duration' => $request->service_duration,
        'u_id'=>gets::user_id($request->email),
        't_id'=>gets::sec_service_type_id($request->service_sec_type),
        ]);
        return response([
            'message'=> 'added successfully'
        ],200);   
    }   
    }
    public function addalt_service(addalt_serviceRequest $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:services,s_id',
            'a-name' => 'required|string',
            'a_price' => 'required|gte:5000',
            'added_duration'=>'required|string'
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'gte:5000'=> 'the :attribute field should be minimum 5000',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $alt_service = alt_services::create([ 
        's_id' => $request->s_id,
        'a_name' => $request->a_name,
        'a_price' => $request->a_price,
        'added_duration' => $request->added_duration,
        ]);
        return response([
            'message'=> 'added successfully'
        ],200); 
    } 

    }
    public function addjob (addjobRequest $request){
        $validator = Validator::make($request->all(), [
            'u_id' => 'required|exists:user,u_id',
            'j-name' => 'required|string',
            'j_desc' => 'required|string',
            'j_sal' => 'required|integer',
            'j_req'=>'required|string'
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $job = job::create([ 
        'u_id' => $request->u_id,
        'j_name' => $request->j_name,
        'j_desc' => $request->j_desc,
        'j_sal' => $request->j_sal,
        'j_req' => $request->j_req,
        ]);
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }

    public function delete_account(deleteRequest $request){
        $request->validated();
        // deleting process 
    }
    public function add_discount(discountRequest $request){
        $request->validated();
        // update process to add the discount 
        //DB::table('services')->where('s_id','=',$request->s_id)->update();
    }
    public function delete_discount(discountRequest $request){
        $request->validated();
        // update process to delete the discount 
        //DB::table('services')->where('s_id','=',$request->s_id)->update();
    }

}
