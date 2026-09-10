<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('visa_enquiries', function (Blueprint $table) {
            $table->foreignId('enquiry_id')->primary()->constrained()->cascadeOnDelete();
            $table->string('passport_number')->nullable();
            $table->string('nationality')->nullable();
            $table->foreignId('country_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('visa_category_id')->nullable()->constrained()->nullOnDelete();
            $table->date('travel_date')->nullable();
            $table->date('return_date')->nullable();
            $table->unsignedInteger('travellers_count')->default(1);
            $table->date('appointment_date')->nullable();
            $table->string('visa_fee')->nullable();
            $table->string('service_fee')->nullable();
            $table->string('payment_status')->default('Pending');
            $table->string('application_status')->default('New');
        });

        Schema::create('general_enquiries', function (Blueprint $table) {
            $table->foreignId('enquiry_id')->primary()->constrained()->cascadeOnDelete();
            $table->string('subject')->nullable();
            $table->text('message')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('general_enquiries');
        Schema::dropIfExists('visa_enquiries');
    }
};
