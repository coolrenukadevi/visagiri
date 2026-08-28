<?php
$legal_slug = $legal_slug ?? '';

$legalPages = [
    'privacy-policy' => [
        'title' => 'Privacy Policy',
        'body' => 'Paynancial Technology Pvt. Ltd. collects only the information necessary to provide our payment services, including account, transaction and support data. Data is stored securely and is never sold to third parties. This is placeholder legal copy — replace with counsel-reviewed content before go-live.',
    ],
    'terms-conditions' => [
        'title' => 'Terms & Conditions',
        'body' => 'Use of the Paynancial platform is subject to these terms. Businesses onboarding to Paynancial must complete KYC verification and comply with applicable payment regulations. This is placeholder legal copy — replace with counsel-reviewed content before go-live.',
    ],
    'refund-policy' => [
        'title' => 'Refund Policy',
        'body' => 'Refunds are processed back to the original payment method once approved. Processing timelines depend on the payment method and issuing bank. This is placeholder legal copy — replace with counsel-reviewed content before go-live.',
    ],
    'cookie-policy' => [
        'title' => 'Cookie Policy',
        'body' => 'Paynancial uses strictly necessary cookies for authentication and session security. We do not use third-party advertising cookies. This is placeholder legal copy — replace with counsel-reviewed content before go-live.',
    ],
];

$page = $legalPages[$legal_slug] ?? null;

if ($page === null) {
    http_response_code(404);
    $page_meta = ['title' => 'Page Not Found | Paynancial'];
    ?>
    <section style="padding:96px 0;text-align:center;">
      <div class="container"><h1>We couldn't find that policy.</h1><a href="/" class="btn btn-primary" style="margin-top:24px;">Back to Home</a></div>
    </section>
    <?php
    return;
}

$page_meta = [
    'title' => $page['title'] . ' | Paynancial',
    'description' => $page['title'] . ' for Paynancial Technology Pvt. Ltd.',
];
?>
<section style="padding:64px 0;">
  <div class="container" style="max-width:760px;">
    <span class="eyebrow">Legal</span>
    <h1 style="margin-top:12px;"><?= e($page['title']) ?></h1>
    <p class="text-muted" style="margin-top:8px;">Last updated: <?= e(date('d M Y')) ?></p>
    <div style="margin-top:32px;line-height:1.8;color:var(--text);">
      <p><?= e($page['body']) ?></p>
    </div>
  </div>
</section>
