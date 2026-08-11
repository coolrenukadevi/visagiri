<?php
declare(strict_types=1);

/**
 * Public application tracking — Phase 11. No login required, so the
 * lookup must not become an enumeration oracle: it requires BOTH the
 * application number AND the email on the account, and a non-match
 * shows one generic message regardless of which part was wrong (same
 * pattern as auth/forgot-password.php). Only limited, non-sensitive
 * fields are shown — status, country, visa type, progress, and the
 * status timeline. Documents, payments, and full applicant details
 * stay inside the authenticated dashboard.
 */

require __DIR__ . '/../includes/dashboard-layout.php';

$prefillNumber = trim((string) ($_GET['application_number'] ?? ''));
$submitted = false;
$result = null;
$errors = [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    csrf_require();
    $applicationNumber = trim((string) ($_POST['application_number'] ?? ''));
    $email = trim((string) ($_POST['email'] ?? ''));
    $prefillNumber = $applicationNumber;

    if (!rate_limit_check('track-visa:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 10, 900)) {
        $errors[] = 'Too many attempts. Please try again later.';
    } elseif ($applicationNumber === '' || !is_valid_email($email)) {
        $errors[] = 'Enter a valid application number and the email address on the application.';
    } else {
        $pdo = db();
        $stmt = $pdo->prepare(
            'SELECT a.id, a.application_number, a.status, a.progress_percent, a.updated_at,
                    c.name AS country_name, c.iso2, vt.name AS visa_type_name
             FROM applications a
             JOIN users u ON u.id = a.user_id
             JOIN countries c ON c.id = a.country_id
             JOIN visa_types vt ON vt.id = a.visa_type_id
             WHERE a.application_number = :number AND u.email = :email AND a.deleted_at IS NULL
             LIMIT 1'
        );
        $stmt->execute(['number' => $applicationNumber, 'email' => $email]);
        $result = $stmt->fetch();

        if ($result) {
            $historyStmt = $pdo->prepare(
                'SELECT * FROM application_status_history WHERE application_id = :id ORDER BY created_at ASC'
            );
            $historyStmt->execute(['id' => $result['id']]);
            $historyByStatus = [];
            foreach ($historyStmt->fetchAll() as $row) {
                $historyByStatus[$row['status']] = $row;
            }
        }

        $submitted = true;
    }
}

$pageTitle = 'Track Your Visa Application';
$pageDescription = 'Track the status of your Visagiri visa application using your application number and email.';
$canonicalUrl = APP_URL . '/track-visa/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section" style="padding-top:var(--space-8)">
    <div class="container" style="max-width:720px">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Track Application</span>
            <h1>Check Your Application Status</h1>
            <p>Enter your application number and the email address used to apply.</p>
        </div>

        <?php foreach ($errors as $error): ?>
        <div class="alert alert-danger"><?= e($error) ?></div>
        <?php endforeach; ?>

        <div class="card" style="margin-bottom:var(--space-8)">
            <form method="post" action="/track-visa/" novalidate>
                <?= csrf_field() ?>
                <div class="form-group">
                    <label class="form-label" for="application_number">Application Number</label>
                    <input class="form-input" type="text" id="application_number" name="application_number" placeholder="e.g. VIS-2026-000001" value="<?= e($prefillNumber) ?>" required autofocus>
                </div>
                <div class="form-group">
                    <label class="form-label" for="email">Email Address</label>
                    <input class="form-input" type="email" id="email" name="email" placeholder="Email used on the application" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width:100%">Track Application</button>
            </form>
        </div>

        <?php if ($submitted): ?>
            <?php if ($result): ?>
            <div class="card">
                <p class="application-card__id"><?= e($result['application_number']) ?></p>
                <div class="card-title"><?= flag_emoji($result['iso2']) ?> <?= e($result['visa_type_name']) ?> &mdash; <?= e($result['country_name']) ?></div>
                <p>Progress: <?= (int) $result['progress_percent'] ?>% &middot; Last updated: <?= e(date('d M Y', strtotime((string) $result['updated_at']))) ?></p>
            </div>

            <?php $stages = application_status_stages(); $stageKeys = array_keys($stages); $currentIndex = array_search($result['status'], $stageKeys, true); ?>
            <h2 class="country-directory__subheading" style="margin-top:var(--space-8)">Status</h2>
            <ul class="status-timeline">
                <?php foreach ($stages as $key => $label): $i = array_search($key, $stageKeys, true); ?>
                <li class="<?= $i < $currentIndex ? 'is-complete' : ($i === $currentIndex ? 'is-current' : '') ?>">
                    <div class="status-title"><?= e($label) ?></div>
                    <?php if (isset($historyByStatus[$key])): ?>
                    <div class="status-meta"><?= e(date('d M Y', strtotime((string) $historyByStatus[$key]['created_at']))) ?></div>
                    <?php elseif ($i === $currentIndex): ?>
                    <div class="status-meta">In progress</div>
                    <?php endif; ?>
                </li>
                <?php endforeach; ?>
            </ul>
            <p style="margin-top:var(--space-6)">For document, payment, or appointment details, <a href="/login/">log in to your dashboard</a>.</p>
            <?php else: ?>
            <div class="alert alert-warning">
                <div>
                    <strong>We couldn't find a matching application.</strong>
                    Double-check your application number and email, or <a href="/contact/">contact our team</a> for help.
                </div>
            </div>
            <?php endif; ?>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
