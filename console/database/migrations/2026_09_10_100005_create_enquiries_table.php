<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('enquiries', function (Blueprint $table) {
            $table->id();
            $table->string('reference_no')->unique();
            $table->string('service_type');
            $table->foreignId('customer_id')->constrained();
            $table->foreignId('party_id')->nullable()->constrained()->nullOnDelete();
            $table->string('country')->nullable();
            $table->string('destination')->nullable();
            $table->date('travel_date')->nullable();
            $table->string('status')->default('New');
            $table->string('priority')->default('Normal');
            $table->string('source')->default('Website');
            $table->foreignId('assigned_to')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('department_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('branch_id')->nullable()->constrained()->nullOnDelete();
            $table->text('notes')->nullable();
            $table->string('dedupe_key')->unique();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('updated_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();

            $table->index('status');
            $table->index('service_type');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('enquiries');
    }
};
