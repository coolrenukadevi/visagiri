<?php

declare(strict_types=1);

namespace App\Services\Notifications;

use App\Contracts\Notifications\EmailProvider;
use Illuminate\Support\Facades\Log;

/**
 * LOCAL DEVELOPMENT SCAFFOLDING — writes to the log instead of sending
 * real email. No provider credentials exist or are needed here.
 * Never call a real provider from local Foundation development
 * (Architecture Wave 1 rule: no production/provider credentials).
 */
final class LogEmailProvider implements EmailProvider
{
    public function send(array $to, string $subject, string $htmlBody, ?string $textBody = null): void
    {
        Log::channel('audit')->info('email.send (local dev — not actually sent)', [
            'to' => $to,
            'subject' => $subject,
        ]);
    }
}
