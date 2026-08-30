#!/usr/bin/env php
<?php
/**
 * Bootstrap an employee account from the command line.
 *
 *   php tools/create-employee.php "Full Name" email@convercession.com ["Role"]
 *
 * There is no admin console yet to do this from (that's Phase 8), and
 * employee accounts are deliberately not self-service — see
 * lib-php/employee_auth.php's docblock. This is the one honest way to get a
 * real, working account today: it prints a freshly generated password
 * ONCE, to the terminal running the script, and never anywhere else —
 * nothing logs it, nothing stores it but its hash.
 */
declare(strict_types=1);
require __DIR__ . '/../includes/config.php';
require __DIR__ . '/../lib-php/auth.php';
require __DIR__ . '/../lib-php/employee_auth.php';

$fullName = trim((string) ($argv[1] ?? ''));
$email = trim((string) ($argv[2] ?? ''));
$role = trim((string) ($argv[3] ?? 'Consultant'));

if ($fullName === '' || $email === '') {
    fwrite(STDERR, "Usage: php tools/create-employee.php \"Full Name\" email@convercession.com [\"Role\"]\n");
    exit(2);
}
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    fwrite(STDERR, "That doesn't look like a valid email address: {$email}\n");
    exit(2);
}

[$id, $password, $error] = employee_create($fullName, $email, $role);
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
fwrite(STDOUT, "  Password    : {$password}\n");
fwrite(STDOUT, "\nThis password is shown ONCE and is not stored anywhere in plaintext.\n");
fwrite(STDOUT, "Share it with {$employee['full_name']} through a secure channel, and have them sign in at /employee-login.\n");
exit(0);
