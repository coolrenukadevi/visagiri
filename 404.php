<?php
if (!defined('SITE_NAME')) {
    require __DIR__ . '/includes/config.php';
    require __DIR__ . '/includes/functions.php';
    require __DIR__ . '/includes/auth.php';
}
http_response_code(404);

$pageTitle = 'Page not found — Videshia';
$robotsMeta = 'noindex, follow';
require __DIR__ . '/includes/header.php';
?>

<section class="section" style="padding-top:90px;padding-bottom:110px;text-align:center">
    <div class="container" style="max-width:560px">
        <span class="eyebrow">404</span>
        <h1 style="margin-top:14px">We couldn't find that page.</h1>
        <p style="font-size:16px">The page may have moved, or the link may be out of date. Try searching from one of the sections below, or head back home.</p>

        <form action="<?= url('visa/') ?>" method="get" style="max-width:420px;margin:28px auto" data-validate novalidate>
            <div class="input-wrap" style="display:flex;gap:10px">
                <input class="form-control" type="text" name="q" placeholder="Search for a country or visa type">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>

        <div class="hero-actions" style="justify-content:center">
            <a href="<?= url('index.php') ?>" class="btn btn-ghost">Home</a>
            <a href="<?= url('visa/') ?>" class="btn btn-ghost">Visa Services</a>
            <a href="<?= url('contact.php') ?>" class="btn btn-primary">Contact us</a>
        </div>
    </div>
</section>

<?php require __DIR__ . '/includes/footer.php'; ?>
