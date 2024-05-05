<?php

namespace App\Http\Controllers;

use App\Http\Requests\addserviceRequest;
use App\Http\Requests\loginRequest;
use App\Http\Requests\addjobRequest;
use App\Models\services;
use App\Models\job;
use App\Http\Controllers\gets;
use App\Http\Requests\add_course_request;
use App\Http\Requests\add_cv_request;
use App\Http\Requests\add_education_request;
use App\Http\Requests\add_exp_request;
use App\Http\Requests\add_language_request;
use App\Http\Requests\add_media_request;
use App\Http\Requests\add_projects_request;
use App\Http\Requests\add_skill_request;
use App\Http\Requests\add_training_request;
use App\Http\Requests\addalt_serviceRequest;
use App\Http\Requests\delete_all_cv;
use App\Http\Requests\deleteRequest;
use App\Http\Requests\discountRequest;
use App\Http\Requests\edit_alt_service_request;
use App\Http\Requests\edit_cv_request;
use App\Http\Requests\edit_exp_request;
use App\Http\Requests\edit_job_request;
use App\Http\Requests\edit_language_request;
use App\Http\Requests\edit_media_request;
use App\Http\Requests\edit_profile_request;
use App\Http\Requests\edit_project_request;
use App\Http\Requests\edit_service_request;
use App\Http\Requests\edit_skill_request;
use App\Http\Requests\get_all_alt_request;
use App\Http\Requests\get_all_cv;
use App\Http\Requests\get_langs_request;
use App\Http\Requests\get_projects_request;
use App\Http\Requests\get_skills_request;
use App\Http\Requests\get_type_service_request;
use App\Http\Requests\getsectype;
use App\Models\alt_services;
use App\Models\course;
use App\Models\cv;
use App\Models\cv_lang;
use App\Models\education;
use App\Models\experience;
use App\Models\media;
use App\Models\projects;
use App\Models\sec_type;
use App\Models\skills;
use App\Models\token;
use App\Models\training_courses;
use App\Models\User;
use Illuminate\Support\Facades\Validator;

