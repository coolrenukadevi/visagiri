<?php
require __DIR__ . '/includes/config.php';
require __DIR__ . '/includes/functions.php';
require __DIR__ . '/includes/auth.php';

require_login();

$pageTitle = 'Dashboard — Videshia';
require __DIR__ . '/includes/header.php';
?>

<section class="page-hero">
    <div class="container">
        <span class="eyebrow">Dashboard</span>
        <h1>Welcome back, <?= e($_SESSION['user']['name']) ?></h1>
        <p>This is a demo landing area confirming your sign-in works end to end. Case management, document review and agent activity would live here.</p>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="grid-3">
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg></div>
                <h3>4 active cases</h3>
                <p>Two awaiting document verification, one with the embassy, one approved this week.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12h13M13 6l6 6-6 6"/></svg></div>
                <h3>Consultant assigned</h3>
                <p>Every new enquiry is reviewed and assigned to a named consultant within one business day.</p>
            </div>
            <div class="card">
                <div class="card-icon"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c2.5 2.7 3.8 6 3.8 9s-1.3 6.3-3.8 9c-2.5-2.7-3.8-6-3.8-9s1.3-6.3 3.8-9z"/></svg></div>
                <h3>Stay informed</h3>
                <p>Your consultant keeps you briefed on any embassy requirement changes relevant to your case.</p>
            </div>
        </div>

        <p style="margin-top:40px">
            <a href="<?= url('logout.php') ?>" class="btn btn-ghost">Sign out</a>
        </p>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
