<?php

declare(strict_types=1);

namespace App\Contracts\Documents;

/**
 * Object-level authorization for a single document — the check that
 * makes IDOR impossible: "does this document belong to a record this
 * caller is scoped to?", not merely "is this caller logged in?".
 * Verified empirically against the existing app in Wave 0 (P0-01: 3
 * live cross-customer access attempts, all correctly denied).
 */
interface DocumentAuthorization
{
    public function canView(int $actorId, string $storageKey): bool;

    public function canDownload(int $actorId, string $storageKey): bool;
}
