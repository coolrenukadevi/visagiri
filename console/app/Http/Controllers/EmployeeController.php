<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Services\HrmsScope;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class EmployeeController extends Controller
{
    public function index(Request $request): View
    {
        $employees = HrmsScope::visibleEmployees($request->user())
            ->with('user.department')
            ->whereHas('user')
            ->get()
            ->sortBy(fn (Employee $e) => $e->user->name);

        return view('hrms.employees.index', ['employees' => $employees]);
    }

    public function show(Request $request, Employee $employee): View
    {
        abort_unless(HrmsScope::canViewEmployee($request->user(), $employee), 404);

        $employee->load('user.department', 'user.branch', 'user.manager');

        return view('hrms.employees.show', [
            'employee' => $employee,
            'canManage' => $request->user()->can('hrms.employees.manage'),
        ]);
    }

    public function update(Request $request, Employee $employee): RedirectResponse
    {
        abort_unless($request->user()->can('hrms.employees.manage'), 403);

        $data = $request->validate([
            'designation' => ['nullable', 'string', 'max:100'],
            'employment_type' => ['required', Rule::in(Employee::EMPLOYMENT_TYPES)],
            'date_of_joining' => ['nullable', 'date'],
            'status' => ['required', Rule::in(Employee::STATUSES)],
            'salary' => ['nullable', 'numeric', 'min:0'],
            'personal_email' => ['nullable', 'email', 'max:120'],
            'personal_phone' => ['nullable', 'string', 'max:30'],
            'emergency_contact_name' => ['nullable', 'string', 'max:120'],
            'emergency_contact_phone' => ['nullable', 'string', 'max:30'],
            'address' => ['nullable', 'string', 'max:500'],
        ]);

        $employee->update($data);

        return back()->with('flash', 'Employee record updated.');
    }
}
