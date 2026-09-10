<?php

namespace App\Services;

use App\Models\LeaveRequest;
use App\Models\User;
use InvalidArgumentException;

class LeaveWriter
{
    public static function request(User $user, array $data): LeaveRequest
    {
        $startDate = $data['start_date'];
        $endDate = $data['end_date'];

        if ($endDate < $startDate) {
            throw new InvalidArgumentException('End date cannot be before the start date.');
        }

        $days = (new \DateTime($startDate))->diff(new \DateTime($endDate))->days + 1;

        return LeaveRequest::create([
            'user_id' => $user->id,
            'leave_type' => $data['leave_type'],
            'start_date' => $startDate,
            'end_date' => $endDate,
            'days' => $days,
            'reason' => $data['reason'] ?? null,
            'status' => 'Pending',
            'department_id' => $user->department_id,
        ]);
    }

    public static function decide(LeaveRequest $leave, string $action, User $actor, ?string $notes = null): LeaveRequest
    {
        if (! in_array($action, ['Approved', 'Rejected'], true)) {
            throw new InvalidArgumentException("Unknown action: {$action}");
        }

        if ($leave->status !== 'Pending') {
            throw new InvalidArgumentException('Only pending leave requests can be decided.');
        }

        if ($leave->user_id === $actor->id) {
            throw new InvalidArgumentException('You cannot approve or reject your own leave request.');
        }

        $leave->update([
            'status' => $action,
            'approved_by' => $actor->id,
            'decision_notes' => $notes,
        ]);

        return $leave->fresh();
    }

    public static function cancel(LeaveRequest $leave, User $actor): LeaveRequest
    {
        if ($leave->user_id !== $actor->id) {
            throw new InvalidArgumentException('You can only cancel your own leave request.');
        }

        if ($leave->status !== 'Pending') {
            throw new InvalidArgumentException('Only a pending request can be cancelled.');
        }

        $leave->update(['status' => 'Cancelled']);

        return $leave->fresh();
    }
}
