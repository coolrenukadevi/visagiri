<?php

declare(strict_types=1);

namespace App\Contracts\Notifications;

/**
 * Provider-agnostic WhatsApp boundary. No WhatsApp integration exists
 * anywhere in the current platform (confirmed absent, Architecture
 * Phase 4/6) — this interface exists so a future integration has one
 * place to plug into, never a business module calling a vendor SDK
 * directly.
 */
interface WhatsAppProvider
{
    public function sendMessage(string $toE164PhoneNumber, string $templateName, array $templateParams = []): void;
}
