<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';
require __DIR__ . '/includes/db.php';

$back = $_SERVER['HTTP_REFERER'] ?? url('index.php');

if ($_SERVER['REQUEST_METHOD'] !== 'POST' || !csrf_verify($_POST['csrf_token'] ?? null)) {
    header('Location: ' . $back);
    exit;
}

$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');

if ($name !== '' && filter_var($email, FILTER_VALIDATE_EMAIL)) {
    try {
        db()->prepare('INSERT INTO newsletter_subscribers (name, email) VALUES (?, ?)')->execute([$name, $email]);
        flash_set('success', 'You\'re subscribed — thanks for staying in the loop.');
    } catch (PDOException $e) {
        flash_set('success', 'You\'re already subscribed with that email.');
    }
} else {
    flash_set('error', 'Enter a valid name and email to subscribe.');
}

header('Location: ' . $back);
exit;
