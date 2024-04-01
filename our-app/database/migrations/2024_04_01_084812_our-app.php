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
        //
        Schema::create('role', function (Blueprint $table) {
            $table->integer('r_id')->primary();
            $table->string('role');
        });

        Schema::create('preservations', function (Blueprint $table) {
            $table->integer('p_id')->primary();
            $table->string('p_name');
        });

        Schema::create('user', function (Blueprint $table) {
            $table->integer('u_id')->primary();
            $table->string('f_name');
            $table->string('l_name');
            $table->integer('age');
            $table->longText('u_desc');
            $table->mediumText('u_img');
            $table->mediumText('email');
            $table->string('username');
            $table->string('password');
            $table->integer('p_id');

        });

        Schema::create('user-role', function (Blueprint $table) {
            $table->integer('ur_id')->primary();
            $table->integer('u_id');
            $table->integer('r_id');
        });

        Schema::create('course', function (Blueprint $table) {
            $table->integer('c_id')->primary();
            $table->string('c_name');
            $table->longText('c_desc');
            $table->integer('c_price');
            $table->mediumText('c_img');
            $table->integer('u_id');
        });

        Schema::create('media', function (Blueprint $table) {
            $table->integer('m_id')->primary();
            $table->string('m_name');
            $table->mediumText('m_path');
            $table->integer('c_id');
        });

        Schema::create('job', function (Blueprint $table) {
            $table->integer('j_id')->primary();
            $table->string('j_name');
            $table->longText('j_desc');
            $table->integer('j_sal');
            $table->longText('req');
            $table->integer('u_id');
        });

        Schema::create('services', function (Blueprint $table) {
            $table->integer('s_id')->primary();
            $table->string('s_name');
            $table->longText('s_desc');
            $table->integer('s_price');
            $table->integer('num_of_buyers');
            $table->string('s_duration');
            $table->integer('u_id');
            $table->integer('t_id');
        });

        Schema::create('rates&reviews', function (Blueprint $table) {
            $table->integer('rv_id')->primary();
            $table->integer('sc_id');
            $table->float('rate');
            $table->string('review');
        });

        Schema::create('services_type', function (Blueprint $table) {
            $table->integer('t_id')->primary();
            $table->string('type');
            $table->mediumText('t_icon');
        });

        Schema::create('alt_services', function (Blueprint $table) {
            $table->integer('a_id')->primary();
            $table->integer('s_id');
            $table->integer('a_price');
            $table->string('a_name');
            $table->string('added_duration');
        });

        Schema::create('languages', function (Blueprint $table) {
            $table->integer('l_id')->primary();
            $table->string('language');
        });

        Schema::create('cv_lang', function (Blueprint $table) {
            $table->integer('cvl_id')->primary();
            $table->integer('cv_id');
            $table->integer('l_id');
        });

        Schema::create('cv', function (Blueprint $table) {
            $table->integer('cv_id')->primary();
            $table->longText('career_obj');
            $table->integer('phone');
            $table->string('address');
            $table->string('email');
            $table->integer('u_id');
        });

        Schema::create('education', function (Blueprint $table) {
            $table->integer('e_id')->primary();
            $table->integer('cv_id');
            $table->integer('grad_year');
            $table->string('degree');
            $table->string('uni');
            $table->string('field_of_study');
            $table->float('gba');
        });

        Schema::create('projects', function (Blueprint $table) {
            $table->integer('p_id')->primary();
            $table->integer('cv_id');
            $table->longText('p_desc');
            $table->string('p_name');
            $table->date('start_date');
            $table->date('end_date');
            $table->longText('responsibilities');
        });

        Schema::create('experience', function (Blueprint $table) {
            $table->integer('exp_id')->primary();
            $table->integer('cv_id');
            $table->string('company');
            $table->string('position');
            $table->date('start_date');
            $table->date('end_date');
            $table->longText('responsibilities');
        });

        Schema::create('skills', function (Blueprint $table) {
            $table->integer('s_id')->primary();
            $table->integer('cv_id');
            $table->string('s_level');
            $table->string('s_name');
            $table->integer('years_of_exp');
        });

        Schema::create('training_courses', function (Blueprint $table) {
            $table->integer('t_id')->primary();
            $table->integer('cv_id');
            $table->date('completion_date');
            $table->string('course_name');
            $table->string('training_center');
        });





    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
        Schema::dropIfExists('cache');
        Schema::dropIfExists('cache_locks');
    }
};
