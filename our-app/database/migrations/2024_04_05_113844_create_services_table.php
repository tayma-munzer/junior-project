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
            $table->integer('t_id');
        
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
