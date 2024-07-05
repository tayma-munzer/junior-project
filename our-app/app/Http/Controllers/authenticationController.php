<?php

namespace App\Http\Controllers;
use App\Models\Complaint;
use App\Models\rates_reviews;
use App\Events\{CourseCreated, JobCreated, ServiceCreated, StringEvent};
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
use App\Http\Requests\add_work_request;
use App\Http\Requests\addalt_serviceRequest;
use App\Http\Requests\course_enrollment_request;
use App\Http\Requests\delete_all_cv;
use App\Http\Requests\delete_work_request;
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
use App\Http\Requests\edit_course_request;
use App\Http\Requests\edit_cv_education_request;
use APP\Http\Requests\edit_training_courses;
use APP\Http\Requests\edit_education_request;
use App\Http\Requests\edit_training_course_request;
use App\Http\Requests\get_all_alt_request;
use App\Http\Requests\get_all_cv;
use App\Http\Requests\get_by_token;
use App\Http\Requests\get_langs_request;
use App\Http\Requests\get_projects_request;
use App\Http\Requests\get_skills_request;
use App\Http\Requests\get_course_detils;
use App\Http\Requests\get_type_service_request;
use App\Http\Requests\getsectype;
use App\Http\Requests\get_courses_type_request;
use App\Http\Requests\get_course_for_user;
use App\Http\Requests\get_project_request;
use App\Http\Requests\get_skill;
use App\Http\Requests\get_works_request;
use App\Http\Requests\is_user_course_enrolled;
use App\Http\Requests\is_user_job_applied;
use App\Http\Requests\is_user_service_enrolled;
use App\Http\Requests\job_application_request;
use App\Http\Requests\not_found_services_request;
use App\Http\Requests\register_request;
use App\Http\Requests\service_enrollment_request;
use App\Models\alt_services;
use App\Models\course;
use App\Models\course_enrollment;
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
use App\Models\courses_type;
use App\Models\job_application;
use App\Models\job_skills;
use App\Models\not_found_services;
use App\Models\role;
use App\Models\service_enrollment;
use Illuminate\Support\Facades\Auth;
use App\Models\user_role;
use App\Models\works_gallery;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Validator;
use Laravel\Sanctum\PersonalAccessToken;
use Illuminate\Http\Request;

use function PHPUnit\Framework\isEmpty;

