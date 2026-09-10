<?php

namespace App\Http\Controllers;

use App\Models\LeaveBalance;
use App\Models\LeaveRequest;
use App\Services\HrmsScope;
use App\Services\LeaveWriter;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class LeaveController extends Controller
{
    public function create(Request $request): View
    {
        $year = (int) now()->format('Y');
        $balances = LeaveBalance::where('user_id', $request->user()->id)->where('year', $year)->get()
            ->map(fn (LeaveBalance $b) => ['type' => $b->leave_type, 'remaining' => $b->remaining()]);

        return view('hrms.leave.create', ['balances' => $balances]);
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'leave_type' => ['required', Rule::in(\App\Models\LeaveRequest::TYPES)],
            'start_date' => ['required', 'date'],
            'end_date' => ['required', 'date', 'after_or_equal:start_date'],
            'reason' => ['nullable', 'string', 'max:500'],
        ]);

        try {
            $leave = LeaveWriter::request($request->user(), $data);
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['end_date' => $e->getMessage()])->withInput();
        }

        return redirect()->route('hrms.index')->with('flash', "Leave request submitted — {$leave->days} day(s) of {$leave->leave_type} leave, pending approval.");
    }

    public function decide(Request $request, LeaveRequest $leave): RedirectResponse
    {
        abort_unless($request->user()->can('hrms.leave.approve'), 403);
        abort_unless(HrmsScope::canViewLeave($request->user(), $leave), 404);

        $data = $request->validate([
            'action' => ['required', Rule::in(['Approved', 'Rejected'])],
            'notes' => ['nullable', 'string', 'max:300'],
        ]);

        try {
            LeaveWriter::decide($leave, $data['action'], $request->user(), $data['notes'] ?? null);
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['action' => $e->getMessage()]);
        }

        return back()->with('flash', "Leave request {$data['action']}.");
    }

    public function cancel(Request $request, LeaveRequest $leave): RedirectResponse
    {
        try {
            LeaveWriter::cancel($leave, $request->user());
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['action' => $e->getMessage()]);
        }

        return back()->with('flash', 'Leave request cancelled.');
    }
}
