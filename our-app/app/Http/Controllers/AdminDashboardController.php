<?php

namespace App\Http\Controllers;

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
    public function add_complaint(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'description' => 'required',
        ]);
        if ($validator->fails()){
            $errors = $validator->errors();
            return response($errors,402);
        }else{
            Complaint::create([
                'description' => $request->description
            ]);
            return response([
                'message'=> 'complaint added successfully',
            ],200);
        }
    }
    public function get_complaints(): JsonResponse
    {
        $complaints = Complaint::all();
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
    public function accept_training_course($id): JsonResponse
    {
        $course = training_courses::findOrFail($id);
        $course->update([
            'is_accepted' => true
        ]);
        return response()->json([
            'message' => "accepted course successfully"
        ]);
    }
    public function reject_training_course($id): JsonResponse
    {
        $course = training_courses::findOrFail($id);
        $course->delete();
        return response()->json([
            'message' => "rejected course successfully"
        ]);
    }
    public function accept_service($id): JsonResponse
    {
        $service = services::findOrFail($id);
        $service->update([
            'is_accepted' => true
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
    public function get_profile($id): JsonResponse
    {
        $user = User::with('cv.cvLangs.language', 'cv.education', 'cv.experiences', 'cv.projects', 'cv.skills')->findOrFail($id);
        return response()->json($user);
    }

    public function get_profits(): JsonResponse
    {
        $totalProfitServices = DB::table('services')
            ->where('is_accepted', 1)
            ->select(DB::raw('SUM(s_price * num_of_buyers) as total_profit'))
            ->first()
            ->total_profit;
        return response()->json([
            "total_profit" => $totalProfitServices
        ]);
    }

    public function delete_course($id): JsonResponse
    {
        $course = course::findOrFail($id);
        $course->delete();
        return response()->json(['message'=>"deleted course successfully"]);
    }
    public function delete_training_course($id): JsonResponse
    {
        $training_course = training_courses::findOrFail($id);
        $training_course->delete();
        return response()->json(['message'=>"deleted training course successfully"]);
    }
    public function delete_job($id): JsonResponse
    {
        $job = job::findOrFail($id);
        $job->delete();
        return response()->json(['message'=>"deleted job successfully"]);
    }
    public function delete_service($id): JsonResponse
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
}
