<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Events\MessageSent;

class MessageController extends Controller
{
    public function sendMessage(Request $request)
    {
        $message = $request->message;
        event(new MessageSent($message));

        return response()->json(['status' => 'Message Sent!']);
    }
    //
}
