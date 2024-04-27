<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('services', function (Blueprint $table) {
            $table->increments('s_id');
            $table->string('s_name');
            $table->longText('s_desc');
            $table->integer('s_price');
            $table->integer('num_of_buyers');
            $table->string('s_duration');
            $table->integer('u_id');
            $table->integer('st_id');
            $table->integer('discount');// a value between 0 to 100 
            $table->string('status');//pinding (waiting for admin aprove) or aproved 
            $table->string('s_img');
            $table->string('s_video')->nullable(true);// it could be null 

        
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('services');
    }
};
