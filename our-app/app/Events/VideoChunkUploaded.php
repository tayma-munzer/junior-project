<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class VideoChunkUploaded implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    
    public $chunk;
    public $filename;

    public function __construct($chunk, $filename)
    {
        echo "hiiiiii";
        $this->chunk = $chunk;
        $this->filename = $filename;
    }

    public function broadcastOn()
    {
        echo "hello";
        return new Channel('video-upload');
    }

    public function broadcastWith()
    {
        return ['chunk' => $this->chunk, 'filename' => $this->filename];
    }
}
