<?php
require_once __DIR__ . '/includes/admin-auth.php';
enquiry_db(); // ensures the database + default admin account exist

if (!empty($_SESSION['admin_user'])) {
    header('Location: index.php');
    exit;
}

$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = (string) ($_POST['password'] ?? '');
    if (admin_attempt_login($username, $password)) {
        header('Location: index.php');
        exit;
    }
    $error = 'Incorrect username or password.';
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="robots" content="noindex, nofollow">
<title>Admin Login &ndash; Visa Agency</title>
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="admin-login-wrap">
    <div class="admin-login-box">
        <h1>Enquiry Admin</h1>
        <p class="sub">Sign in to manage website enquiries.</p>
        <?php if ($error): ?>
        <div class="admin-error"><?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>
        <form method="post">
            <div class="admin-field">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required autofocus>
            </div>
            <div class="admin-field">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="admin-btn">Sign In</button>
        </form>
    </div>
</div>
</body>
</html>
