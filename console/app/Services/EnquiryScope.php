<?php

namespace App\Services;

use App\Models\Enquiry;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Collection;

/**
 * The single source of truth for "what enquiries can this user see/act on" —
 * shared by the web controllers and the /api/v1/enquiries endpoints so
 * there is exactly one authorization code path, not two that could drift.
 */
class EnquiryScope
{
    /**
     * Service types a role is restricted to, mirroring the live PHP CRM's
     * crm_visible_service_types() (includes/crm-auth.php) exactly. A role
     * not listed here is unrestricted by service type.
     */
    private const SERVICE_TYPE_SCOPE = [
        'visa_consultant' => ['visa'],
        'forex_consultant' => ['forex'],
        'travel_consultant' => ['hotel', 'flight', 'tour', 'insurance', 'general', 'corporate'],
    ];

    public static function visibleTo(User $user): Builder
    {
        $query = match (true) {
            $user->can('enquiries.view.all') => Enquiry::query(),
            $user->can('enquiries.view.team') => Enquiry::whereIn('assigned_to', self::teamIds($user)),
            $user->can('enquiries.view.own') => Enquiry::where('assigned_to', $user->id),
            default => Enquiry::whereRaw('1 = 0'),
        };

        $allowedTypes = self::SERVICE_TYPE_SCOPE[$user->getRoleNames()->first()] ?? null;
        if ($allowedTypes !== null) {
            $query->whereIn('service_type', $allowedTypes);
        }

        return $query;
    }

    public static function canView(User $user, Enquiry $enquiry): bool
    {
        return self::visibleTo($user)->whereKey($enquiry->id)->exists();
    }

    /** Coarse route-level gate: does this user hold any view.* tier at all? */
    public static function hasAnyViewPermission(User $user): bool
    {
        return $user->can('enquiries.view.own') || $user->can('enquiries.view.team') || $user->can('enquiries.view.all');
    }

    public static function canEdit(User $user, Enquiry $enquiry): bool
    {
        if (! self::canView($user, $enquiry)) {
            return false;
        }

        return match (true) {
            $user->can('enquiries.edit.all') => true,
            $user->can('enquiries.edit.team') => self::teamIds($user)->contains($enquiry->assigned_to),
            $user->can('enquiries.edit.own') => $enquiry->assigned_to === $user->id,
            default => false,
        };
    }

    private static function teamIds(User $user): Collection
    {
        return User::where('manager_id', $user->id)->pluck('id')->push($user->id);
    }
}
