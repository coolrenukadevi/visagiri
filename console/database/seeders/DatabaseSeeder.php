<?php

namespace Database\Seeders;

use App\Models\Branch;
use App\Models\Department;
use App\Models\Employee;
use App\Models\LeaveBalance;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    public function run(): void
    {
        $this->call(RolesAndPermissionsSeeder::class);

        $departments = collect([
            ['name' => 'Sales', 'slug' => 'sales'],
            ['name' => 'Visa Services', 'slug' => 'visa-services'],
            ['name' => 'Forex', 'slug' => 'forex'],
            ['name' => 'Travel Services', 'slug' => 'travel-services'],
            ['name' => 'Operations', 'slug' => 'operations'],
        ])->mapWithKeys(fn ($d) => [$d['slug'] => Department::firstOrCreate(['slug' => $d['slug']], $d)]);

        $headOffice = Branch::firstOrCreate(['slug' => 'head-office'], ['name' => 'Head Office', 'slug' => 'head-office']);

        // Same demo accounts and password convention as the existing PHP/SQLite CRM
        // (database/seed.php in the main site repo), extended to cover every role.
        $demoUsers = [
            ['Admin User', 'admin@videshia.com', 'super_admin', null, 'Founder & CEO'],
            ['Ops Admin', 'ops.admin@videshia.com', 'admin', 'operations', 'Operations Head'],
            ['Sales Manager', 'sales.manager@videshia.com', 'sales_manager', 'sales', 'Sales Manager'],
            ['Priya Sharma', 'visa.consultant@videshia.com', 'visa_consultant', 'visa-services', 'Visa Consultant'],
            ['Forex Consultant', 'forex.consultant@videshia.com', 'forex_consultant', 'forex', 'Forex Consultant'],
            ['Travel Consultant', 'travel.consultant@videshia.com', 'travel_consultant', 'travel-services', 'Travel Consultant'],
            ['Operations User', 'operations@videshia.com', 'operations', 'operations', 'Operations Executive'],
            ['Finance Executive', 'finance.executive@videshia.com', 'finance_executive', 'operations', 'Finance Executive'],
        ];

        $currentYear = (int) now()->format('Y');

        foreach ($demoUsers as [$name, $email, $role, $deptSlug, $designation]) {
            $user = User::firstOrCreate(
                ['email' => $email],
                [
                    'name' => $name,
                    'password' => 'Videshia@123',
                    'department_id' => $deptSlug ? $departments[$deptSlug]->id : null,
                    'branch_id' => $headOffice->id,
                    'status' => 'active',
                    'email_verified_at' => now(),
                ]
            );
            $user->syncRoles([$role]);

            // Salary and other personal details are deliberately left null here —
            // these are synthetic demo accounts, not real people, and the point
            // of the employees table is that nothing sensitive gets fabricated
            // into it just to make the UI look populated.
            Employee::firstOrCreate(
                ['user_id' => $user->id],
                ['designation' => $designation, 'employment_type' => 'Full-time', 'status' => 'Active']
            );

            foreach (['Casual' => 12, 'Sick' => 10, 'Earned' => 15] as $type => $allocated) {
                LeaveBalance::firstOrCreate(
                    ['user_id' => $user->id, 'leave_type' => $type, 'year' => $currentYear],
                    ['allocated' => $allocated]
                );
            }
        }

        // Gives sales_manager's enquiries.view.team scope real reports to filter on.
        $salesManager = User::where('email', 'sales.manager@videshia.com')->first();
        User::whereIn('email', [
            'visa.consultant@videshia.com',
            'forex.consultant@videshia.com',
            'travel.consultant@videshia.com',
        ])->update(['manager_id' => $salesManager->id]);
    }
}
