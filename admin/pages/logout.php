<?php
declare(strict_types=1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $adminId = current_admin_id();
    log_out_admin();
    if ($adminId !== null) {
        log_action('logout', 'auth', $adminId, actorId: $adminId);
    }
}

redirect('/admin/login/');
