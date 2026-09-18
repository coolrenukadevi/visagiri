<?php

declare(strict_types=1);

namespace App\Services\Documents;

use App\Contracts\Documents\DocumentAuthorization;

/**
 * Foundation implementation: a storage key only grants access when it
 * was issued to this exact actor. Matches LocalDiskDocumentStorage's
 * key shape ("documents/{ownerType}/{ownerId}/...") so ownership is
 * verifiable without a database lookup — the same object-level check
 * the existing app performs via a SQL WHERE clause (verified correct
 * in Wave 0's P0-01 live tests), expressed here as a pure function
 * until the database-backed version (real ownership records, not just
 * key-shape) replaces it.
 */
final class OwnerScopedDocumentAuthorization implements DocumentAuthorization
{
    public function canView(int $actorId, string $storageKey): bool
    {
        return $this->belongsToActor($actorId, $storageKey);
    }

    public function canDownload(int $actorId, string $storageKey): bool
    {
        return $this->belongsToActor($actorId, $storageKey);
    }

    private function belongsToActor(int $actorId, string $storageKey): bool
    {
        return (bool) preg_match('#^documents/[^/]+/'.preg_quote((string) $actorId, '#').'/#', $storageKey);
    }
}
