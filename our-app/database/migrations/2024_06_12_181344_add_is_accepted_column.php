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
        Schema::table('jobs', function (Blueprint $table) {
            $table->boolean('is_accepted')->default(false);
        });
        Schema::table('courses', function (Blueprint $table) {
            $table->boolean('is_accepted')->default(false);
        });
        Schema::table('training_courses', function (Blueprint $table) {
            $table->boolean('is_accepted')->default(false);
        });
        Schema::table('services', function (Blueprint $table) {
            $table->boolean('is_accepted')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('jobs', function (Blueprint $table) {
            $table->dropColumn('is_accepted');
        });
        Schema::table('courses', function (Blueprint $table) {
            $table->dropColumn('is_accepted');
        });
        Schema::table('training_courses', function (Blueprint $table) {
            $table->dropColumn('is_accepted');
        });
        Schema::table('services', function (Blueprint $table) {
            $table->dropColumn('is_accepted');
        });
    }
};
