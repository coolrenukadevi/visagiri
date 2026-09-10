<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Append-only: rows are never updated or deleted, so this is the
        // real audit trail the module promises — not just the case's
        // current `status` column overwritten in place.
        Schema::create('attestation_case_status_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('attestation_case_id')->constrained()->cascadeOnDelete();
            $table->string('from_status')->nullable();
            $table->string('to_status');
            $table->text('notes')->nullable();
            $table->foreignId('changed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('created_at')->useCurrent();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('attestation_case_status_history');
    }
};
