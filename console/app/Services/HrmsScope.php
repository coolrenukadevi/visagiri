<?php

namespace App\Services;

use App\Models\Employee;
use App\Models\LeaveRequest;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Collection;

/**
 * Two independent scopes, not one — this is what "HRMS gets the
 * strictest permission boundary in the system" actually means in code.
 * A sales_manager can hold hrms.leave.view.team (see and approve their
 * reports' leave) while holding only hrms.employees.view.own (their own
 * salary and personal details, nobody else's) — approving leave and
 * seeing a payslip are different privileges, and the schema/permission
 * split keeps that true even under a future bug in one code path.
 */
class HrmsScope
{
    public static function visibleEmployees(User $user): Builder
    {
        return match (true) {
            $user->can('hrms.employees.view.all') => Employee::query(),
            $user->can('hrms.employees.view.department') => Employee::whereHas(
                'user', fn ($q) => $q->where('department_id', $user->department_id)
            ),
            $user->can('hrms.employees.view.own') => Employee::where('user_id', $user->id),
            default => Employee::whereRaw('1 = 0'),
        };
    }

    public static function canViewEmployee(User $user, Employee $employee): bool
    {
        return self::visibleEmployees($user)->whereKey($employee->id)->exists();
    }

    public static function visibleLeaveRequests(User $user): Builder
    {
        return match (true) {
            $user->can('hrms.leave.view.all') => LeaveRequest::query(),
            $user->can('hrms.leave.view.department') => LeaveRequest::where('department_id', $user->department_id),
            $user->can('hrms.leave.view.team') => LeaveRequest::whereIn('user_id', self::teamIds($user)),
            $user->can('hrms.leave.view.own') => LeaveRequest::where('user_id', $user->id),
            default => LeaveRequest::whereRaw('1 = 0'),
        };
    }

    public static function canViewLeave(User $user, LeaveRequest $leave): bool
    {
        return self::visibleLeaveRequests($user)->whereKey($leave->id)->exists();
    }

    public static function hasAnyAccess(User $user): bool
    {
        foreach (['hrms.employees.view.own', 'hrms.employees.view.department', 'hrms.employees.view.all',
            'hrms.leave.view.own', 'hrms.leave.view.team', 'hrms.leave.view.department', 'hrms.leave.view.all'] as $permission) {
            if ($user->can($permission)) {
                return true;
            }
        }

        return false;
    }

    private static function teamIds(User $user): Collection
    {
        return User::where('manager_id', $user->id)->pluck('id')->push($user->id);
    }
}
