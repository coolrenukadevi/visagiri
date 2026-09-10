<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Mirrors enquiry_counters — its own independent per-year sequence
        // so case numbers (ATT-YYYY-NNNNNN) don't share the enquiry series.
        Schema::create('attestation_case_counters', function (Blueprint $table) {
            $table->unsignedSmallInteger('year')->primary();
            $table->unsignedInteger('last_value')->default(0);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('attestation_case_counters');
    }
};
