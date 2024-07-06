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
        Schema::create('jobs', function (Blueprint $table) {
            
            $table->increments('j_id');
            $table->string('j_title');
            $table->longText('j_desc');
            $table->longText('j_req');
            $table->integer('j_min_sal');
            $table->integer('j_max_sal');
            $table->integer('j_min_age');
            $table->integer('j_max_age');
            $table->string('education');
            $table->integer('num_of_exp_years');
            $table->integer('jt_id');
            $table->integer('u_id');
            $table->timestamps();
        
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jobs');
    }
};