class authenticationController extends Controller
{
    //done
    public function login(loginRequest $request) {
        $validator = Validator::make($request->all(), [
            'email' => 'required',//|email:rfc,dns
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
        $token = $user->createToken('token')->plainTextToken;
        $roles= DB::table('user_roles')->join('roles','roles.r_id','=','user_roles.r_id')->select('role')->where('u_id','=',$user->u_id)->get();//cv_lang::where('cv_id','=',$cv_id)->get();
        return response([
            'message'=> 'logged in',
            'token'=>$token,
            'roles'=>$roles,
        ],200);
    }
    }
    // public function switch_account(loginRequest $request)
    // {
    //     Auth::user()->tokens()->delete();
    //     return $this->login($request);
    // }

    // public function logout(): \Illuminate\Http\JsonResponse
    // {
    //     Auth::user()->tokens()->delete();
    //     return response()->json(['message'=>'logged out successfully']);
    // }

    public function delete_account(): \Illuminate\Http\JsonResponse
    {
        $id = Auth::id();
        User::find($id)->delete();
        return response()->json(['message'=>'account deleted successfully']);
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
            'service_img_data' => 'required',
            'img_name' => 'required',
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

        $user_token = PersonalAccessToken::findToken($request->token);
        $img_data = $request ->service_img_data;
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
        's_img' => $request->img_name,
        'status' => 'pinding',
        'discount' => 0,
        ]);
            event(new ServiceCreated($service->s_name));
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
        $request = json_decode($request->getContent(), true);
        $validator = Validator::make($request, [
            'token' => 'required',
            'j_title' => 'required|string',
            'j_desc' => 'required|string',
            'j_req'=>'required|string',
            'j_min_sal' => 'required|integer',
            'j_max_sal' => 'required|integer',
            'j_min_age' => 'required|integer',
            'j_max_age' => 'required|integer',
            'education'=>'required|string',
            'category'=>'required|string',
            'num_of_exp_years' => 'required|integer',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token =PersonalAccessToken::findToken($request['token']);
        $job = job::create([
        'u_id' => $user_token->tokenable_id,
        'j_title' => $request['j_title'],
        'j_desc' => $request['j_desc'],
        'j_req' => $request['j_req'],
        'j_min_sal' => $request['j_min_sal'],
        'j_max_sal' => $request['j_max_sal'],
        'j_min_age' => $request['j_min_age'],
        'j_max_age' => $request['j_max_age'],
        'education' => $request['education'],
        'jt_id'=>gets::job_type_id($request['category']),
        'num_of_exp_years' => $request['num_of_exp_years'],
        ]);
        if(!empty($request['skills'])){
            foreach ($request['skills'] as $skill){
                $skill = job_skills::create([
                    'j_id'=>$job->j_id,
                    'skill'=>$skill['s_name'],
                ]);
            }
        }
        event(new JobCreated($job->j_name,"ll"));
        return response([
            'message'=> 'added successfully',
            'j_id' =>$job->j_id
        ],200);
    }
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
            $path = storage_path('images\\');
            foreach ($services as $service) {
                $fullpath = $path.''.$service->s_img;
                $image = file_get_contents($fullpath);
                $base64image = base64_encode($image);
                $service->image = $base64image;
            }
            return response($services,200);
        }
    }
    //done
    public function edit_profile(edit_profile_request $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'age' => 'required|integer|gte:10',
            'u_desc' => 'required|string',
            'u_img_data' => 'required',
            'u_img_name' => 'required',
            'f_name' => 'required|string',
            'l_name' => 'required|string',
            'email' => 'required',//|email:rfc,dns
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
            $user_token = PersonalAccessToken::findToken($request->token);
            $user = User::where('u_id','=',$user_token->tokenable_id)->first();
            $user_image= $user->u_img;
            $path = storage_path('images\\');
            $fullpath = $path.''.$user_image;
            File::delete($fullpath);
            $img_data = $request ->u_img_data;
            $decoded_img = base64_decode($img_data);
            $path = storage_path('images/');
            if (!file_exists($path)) {
                mkdir($path, 0777, true);
            }
            $fullpath = $path.''.$request->u_img_name;
            file_put_contents($fullpath,$decoded_img);
            $effected_rows=User::where('u_id','=',$user_token->tokenable_id)->update(
                ['age'=>$request->age,
                'u_desc'=>$request->u_desc,
                'f_name'=>$request->f_name,
                'l_name'=>$request->l_name,
                'email'=>$request->email,
                'password'=>$request->password,
                'u_img'=>$request->u_img_name,
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
            'c_img_data'=>'required|string',
            'c_desc' => 'required|string',
            'c_duration'=>'required|string',
            'pre_requisite' =>'required|string',
            'num_of_free_videos'=>'required|integer',
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
        $user_token = PersonalAccessToken::findToken($request->token);
        $img_data = $request ->c_img_data;
        $decoded_img = base64_decode($img_data);
        $path = storage_path('images/');
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        $fullpath = $path.''.$request->c_img;
        file_put_contents($fullpath,$decoded_img);
        $course = course::create([
        'u_id' => $user_token->tokenable_id,
        'c_name' => $request->c_name,
        'c_desc' => $request->c_desc,
        'c_price' => $request->c_price,
        'c_img' => $request->c_img,
        'c_duration'=>$request->c_duration,
        'pre_requisite' =>$request->pre_requisite,
        'num_of_free_videos'=>$request->num_of_free_videos,
        'ct_id'=>gets::course_type_id($request->category),
        ]);
        //event(new CourseCreated($course->c_name));
        return response([
            'message'=> 'added successfully',
            'course_id'=>$course->id,
        ],200);
    }
    }
    //not done
    public function add_media(add_media_request $request){
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'c_id'=>'required|integer',
            'medias' => 'required',
            'medias.*.m_title' => 'required|string',
            'medias.*.m_desc' => 'required|string',
            'medias.*.m_name' => 'required|string'
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $data = $request->medias;
            $c_id = $request->c_id;
            foreach ($data as $d){
                $media = media::create([
                'c_id' => $c_id,
                'm_name' => $d['m_name'],
                'm_title' => $d['m_title'],
                'm_desc' => $d['m_desc'],
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
            'email' => 'required',//|email:rfc,dns
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
        $user_token = PersonalAccessToken::findToken($request->token);
        $cv = cv::create([
        'u_id' =>$user_token->tokenable_id,
        'email' => $request->email,
        'address' => $request->address,
        'phone'=>$request->phone,
        'career_obj'=>$request->career_obj,
        ]);
        return response([
            'message'=> 'added successfully',
            'cv_id'=>$cv->id,
        ],200);
    }
    }
    //done
    public function add_skills(add_skill_request $request){
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'cv_id'=>'required',
            'skills' => 'required|array',
            'skills.*.s_name' => 'required|string',
            'skills.*.s_level' => 'required|string',
            'skills.*.years_of_exp' => 'required|integer'
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
            $cv_id= $requestData ['cv_id'];
            $skills = $requestData['skills'];
            foreach ($skills as $d){
                $skill = skills::create([
                'cv_id' =>$cv_id,
                's_name' => $d['s_name'],
                's_level' => $d['s_level'],
                'years_of_exp' => $d['years_of_exp'],
                ]);
            }
        return response([
            'message'=> 'added successfully'
        ],200);  }
    }
    //done
    public function add_language(add_language_request $request){
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'cv_id'=>'required',
            'languages'=>'required|array',
            'languages.*.l_id' => 'required|integer|exists:languages,l_id',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'integer'=> 'the :attribute field should be integer',
            'exists'=> 'the :attribute field should be existed',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $cv_id=$requestData['cv_id'];
            $data=$requestData['languages'];
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
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'cv_id'=>'required|integer',
            'projects'=>'required|array',
            'projetcs.*.p_name' => 'required|string',
            'projetcs.*.p_desc' => 'required|string',
            'projetcs.*.start_date' => 'required|date',
            'projetcs.*.end_date' => 'required|date',
            'projetcs.*.responsibilities' => 'required|string',
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
            $cv_id=$requestData['cv_id'];
            $data=$requestData['projects'];
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
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'cv_id'=>'required|integer',
            'experiences'=>'required|array',
            'experiences.*.position' => 'required|string',
            'experiences.*.company' => 'required|string',
            'experiences.*.start_date' => 'required|date',
            'experiences.*.end_date' => 'required|date',
            'experiences.*.responsibilities' => 'required|string'
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
            $cv_id=$requestData['cv_id'];
            $data=$requestData['experiences'];
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
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'cv_id'=>'required',
            'training_courses'=>'required|array',
            'training_courses.*.course_name' => 'required|string',
            'training_courses.*.training_center' => 'required|string',
            'training_courses.*.completion_date' => 'required|date',
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
            $cv_id=$requestData['cv_id'];
            $data=$requestData['training_courses'];
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
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            "cv_id"=>'required|integer',
            'education'=>'required|array',
            'education.*.degree' => 'required|string',
            'education.*.uni' => 'required|string',
            'education.*.field_of_study' => 'required|string',
            'education.*.grad_year' => 'required|integer',
            'education.*.gba' => 'required|numeric|lte:100|gte:0'
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
            $cv_id=$requestData['cv_id'];
            $data=$requestData['education'];
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
            'j_min_sal' => 'required|integer',
            'j_max_sal' => 'required|integer',
            'j_min_age' => 'required|integer',
            'j_max_age' => 'required|integer',
            'j_title'=> 'required|string',
            'j_desc'=> 'required|string',
            'j_req' => 'required|string',
            'education' => 'required|string',
            'category'=>'required|string',
            'num_of_exp_years' => 'required|integer',
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
            'j_title' => $request->j_title,
            'j_desc' => $request->j_desc,
            'j_req' => $request->j_req,
            'j_min_sal' => $request->j_min_sal,
            'j_max_sal' => $request->j_max_sal,
            'j_min_age' => $request->j_min_age,
            'j_max_age' => $request->j_max_age,
            'education' => $request->education,
            'jt_id'=>gets::job_type_id($request->category),
            'num_of_exp_years' => $request->num_of_exp_years,
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
            'm_title'=> 'required|string',
            'm_desc'=> 'required|string',
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
            'm_title'=>$request->m_title,
            'm_desc'=>$request->m_desc,
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
            's_img_data'=>'required',
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
            $service = services::where('s_id','=',$request->s_id);
            $service_img =$service ->s_img;
            $path = storage_path('images\\');
            $fullpath = $path.''.$service_img;
            File::delete($fullpath);
            $img_data = $request ->s_img_data;
            $decoded_img = base64_decode($img_data);
            $path = storage_path('images/');
            if (!file_exists($path)) {
                mkdir($path, 0777, true);
            }
            $fullpath = $path.''.$request->s_img;
            file_put_contents($fullpath,$decoded_img);
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
                job_skills::where('j_id','=',$request->j_id)->delete();
                $jobs =job::all();
            return response([
                'message'=> 'deleted successfully',
                'jobs'=>$jobs
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
            $service= services::where('s_id','=',$request->s_id);
            $service_img= $service->s_img;
            $path = storage_path('images\\');
            $fullpath = $path.''.$service_img;
            File::delete($fullpath);
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
            $media = media::where('m_id','=',$request->m_id)->first();
            $media_name= $media->m_name;
            $path = storage_path('videos\\');
            $fullpath = $path.''.$media_name;
            File::delete($fullpath);
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
        $job =job::where('j_id','=',$request->j_id)->first();
        $skills = job_skills::where('j_id','=',$request->j_id)->get();
        $job->category = gets::job_type_by_id($job->jt_id);
        return response([
            'job'=> $job,
            'skills'=>$skills,
        ],200);}
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
            'c_id' => 'required',///////////////////////exists:media,c_id
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
        $path = storage_path('images\\');
        $fullpath = $path.''.$service->s_img;
        $image = file_get_contents($fullpath);
        $base64image = base64_encode($image);
        $service->image = $base64image;
        return $service; }
    }
    //done
    public function get_all_cv (get_all_cv $request){
        $token = PersonalAccessToken::findToken($request->token);
        $user_id = $token->tokenable_id;
        $cv = cv::where('u_id','=',$user_id)->first();
        $cv_id = $cv->cv_id;
        $skills=skills::where('cv_id','=',$cv_id)->get();
        $training_courses=training_courses::where('cv_id','=',$cv_id)->get();
        $experience=experience::where('cv_id','=',$cv_id)->get();
        $project=projects::where('cv_id','=',$cv_id)->get();
        $education=education::where('cv_id','=',$cv_id)->get();
        $languages= DB::table('cv_langs')->join('languages','cv_langs.l_id','=','languages.l_id')->select('language','cvl_id')->where('cv_id','=',$cv_id)->get();//cv_lang::where('cv_id','=',$cv_id)->get();
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
        $skills = skills::all();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'skills'=>$skills ,
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
        $cv_id = cv_lang::where('cvl_id','=',$request->cvl_id)->first()->cv_id;
        $effected_rows=cv_lang::where('cvl_id','=',$request->cvl_id)->delete();
        $cv_langs =DB::table('cv_langs')->join('languages','cv_langs.l_id','=','languages.l_id')->select('language','cvl_id')->where('cv_id','=',$cv_id)->get();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'languages'=> $cv_langs,
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
        $projects = projects ::all();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'projects'=>$projects,
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
//
public function delete_exp(edit_exp_request $request){
    $validator = Validator::make($request->all(), [
        'exp_id' =>'required|exists:experiences,exp_id',
    ] , $message =[
        'required'=> 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if($validator->fails()){
        $errors =$validator->errors();
        return response($errors,402);
    }
    else{
        $effected_rows=experience::where('exp_id','=',$request->exp_id)->delete();
        $experiences = experience::all();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'experiences' => $experiences,
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    }
}

//
public function get_exp(edit_exp_request $request) {
    $validator = Validator::make($request->all(), [
        'exp_id' =>'required|exists:experiences,exp_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $experience=experience::where('exp_id','=',$request->exp_id);
    return $experience->first(); }
}
//
public function edit_course(edit_course_request $request){
    $validator = Validator::make($request->all(), [
        'c_id'=>'required|exists:courses,c_id',
        'c_name'=>'required|string',
        'c_desc'=>'required|string',
        'c_price'=>'required|integer|gte:50000',
        'c_img'=>'required|string',
        'c_duration'=>'required|string',
        'pre_requisite' =>'required|string',
        'c_img_data'=>'required',

    ],$messages = [
        'required' => 'The :attribute field is required.',
        'integer' => 'the :attribute field should be a number',
        'gte'=> 'the :attribute field should be minimum 50000',
        'string'=> 'the :attribute field should be string',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $course = course::where('c_id','=',$request->c_id)->first();
        $course_image = $course->c_img;
        $path = storage_path('images\\');
        $fullpath = $path.''.$course_image;
        File::delete($fullpath);
        $img_data = $request ->c_img_data;
        $decoded_img = base64_decode($img_data);
        $path = storage_path('images/');
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        $fullpath = $path.''.$request->c_img;
        file_put_contents($fullpath,$decoded_img);
    $effected_rows=course::where('c_id','=',$request->c_id)->update([
        'c_name'=>$request->c_name,
        'c_desc'=>$request->c_desc,
        'c_price'=>$request->c_price,
        'c_img'=>$request->c_img ,
        'c_duration'=>$request->c_duration,
        'pre_requisite' =>$request->pre_requisite,

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
//
public function delete_course(edit_course_request $request){
    $validator = Validator::make($request->all(), [
        'c_id' =>'required|exists:courses,c_id',
    ] , $message =[
        'required'=> 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if($validator->fails()){
        $errors =$validator->errors();
        return response($errors,402);
    }
    else{
        $effected_rows=course::where('c_id','=',$request->c_id)->delete();
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
//
public function get_course(edit_course_request $request) {
    $validator = Validator::make($request->all(), [
        'c_id' =>'required|exists:courses,c_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $course=course::where('c_id','=',$request->c_id);
    return $course->get();
    }

}
//
public function edit_training_courses(edit_training_course_request $request){
    $validator = Validator::make($request->all(), [
        't_id'=>'required|exists:training_courses,t_id',
        'course_name' => 'required|string',
        'training_center' => 'required|string',
        'completion_date' => 'required|date',
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
    $effected_rows= training_courses::where('t_id','=',$request->t_id)->update([
        'course_name'=>$request->course_name,
        'training_center'=>$request->training_center,
        'completion_date'=>date('Y-m-d' , strtotime($request->completion_date))

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
//
public function delete_training_courses(edit_training_course_request $request){
    $validator = Validator::make($request->all(), [
        't_id' =>'required|exists:training_courses,t_id',
    ] , $message =[
        'required'=> 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if($validator->fails()){
        $errors =$validator->errors();
        return response($errors,402);
    }
    else{
        $effected_rows=training_courses::where('t_id','=',$request->t_id)->delete();
        $courses = training_courses::all();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'courses'=>$courses,
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    }
}
//
public function get_training_courses(edit_training_course_request $request) {
    $validator = Validator::make($request->all(), [
        't_id' =>'required|exists:training_courses,t_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $training_courses=training_courses::where('t_id','=',$request->t_id);
    return $training_courses->first(); }
}
 //
 public function edit_education(edit_cv_education_request $request){
    $validator = Validator::make($request->all(), [
        'e_id'=>'required|exists:education,e_id',
        'degree' => 'required|string',
        'uni' => 'required|string',
        'field_of_study' => 'required|string',
        'grad_year' => 'required|integer',
        'gba' => 'required|numeric|lte:100|gte:0'],
        $messages = [
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
    $effected_rows=education::where('e_id','=',$request->e_id)->update([
        'degree'=>$request->degree,
        'uni'=>$request-> uni,
        'field_of_study'=>$request->field_of_study,
        'grad_year'=>$request->grad_year,
        'gba' =>$request ->gba

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
//
public function delete_education(edit_cv_education_request $request){
    $validator = Validator::make($request->all(), [
        'e_id' =>'required|exists:education,e_id',
    ] , $message =[
        'required'=> 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if($validator->fails()){
        $errors =$validator->errors();
        return response($errors,402);
    }
    else{
        $effected_rows=education::where('e_id','=',$request->e_id)->delete();
        $educations = education::all();
        if ($effected_rows!=0){
        return response([
            'message'=> 'deleted successfully',
            'educations' => $educations,
        ],200); }
        else {
            return response([
                'message'=> 'nothing is deleted something went wrong'
            ],402);
        }
    }
}
//
public function get_education(edit_cv_education_request $request) {
    $validator = Validator::make($request->all(), [
        'e_id' =>'required|exists:education,e_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $education=education::where('e_id','=',$request->e_id);
    return $education->first(); }
}
public function check_job_owner(edit_education_request $request) {
    $validator = Validator::make($request->all(), [
        'e_id' =>'required|exists:education,e_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $education=education::where('e_id','=',$request->e_id);
    return $education->get(); }
}

public function get_user_jobs(get_by_token $request) {
    $validator = Validator::make($request->all(), [
        'token' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $token = PersonalAccessToken::findToken($request->token);
        $user_id = $token->tokenable_id;
        $jobs=job::where('u_id','=',$user_id);
        return $jobs->get(); }
    }
//
public function get_courses_for_type(get_courses_type_request $request){
    $validator = Validator::make($request->all(), [
        'ct_id' => 'required|integer',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'integer' => 'the :attribute field should be a number',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $courses_type=course::where('ct_id','=',$request->ct_id)->get();
        $path = storage_path('images\\');
        foreach ($courses_type as $course) {
            $fullpath = $path.''.$course->c_img;
            $image = file_get_contents($fullpath);
            $base64image = base64_encode($image);
            $course->image = $base64image;
        }
        return $courses_type; }
    }

//
public function get_course_for_user(get_course_for_user $request){
    $validator = Validator::make($request->all(), [
        'token' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $token = PersonalAccessToken::findToken($request->token);
        $user_id = $token->tokenable_id;
    $course=course::where('u_id','=',$user_id);
    return $course->get(); }
}
//
public function get_course_detils(get_course_detils $request){
    $validator = Validator::make($request->all(), [
        'c_id' =>'required|exists:courses,c_id',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $course_detils=course::where('c_id','=',$request->c_id)->first();
    $path = storage_path('images\\');
    $fullpath = $path.''.$course_detils->c_img;
    $image = file_get_contents($fullpath);
    $base64image = base64_encode($image);
    $course_detils->image = $base64image;
    return $course_detils; }
}

public function get_skill(get_skills_request $request){
    $validator = Validator::make($request->all(), [
        's_id' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $skill=skills::where('s_id','=',$request->s_id)->first();
    return $skill; }
}
public function get_project(get_project_request $request){
    $validator = Validator::make($request->all(), [
        'p_id' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
    $skill=projects::where('p_id','=',$request->p_id)->first();
    return $skill; }
}
public function get_cv_lang(get_langs_request $request){
    $validator = Validator::make($request->all(), [
        'cv_id' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $languages= DB::table('cv_langs')->join('languages','cv_langs.l_id','=','languages.l_id')->select('language','cvl_id')->where('cv_id','=',$request->cv_id)->get();
    return ['languages'=> $languages];
    }
}
public function  get_profile(get_by_token $request){
    $validator = Validator::make($request->all(), [
        'token' =>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
        'exists'=> 'the :attribute field should be exist',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $token = PersonalAccessToken::findToken($request->token);
        $personal_info=User::where('u_id','=',$token->tokenable_id)->first();
        $path = storage_path('images\\');
        $fullpath = $path.''.$personal_info->u_img;
        $image = file_get_contents($fullpath);
        $base64image = base64_encode($image);
        $personal_info->image = $base64image;
        return $personal_info; }
}


public function  test_add_media(add_media_request $request){
    $validator = Validator::make($request->all(), [
        'c_id' =>'required',
        'm_name'=>'required',
        'video_name'=>'required',
        'm_data'=>'required',
    ], $messages = [
        'required' => 'The :attribute field is required.',
    ]);
    if ($validator->fails()){
        $errors = $validator->errors();
        return response($errors,402);
    }else{
        $video_data = $request ->m_data;
        $decoded_video = base64_decode($video_data);
        $path = storage_path('videos/');
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        $fullpath = $path.''.$request->video_name;
        file_put_contents($fullpath,$decoded_video);
        $media = media::create([
        'c_id' =>$request->c_id,
        'm_name'=>$request->m_name,
        'm_path'=>$request->video_name,
    ]);
        return response([
            'message'=> 'media add successfully'
        ],200);
    }
}

public function add_course_rating(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'user_id' => ['required', 'exists:user,u_id'],
            'rate' => ['required', 'numeric'],
            'review' => ['required', 'string'],
            'course_id' => ['required', 'exists:courses,c_id'],
        ]);
        if ($validator->fails()) {
            $errors = $validator->errors();
            return response($errors, 402);
        } else {
            rates_reviews::create([
                'user_id' => $request->user_id,
                'rate' => $request->rate,
                'review' => $request->review,
                'ratable_id' => $request->service_id,
                'ratable_type' => course::class
            ]);
            return response([
                'message' => 'added successfully'
            ], 200);
        }
    }

    public function add_service_rating(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'user_id' => ['required', 'exists:user,u_id'],
            'rate' => ['required', 'numeric'],
            'review' => ['required', 'string'],
            'service_id' => ['required', 'exists:services,s_id'],
        ]);
        if ($validator->fails()) {
            $errors = $validator->errors();
            return response($errors, 402);
        } else {
            rates_reviews::create([
                'user_id' => $request->user_id,
                'rate' => $request->rate,
                'review' => $request->review,
                'ratable_id' => $request->service_id,
                'ratable_type' => services::class
            ]);
            return response([
                'message' => 'added successfully'
            ], 200);
        }
    }

    public function add_job_rating(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'user_id' => ['required', 'exists:user,u_id'],
            'rate' => ['required', 'numeric'],
            'review' => ['required', 'string'],
            'job_id' => ['required', 'exists:jobs,j_id'],
        ]);
        if ($validator->fails()) {
            $errors = $validator->errors();
            return response($errors, 402);
        } else {
            rates_reviews::create([
                'user_id' => $request->user_id,
                'rate' => $request->rate,
                'review' => $request->review,
                'ratable_id' => $request->job_id,
                'ratable_type' => job::class
            ]);
            return response([
                'message' => 'added successfully'
            ], 200);
        }
    }

    public function add_training_courses_rating(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'user_id' => ['required', 'exists:user,u_id'],
            'rate' => ['required', 'numeric'],
            'review' => ['required', 'string'],
            'training_courses_id' => ['required', 'exists:training_courses,t_id'],
        ]);
        if ($validator->fails()) {
            $errors = $validator->errors();
            return response($errors, 402);
        } else {
            rates_reviews::create([
                'user_id' => $request->user_id,
                'rate' => $request->rate,
                'review' => $request->review,
                'ratable_id' => $request->course_id,
                'ratable_type' => training_courses::class
            ]);
            return response([
                'message' => 'added successfully'
            ], 200);
        }
    }

    //done without testking
    public function add_job_application (job_application_request $request){
        $validator = Validator::make($request->all(), [
            'j_id' => 'required|integer',
            'token'=>'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $user_token = PersonalAccessToken::findToken($request->token);
            $job = job_application::create([
            'j_id' => $request->j_id,
            'u_id' => $user_token->tokenable_id,
            ]);
            return response([
                'message'=> 'added successfully',
            ],200);
    }
    }

    //done without testking
    public function add_course_enrollment (course_enrollment_request $request){
        $validator = Validator::make($request->all(), [
            'c_id' => 'required|integer',
            'token'=>'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $user_token = PersonalAccessToken::findToken($request->token);
            $course_enrollment = course_enrollment::create([
            'c_id' => $request->c_id,
            'u_id' => $user_token->tokenable_id,
            ]);
            return response([
                'message'=> 'added successfully',
            ],200);
    }
    }

    //done
    public function add_service_enrollment (service_enrollment_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required|integer',
            'token'=>'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $user_token = PersonalAccessToken::findToken($request->token);
            $service_enrollment = service_enrollment::create([
            's_id' => $request->s_id,
            'u_id' => $user_token->tokenable_id,
            ]);
            // $service = services::where('s_id','=',$request->s_id)->first();
            // $num_of_buyers = $service->num_of_buyers;
            // services::where('s_id','=',$request->s_id)->update(['num_of_buyers'=>$num_of_buyers+1]);
            return response([
                'message'=> 'added successfully',
            ],200);
    }
    }

    //done
    public function get_user_services (get_by_token $request){
        $validator = Validator::make($request->all(), [
            'token'=>'required',
        ], $messages = [
            'required' => 'The :attribute field is required',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $user_token = PersonalAccessToken::findToken($request->token);
            $services = services::where('u_id','=',$user_token->tokenable_id);
            return $services->get();
    }
    }

    // done without testing
    public function add_not_found_service (not_found_services_request $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'service_desc' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token =PersonalAccessToken::findToken($request->token);
        $not_found_service = not_found_services::create([
        'u_id' => $user_token->tokenable_id,
        'service_desc' => $request->service_desc,
        ]);
        return response([
            'message'=> 'added successfully',
        ],200);
    }
    }


    // done
    public function register(register_request $request){
        $requestData = json_decode($request->getContent(), true);
        $validator = Validator::make($requestData, [
            'data'=>'required|array',
            'data.f_name' => 'required|string',
            'data.l_name' => 'required|string',
            'data.age' => 'required|integer',
            'data.u_desc' => 'required|string',
            'data.u_img_name' => 'required|string',
            'data.u_img_data' => 'required',
            'data.email' => 'required',
            'data.username'=>'required|string',
            'data.password'=>'required|min:5',
            'data.gender'=>'required|string',
            'data.preservation'=>'required|string',
            'roles'=>'required|array',
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
            $request = $requestData['data'];
        $img_data = $request['u_img_data'];
        $decoded_img = base64_decode($img_data);
        $path = storage_path('images/');
        if (!file_exists($path)) {
            mkdir($path, 0777, true);
        }
        $fullpath = $path.''.$request['u_img_name'];
        file_put_contents($fullpath,$decoded_img);
        $user = User::create([
        'f_name' => $request['f_name'],
        'l_name' => $request['l_name'],
        'age' => $request['age'],
        'u_desc' => $request['u_desc'],
        'email' => $request['email'],
        'username'=> $request['username'] ,
        'password'=>$request['password'],
        'u_img' => $request['u_img_name'],
        'gender' => $request['gender'],
        'p_id'=>gets::preservation_id($request['preservation']),
        ]);
        $user_id = $user->u_id;
        $roles = $requestData['roles'];
        $returned_roles=[];
        foreach ($roles as $role){
            $r_id = gets::role_id($role);
            $returned_roles[]=['role' => $role];
            $role = user_role::create([
            'u_id' =>$user_id,
            'r_id' => $r_id,
            ]);
        }
        $token = $user->createToken('token')->plainTextToken;
        return response([
            'message'=> 'added successfully',
            'token'=>$token,
            'roles'=> $returned_roles,
        ],200);
    }
    }

    //done
    public function delete_work(delete_work_request $request){
        $validator = Validator::make($request->all(), [
            'w_id' => 'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $work = works_gallery::where('w_id','=',$request->w_id)->first();
            $s_id = $work -> s_id ;
            $work_name= $work->w_name;
            $path = storage_path('works\\');
            $fullpath = $path.''.$work_name;
            File::delete($fullpath);
            $effected_rows=works_gallery::where('w_id','=',$request->w_id)->delete();
            if ($effected_rows!=0){
                $works =works_gallery::where('s_id','=',$s_id)->get();
            return response([
                'message'=> 'deleted successfully',
                'works'=>$works,
            ],200); }
            else {
                return response([
                    'message'=> 'nothing is deleted something went wrong'
                ],402);
            }
        }
    }

    //done
    public function add_work(add_work_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required',
            'w_name' => 'required|string',
            'w_desc' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $work = works_gallery::create([
                's_id' => $request->s_id,
                'w_name' => $request->w_name,
                'w_desc' => $request->w_desc,
                ]);
            return response([
                'message'=> 'added successfully',
            ],200);

        }
    }


    //done
    public function get_works(get_works_request $request){
        $validator = Validator::make($request->all(), [
            's_id' => 'required',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'exists'=> 'the :attribute field should be exist',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $media =works_gallery::where('s_id','=',$request->s_id);
        return $media->get(); }
    }

    //done
    public function edit_work(edit_job_request $request){
        $validator = Validator::make($request->all(), [
            'w_id' => 'required',
            'w_desc' => 'required|string',
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
        $effected_rows=works_gallery::where('w_id','=',$request->w_id)->update([
            'w_desc'=>$request->w_desc,
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
    public function add_job_complaint(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'description' => 'required',
            'u_id'=>'required',
            'j_id'=>'required',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            Complaint::create([
                'description' => $request->description,
                'u_id'=>$request->u_id,
                'complainable_id'=>$request->j_id,
                'complainable_type'=> job::class,
            ]);
            return response([
                'message'=> 'complaint added successfully',
            ],200);
        }
    }
    public function add_course_complaint(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'description' => 'required',
            'u_id'=>'required',
            'c_id'=>'required',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            Complaint::create([
                'description' => $request->description,
                'u_id'=>$request->u_id,
                'complainable_id'=>$request->c_id,
                'complainable_type'=> course::class,
            ]);
            return response([
                'message'=> 'complaint added successfully',
            ],200);
        }
    }

    public function add_service_complaint(Request $request): \Illuminate\Foundation\Application|\Illuminate\Http\Response|\Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\Routing\ResponseFactory
    {
        $validator = Validator::make($request->all(), [
            'description' => 'required',
            'u_id'=>'required',
            's_id'=>'required',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            Complaint::create([
                'description' => $request->description,
                'u_id'=>$request->u_id,
                'complainable_id'=>$request->s_id,
                'complainable_type'=> services::class,
            ]);
            return response([
                'message'=> 'complaint added successfully',
            ],200);
        }
    }

    public function get_course_rating($id): \Illuminate\Http\JsonResponse
    {
        $course = course::findOrFail($id);
        $ratings = $course->ratings;
        return response()->json(['ratings'=>$ratings]);
    }
    public function get_training_course_rating($id): \Illuminate\Http\JsonResponse
    {
        $training_course = training_courses::findOrFail($id);
        $ratings = $training_course->ratings;
        return response()->json(['ratings'=>$ratings]);
    }
    public function get_job_rating($id): \Illuminate\Http\JsonResponse
    {
        $job = job::findOrFail($id);
        $ratings = $job->ratings()->with('user')->get();
        return response()->json(['ratings'=>$ratings]);
    }
    public function get_service_rating($id): \Illuminate\Http\JsonResponse
    {
        $service = services::findOrFail($id);
        $ratings = $service->ratings;
        return response()->json(['ratings'=>$ratings]);
    }

    public function get_enrollments_last_7_days()
    {
        $lastSevenDays = now()->subDays(7)->format('Y-m-d');
        $services_data = DB::table('service_enrollments')
        ->selectRaw("DATE_FORMAT(updated_at, '%Y-%m-%d') as date")
        ->selectRaw('COUNT(service_enrollments.se_id) as services')
        ->whereDate('service_enrollments.updated_at', '>=', $lastSevenDays)
        ->groupBy('date')
        ->get()
        ->toArray();
        $courses_data = DB::table('course_enrollments')
        ->selectRaw("DATE_FORMAT(created_at, '%Y-%m-%d') as date")
        ->selectRaw('COUNT(course_enrollments.ce_id) as courses')
        ->whereDate('course_enrollments.created_at', '>=', $lastSevenDays)
        ->groupBy('date')
        ->get()
        ->toArray();
        $dates = [];
        for ($i = 6; $i >= 0; $i--) {
            $date = now()->subDays($i)->toDateString();
            $dates[] = $date;
        }

        $combinedData = [];

        foreach ($courses_data as $course) {
            $combinedData[$course->date]['courses'] = $course->courses;
        }

        foreach ($services_data as $service) {
            $combinedData[$service->date]['services'] = $service->services;
        }
        $finalData = [];
        foreach($dates as $date){
            $data = [
                "date" => $date,
                "courses" => 0,
                "services" => 0
            ];
            if (isset($combinedData[$date])) {
                $data['courses'] = $combinedData[$date]['courses'] ?? 0;
                $data['services'] = $combinedData[$date]['services'] ?? 0;
            }
            $finalData[] = $data;
        }
        return $finalData; 
    }

    public function is_user_course_enrolled(is_user_course_enrolled $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'c_id'=>'required|integer'
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $token = PersonalAccessToken::findToken($request->token);
            $user_id = $token->tokenable_id;
            $result = course_enrollment::where('u_id',$user_id)->where('c_id',$request->c_id)->first();
            if (!empty($result)){
                return response([
                    'enrolled'=> 'true',
                ],200);
            }else{
                return response([
                    'enrolled'=> 'false',
                ],202);
            }
        }
    }


    public function is_user_service_enrolled(is_user_service_enrolled $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            's_id'=>'required|integer'
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $token = PersonalAccessToken::findToken($request->token);
            $user_id = $token->tokenable_id;
            $result = service_enrollment::where('u_id',$user_id)->where('s_id',$request->s_id)->first();
            if (!empty($result)){
                return response([
                    'enrolled'=> 'true',
                ],200);
            }else{
                return response([
                    'enrolled'=> 'false',
                ],202);
            }
        }
    }
    public function is_user_job_applied(is_user_job_applied $request){
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'j_id'=>'required|integer'
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            $token = PersonalAccessToken::findToken($request->token);
            $user_id = $token->tokenable_id;
            $result = job_application::where('u_id',$user_id)->where('j_id',$request->j_id)->first();
            if (!empty($result)){
                return response([
                    'applied'=> 'true',
                ],200);
            }else{
                return response([
                    'applied'=> 'false',
                ],202);
            }
        }
    }


    public function add_job_skill(add_cv_request $request){
        $validator = Validator::make($request->all(),[
            'j_id' => 'required|integer',
            'skill' => 'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
            'string'=> 'the :attribute field should be string',
            'integer' => 'the :attribute field should be a number',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
        $user_token = PersonalAccessToken::findToken($request->token);
        $cv = cv::create([
        'u_id' =>$user_token->tokenable_id,
        'email' => $request->email,
        'address' => $request->address,
        'phone'=>$request->phone,
        'career_obj'=>$request->career_obj,
        ]);
        return response([
            'message'=> 'added successfully',
            'cv_id'=>$cv->id,
        ],200);
    }
    }

}
