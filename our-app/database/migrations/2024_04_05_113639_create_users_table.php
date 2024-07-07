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
        Schema::create('user', function (Blueprint $table) {
            $table->increments('u_id');
            $table->string('f_name');
            $table->string('l_name');
            $table->integer('age');
            $table->longText('u_desc');
            $table->mediumText('u_img');
            $table->mediumText('email');
            $table->string('username');
            $table->string('password');
            $table->string('gender');
            $table->integer('p_id');
            $table->timestamp('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
        
    }
};
