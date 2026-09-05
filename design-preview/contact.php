<?php
/**
 * Contact / Support — Visa Agency (design preview)
 */

$sitePhoneDisplay = '+91 78448 19819';
$sitePhoneE164    = '+917844819819';
$siteEmail        = 'info@visaagency.in';
$siteAddress      = '#302, Sharda Mansion Apartment, Kailash Puri, Hanuman Nagar, Patna, Bihar 800020';

$faqs = [
    [
        'q' => 'How do I check the status of an existing application?',
        'a' => 'Sign in to your tracking portal using the link sent to your email when your file was opened. If you cannot find it, send your application reference through the form below.',
    ],
    [
        'q' => 'Can I change my appointment date after booking?',
        'a' => 'Contact your assigned caseworker directly, or use this form and mark the message urgent.',
    ],
    [
        'q' => 'What happens if a consulate rejects my visa?',
        'a' => 'We review the rejection letter with you at no charge and advise whether a re-application is likely to succeed before you pay a second filing fee.',
    ],
    [
        'q' => 'Do you handle visas for countries not listed on the homepage?',
        'a' => 'The homepage shows visa types, not every destination we cover. Ask your caseworker or use the form below to confirm coverage for your destination.',
    ],
];

$pageTitle       = 'Support — Visa Agency (Design Preview)';
$pageDescription = 'Design concept preview — reach the Visa Agency support desk by phone, email, or the contact form.';
$activeNav       = 'contact';
include __DIR__ . '/header.php';
?>

  <!-- INTRO -->
  <section class="hero" style="padding:64px 0 56px;">
    <div class="wrap">
      <span class="badge">Support</span>
      <h1 style="max-width:20ch;">Talk to the desk handling your file.</h1>
      <p class="hero-lead">
        For fastest answers, include your application reference — it routes
        your message straight to the caseworker already assigned to you.
      </p>
    </div>
  </section>

  <!-- CONTACT INFO -->
  <section>
    <div class="wrap">
      <div class="info-grid">
        <div class="info-card">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M4 5h4l2 5-2.5 1.5a11 11 0 0 0 5 5L14 14l5 2v4a2 2 0 0 1-2 2C9.6 22 2 14.4 2 5a2 2 0 0 1 2-2z"/></svg>
          <h3>Phone</h3>
          <p><a href="tel:<?php echo htmlspecialchars($sitePhoneE164); ?>" style="color:inherit; text-decoration:none;"><?php echo htmlspecialchars($sitePhoneDisplay); ?></a></p>
        </div>
        <div class="info-card">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M4 4h16v16H4z"/><path d="M4 6l8 7 8-7"/></svg>
          <h3>Email</h3>
          <p><a href="mailto:<?php echo htmlspecialchars($siteEmail); ?>" style="color:inherit; text-decoration:none;"><?php echo htmlspecialchars($siteEmail); ?></a></p>
        </div>
        <div class="info-card">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M12 21s7-6.5 7-11a7 7 0 0 0-14 0c0 4.5 7 11 7 11z"/><circle cx="12" cy="10" r="2.5"/></svg>
          <h3>Office</h3>
          <p><?php echo htmlspecialchars($siteAddress); ?></p>
        </div>
      </div>
    </div>
  </section>

  <!-- FORM + FAQ -->
  <section class="alt">
    <div class="wrap">
      <div class="two-col">

        <div>
          <div class="section-head" style="margin-bottom:28px;">
            <span class="kicker">Send a message</span>
            <h2>Get in touch.</h2>
          </div>

          <div class="alert">
            This is a design preview — the form below is illustrative only and is not connected to email yet.
          </div>

          <form method="post" action="#" id="contact-form" onsubmit="return false;">
            <div class="field">
              <label for="cname">Name</label>
              <input type="text" id="cname" name="name">
            </div>
            <div class="field">
              <label for="cemail">Email</label>
              <input type="email" id="cemail" name="email">
            </div>
            <div class="field">
              <label for="cref">Application reference (optional)</label>
              <input type="text" id="cref" name="refnum" placeholder="e.g. VA-2026-0417">
            </div>
            <div class="field">
              <label for="cmessage">Message</label>
              <textarea id="cmessage" name="message" rows="5"></textarea>
            </div>
            <button type="submit" class="btn btn-solid" style="border:none; cursor:pointer;">Send message</button>
          </form>
        </div>

        <div>
          <div class="section-head" style="margin-bottom:8px;">
            <span class="kicker">Common questions</span>
            <h2>Before you write in.</h2>
          </div>
          <div>
            <?php foreach ($faqs as $item): ?>
              <details class="faq-item">
                <summary><?php echo htmlspecialchars($item['q']); ?></summary>
                <p><?php echo htmlspecialchars($item['a']); ?></p>
              </details>
            <?php endforeach; ?>
          </div>
        </div>

      </div>
    </div>
  </section>

<?php include __DIR__ . '/footer.php'; ?>
