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
    ?int $actorId = null
): void {
    $actorId ??= current_admin_id();

    db()->prepare(
        'INSERT INTO audit_logs (admin_user_id, action, module, record_id, ip_address, user_agent, old_value, new_value)
         VALUES (:admin_id, :action, :module, :record_id, :ip, :ua, :old_value, :new_value)'
    )->execute([
        'admin_id' => $actorId,
        'action' => $action,
        'module' => $module,
        'record_id' => $recordId,
        'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
        'ua' => substr((string) ($_SERVER['HTTP_USER_AGENT'] ?? ''), 0, 255),
        'old_value' => $oldValue,
        'new_value' => $newValue,
    ]);
}
