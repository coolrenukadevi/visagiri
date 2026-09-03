<?php
require_once __DIR__ . '/includes/admin-auth.php';
require_once __DIR__ . '/../includes/site-contact.php';
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
<title>Staff Sign In &ndash; Visa Agency CRM</title>
<link rel="stylesheet" href="../assets/css/all.min.css">
<link rel="stylesheet" href="assets/admin.css">
</head>
<body>
<div class="admin-login-wrap">
    <div class="admin-login-card">
        <div class="admin-login-brand">
            <div class="admin-login-brand-inner">
                <a href="/" class="admin-login-logo admin-login-logo-badge">
                    <img src="../assets/img/logo/badge-full.svg" alt="Visa Agency">
                </a>
                <h1>Staff &amp; Partner Sign In</h1>
                <p>Manage visa enquiries, applications, documents, forex requests and payments from one console.</p>
                <ul class="admin-login-trust">
                    <li><i class="fa-solid fa-shield-alt" aria-hidden="true"></i> Secure, permissioned access</li>
                    <li><i class="fa-solid fa-users-gear" aria-hidden="true"></i> Role-based dashboards</li>
                    <li><i class="fa-solid fa-clock-rotate-left" aria-hidden="true"></i> Every action audit-logged</li>
                </ul>
            </div>
        </div>
        <div class="admin-login-form-side">
            <div class="admin-login-form-inner">
                <h2>Welcome back</h2>
                <p class="sub">Sign in to your Visa Agency CRM account.</p>
                <?php if ($error): ?>
                <div class="admin-error"><i class="fa-solid fa-triangle-exclamation" aria-hidden="true"></i> <?php echo htmlspecialchars($error); ?></div>
                <?php endif; ?>
                <form method="post" novalidate>
                    <div class="admin-field">
                        <label for="username">Username</label>
                        <div class="admin-field-input">
                            <i class="fa-solid fa-user" aria-hidden="true"></i>
                            <input type="text" id="username" name="username" required autofocus autocomplete="username">
                        </div>
                    </div>
                    <div class="admin-field">
                        <label for="password">Password</label>
                        <div class="admin-field-input">
                            <i class="fa-solid fa-lock" aria-hidden="true"></i>
                            <input type="password" id="password" name="password" required autocomplete="current-password">
                            <button type="button" class="admin-field-toggle" id="adminPasswordToggle" aria-label="Show password" aria-pressed="false">
                                <i class="fa-solid fa-eye" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                    <button type="submit" class="admin-btn">Sign In <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></button>
                </form>
                <a href="/" class="admin-login-back"><i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back to VisaAgency.in</a>
            </div>
        </div>
    </div>
</div>
<script>
(function () {
    var toggle = document.getElementById('adminPasswordToggle');
    var input = document.getElementById('password');
    if (!toggle || !input) { return; }
    toggle.addEventListener('click', function () {
        var isHidden = input.type === 'password';
        input.type = isHidden ? 'text' : 'password';
        toggle.setAttribute('aria-pressed', isHidden ? 'true' : 'false');
        toggle.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
        toggle.querySelector('i').className = isHidden ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
    });
})();
</script>
</body>
</html>
