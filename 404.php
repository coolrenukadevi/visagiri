<?php
declare(strict_types=1);
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/partials.php';
require_once __DIR__ . '/lib-php/auth.php';

// Must run before any output — see index.php for why.
auth_session_start();

http_response_code(404);
$page = [
  'title' => 'Page not found | ' . SITE['name'],
  'short_title' => 'Page not found',
  'description' => 'The page you requested could not be found.',
  'path' => '/404',
];
?><!DOCTYPE html>
<html lang="en">
<head><?php include __DIR__ . '/includes/head.php'; ?><meta name="robots" content="noindex, follow"></head>
<body>
<?php include __DIR__ . '/includes/header.php'; ?>
<section class="page-hero">
  <div class="hero-bg" aria-hidden="true">
    <svg class="hero-blob hero-blob-1" viewBox="0 0 600 600" xmlns="http://www.w3.org/2000/svg"><path fill="url(#hg4)" d="M451.5,318.5Q447,387,388,428.5Q329,470,264.5,447Q200,424,144,384.5Q88,345,90.5,272.5Q93,200,148,155.5Q203,111,271.5,95Q340,79,391.5,127Q443,175,458.5,246.5Q474,318,451.5,318.5Z"/><defs><linearGradient id="hg4" x1="0" y1="0" x2="600" y2="600"><stop stop-color="#29b6f6"/><stop offset="1" stop-color="#0f1b3d"/></linearGradient></defs></svg>
  </div>
  <div class="container">
    <p class="eyebrow">404</p>
    <h1>Looks like this visa page took a different route.</h1>
    <p class="page-hero-sub">The page you were looking for doesn't exist, or has moved. Here's how to get back on track.</p>
    <div class="quick-actions">
      <a href="<?= url('/visa-finder') ?>" class="btn btn-primary">Visa Finder</a>
      <a href="<?= url('/countries') ?>" class="btn btn-outline">Search visas</a>
      <a href="<?= url('/') ?>" class="btn btn-outline">Go home</a>
      <a href="<?= url('/contact') ?>" class="btn btn-outline">Contact a consultant</a>
    </div>
  </div>
</section>
<main><?php include __DIR__ . '/includes/service-console.php'; ?></main>
<?php include __DIR__ . '/includes/footer.php'; ?>
</body>
</html>
