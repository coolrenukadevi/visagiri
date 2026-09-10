<?php
declare(strict_types=1);

// Standing in for a users table until the app is wired to a database.
function demo_users(): array
{
    return [
        'demo@videshia.com' => [
            'name' => 'Demo User',
            'hash' => '$2y$12$muOMAOiyeTyCwhWEHcIcZu0.vrEuApxCxb8Ngp2aJ7ir6gnMptaE2',
        ],
    ];
}

function csrf_token(): string
{
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function csrf_verify(?string $token): bool
{
    return is_string($token) && hash_equals($_SESSION['csrf_token'] ?? '', $token);
}

function is_logged_in(): bool
{
    return !empty($_SESSION['user']);
}

function require_login(): void
{
    if (!is_logged_in()) {
        flash_set('error', 'Please sign in to continue.');
        header('Location: ' . url('login.php'));
        exit;
    }
}

function attempt_login(string $email, string $password): bool
{
    $email = strtolower(trim($email));
    $users = demo_users();

    if (!isset($users[$email]) || !password_verify($password, $users[$email]['hash'])) {
        return false;
    }

    session_regenerate_id(true);
    $_SESSION['user'] = ['email' => $email, 'name' => $users[$email]['name']];
    return true;
}
