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

class readVideoChunks implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    /**
     * Create a new event instance.
     */
    public $chunk;
    public $isLastChunk;

    public function __construct($chunk, $isLastChunk)
    {
        $this->chunk = $chunk;
        $this->isLastChunk = $isLastChunk;
    }

    public function broadcastOn()
    {
        return new Channel('video-channel');
    }

    public function broadcastAs()
    {
        return 'App\\Events\\VideoChunkBroadcast';
    }
}
