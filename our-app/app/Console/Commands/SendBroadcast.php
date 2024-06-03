<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class SendBroadcast extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'broadcast:send';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Broadcast a message';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //
        $message = $this->ask("Which message do you want to broadcast?");
        event(new \App\Events\SendMessage($message ?: 'No Message :)'));
    }
}
