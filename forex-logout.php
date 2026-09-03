<?php
require_once __DIR__ . '/includes/forex-customer-auth.php';
forex_customer_logout();
header('Location: forex-login');
exit;
