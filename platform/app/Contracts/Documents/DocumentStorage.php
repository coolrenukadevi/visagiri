<?php

declare(strict_types=1);

namespace App\Contracts\Documents;

/**
 * Private document storage abstraction. Mirrors the existing app's
 * verified-correct pattern (dashboard/pages/document-download.php:
 * every read scoped by the authenticated owner, never a client-
 * supplied id alone — confirmed by live testing in Wave 0) rather
 * than reinventing it. Business modules depend on this interface,
 * never on a storage driver directly (Architecture Phase 4 provider-
 * abstraction rule) — swapping local disk for S3-compatible storage
 * later is a one-file change behind this contract.
 */
interface DocumentStorage
{
    /** Store a file and return an opaque storage key (never a public URL). */
    public function put(string $ownerType, int $ownerId, string $originalFilename, string $contents, string $mimeType): string;

    /** Retrieve file bytes for an already-authorized request. Authorization happens before this is called, never inside it. */
    public function get(string $storageKey): string;

    public function delete(string $storageKey): void;

    /** A short-lived, single-purpose download URL — never a permanent public path (Architecture Phase 5). */
    public function temporaryDownloadUrl(string $storageKey, int $expiresInSeconds = 300): string;
}
