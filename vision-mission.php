<?php
$page_title = "Vision &amp; Mission &ndash; Visa Agency";
$page_description = "Visa Agency's vision and mission &ndash; making the paperwork stage of travel ordinary, with a tracked, transparent process handled by one caseworker per file.";
include __DIR__ . '/includes/header.php';

$vm_placards = [
    ['title' => 'Transparency over guesswork', 'text' => 'You always know which stage your application is at and what happens next, instead of waiting on an unexplained status.', 'icon' => '<path d="M4 12l5 5L20 6"/>'],
    ['title' => 'Consistency across every destination', 'text' => 'The same documentation rigour applies whether your file is headed to a nearby consulate or a country we rarely process, because the standard does not change by destination.', 'icon' => '<circle cx="12" cy="12" r="9"/><path d="M12 3a9 9 0 0 1 0 18M3 12h18"/>'],
    ['title' => "Honesty about what we don't control", 'text' => "We're upfront that the final visa decision belongs to the embassy or authority, not us &mdash; our job is to remove every avoidable reason for delay or refusal.", 'icon' => '<rect x="4" y="10" width="16" height="10" rx="1.5"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>'],
];
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Vision &amp; Mission</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="about">About Us</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Vision &amp; Mission</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- ============ LEDE (navy band) ============ -->
        <section style="background:var(--theme-2); color:var(--white); padding:44px 0 40px;">
            <div class="container">
                <p class="ab-hero-lead" style="color:rgba(255,255,255,.82); font-size:1.05rem; max-width:70ch; margin:0;">Two pages, one booklet &mdash; what we're working toward, and how we handle every file to get there.</p>
            </div>
        </section>

        <!-- ============ VISION / MISSION MINI-BOARDS ============ -->
        <section class="section-padding fix">
            <div class="container">
                <div class="ab2-mini-board-pair">
                    <div class="ab2-mini-board">
                        <div class="mb-head">Vision</div>
                        <h3 style="color:var(--white); font-family:inherit; text-transform:none; font-size:1.3rem; font-weight:700; margin:0 0 12px; line-height:1.3;">A border that isn't the hardest part of the trip.</h3>
                        <p style="color:rgba(255,255,255,.75); font-size:.92rem; line-height:1.7; margin:0;">We want the paperwork stage of travel to feel ordinary &mdash; something you complete quickly and stop thinking about, not the part of the trip you dread. Every process we build works toward that, replacing guesswork with a tracked, transparent process, city by city.</p>
                    </div>
                    <div class="ab2-mini-board">
                        <div class="mb-head">Mission</div>
                        <h3 style="color:var(--white); font-family:inherit; text-transform:none; font-size:1.3rem; font-weight:700; margin:0 0 12px; line-height:1.3;">Handle every file with the same precision, start to finish.</h3>
                        <p style="color:rgba(255,255,255,.75); font-size:.92rem; line-height:1.7; margin:0;">We review, format and check every document against the exact standard each consulate expects, and assign one caseworker who stays with your application from intake to appointment &mdash; while being upfront that final decisions rest with the relevant embassy or authority.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ WHAT THIS LOOKS LIKE: PLACARDS ============ -->
        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="section-title text-center">
                    <span class="sub-title-2 wow fadeInUp">What This Looks Like In Practice</span>
                    <h2 class="split-text-right split-text-in-right">Three Commitments Behind The Mission</h2>
                    <p style="margin-top:10px;">Vision and mission statements are easy to write and easy to ignore &mdash; here's what ours actually means for how your file is handled.</p>
                </div>
                <div class="ab2-placards">
                    <?php foreach ($vm_placards as $t): ?>
                    <div class="ab2-placard">
                        <div class="tile"><svg viewBox="0 0 24 24"><?php echo $t['icon']; ?></svg></div>
                        <div>
                            <h3><?php echo htmlspecialchars($t['title']); ?></h3>
                            <p><?php echo $t['text']; ?></p>
                        </div>
                    </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want To Talk To The Team Directly?</h3>
                            <p>Book a consultation or send us your case details &mdash; we'll get back to you promptly.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Start Your Visa Enquiry</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Call +91 78448 19819</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
