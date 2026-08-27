<?php
require_once __DIR__ . '/includes/partner-auth.php';
partner_logout();
header('Location: b2b-login.php');
exit;
