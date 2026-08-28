<?php
$page_meta = [
    'title' => 'Security & Compliance | Paynancial',
    'description' => 'How Paynancial protects data, authentication and transactions across its platform.',
];
?>
<section style="padding-top:56px;">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Security</span>
      <h1>Security built into every transaction.</h1>
      <p class="lead">Protecting customer and business data is a foundational design requirement across the Paynancial platform, not an afterthought.</p>
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container grid grid-3">
    <?php
    $sec = [
        ['Data Protection', 'Sensitive fields are encrypted, and database access is restricted by role.'],
        ['Secure Authentication', 'Passwords are hashed with bcrypt/Argon2 via PHP\'s password_hash(); plaintext passwords are never stored.'],
        ['Encrypted Communication', 'All traffic between browsers and our servers is served over HTTPS/TLS.'],
        ['Access Control', 'Role-based access control governs every customer, partner, employee, HR and admin portal.'],
        ['Transaction Monitoring', 'Login attempts and account activity are logged for audit and monitoring purposes.'],
        ['Fraud Prevention', 'Rate limiting, account lockout and session controls reduce common attack vectors.'],
    ];
    foreach ($sec as [$title, $desc]): ?>
      <div class="card reveal">
        <span class="card-icon">🛡</span>
        <h3><?= e($title) ?></h3>
        <p><?= e($desc) ?></p>
      </div>
    <?php endforeach; ?>
  </div>
</section>

<section>
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Certifications &amp; Compliance</span>
      <h2>Verified certifications</h2>
    </div>
    <div class="module-stub reveal">
      <strong>No certifications published yet</strong>
      This section is reserved for verified certifications and regulatory approvals (e.g. PCI DSS, ISO, RBI authorization). They will appear here — manageable from the admin CMS — once formally issued and confirmed, and are not claimed before then.
    </div>
  </div>
</section>

<section class="section-subtle">
  <div class="container">
    <div class="section-head reveal">
      <span class="eyebrow">Report an Issue</span>
      <h2>Found a security concern?</h2>
      <p>Email <a href="mailto:hello@paynancial.com">hello@paynancial.com</a> with details and our team will respond promptly.</p>
    </div>
  </div>
</section>
