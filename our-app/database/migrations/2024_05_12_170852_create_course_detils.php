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
        Schema::create('course_detils', function (Blueprint $table) {
            $table->increments('cd_id');
            $table->string('cd_name');
            $table->longText('cd_desc');
            $table->integer('cd_price');
            $table->mediumText('cd_img');
            $table->integer('c_id');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('course_detils');
    }
};
