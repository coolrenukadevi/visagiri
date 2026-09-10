<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['user_id', 'leave_type', 'year', 'allocated'])]
class LeaveBalance extends Model
{
    public $timestamps = false;

    protected function casts(): array
    {
        return ['allocated' => 'decimal:1'];
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Days already taken (Pending + Approved — a pending request still
     * holds the days against the balance until it's decided) for this
     * user/type/year, computed live from leave_requests rather than
     * cached here, so there is exactly one source of truth.
     */
    public static function used(int $userId, string $leaveType, int $year): int
    {
        return (int) LeaveRequest::where('user_id', $userId)
            ->where('leave_type', $leaveType)
            ->whereIn('status', ['Pending', 'Approved'])
            ->whereYear('start_date', $year)
            ->sum('days');
    }

    public function remaining(): float
    {
        return (float) $this->allocated - self::used($this->user_id, $this->leave_type, $this->year);
    }
}