use function PHPUnit\Framework\isEmpty;

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
            'service_sec_type' => 'required',
            'service_img',
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
        $img_data = $request ->service_img;
        $decoded_img = base64_decode($img_data);
        $path = storage_path('images/');
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        $fullpath = $path.''.$request->img_name;
        file_put_contents($fullpath,$decoded_img);
        $service = services::create([ 
        's_name' => $request->service_name,
        's_price' => $request->service_price,
        'num_of_buyers' => 0,
        's_desc' => $request->service_desc,
        's_duration' => $request->service_duration,
        'u_id'=> $user_token->tokenable_id ,
        'st_id'=>gets::sec_service_type_id($request->service_sec_type),
        's_img' => $fullpath,
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
        $validator = Validator::make($request->input('alt_service'), [
            'alt_service'=> [ 
            'a_name' => 'required|string',
            'a_price' => 'required|gte:5000',
            'added_duration'=>'required|string' ]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'gte:5000'=> 'the :attribute field should be minimum 5000',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{$data = $request->alt_service;
            $s_id = $request->s_id;
            foreach ($data as $d){ 
                $alt_service = alt_services::create([ 
                    's_id' => $s_id,
                    'a_name' => $d['a_name'],
                    'a_price' => $d['a_price'],
                    'added_duration' => $d['added_duration'],
                ]);
            }
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
    //done
    public function add_course(add_course_request $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'c_name' => 'required|string',
            'c_price' => 'required|integer|gte:50000',
            'c_img' => 'required|string',
            'c_desc' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'integer' => 'the :attribute field should be a number',
            'gte'=> 'the :attribute field should be minimum 50000',
            'string'=> 'the :attribute field should be string',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token = token::where('token','=',$request->token)->first();
        $course = course::create([ 
        'u_id' => $user_token->tokenable_id,
        'c_name' => $request->c_name,
        'c_desc' => $request->c_desc,
        'c_price' => $request->c_price,
        'c_img' => $request->c_img,
        ]);
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done
    public function add_media(add_media_request $request){
        //$data = json_decode($request->media, true);
        $validator = Validator::make($request->media, [
            'media' => [ 
            'c_id' => 'required|integer|exists:courses,c_id',
            'm_name' => 'required|string',
            'm_path' => 'required|string',
            ]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $data = $request->media;
            $c_id = $request->c_id;
            foreach ($data as $d){ 
                $media = media::create([ 
                'c_id' => $c_id,
                'm_name' => $d['m_name'],
                'm_path' => $d['m_path'],
        ]);
    }
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done 
    public function add_cv(add_cv_request $request){
        $validator = Validator::make($request->all(),[
            'token' => 'required',
            'email' => 'required|email:rfc,dns',
            'phone' => 'required|numeric|min:10',
            'career_obj' => 'required|string',
            'address' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'integer' => 'the :attribute field should be a number',
            'min' => 'the :attribute field should be minimun 10 digits',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token = token::where('token','=',$request->token)->first();
        $cv = cv::create([ 
        'u_id' =>$user_token->tokenable_id,
        'email' => $request->email,
        'address' => $request->address,
        'phone'=>$request->phone,
        'career_obj'=>$request->career_obj,
        ]);
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done 
    public function add_skills(add_skill_request $request){
        $validator = Validator::make($request->skills, [
            'skills'=>[ 
            's_name' => 'required|string',
            's_level' => 'required|string',
            'years_of_exp' => 'required|integer',]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'integer'=> 'the :attribute field should be integer',
            'exists'=> 'the :attribute field should be existed',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->skills;
            foreach ($data as $d){ 
                $skill = skills::create([ 
                'cv_id' =>$cv_id,
                's_name' => $d['s_name'],
                's_level' => $d['s_level'],
                'years_of_exp' => $d['years_of_exp'],
                ]);
            }
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done 
    public function add_language(add_language_request $request){
        $validator = Validator::make($request->languages, [
            'languages'=>[ 
            'l_id' => 'required|integer|exists:languages,l_id',]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'integer'=> 'the :attribute field should be integer',
            'exists'=> 'the :attribute field should be existed',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->languages;
            foreach ($data as $d){ 
                $cv_lang = cv_lang::create([ 
                'cv_id' =>$cv_id,
                'l_id' => $d['l_id'],
                ]);
            }
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done
    public function add_projects(add_projects_request $request){
        $validator = Validator::make($request->projects, [
            'projects'=>[
            'p_name' => 'required|string',
            'p_desc' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
            'responsibilities' => 'required|string',]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be existed',
            'date' => 'the :attribute field should be date',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->projects;
            foreach ($data as $d){ 
        $project = projects::create([ 
        'cv_id' =>$cv_id,
        'p_name' => $d['p_name'],
        'p_desc' => $d['p_desc'],
        'start_date' =>date('Y-m-d' , strtotime($d['start_date'])),
        'end_date' =>date('Y-m-d' , strtotime($d['end_date'])),
        'responsibilities' =>$d['responsibilities'],
        ]);}
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
//done
    public function add_exp(add_exp_request $request){
        $validator = Validator::make($request->experiences, [
            'experiences'=>[
            'position' => 'required|string',
            'company' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
            'responsibilities' => 'required|string']
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be existed',
            'date' => 'the :attribute field should be date',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->experiences;
            foreach ($data as $d){ 
                $exp = experience::create([ 
                'cv_id' =>$cv_id,
                'position' => $d['position'],
                'company' => $d['company'],
                'start_date' =>date('Y-m-d' , strtotime($d['start_date'])),
                'end_date' =>date('Y-m-d' , strtotime($d['end_date'])),
                'responsibilities' =>$d['responsibilities'],
                ]);
            }
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done
    public function add_training_courses(add_training_request $request){
        $validator = Validator::make($request->training_courses, [
            'training_courses'=>[
            'course_name' => 'required|string',
            'training_center' => 'required|string',
            'completion_date' => 'required|date',]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'exists'=> 'the :attribute field should be existed',
            'date' => 'the :attribute field should be date',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->training_courses;
            foreach ($data as $d){ 
                $course = training_courses::create([ 
                'cv_id' =>$cv_id,
                'course_name' => $d['course_name'],
                'training_center' => $d['training_center'],
                'completion_date' =>date('Y-m-d' , strtotime($d['completion_date'])),
                ]);}
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done 
    public function add_education(add_education_request $request){
        $validator = Validator::make($request->education, [
            "education"=>[
            'degree' => 'required|string',
            'uni' => 'required|string',
            'field_of_study' => 'required|string',
            'grad_year' => 'required|integer',
            'gba' => 'required|numeric|lte:100|gte:0',]
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'integer'=> 'the :attribute field should be integer',
            'exists'=> 'the :attribute field should be existed',
            'date' => 'the :attribute field should be date',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$request->cv_id;
            $data=$request->education;
            foreach ($data as $d){ 
                $education = education::create([ 
                'cv_id' =>$cv_id,
                'degree' => $d['degree'],
                'uni' => $d['uni'],
                'grad_year' =>$d['grad_year'],
                'field_of_study' =>$d['field_of_study'],
                'gba' =>$d['gba'],
                ]);}
        return response([
            'message'=> 'added successfully'
        ],200);  
    }
    }
    //done
    public function edit_job(edit_job_request $request){
        $validator = Validator::make($request->all(), [
            'j_id' => 'required|exists:jobs,j_id',
            'j_sal' => 'required|integer',
            'j_name'=> 'required|string',
            'j_desc'=> 'required|string',
            'j_req' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=job::where('j_id','=',$request->j_id)->update([
            'j_sal'=>$request->j_sal,
            'j_name'=>$request->j_name,
            'j_desc'=>$request->j_desc,
            'j_req'=>$request->j_req,        
        ]);
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
    //done
    public function edit_media(edit_media_request $request){
        $validator = Validator::make($request->all(), [
            'm_id' => 'required|exists:media,m_id',
            'm_name' => 'required|string',
            'm_path'=> 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=media::where('m_id','=',$request->m_id)->update([
            'm_name'=>$request->m_name,
            'm_path'=>$request->m_path,      
        ]);
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
    //done
    public function edit_service(edit_service_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:services,s_id',
            's_name' => 'required|string',
            's_desc'=> 'required|string',
            's_price'=> 'required|integer',
            's_duration'=> 'required|string',
            's_img'=> 'required|string',
            's_video'=> 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'string' => 'The :attribute field must be string.',
            'integer' => 'The :attribute field must be integer.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=services::where('s_id','=',$request->s_id)->update([
            's_name'=>$request->s_name,
            's_desc'=>$request->s_desc, 
            's_price'=>$request->s_price,
            's_duration'=>$request->s_duration,
            's_img'=>$request->s_img,
            's_video'=>$request->s_video,   
        ]);
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
    //done
    public function edit_cv(edit_cv_request $request){
        $validator = Validator::make($request->all(), [
            'cv_id' => 'required|exists:cv,cv_id',
            'career_obj' => 'required|string',
            'phone'=> 'required|numeric',
            'address'=> 'required|string',
            'email'=> 'required|email:rfc,dns',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'string' => 'The :attribute field must be string.',
            'integer' => 'The :attribute field must be integer.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=cv::where('cv_id','=',$request->cv_id)->update([
            'career_obj'=>$request->career_obj,
            'phone'=>$request->phone, 
            'address'=>$request->address,
            'email'=>$request->email,  
        ]);
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
    //done
    public function delete_job(edit_job_request $request){
        $validator = Validator::make($request->all(), [
            'j_id' => 'required|exists:jobs,j_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=job::where('j_id','=',$request->j_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function delete_service(edit_service_request $request){
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
        $effected_rows=services::where('s_id','=',$request->s_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function delete_media(edit_media_request $request){
        $validator = Validator::make($request->all(), [
            'm_id' => 'required|exists:media,m_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=media::where('m_id','=',$request->m_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function get_job(edit_job_request $request){
        $validator = Validator::make($request->all(), [
            'j_id' => 'required|exists:jobs,j_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $job =job::where('j_id','=',$request->j_id);
        return $job->get(); }
    } 
    //done
    public function get_media(edit_media_request $request){
        $validator = Validator::make($request->all(), [
            'm_id' => 'required|exists:media,m_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $media =media::where('m_id','=',$request->m_id);
        return $media->get(); }
    } 
    //done
    public function get_all_media(edit_media_request $request){
        $validator = Validator::make($request->all(), [
            'c_id' => 'required|exists:media,c_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $media =media::where('c_id','=',$request->c_id);
        return $media->get(); }
    } 
    //done
    public function get_service(edit_service_request $request){
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
        $service =services::where('s_id','=',$request->s_id)->first();
        $image = file_get_contents($service->s_img);
        $base64image = base64_encode($image);
        $service->image = $base64image;
        return $service; }
    } 
    //done
    public function get_all_cv (get_all_cv $request){
        $token = token::where('token','=',$request->token)->first();
        $user_id = $token->tokenable_id;
        $cv = cv::where('u_id','=',$user_id)->first();
        $cv_id = $cv->cv_id;
        $skills=skills::where('cv_id','=',$cv_id)->get();
        $training_courses=training_courses::where('cv_id','=',$cv_id)->get();
        $experience=experience::where('cv_id','=',$cv_id)->get();
        $project=projects::where('cv_id','=',$cv_id)->get();
        $education=education::where('cv_id','=',$cv_id)->get();
        $languages=cv_lang::where('cv_id','=',$cv_id)->get();
        return [
            'cv' => $cv,
            'skills' => $skills,
            'training_courses'=>$training_courses,
            'experience'=>$experience,
            'projects'=>$project,
            'education'=>$education,
            'languages'=>$languages,
        ];
    }
    //done
    public function delete_all_cv (delete_all_cv $request){
        $cv_id = $request->cv_id;
        $cv =cv::where('cv_id','=',$cv_id)->delete();
        $skills=skills::where('cv_id','=',$cv_id)->delete();
        $training_courses=training_courses::where('cv_id','=',$cv_id)->delete();
        $experience=experience::where('cv_id','=',$cv_id)->delete();
        $project=projects::where('cv_id','=',$cv_id)->delete();
        $education=education::where('cv_id','=',$cv_id)->delete();
        $languages=cv_lang::where('cv_id','=',$cv_id)->delete();
        $effected_rows = $cv;
        if ($effected_rows!=0){
            return response([
                'message'=> 'deleted successfully'
            ],200); }
            else {
                return response([
                    'message'=> 'nothing is deleted something went wrong'
                ],402);
            }
    }
    //done
    public function edit_alt_service(edit_alt_service_request $request){
        $validator = Validator::make($request->all(), [
            'a_id' => 'required|exists:alt_services,a_id',
            'a_price' => 'required|integer',
            'a_name'=> 'required|string',
            'added_duration'=> 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=alt_services::where('a_id','=',$request->a_id)->update([
            'a_price'=>$request->a_price,
            'a_name'=>$request->a_name,
            'added_duration'=>$request->added_duration,     
        ]);
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
    //done
    public function edit_skills(edit_skill_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:skills,s_id',
            'years_of_exp' => 'required|integer',
            's_name'=> 'required|string',
            's_level'=> 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=skills::where('s_id','=',$request->s_id)->update([
            's_level'=>$request->s_level,
            's_name'=>$request->s_name,
            'years_of_exp'=>$request->years_of_exp,     
        ]);
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
    //done
    public function edit_language(edit_language_request $request){
        $validator = Validator::make($request->all(), [
            'cvl_id' => 'required|exists:cv_langs,cvl_id',
            'l_id' => 'required|integer',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=cv_lang::where('cvl_id','=',$request->cvl_id)->update([
            'l_id'=>$request->l_id,  
        ]);
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
    //done
    public function edit_projects(edit_project_request $request){
        $validator = Validator::make($request->all(), [
            'p_id' => 'required|exists:projects,p_id',
            'p_name' => 'required|string',
            'p_desc' => 'required|string',
            'responsibilities' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=projects::where('p_id','=',$request->p_id)->update([
            'p_desc'=>$request->p_desc,  
            'p_name'=>$request->p_name,
            'responsibilities'=>$request->responsibilities,
            'start_date'=>date('Y-m-d' , strtotime($request->start_date)),
            'end_date'=>date('Y-m-d' , strtotime($request->end_date)),
        ]);
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
    //done
    public function edit_experience(edit_exp_request $request){
        $validator = Validator::make($request->all(), [
            'exp_id' => 'required|exists:experiences,exp_id',
            'company' => 'required|string',
            'position' => 'required|string',
            'responsibilities' => 'required|string',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'The :attribute field must be integer.',
            'string' => 'The :attribute field must be string.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=experience::where('exp_id','=',$request->exp_id)->update([
            'company'=>$request->company,  
            'position'=>$request->position,
            'responsibilities'=>$request->responsibilities,
            'start_date'=>date('Y-m-d' , strtotime($request->start_date)),
            'end_date'=>date('Y-m-d' , strtotime($request->end_date)),
        ]);
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
    //done
    public function delete_alt_service(edit_alt_service_request $request){
        $validator = Validator::make($request->all(), [
            'a_id' => 'required|exists:alt_services,a_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=alt_services::where('a_id','=',$request->a_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function delete_skill(edit_skill_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:skills,s_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=skills::where('s_id','=',$request->s_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function delete_cv_language(edit_language_request $request){
        $validator = Validator::make($request->all(), [
            'cvl_id' => 'required|exists:cv_langs,cvl_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=cv_lang::where('cvl_id','=',$request->cvl_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function delete_project(edit_project_request $request){
        $validator = Validator::make($request->all(), [
            'p_id' => 'required|exists:projects,p_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $effected_rows=projects::where('p_id','=',$request->p_id)->delete();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully'
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    } 
    }
    //done
    public function get_all_alt_services(get_all_alt_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|exists:alt_services,s_id',/////////////////
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $alt_services =alt_services::where('s_id','=',$request->s_id);
        return $alt_services->get(); }
    } 
    //done
    public function get_skills(get_skills_request $request){
        $validator = Validator::make($request->all(), [
            'cv_id' => 'required|exists:skills,cv_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $skills =skills::where('cv_id','=',$request->cv_id);
        return $skills->get(); }
    } 
    //done
    public function get_languages(get_langs_request $request){
        $validator = Validator::make($request->all(), [
            'cv_id' => 'required|exists:cv_langs,cv_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $langs =cv_lang::where('cv_id','=',$request->cv_id);
        return $langs->get(); }
    } 
    //done
    public function get_projects(get_projects_request $request){
        $validator = Validator::make($request->all(), [
            'cv_id' => 'required|exists:projects,cv_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $projects =projects::where('cv_id','=',$request->cv_id);
        return $projects->get(); }
    } 



}
