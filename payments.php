<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Payments']];
$page = [
  'title' => 'Payment Methods | ' . SITE['name'],
  'short_title' => 'Payment Methods',
  'description' => 'How to pay ' . SITE['name'] . ' for visa consultation and service charges — accepted payment methods, invoicing, and receipts.',
  'path' => '/payments',
  'jsonld' => [breadcrumb_schema($crumb)],
];
$methods = [
  ['💳', 'Credit / Debit Card', 'Visa, Mastercard and RuPay cards accepted via our secure payment link.'],
  ['📱', 'UPI', 'Google Pay, PhonePe, Paytm and any UPI ID.'],
  ['🏦', 'Net Banking', 'All major Indian banks supported via our payment partner.'],
  ['🔁', 'Bank Transfer (NEFT / RTGS / IMPS)', 'Ask your consultant for current account details for direct transfer.'],
  ['🧾', 'Cash at office', 'Accepted at our Patna head office by prior appointment.'],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<section class="page-hero">
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <p class="eyebrow">Billing &amp; payments</p>
    <h1>Payment methods</h1>
    <p class="page-hero-sub"><?= e(SITE['name']) ?>'s visa consultation and service charges are separate from the destination country's own visa fee (which is paid to the embassy/consulate or its official portal directly). Here's how to pay us.</p>
  </div>
</section>
<main>
  <section class="section">
    <div class="container">
      <div class="info-grid">
        <?php foreach ($methods as [$icon, $name, $detail]): ?>
        <div class="info-card"><h3><?= e($icon) ?> <?= e($name) ?></h3><p><?= e($detail) ?></p></div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>
  <section class="section section-alt">
    <div class="container">
      <div class="info-grid">
        <div class="info-card"><h3>Invoices &amp; receipts</h3><p>A receipt is issued for every payment. GST-compliant invoices are available on request — ask your consultant when you pay.</p></div>
        <div class="info-card"><h3>Security</h3><p>Card and UPI payments are processed by our payment partner over an encrypted connection — <?= e(SITE['name']) ?> does not store your card details.</p></div>
        <div class="info-card"><h3>Refunds</h3><p>Refund eligibility depends on the stage of your application — talk to your consultant before requesting a refund.</p></div>
        <div class="info-card"><h3>Payment queries</h3><p>Call <?= e(SITE['phone']) ?> or email <a href="mailto:<?= e(SITE['email']) ?>" style="color:var(--brand-blue);"><?= e(SITE['email']) ?></a> for anything payment-related.</p></div>
      </div>
    </div>
  </section>
</main>
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
