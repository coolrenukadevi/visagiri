<?php
/**
 * Sidebar navigation config per dashboard area.
 * Returns [ ['label'=>..,'page'=>..,'icon'=>..], ... ].
 */
function dashboard_nav_items(string $area): array
{
    return match ($area) {
        'customer' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
            ['label' => 'Payment History', 'page' => 'transactions'],
            ['label' => 'Profile', 'page' => 'profile'],
        ],
        'partner' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
            ['label' => 'Transactions', 'page' => 'transactions'],
            ['label' => 'Settlements', 'page' => 'settlements'],
        ],
        'employee' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
            ['label' => 'My Tasks', 'page' => 'tasks'],
        ],
        'hrms' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
            ['label' => 'Employees', 'page' => 'employees'],
            ['label' => 'Recruitment', 'page' => 'recruitment'],
            ['label' => 'Attendance', 'page' => 'attendance'],
        ],
        'admin' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
            ['label' => 'Users', 'page' => 'users'],
            ['label' => 'Transactions', 'page' => 'transactions'],
            ['label' => 'Enquiries', 'page' => 'enquiries'],
            ['label' => 'CMS', 'page' => 'cms'],
        ],
        'super-admin' => [
            ['label' => 'Dashboard', 'page' => 'dashboard'],
        ],
        default => [],
    };
}

function dashboard_area_label(string $area): string
{
    return match ($area) {
        'customer' => 'Customer Portal',
        'partner' => 'Partner Portal',
        'employee' => 'Employee Portal',
        'hrms' => 'HRMS',
        'admin' => 'Admin Panel',
        'super-admin' => 'Super Admin',
        default => 'Dashboard',
    };
}
