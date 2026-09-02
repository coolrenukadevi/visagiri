<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

$crumb = [['label' => 'Home', 'href' => url('/')], ['label' => 'Request Visa Information']];
$page = [
  'title' => 'Request Visa Information | ' . SITE['name'],
  'short_title' => 'Request Visa Information',
  'description' => "Tell us your destination country and visa type — a " . SITE['name'] . " visa expert will follow up with the exact requirements.",
  'path' => '/visa/request-info',
  'jsonld' => [breadcrumb_schema($crumb)],
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<section class="page-hero">
  <div class="container">
    <?= breadcrumbs($crumb) ?>
    <p class="eyebrow">Tell us what you need</p>
    <h1>Request visa information</h1>
    <p class="page-hero-sub">Fill in the form below with your destination and visa type and a <?= e(SITE['name']) ?> visa expert will follow up with exact, current requirements.</p>
  </div>
</section>
<main><?= enquiry_widget('', '') ?></main>
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
