<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable([
    'user_id', 'designation', 'employment_type', 'date_of_joining', 'date_of_birth',
    'personal_email', 'personal_phone', 'emergency_contact_name', 'emergency_contact_phone',
    'address', 'salary', 'pan_number', 'status', 'created_by',
])]
class Employee extends Model
{
    public const EMPLOYMENT_TYPES = ['Full-time', 'Part-time', 'Contract', 'Intern'];

    public const STATUSES = ['Active', 'On Leave', 'Resigned', 'Terminated'];

    protected function casts(): array
    {
        return [
            'salary' => 'decimal:2',
            'date_of_joining' => 'date',
            'date_of_birth' => 'date',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
