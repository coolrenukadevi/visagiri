<?php

namespace App\Services;

use App\Models\AttestationCase;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Collection;

/**
 * Same shape as EnquiryScope, for the same reason: one authorization path
 * shared by every controller that touches attestation cases.
 */
class AttestationScope
{
    public static function visibleTo(User $user): Builder
    {
        return match (true) {
            $user->can('attestation.view.all') => AttestationCase::query(),
            $user->can('attestation.view.team') => AttestationCase::whereIn('assigned_to', self::teamIds($user)),
            $user->can('attestation.view.own') => AttestationCase::where('assigned_to', $user->id),
            default => AttestationCase::whereRaw('1 = 0'),
        };
    }

    public static function canView(User $user, AttestationCase $case): bool
    {
        return self::visibleTo($user)->whereKey($case->id)->exists();
    }

    public static function canEdit(User $user, AttestationCase $case): bool
    {
        if (! self::canView($user, $case)) {
            return false;
        }

        return match (true) {
            $user->can('attestation.edit.all') => true,
            $user->can('attestation.edit.team') => self::teamIds($user)->contains($case->assigned_to),
            $user->can('attestation.edit.own') => $case->assigned_to === $user->id,
            default => false,
        };
    }

    public static function hasAnyViewPermission(User $user): bool
    {
        return $user->can('attestation.view.own') || $user->can('attestation.view.team') || $user->can('attestation.view.all');
    }

    private static function teamIds(User $user): Collection
    {
        return User::where('manager_id', $user->id)->pluck('id')->push($user->id);
    }
}
