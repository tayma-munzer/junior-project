<?php

namespace App\Http\Controllers;

use App\Http\Requests\add_common_question;
use App\Models\common_questions;
use App\Models\Complaint;
use App\Models\course;
use App\Models\job;
use App\Models\services;
use App\Models\training_courses;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AdminDashboardController extends Controller
{
    public function get_complaints(): JsonResponse
    {
        $complaints = Complaint::with(['user','complainable'])->get();
        return response()->json([
            "complaints" => $complaints
        ]);
    }

     public function accept_job($id): JsonResponse
     {
         $job = job::findOrFail($id);
         $job->update([
             'is_accepted' => true
         ]);
         return response()->json([
             'message' => "accepted job successfully"
         ]);
     }
     public function reject_job($id): JsonResponse
     {
         $job = job::findOrFail($id);
         $job->delete();
         return response()->json([
             'message' => "rejected job successfully"
         ]);
     }
    public function accept_course($id): JsonResponse
    {
        $course = course::findOrFail($id);
        $course->update([
            'is_accepted' => true
        ]);
        return response()->json([
            'message' => "accepted course successfully"
        ]);
    }
    public function reject_course($id): JsonResponse
    {
        $course = course::findOrFail($id);
        $course->delete();
        return response()->json([
            'message' => "rejected course successfully"
        ]);
    }

   public function accept_service($id): JsonResponse
   {
       $service = services::findOrFail($id);
       $service->update([
           'status' =>"approved"
       ]);
       return response()->json([
           'message' => "accepted service successfully"
       ]);
   }
   public function reject_service($id): JsonResponse
   {
       $service = services::findOrFail($id);
       $service->delete();
       return response()->json([
           'message' => "rejected service successfully"
       ]);
   }

    public function get_profiles(): JsonResponse
    {
        $users = User::with('cv.cvLangs.language', 'cv.education', 'cv.experiences', 'cv.projects', 'cv.skills')->get();
        return response()->json($users);
    }


    public function get_profits(): JsonResponse
    {
        $totalProfitServices = DB::table('services')
            ->where('status', "approved")
            ->select(DB::raw('SUM(s_price * num_of_buyers) as total_profit'))
            ->first()
            ->total_profit;
        return response()->json([
            "total_profit" => $totalProfitServices
        ]);
    }

    public function delete_coursee($id): JsonResponse
    {
        $course = course::findOrFail($id);
        $course->delete();
        return response()->json(['message'=>"deleted course successfully"]);
    }
    public function delete_jobb($id): JsonResponse
    {
        $job = job::findOrFail($id);
        $job->delete();
        return response()->json(['message'=>"deleted job successfully"]);
    }
    public function delete_servicee($id): JsonResponse
    {
        $service = services::findOrFail($id);
        $service->delete();
        return response()->json(['message'=>"deleted service successfully"]);
    }

    public function delete_user($id): JsonResponse
    {
        $user = User::findOrFail($id);
        $user->delete();
        return response()->json(['message'=>"deleted user successfully"]);
    }

    public function get_courses_count($id): JsonResponse
    {
    $user = User::findOrFail($id);
    $totalcourses = $user->courses()->count();
    $approvedcourse = $user->courses()->where('is_accepted', 'true')->count();
    $count = ($totalcourses > 0) ? ($approvedcourse* 100) / $totalcourses : 0;
    return response()->json(['courses_count'=>$count]);
    }
    public function get_services_count($id): JsonResponse
    {
        $user = User::findOrFail($id);
        $totalservices = $user->services()->count();
        $approvedservice = $user->services()->where('status', 'approved')->count();
        $count = ($totalservices > 0) ? ( $approvedservice * 100) / $totalservices : 0;
        return response()->json(['services_count'=>$count]);
    }
    
    public function get_jobs_count($id): JsonResponse
    {
    $user = User::findOrFail($id);
    $totalJobs = $user->jobs()->count();
    $approvedJobs = $user->jobs()->where('is_accepted', 'true')->count();
    $count = ($totalJobs > 0) ? ($approvedJobs * 100) / $totalJobs : 0;
    return response()->json(['jobs_count' => $count]);
    }
    public function get_service_requests(): JsonResponse
    {
        //$services = services::with('user')->where('status', 'pinding')->get();
        $services=services::all()->where('status', 'pinding');
        $path = storage_path('images\\');
        foreach ($services as $service){
            $fullpath = $path.''.$service->s_img;
            $image = file_get_contents($fullpath);
            $base64image = base64_encode($image);
            $service->image = $base64image;
        }
        return response()->json(['services'=>$services]);
    }

    public function get_courses_requests(): JsonResponse
    {
        $courses = course::where('is_accepted', 'false')->get();
        $path = storage_path('images\\');
        foreach ($courses as $course){
            $fullpath = $path.''.$course->c_img;
            $image = file_get_contents($fullpath);
            $base64image = base64_encode($image);
            $course->image = $base64image;
        }
        return response()->json(['courses'=>$courses]);
    }

    public function get_jobs_requests(): JsonResponse
    {
        $jobs = job::where('is_accepted', 'false')->get();
        return response()->json(['jobs'=>$jobs]);
    }
    
    public function get_course_user($id): JsonResponse
    {
        $user = User::findOrFail($id);
        $courses=$user->courses;
        return response()->json ($courses) ;
    }

    public function get_service_user($id): JsonResponse
    {
        $user = User::findOrFail($id);
        $services=$user->services;
        return response()->json ($services) ;
    }

    public function get_job_user($id): JsonResponse
    {
        $user = User::findOrFail($id);
        $jobs=$user->jobs;
        return response()->json ($jobs) ;
    }
    
    public function get_user_profile($id){
        $personal_info=User::where('u_id','=',$id)->first();
        $path = storage_path('images\\');
        $fullpath = $path.''.$personal_info->u_img;
        $image = file_get_contents($fullpath);
        $base64image = base64_encode($image);
        $personal_info->image = $base64image;
        $personal_info -> preservation = gets::get_preservation($personal_info->p_id);
        return $personal_info;
    }

    public function add_common_question (add_common_question $request){
        $validator = Validator::make($request->all(), [
            'answer' =>'required|string',
            'question'=>'required|string',
        ], $messages = [
            'required' => 'The :attribute field is required.',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            common_questions::create([
                'question'=>$request->question,
                'answer'=>$request->answer,
            ]);
            return response([
                'message'=> 'added successfully'
            ],200);
        }
    }

    public function get_user_app_uploads($id){
        $services = services::where('u_id',$id)->select('s_id','s_name')->get();
        $courses = course::where('u_id',$id)->select('c_id','c_name')->get();
        $jobs = job::where('u_id',$id)->select('j_id','j_title')->get();

        return response([
            'services'=> $services,
            'courses'=> $courses,
            'jobs'=> $jobs,
        ],200);
    }

}
