<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable([
    'user_id', 'leave_type', 'start_date', 'end_date', 'days', 'reason',
    'status', 'approved_by', 'decision_notes', 'department_id',
])]
class LeaveRequest extends Model
{
    public const TYPES = ['Casual', 'Sick', 'Earned', 'Unpaid'];

    public const STATUSES = ['Pending', 'Approved', 'Rejected', 'Cancelled'];

    protected function casts(): array
    {
        return [
            'start_date' => 'date',
            'end_date' => 'date',
        ];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
