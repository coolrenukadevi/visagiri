<?php
/**
 * Home — Visa Agency (design preview)
 */

$services = [
    [
        'tag'   => 'TOURIST',
        'title' => 'Tourist & visitor visas',
        'desc'  => 'Short-stay visas for holidays, family visits, and conferences, filed with the correct return-travel proof attached.',
    ],
    [
        'tag'   => 'STUDENT',
        'title' => 'Student visas',
        'desc'  => 'Offer-letter verification, financial proof formatting, and interview preparation for university admissions abroad.',
    ],
    [
        'tag'   => 'WORK',
        'title' => 'Work visas',
        'desc'  => 'Employer sponsorship paperwork, labour-market documentation, and dependant visas filed alongside the primary applicant.',
    ],
    [
        'tag'   => 'BUSINESS',
        'title' => 'Business visas',
        'desc'  => 'Multiple-entry business visas with invitation-letter drafting support for trade shows and client meetings.',
    ],
    [
        'tag'   => 'FAMILY',
        'title' => 'Family & spouse visas',
        'desc'  => 'Relationship-proof documentation and translated certificates handled with one caseworker for the whole family.',
    ],
    [
        'tag'   => 'RENEWAL',
        'title' => 'Renewals & extensions',
        'desc'  => 'Re-filing before an existing visa lapses, including the follow-up calls most people forget to make in time.',
    ],
];

$steps = [
    ['title' => 'Free consultation', 'desc' => 'A caseworker reviews your travel purpose and tells you which visa class and documents apply.'],
    ['title' => 'Document collection', 'desc' => 'You upload documents to your private portal; we flag anything missing or incorrectly formatted.'],
    ['title' => 'Submission & appointment', 'desc' => 'We file the completed application and book your consulate or visa-centre appointment slot.'],
    ['title' => 'Approval & delivery', 'desc' => 'Your passport and visa are tracked back to our office and couriered to you, or collected in person.'],
];

$pageTitle       = 'Visa Agency — Design Preview';
$pageDescription = 'Design concept preview — tourist, student, work, business, and family visas, filed by country specialists.';
$activeNav       = 'home';
include __DIR__ . '/header.php';
?>

  <!-- HERO -->
  <section class="hero">
    <div class="wrap hero-grid">
      <div>
        <span class="badge">Licensed visa consultancy</span>
        <h1>Six kinds of visas. One caseworker who actually answers.</h1>
        <p class="hero-lead">
          We file tourist, student, work, business, family, and renewal visas,
          reviewed by former consulate staff before they're ever submitted.
          Track your file from your phone, at any hour.
        </p>
        <div class="hero-actions">
          <a class="btn btn-solid" href="payment.php">Start an application</a>
          <a class="btn btn-ghost" href="about.php#overview">About the agency</a>
        </div>
      </div>

      <div class="stamp-frame">
        <svg class="stamp-svg" viewBox="0 0 260 260">
          <circle class="ring-dash" cx="130" cy="130" r="118"/>
          <circle class="ring" cx="130" cy="130" r="98"/>
          <path id="curveTopH" d="M 32,130 A 98,98 0 1,1 228,130" fill="none"/>
          <path id="curveBottomH" d="M 228,132 A 98,98 0 1,1 32,132" fill="none"/>
          <text><textPath href="#curveTopH" startOffset="50%" text-anchor="middle">SIX VISA CLASSES</textPath></text>
          <text><textPath href="#curveBottomH" startOffset="50%" text-anchor="middle">ONE CASEWORKER EACH</textPath></text>
          <g class="mark" transform="translate(130,130)">
            <path d="M-28,6 L28,6 M-18,6 L-28,-14 L-20,-14 L-6,6 M18,6 L28,-14 L20,-14 L6,6"/>
            <circle r="3" fill="currentColor" stroke="none"/>
          </g>
        </svg>
      </div>
    </div>
  </section>

  <!-- SERVICES -->
  <section>
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">Services</span>
        <h2>Pick a visa class, talk to a caseworker about pricing.</h2>
        <p>Consulate and government fees are separate and billed at cost — our filing fee is quoted up front once your case is reviewed.</p>
      </div>

      <div class="doc-grid">
        <?php foreach ($services as $s): ?>
          <div class="doc-card">
            <span class="tag-mono"><?php echo htmlspecialchars($s['tag']); ?></span>
            <h3><?php echo htmlspecialchars($s['title']); ?></h3>
            <p><?php echo htmlspecialchars($s['desc']); ?></p>
          </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <!-- PROCESS -->
  <section class="alt">
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">How it works</span>
        <h2>Four stages, start to finish.</h2>
      </div>

      <div class="steps">
        <?php foreach ($steps as $i => $step): ?>
          <div class="step">
            <span class="num">0<?php echo $i + 1; ?></span>
            <h3><?php echo htmlspecialchars($step['title']); ?></h3>
            <p><?php echo htmlspecialchars($step['desc']); ?></p>
          </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section>
    <div class="wrap cta-band">
      <h2>Know which visa you need? Let's get the file started.</h2>
      <div class="btn-group">
        <a class="btn btn-solid" href="payment.php">Make a payment</a>
        <a class="btn btn-ghost" href="contact.php">Talk to support</a>
      </div>
    </div>
  </section>

<?php include __DIR__ . '/footer.php'; ?>
