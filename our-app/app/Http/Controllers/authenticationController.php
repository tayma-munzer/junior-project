<?php

namespace App\Http\Controllers;

use App\Http\Requests\addserviceRequest;
use App\Http\Requests\loginRequest;
use App\Http\Requests\addjobRequest;
use App\Models\services;
use App\Models\job;
use App\Http\Controllers\gets;
use App\Http\Requests\addalt_serviceRequest;
use App\Http\Requests\deleteRequest;
use App\Http\Requests\discountRequest;
use App\Http\Requests\edit_profile_request;
use App\Http\Requests\get_type_service_request;
use App\Http\Requests\getsectype;
use App\Models\alt_services;
use App\Models\sec_type;
use App\Models\token;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

class authenticationController extends Controller
{
    //done
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
        $user = User::where('email','=', $request->email)->first();
        if(empty($user) || !($request->password === $user->password)){
            return response([
                'message'=> 'username or password are wrong'
            ],422);
        }
        else
        $token = $user->createToken('apitoken')->plainTextToken;
        return response([
            'message'=> 'logged in',
            'token'=>$token,
        ],200);
    }
    }
//done
    public function sec_types (getsectype $request){
        $types = sec_type::where('t_id','=',$request->t_id);
        return $types->get() ;
    }

    // static public function getuser_id(string $token){
    //     $user_id = DB::table('personal_access_tokens')->where('token','=',$token);
    //     return $user_id;
    // }

// done 
    public function addservice(addserviceRequest $request){
        $validator = Validator::make($request->all(), [
            'service_name' => 'required|string',
            'service_price' => 'required|gte:50000',
            'service_desc' => 'required|string',
            'service_duration' => 'required|string',
            'service_sec_type' => 'required|exists:secondry_type,sec_type',
            'token'=>'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'gte:50000'=> 'the :attribute field should be minimum 50000',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be exist',
            'integer'=>'the :attribute field should be integer ',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token = token::where('token','=',$request->token)->first();
        $service = services::create([ 
        's_name' => $request->service_name,
        's_price' => $request->service_price,
        'num_of_buyers' => 0,
        's_desc' => $request->service_desc,
        's_duration' => $request->service_duration,
        'u_id'=> $user_token->tokenable_id ,
        'st_id'=>gets::sec_service_type_id($request->service_sec_type),
        's_img' => $request->img_path,
        'status' => 'pinding',
        'discount' => 0,
        ]);
        return response([
            'message'=> 'added successfully'
        ],200);   
    }   
    }
    // done 
    public function addalt_service(addalt_serviceRequest $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:services,s_id',
            'a_name' => 'required|string',
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
// done 
    public function addjob (addjobRequest $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'j_name' => 'required|string',
            'j_desc' => 'required|string',
            'j_sal' => 'required|integer',
            'j_req'=>'required|string',
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
        $user_token = token::where('token','=',$request->token)->first();
        $job = job::create([ 
        'u_id' => $user_token->tokenable_id,
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
// not done yet 
    public function delete_account(deleteRequest $request){
        $request->validated();

        // deleting process 
    }
// done
    public function add_discount(discountRequest $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:services,s_id',
            'discount' => 'required|integer|gt:0|lte:100',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'gt'=> 'the :attribute field should be minimum 0.1',
            'exists'=> 'the :attribute field should be exist',
            'lte'=> 'the :attribute field should be maximum 100',
            'integer' => 'The :attribute field must be integer.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=services::where('s_id','=',$request->s_id)->update(['discount'=>$request->discount]);
        if ($effected_rows!=0){
        return response([
            'message'=> 'updated successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is updated something went wrong'
            ],402);
        }
    } 
    }
// done
    public function delete_discount(discountRequest $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:services,s_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=services::where('s_id','=',$request->s_id)->update(['discount'=>0]);
        if ($effected_rows!=0){
        return response([
            'message'=> 'discount deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    // done
    public function get_type_services(get_type_service_request $request){
        $validator = Validator::make($request->all(), [
            'st_id' => 'required|integer',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            //$services =  services::where('st_id','=',$request->st_id);
            $services=services::all()->where('st_id','=',$request->st_id);
            return response($services,200);
        }
    }
    //done
    public function edit_profile(edit_profile_request $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'age' => 'required|integer|gte:10',
            'u_desc' => 'required|string',
            'u_img' => 'required|string',
            'f_name' => 'required|string',
            'l_name' => 'required|string',
            'email' => 'required|email:rfc,dns',
            'password' => 'required|min:5',
            'username' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'integer' => 'the :attribute field should be a number',
            'min:5'=> 'the :attribute field should be minimum 5 chars',
            'gte'=> 'the :attribute field should be minimum 10',
            'string'=> 'the :attribute field should be string',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $user_token = token::where('token','=',$request->token)->first();
            $effected_rows=User::where('u_id','=',$user_token->tokenable_id)->update(
                ['age'=>$request->age,
                'u_desc'=>$request->u_desc,
                'u_img'=>$request->u_img,
                'f_name'=>$request->f_name,
                'l_name'=>$request->l_name,
                'email'=>$request->email,
                'password'=>$request->password,
                'u_img'=>$request->u_img,
                'username'=>$request->username,
                ]
            );
            if ($effected_rows!=0){
            return response([
                'message'=> 'edit profile successfully'
            ],200); }
        else {
            return response([
                'message'=> 'nothing is edited something went wrong'
            ],402);
        }
    } 
    }

    


}
