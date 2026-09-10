<?php

namespace App\Http\Controllers;

use App\Models\LeaveBalance;
use App\Models\LeaveRequest;
use App\Services\HrmsScope;
use Illuminate\Contracts\View\View;
use Illuminate\Http\Request;

class HrmsController extends Controller
{
    public function index(Request $request): View
    {
        $user = $request->user();
        $year = (int) now()->format('Y');

        $balances = LeaveBalance::where('user_id', $user->id)->where('year', $year)->get()
            ->map(fn (LeaveBalance $b) => ['type' => $b->leave_type, 'allocated' => (float) $b->allocated, 'remaining' => $b->remaining()]);

        $myLeave = LeaveRequest::where('user_id', $user->id)->latest('created_at')->limit(10)->get();

        $pendingForMe = collect();
        if ($user->can('hrms.leave.approve')) {
            $pendingForMe = HrmsScope::visibleLeaveRequests($user)
                ->where('status', 'Pending')
                ->where('user_id', '!=', $user->id)
                ->with('user')
                ->latest('created_at')
                ->get();
        }

        return view('hrms.index', [
            'employee' => $user->employee,
            'balances' => $balances,
            'myLeave' => $myLeave,
            'pendingForMe' => $pendingForMe,
            'canViewDirectory' => $user->can('hrms.employees.view.department') || $user->can('hrms.employees.view.all'),
        ]);
    }
}
