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
        Schema::table('rates_reviews', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('ratable_id');
            $table->string('ratable_type');
            $table->dropColumn('sc_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('rates_reviews', function (Blueprint $table) {
            $table->dropColumn('user_id');
            $table->dropColumn('ratable_type');
            $table->integer('sc_id');
        });
    }
};
