<?php
/**
 * "Employee Login" is the public-facing name for staff sign-in; the actual
 * authentication system lives in admin/login.php (the CRM). Redirect rather
 * than duplicating the login form/logic here.
 */
header('Location: /admin/login.php');
exit;
