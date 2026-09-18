<?php

declare(strict_types=1);

namespace App\Contracts\Audit;

/**
 * ONE shared audit foundation for every module — mirrors includes/
 * audit.php's log_action() from the existing PHP app. No module gets
 * its own audit table or logging mechanism (Architecture Phase 5).
 *
 * Every mutating action and every authorization failure must call
 * this. The existing app was missing the second half (Wave 0 found
 * permission-denials were never logged) — this contract makes that
 * gap impossible to repeat by construction: EnsurePermission calls it
 * on every 403, not by convention but because the middleware itself
 * requires this dependency.
 */
interface AuditLogger
{
    /**
     * @param  array<string, mixed>  $context  extra structured detail
     *   (e.g. old/new value, target record id) — never secrets, never
     *   decrypted PII, never a bearer token (Architecture Phase 5).
     */
    public function log(
        string $action,
        string $module,
        ?int $actorId = null,
        ?int $recordId = null,
        array $context = [],
    ): void;
}
