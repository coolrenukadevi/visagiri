<?php

declare(strict_types=1);

namespace App\Contracts\Notifications;

/**
 * Provider-agnostic OCR/document-extraction boundary. No OCR
 * integration exists anywhere in the current platform today
 * (confirmed absent, Architecture Phase 4) — reserved for a future
 * document-auto-verification feature, never coupled to a specific
 * vendor.
 */
interface OcrProvider
{
    /** @return array<string, mixed> extracted fields, provider-specific shape left to the caller to interpret */
    public function extract(string $documentContents, string $mimeType): array;
}
