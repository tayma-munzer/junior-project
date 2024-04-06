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
        Schema::create('alt_services', function (Blueprint $table) {
            $table->increments('a_id');
            $table->integer('s_id');
            $table->integer('a_price');
            $table->string('a_name');
            $table->string('added_duration');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('alt_services');
    }
};
