<?php
declare(strict_types=1);

/**
 * Read-only viewer for storage/logs/mail.log (written by includes/
 * mail.php's mail_log()) — lets a non-technical client see exactly
 * why an SMTP send failed (or that it succeeded) without needing to
 * find their host's PHP error log, which varies by provider and
 * isn't always easy to locate in cPanel.
 */

require_permission('settings.manage');

$logPath = STORAGE_PATH . '/logs/mail.log';
$lines = is_file($logPath) ? (file($logPath, FILE_IGNORE_NEW_LINES) ?: []) : [];
$recent = array_reverse(array_slice($lines, -300));

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['action'] ?? '') === 'clear') {
    csrf_require();
    @file_put_contents($logPath, '');
    flash_set('admin_notice', 'Mail log cleared.');
    redirect('/admin/mail-log/');
}

admin_header_start('Mail Log', 'mail-log');
?>
<div class="admin-form-card" style="max-width:1100px">
    <p style="color:var(--text-muted);margin-top:0">
        Every attempt to send an email through <code>send_mail()</code> (enquiry notifications, password
        resets, partner emails, etc.) logs one line here — success or the exact reason it failed. Newest first.
    </p>
    <?php if (!$recent): ?>
    <p>No entries yet — nothing has tried to send an email since this log started, or the log file hasn't been created.</p>
    <?php else: ?>
    <pre style="background:var(--visa-blue-dark);color:#eaf2ff;padding:var(--space-4);border-radius:var(--radius-md);overflow-x:auto;white-space:pre-wrap;font-size:var(--font-size-sm);line-height:1.6;max-height:70vh;overflow-y:auto"><?php foreach ($recent as $line): ?><?= e($line) ?>
<?php endforeach; ?></pre>
    <form method="post" action="/admin/mail-log/" style="margin-top:var(--space-4)" onsubmit="return confirm('Clear the mail log?');">
        <?= csrf_field() ?>
        <input type="hidden" name="action" value="clear">
        <button type="submit" class="btn btn-outline btn-sm">Clear Log</button>
    </form>
    <?php endif; ?>
</div>
<?php
admin_header_end();
