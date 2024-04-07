<?php

namespace App\Http\Controllers;

use App\Http\Requests\loginRequest;
use app\Models\user;
use function PHPUnit\Framework\matches;
use Illuminate\Support\Facades\DB;

class authenticationController extends Controller
{
    //
    public function login(loginRequest $request) {

        $request->validated();
        $user = DB::table('user')->where('email','=', $request->email)->first();
        if( !($request->password === $user->password) || !$user ){
            return response([
                'message'=> 'invalid input'
            ],422);
        }
        else 
        return response([
            'message'=> 'valid input'
        ],200);
        
    }
}
