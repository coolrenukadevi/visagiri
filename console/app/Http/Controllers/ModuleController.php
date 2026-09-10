<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\View\View;

class ModuleController extends Controller
{
    private const LABELS = [
        'sales-crm' => ['Sales CRM', 2],
        'general-enquiry' => ['General Enquiry', 2],
        'attestation' => ['Attestation', 3],
        'b2b-partners' => ['B2B Partners', 4],
        'hrms' => ['HRMS', 5],
        'finance' => ['Finance', 4],
        'website-cms' => ['Website CMS', 5],
        'reports' => ['Reports & Analytics', 6],
        'audit-logs' => ['Audit Logs', 6],
        'administration' => ['Administration', 1],
    ];

    public function comingSoon(string $module): View
    {
        [$label, $milestone] = self::LABELS[$module] ?? [ucfirst(str_replace('-', ' ', $module)), null];

        return view('modules.coming-soon', [
            'title' => $label,
            'milestone' => $milestone,
        ]);
    }
}
