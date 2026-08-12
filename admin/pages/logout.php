<?php
declare(strict_types=1);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    log_out_admin();
}

redirect('/admin/login/');
