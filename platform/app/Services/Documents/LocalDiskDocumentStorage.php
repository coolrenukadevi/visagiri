<?php

declare(strict_types=1);

namespace App\Services\Documents;

use App\Contracts\Documents\DocumentStorage;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

/**
 * Local Foundation implementation of DocumentStorage — private local
 * disk only ("local" disk, never "public"), scoped by owner type/id
 * so a storage key alone never reveals or grants access to a file.
 * This is this NEW app's own storage/app/private directory, entirely
 * separate from the existing production application's storage/
 * directory — never reads or writes anything outside platform/.
 *
 * Swapped for an S3-compatible implementation of the same contract
 * when the target VPS/object-storage stage is approved (Architecture
 * Phase 6) — no caller of DocumentStorage needs to change.
 */
final class LocalDiskDocumentStorage implements DocumentStorage
{
    private const DISK = 'local';

    public function put(string $ownerType, int $ownerId, string $originalFilename, string $contents, string $mimeType): string
    {
        $storageKey = sprintf(
            'documents/%s/%d/%s-%s',
            $ownerType,
            $ownerId,
            (string) Str::ulid(),
            basename($originalFilename),
        );

        Storage::disk(self::DISK)->put($storageKey, $contents);

        return $storageKey;
    }

    public function get(string $storageKey): string
    {
        return Storage::disk(self::DISK)->get($storageKey)
            ?? throw new \RuntimeException("Document not found in storage: {$storageKey}");
    }

    public function delete(string $storageKey): void
    {
        Storage::disk(self::DISK)->delete($storageKey);
    }

    public function temporaryDownloadUrl(string $storageKey, int $expiresInSeconds = 300): string
    {
        // The local disk has no native signed-URL support the way S3
        // does; Foundation-stage callers should route downloads
        // through an authorized controller action instead of this URL
        // until object storage (Architecture Phase 6) is in place.
        return route('documents.download', ['key' => $storageKey, 'expires' => now()->addSeconds($expiresInSeconds)->timestamp]);
    }
}
