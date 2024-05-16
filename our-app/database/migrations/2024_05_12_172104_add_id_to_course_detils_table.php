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
        Schema::table('course_detils', function (Blueprint $table) {
            $table->integer('cd_duration');
            $table->string('cd_pre_requisite');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('course_detils', function (Blueprint $table) {
            //
        });
    }
};
