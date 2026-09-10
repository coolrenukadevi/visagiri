<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Polymorphic owner (documentable_type/documentable_id) so future
        // modules (B2B, HRMS) can attach documents the same way, per the
        // architecture doc's documents_v2 design. `stored_filename` is a
        // random name never derived from user input — `original_filename`
        // is display-only and never touches the filesystem path.
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
            $table->string('documentable_type');
            $table->unsignedBigInteger('documentable_id');
            $table->string('doc_type');
            $table->string('original_filename');
            $table->string('stored_filename');
            $table->string('disk')->default('local');
            $table->string('mime_type');
            $table->unsignedBigInteger('size_bytes');
            $table->string('status')->default('Uploaded');
            $table->foreignId('uploaded_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();

            $table->index(['documentable_type', 'documentable_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};
