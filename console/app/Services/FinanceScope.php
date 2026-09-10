<?php

namespace App\Services;

use App\Models\Invoice;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;

/**
 * Same shape as EnquiryScope/AttestationScope, but the middle tier is
 * "department" rather than "team" — matching the architecture doc's own
 * Finance permission matrix (admin gets "Finance scope", operations gets
 * "Department, approval-gated"), since finance review follows department
 * boundaries rather than direct-report chains.
 */
class FinanceScope
{
    public static function visibleTo(User $user): Builder
    {
        return match (true) {
            $user->can('finance.invoices.view.all') => Invoice::query(),
            $user->can('finance.invoices.view.department') => Invoice::where('department_id', $user->department_id),
            $user->can('finance.invoices.view.own') => Invoice::where('created_by', $user->id),
            default => Invoice::whereRaw('1 = 0'),
        };
    }

    public static function canView(User $user, Invoice $invoice): bool
    {
        return self::visibleTo($user)->whereKey($invoice->id)->exists();
    }

    public static function hasAnyViewPermission(User $user): bool
    {
        return $user->can('finance.invoices.view.own') || $user->can('finance.invoices.view.department') || $user->can('finance.invoices.view.all');
    }
}
