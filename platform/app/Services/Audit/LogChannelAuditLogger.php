<?php

declare(strict_types=1);

namespace App\Services\Audit;

use App\Contracts\Audit\AuditLogger;
use Illuminate\Support\Facades\Log;

/**
 * LOCAL DEVELOPMENT SCAFFOLDING — writes audit events to the "audit"
 * log channel instead of a database table, since PostgreSQL 18.x is
 * unavailable in this environment. Once the database foundation is
 * available, this is replaced by a table-backed implementation of the
 * same AuditLogger contract (shaped after the existing app's
 * audit_logs table: actor, action, module, record, context, time,
 * outcome) — nothing that depends on the contract needs to change.
 */
final class LogChannelAuditLogger implements AuditLogger
{
    public function log(
        string $action,
        string $module,
        ?int $actorId = null,
        ?int $recordId = null,
        array $context = [],
    ): void {
        Log::channel('audit')->info($action, [
            'module' => $module,
            'actor_id' => $actorId,
            'record_id' => $recordId,
            'context' => $context,
            'at' => now()->toIso8601String(),
        ]);
    }
}
