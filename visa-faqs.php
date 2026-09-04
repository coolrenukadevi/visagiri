<?php
$page_title = "Visa FAQs &ndash; Common Questions, Answered | Visa Agency";
$page_description = "Answers to the visa questions we're asked most often &mdash; eligibility, documents, timing and process. For destination-specific FAQs, see the relevant country page.";
$page_canonical = 'https://visaagency.in/visa-faqs';
include __DIR__ . '/includes/header.php';

$faqs = [
    ['q' => 'How far in advance should I apply for a visa?', 'a' => 'As early as the destination allows &mdash; many authorities open applications weeks to a few months before travel. See our <a href="visa-application-timing">application timing guide</a> for category-specific guidance.'],
    ['q' => 'What documents do I need for a visa application?', 'a' => 'It depends on your destination and visa category, but almost every application needs a valid passport, recent photographs, financial proof and purpose-of-travel evidence. Use our <a href="visa-checklist">Document Checklist tool</a> for a list tailored to you.'],
    ['q' => 'Can Visa Agency guarantee my visa will be approved?', 'a' => 'No consultancy can guarantee approval for any destination &mdash; the decision is always made solely by the relevant embassy, consulate or immigration authority. We help you present the strongest, most complete application possible.'],
    ['q' => 'Do I need travel insurance for my visa application?', 'a' => 'Some destinations require it &mdash; the Schengen Area, for example, mandates a minimum &euro;30,000 of travel medical cover. Others don\'t require it for the visa itself, though we generally recommend it. Check your destination\'s specific requirement.'],
    ['q' => 'What happens if my visa application is refused?', 'a' => 'You typically have the option to reapply, addressing whatever the refusal letter cited. See our <a href="visa-refusal">Rejection Guide</a> for common reasons and how to strengthen a reapplication.'],
    ['q' => 'Is a visa interview always required?', 'a' => 'No &mdash; many categories and destinations are decided entirely on document review. Where an interview is required, see our <a href="visa-interview-guide">Interview Guide</a> for how to prepare.'],
    ['q' => 'What\'s the difference between a visa fee and your service fee?', 'a' => 'The government/embassy fee is set and collected by the destination\'s authority and goes entirely to them. Our service fee, quoted separately, covers document review, application preparation and support. See our <a href="visa-fee-calculator">Fee Calculator</a> for how these typically break down.'],
    ['q' => 'Can I track my application after it\'s submitted?', 'a' => 'Yes &mdash; use our <a href="track-application">Track Your Application</a> page, or the official tracking portal for your destination where one exists.'],
];
?>
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape"><img src="assets/img/inner-page/shape.png" alt="img"></div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa FAQs</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li><a href="resources">Resources</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa FAQs</li>
                    </ul>
                </div>
            </div>
        </section>

        <section id="visa-faq" class="section-padding fix">
            <div class="container">
                <div class="row g-5 align-items-start">
                    <div class="col-lg-4">
                        <div class="section-title mb-0">
                            <span class="sub-title-2 wow fadeInUp">Help</span>
                            <h2 class="split-text-right split-text-in-right">Frequently Asked Questions</h2>
                        </div>
                        <p class="text mt-3">Cross-cutting questions we hear most often. For a specific destination's FAQs, see that <a href="country-list">country's page</a>.</p>
                    </div>
                    <div class="col-lg-8">
                        <div class="faq-accordion">
                            <?php foreach ($faqs as $i => $faq): ?>
                            <div class="faq-item<?php echo $i === 0 ? ' active' : ''; ?>">
                                <div class="faq-question"><?php echo htmlspecialchars($faq['q']); ?> <i class="fa-solid fa-plus"></i></div>
                                <div class="faq-answer"><p><?php echo $faq['a']; ?></p></div>
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>
                <div class="text-center mt-5">
                    <a href="contact" class="theme-btn" data-open-enquiry>Ask Us Your Question <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </div>
        </section>

<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'FAQPage',
    'mainEntity' => array_map(function ($f) {
        return ['@type' => 'Question', 'name' => $f['q'], 'acceptedAnswer' => ['@type' => 'Answer', 'text' => strip_tags($f['a'])]];
    }, $faqs),
], JSON_UNESCAPED_SLASHES); ?>
</script>
<script type="application/ld+json">
<?php echo json_encode([
    '@context' => 'https://schema.org',
    '@type' => 'BreadcrumbList',
    'itemListElement' => [
        ['@type' => 'ListItem', 'position' => 1, 'name' => 'Home', 'item' => 'https://visaagency.in/'],
        ['@type' => 'ListItem', 'position' => 2, 'name' => 'Resources', 'item' => 'https://visaagency.in/resources'],
        ['@type' => 'ListItem', 'position' => 3, 'name' => 'Visa FAQs', 'item' => $page_canonical],
    ],
], JSON_UNESCAPED_SLASHES); ?>
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
