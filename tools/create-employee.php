#!/usr/bin/env php
<?php
/**
 * Bootstrap an employee account from the command line.
 *
 *   php tools/create-employee.php "Full Name" email@convercession.com ["Role"] [--admin]
 *
 * Once at least one admin exists, further accounts are normally created
 * from the admin console (/employee/admin) instead — this script's real
 * remaining job is creating that FIRST admin, since nothing can grant
 * admin access before one exists. Employee accounts are deliberately not
 * self-service — see lib-php/employee_auth.php's docblock. This is the one
 * honest way to get a real, working account without one: it prints a
 * freshly generated password ONCE, to the terminal running the script, and
 * never anywhere else — nothing logs it, nothing stores it but its hash.
 */
declare(strict_types=1);
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../lib-php/auth.php';
require __DIR__ . '/../lib-php/employee_auth.php';

$isAdmin = in_array('--admin', $argv, true);
$positional = array_values(array_filter(array_slice($argv, 1), static fn($a) => $a !== '--admin'));
$fullName = trim((string) ($positional[0] ?? ''));
$email = trim((string) ($positional[1] ?? ''));
$role = trim((string) ($positional[2] ?? 'Consultant'));

if ($fullName === '' || $email === '') {
    fwrite(STDERR, "Usage: php tools/create-employee.php \"Full Name\" email@convercession.com [\"Role\"] [--admin]\n");
    exit(2);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    fwrite(STDERR, "That doesn't look like a valid email address: {$email}\n");
    exit(2);
}

[$id, $password, $error] = employee_create($fullName, $email, $role, $isAdmin);
if ($id === null) {
    fwrite(STDERR, "Failed: {$error}\n");
    exit(1);
}

$employee = employee_find($id);
fwrite(STDOUT, "Employee account created.\n");
fwrite(STDOUT, "  Employee ID : {$employee['employee_code']}\n");
fwrite(STDOUT, "  Name        : {$employee['full_name']}\n");
fwrite(STDOUT, "  Email       : {$employee['email']}\n");
fwrite(STDOUT, "  Role        : {$employee['role']}\n");
fwrite(STDOUT, "  Admin       : " . ($employee['is_admin'] ? 'yes' : 'no') . "\n");
fwrite(STDOUT, "  Password    : {$password}\n");
fwrite(STDOUT, "\nThis password is shown ONCE and is not stored anywhere in plaintext.\n");
fwrite(STDOUT, "Share it with {$employee['full_name']} through a secure channel, and have them sign in at /employee-login.\n");
exit(0);
