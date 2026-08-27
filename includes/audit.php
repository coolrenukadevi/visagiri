<?php
declare(strict_types=1);

/**
 * Central audit-log writer. Every sensitive CRM action (login/logout,
 * customer/enquiry/application create+update, assignment, status
 * change, document upload/verification, quote/payment changes,
 * deletion, password change) calls this. Deliberately does NOT copy
 * full sensitive values (e.g. a decrypted passport number) into
 * old_value/new_value — callers pass a redacted summary for anything
 * sensitive, per the "avoid unnecessarily copying full sensitive
 * values into audit logs" requirement.
 */
function log_action(
    string $action,
    string $module,
    ?int $recordId = null,
    ?string $oldValue = null,
    ?string $newValue = null,
    ?int $actorId = null,
    ?int $partnerActorId = null
): void {
    // Every action logged so far has an admin actor (staff performing
    // the action) — $partnerActorId exists for a future phase where a
    // partner acts on their own account (e.g. submits a document) and
    // there is no admin actor at all. Callers set at most one of the
    // two; both null falls back to the current admin, same as before.
    if ($partnerActorId === null) {
        $actorId ??= current_admin_id();
    }

    db()->prepare(
        'INSERT INTO audit_logs (admin_user_id, partner_id, action, module, record_id, ip_address, user_agent, old_value, new_value)
         VALUES (:admin_id, :partner_id, :action, :module, :record_id, :ip, :ua, :old_value, :new_value)'
    )->execute([
        'admin_id' => $actorId,
        'partner_id' => $partnerActorId,
        'action' => $action,
        'module' => $module,
        'record_id' => $recordId,
        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
        'ua' => substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 255),
        'old_value' => $oldValue,
        'new_value' => $newValue,
    ]);
}
