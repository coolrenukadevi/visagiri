<?php

namespace Database\Seeders;

use App\Models\Branch;
use App\Models\Department;
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
            ['Admin User', 'admin@videshia.com', 'super_admin', null],
            ['Ops Admin', 'ops.admin@videshia.com', 'admin', 'operations'],
            ['Sales Manager', 'sales.manager@videshia.com', 'sales_manager', 'sales'],
            ['Priya Sharma', 'visa.consultant@videshia.com', 'visa_consultant', 'visa-services'],
            ['Forex Consultant', 'forex.consultant@videshia.com', 'forex_consultant', 'forex'],
            ['Travel Consultant', 'travel.consultant@videshia.com', 'travel_consultant', 'travel-services'],
            ['Operations User', 'operations@videshia.com', 'operations', 'operations'],
        ];

        foreach ($demoUsers as [$name, $email, $role, $deptSlug]) {
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
        }
    }
}
