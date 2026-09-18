<?php

declare(strict_types=1);

namespace App\Contracts\Notifications;

/**
 * Provider-agnostic email boundary (Architecture Phase 4). Business
 * code never talks to a mail SDK directly — swapping providers later
 * is a one-file change behind this contract, same reasoning as the
 * existing app's hand-rolled SMTP client being wrapped rather than
 * assumed permanent.
 */
interface EmailProvider
{
    /** @param  list<string>  $to */
    public function send(array $to, string $subject, string $htmlBody, ?string $textBody = null): void;
}
