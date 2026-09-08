<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('employee_id')->nullable()->unique()->after('id');
            $table->foreignId('department_id')->nullable()->after('email')->constrained()->nullOnDelete();
            $table->foreignId('branch_id')->nullable()->after('department_id')->constrained()->nullOnDelete();
            $table->foreignId('manager_id')->nullable()->after('branch_id')->constrained('users')->nullOnDelete();
            $table->string('status')->default('active')->after('manager_id');
            $table->timestamp('last_login_at')->nullable()->after('status');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropConstrainedForeignId('department_id');
            $table->dropConstrainedForeignId('branch_id');
            $table->dropConstrainedForeignId('manager_id');
            $table->dropColumn(['employee_id', 'status', 'last_login_at']);
        });
    }
};
