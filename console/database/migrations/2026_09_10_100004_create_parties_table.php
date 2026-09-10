<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('parties', function (Blueprint $table) {
            $table->id();
            $table->string('type')->default('customer');
            $table->string('display_name');
            $table->string('primary_email')->nullable();
            $table->string('primary_mobile')->nullable();
            $table->timestamps();
        });

        Schema::create('party_links', function (Blueprint $table) {
            $table->id();
            $table->foreignId('party_id')->constrained()->cascadeOnDelete();
            $table->string('linkable_type');
            $table->unsignedBigInteger('linkable_id');
            $table->timestamps();
            $table->unique(['linkable_type', 'linkable_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('party_links');
        Schema::dropIfExists('parties');
    }
};
