<?php
/**
 * About — Visa Agency (design preview)
 * Content is data-driven on purpose: the "Why choose us" and "Leadership"
 * sections are rendered from PHP arrays below, so copy can be edited here
 * without touching markup.
 */

$whyUs = [
    [
        'title' => 'Document precision',
        'desc'  => 'Every file is checked line by line by caseworkers before it ever reaches an embassy.',
        'icon'  => 'check',
    ],
    [
        'title' => 'Transparent pricing',
        'desc'  => 'Your filing fee is quoted before you commit, with consulate and government charges shown separately.',
        'icon'  => 'tag',
    ],
    [
        'title' => 'Country specialists',
        'desc'  => 'You are assigned one caseworker who handles that destination regularly, not a rotating call queue that re-reads your file each time.',
        'icon'  => 'globe',
    ],
    [
        'title' => 'A file you can watch',
        'desc'  => 'A private tracking page shows the exact stage your application is at, from intake to the day it reaches the visa window.',
        'icon'  => 'track',
    ],
    [
        'title' => '24×7 support when it matters',
        'desc'  => 'Reach your caseworker or the support desk outside office hours if something on your file needs urgent attention.',
        'icon'  => 'clock',
    ],
];

$team = [
    [
        'role'  => 'Founder & Director',
        'bio'   => 'Sets the direction for the agency and signs off on how every regional desk operates.',
    ],
    [
        'role'  => 'Head of Visa Operations',
        'bio'   => 'Oversees every regional desk and signs off on documentation standards before a file is ever submitted.',
    ],
    [
        'role'  => 'Head of Apostille & Attestation',
        'bio'   => 'Runs the attestation and apostille desk for documents that need to be legalised before filing.',
    ],
    [
        'role'  => 'Client Experience Lead',
        'bio'   => 'Runs the tracking portal and support line, and is usually the person you will speak to if a date needs to move.',
    ],
];

function initials(string $name): string {
    $parts = explode(' ', trim($name));
    $out = '';
    foreach ($parts as $p) { $out .= mb_strtoupper(mb_substr($p, 0, 1)); }
    return $out;
}
?>

<?php
$pageTitle = 'About — Visa Agency (Design Preview)';
$pageDescription = 'Design concept preview — document precision, country specialists, and transparent pricing.';
$activeNav = 'about';
include __DIR__ . '/header.php';
?>
  <!-- OVERVIEW -->
  <section class="hero" id="overview">
    <div class="wrap hero-grid">
      <div>
        <span class="badge">Licensed consultancy</span>
        <h1>Getting you across the border, on paper and in practice.</h1>
        <p class="hero-lead">
          Visa Agency handles the documentation side of travel: the forms, the
          appointment slots, the follow-up calls to embassies. We file for
          students, workers, and families across a wide range of destinations,
          and tell you exactly where your file stands at every step.
        </p>
        <div class="hero-actions">
          <a class="btn btn-solid" href="#why-choose-us">See how we work</a>
          <a class="btn btn-ghost" href="#leadership">Meet the team</a>
        </div>
      </div>

      <div class="stamp-frame">
        <svg class="stamp-svg" viewBox="0 0 260 260">
          <circle class="ring-dash" cx="130" cy="130" r="118"/>
          <circle class="ring" cx="130" cy="130" r="98"/>
          <path id="curveTop" d="M 32,130 A 98,98 0 1,1 228,130" fill="none"/>
          <path id="curveBottom" d="M 228,132 A 98,98 0 1,1 32,132" fill="none"/>
          <text><textPath href="#curveTop" startOffset="50%" text-anchor="middle">VISA AGENCY</textPath></text>
          <text><textPath href="#curveBottom" startOffset="50%" text-anchor="middle">LICENSED CONSULTANCY</textPath></text>
          <g class="mark" transform="translate(130,130)">
            <path d="M-28,6 L28,6 M-18,6 L-28,-14 L-20,-14 L-6,6 M18,6 L28,-14 L20,-14 L6,6"/>
            <circle r="3" fill="currentColor" stroke="none"/>
          </g>
        </svg>
      </div>
    </div>
  </section>

  <!-- WHY CHOOSE US -->
  <section id="why-choose-us">
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">Why us</span>
        <h2>What clients mention when they refer a friend.</h2>
        <p>None of this is aspirational copy — it's the actual process every file goes through before it leaves our office.</p>
      </div>

      <div class="why-list">
        <?php
        $icons = [
            'check' => '<path d="M4 12l5 5L20 6"/>',
            'tag'   => '<path d="M3 12l9-9h7v7l-9 9-7-7z"/><circle cx="15" cy="8" r="1.4" fill="currentColor" stroke="none"/>',
            'globe' => '<circle cx="12" cy="12" r="9"/><path d="M3 12h18M12 3c3 3.5 3 14.5 0 18M12 3c-3 3.5-3 14.5 0 18"/>',
            'track' => '<path d="M4 6h16M4 12h10M4 18h6"/><circle cx="19" cy="18" r="2.4"/>',
            'clock' => '<circle cx="12" cy="12" r="9"/><path d="M12 7v5l4 2"/>',
        ];
        foreach ($whyUs as $item): ?>
          <div class="why-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <?php echo $icons[$item['icon']]; ?>
            </svg>
            <div>
              <h3><?php echo htmlspecialchars($item['title']); ?></h3>
              <p><?php echo htmlspecialchars($item['desc']); ?></p>
            </div>
          </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <!-- VISION & MISSION -->
  <section class="alt" id="vision-mission">
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">Vision &amp; mission</span>
        <h2>Two pages, one booklet.</h2>
      </div>

      <div class="spread">
        <div>
          <span class="tag">VISION</span>
          <h3>A border that isn't the hardest part of the trip.</h3>
          <p>
            We want the paperwork stage of travel to feel ordinary — something
            you complete in good time and stop thinking about, not the part of the
            trip you dread. Every process we build works toward that.
          </p>
        </div>
        <div>
          <span class="tag">MISSION</span>
          <h3>Handle every file with the same precision, start to finish.</h3>
          <p>
            We review, translate, and format every document to the exact
            standard each consulate expects, and assign one caseworker who
            stays with your application from intake to appointment.
          </p>
        </div>
      </div>
    </div>
  </section>

  <!-- LEADERSHIP -->
  <section id="leadership">
    <div class="wrap">
      <div class="section-head">
        <span class="kicker">Leadership</span>
        <h2>Meet our team.</h2>
        <p>The people who sign off on the work before it goes anywhere near an embassy.</p>
      </div>

      <div class="team-grid">
        <?php foreach ($team as $member): ?>
          <div class="team-card">
            <div class="avatar"><?php echo htmlspecialchars(initials($member['role'])); ?></div>
            <span class="team-role"><?php echo htmlspecialchars($member['role']); ?></span>
            <p class="bio"><?php echo htmlspecialchars($member['bio']); ?></p>
          </div>
        <?php endforeach; ?>
      </div>
    </div>
  </section>

  <!-- CTA BAND -->
  <section class="alt">
    <div class="wrap cta-band">
      <h2>Ready to start a file, or check one already in progress?</h2>
      <div class="btn-group">
        <a class="btn btn-solid" href="payment.php">Make a payment</a>
        <a class="btn btn-ghost" href="contact.php">Talk to support</a>
      </div>
    </div>
  </section>


<?php include __DIR__ . '/footer.php'; ?>
