<?php
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../includes/functions.php';
require __DIR__ . '/../includes/crm-auth.php';

if (crm_current_user()) {
    crm_audit_log('logout', 'user', crm_current_user()['id']);
}
unset($_SESSION['crm_user']);

header('Location: ' . url('crm/login.php'));
exit;
