<?php

namespace App\Http\Controllers;

use App\Models\Branch;
use App\Models\Department;
use App\Models\User;
use Illuminate\Contracts\View\View;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class DashboardController extends Controller
{
    public function __invoke(Request $request): View
    {
        $user = $request->user();

        return view('dashboard', [
            'stats' => [
                'Active users' => User::where('status', 'active')->count(),
                'Roles configured' => Role::count(),
                'Permissions defined' => Permission::count(),
                'Departments' => Department::count(),
            ],
            'branches' => Branch::withCount('users')->get(),
            'permissions' => $user->getAllPermissions()->pluck('name'),
        ]);
    }
}
