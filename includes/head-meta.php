<?php
require_once __DIR__ . '/partner-nav-state.php';
require_once __DIR__ . '/forex-customer-nav-state.php';
if (!isset($page_title)) { $page_title = "Visa Agency &ndash; Trusted Visa Consultant in Patna, Ranchi, Raipur & Bhopal"; }
if (!isset($page_description)) { $page_description = "Visa Agency &ndash; Trusted Visa Consultant in Patna, Ranchi, Raipur & Bhopal."; }
if (!isset($page_canonical)) {
    // Self-referencing fallback so every page gets a canonical even if the
    // including file never set one explicitly (found via full-site audit:
    // only 20 of ~280 indexable pages were setting this, including all 203
    // country pages — a real indexability gap, not an intentional omission).
    // Always points at the production host, matching how pages that do set
    // $page_canonical by hand already do it (hardcoded https://visaagency.in/...),
    // since canonical is a statement about the authoritative production URL
    // regardless of which host actually served this request (local dev, etc.).
    $__canonicalPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
    $__canonicalPath = '/' . ltrim($__canonicalPath, '/');
    if ($__canonicalPath !== '/') {
        $__canonicalPath = rtrim($__canonicalPath, '/');
    }
    $page_canonical = 'https://visaagency.in' . $__canonicalPath;
}
if (!isset($page_noindex)) { $page_noindex = false; }
if (!isset($page_og_title)) { $page_og_title = $page_title; }
if (!isset($page_og_description)) { $page_og_description = $page_description; }
require_once __DIR__ . '/site-contact.php';
?>
<!DOCTYPE html>
<html lang="en">
    <!--<< Header Area >>-->
    <head>
       <!-- ========== Meta Tags ========== -->
        <meta charset="UTF-8">
        <?php
        // Every relative href/src/action/fetch URL on the site assumes it's
        // being resolved from a single-segment root URL (e.g. /contact).
        // Nested URLs like /countries/australia-tourist-visa/ would otherwise
        // resolve those relative references one level too deep. An explicit
        // <base> (computed from the current request, not hardcoded, so local
        // dev keeps working) fixes every page without touching every link.
        $__siteScheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';
        $__siteBase = $__siteScheme . '://' . $_SERVER['HTTP_HOST'] . '/';
        ?>
        <base href="<?php echo htmlspecialchars($__siteBase); ?>">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="Visa Agency">
        <meta name="description" content="<?php echo $page_description; ?>">
        <?php if ($page_canonical): ?><link rel="canonical" href="<?php echo $page_canonical; ?>"><?php endif; ?>
        <?php if ($page_noindex): ?><meta name="robots" content="noindex, nofollow"><?php endif; ?>
        <meta property="og:type" content="website">
        <meta property="og:title" content="<?php echo $page_og_title; ?>">
        <meta property="og:description" content="<?php echo $page_og_description; ?>">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="<?php echo $page_og_title; ?>">
        <meta name="twitter:description" content="<?php echo $page_og_description; ?>">
        <!-- ======== Page title ============ -->
        <title><?php echo $page_title; ?></title>
        <!--<< Favcion >>-->
         <link rel="shortcut icon" href="assets/img/favicon.png">
        <!--<< Bootstrap min.css >>-->
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <!--<< All Min Css >>-->
        <link rel="stylesheet" href="assets/css/all.min.css">
        <!--<< Animate.css >>-->
        <link rel="stylesheet" href="assets/css/animate.css">
        <!--<< Magnific Popup.css >>-->
        <link rel="stylesheet" href="assets/css/magnific-popup.css">
        <!--<< MeanMenu.css >>-->
        <link rel="stylesheet" href="assets/css/meanmenu.css">
         <!--<< Odometer.css >>-->
        <link rel="stylesheet" href="assets/css/odometer.css">
        <!--<< Swiper Bundle.css >>-->
        <link rel="stylesheet" href="assets/css/swiper-bundle.min.css">
        <!--<< Nice Select.css >>-->
        <link rel="stylesheet" href="assets/css/nice-select.css">
        <!--<< Main.css >>-->
        <link rel="stylesheet" href="assets/css/main.css">
        <link rel="stylesheet" href="assets/css/custom.css">
        <link rel="stylesheet" href="assets/css/home-redesign.css">

        <?php include __DIR__ . '/schema.php'; ?>
    </head>
    <body class="smooth-scroll-yes">
