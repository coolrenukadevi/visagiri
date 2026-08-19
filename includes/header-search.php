<?php
$header_search_index = [];
foreach ($VISA_AGENCY_COUNTRIES as $hc) {
    $header_search_index[] = [
        't' => $hc['name'] . ' Visa',
        'u' => 'country-' . $hc['slug'],
        'y' => 'Country',
        'i' => 'fa-earth-americas',
        's' => $hc['slug'],
    ];
}
$header_search_curated = [
    ['t' => 'Tourist Visa', 'u' => 'visa-tourist', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Business Visa', 'u' => 'visa-business', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Family Visa', 'u' => 'visa-family', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Transit Visa', 'u' => 'visa-transit', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Sports Visa', 'u' => 'visa-sports', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Medical Visa', 'u' => 'visa-medical', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Crew Visa', 'u' => 'visa-crew', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Visa Extension', 'u' => 'visa-extension', 'y' => 'Visa', 'i' => 'fa-passport'],
    ['t' => 'Apostille & Attestation Overview', 'u' => 'apostille', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'MEA Apostille', 'u' => 'apostille-mea', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'Embassy Attestation', 'u' => 'apostille-embassy-attestation', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'Certificate Attestation', 'u' => 'apostille-certificate-attestation', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'Document Legalisation', 'u' => 'apostille-document-legalisation', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'Translation Services', 'u' => 'apostille-translation-services', 'y' => 'Apostille', 'i' => 'fa-stamp'],
    ['t' => 'All Services Directory', 'u' => 'our-services', 'y' => 'Services', 'i' => 'fa-briefcase'],
    ['t' => 'Visa Consultancy Services', 'u' => 'visa-consultancy-services', 'y' => 'Services', 'i' => 'fa-briefcase'],
    ['t' => 'Visa Requirements Checker', 'u' => 'visa-requirements', 'y' => 'Resource', 'i' => 'fa-book-open'],
    ['t' => 'Visa Document Checklist', 'u' => 'visa-checklist', 'y' => 'Resource', 'i' => 'fa-book-open'],
    ['t' => 'Book a Visa Appointment', 'u' => 'visa-appointment', 'y' => 'Resource', 'i' => 'fa-book-open'],
    ['t' => 'Visa News & Updates', 'u' => 'visa-news', 'y' => 'Resource', 'i' => 'fa-book-open'],
    ['t' => 'Visa Refusal Guidance', 'u' => 'visa-refusal', 'y' => 'Resource', 'i' => 'fa-book-open'],
    ['t' => 'Country Directory', 'u' => 'country-list', 'y' => 'Countries', 'i' => 'fa-globe'],
    ['t' => 'About VisaAgency.in', 'u' => 'about', 'y' => 'Company', 'i' => 'fa-building'],
    ['t' => 'Careers', 'u' => 'careers', 'y' => 'Company', 'i' => 'fa-building'],
    ['t' => 'Contact Us', 'u' => 'contact', 'y' => 'Company', 'i' => 'fa-headset'],
];
$header_search_index = array_merge($header_search_curated, $header_search_index);
?>
        <button type="button" class="header-search-toggle" id="headerSearchToggle" aria-label="Search country, visa type or service">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
        <div class="header-search-panel" id="headerSearchPanel" aria-hidden="true">
            <div class="header-search-box">
                <div class="header-search-field">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="headerSearchInput" placeholder="Search country, visa type or service...">
                    <button type="button" class="header-search-close" id="headerSearchClose" aria-label="Close search">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
                <div class="header-search-results" id="headerSearchResults"></div>
                <div class="header-search-hint">Try: <b>USA Tourist Visa</b>, <b>UK Business Visa</b>, <b>Schengen Visa</b>, <b>Apostille</b>, <b>Document Checklist</b></div>
            </div>
        </div>
        <script>
        (function () {
            var HEADER_SEARCH_INDEX = <?php echo json_encode($header_search_index, JSON_UNESCAPED_SLASHES); ?>;
            var toggle = document.getElementById('headerSearchToggle');
            var panel = document.getElementById('headerSearchPanel');
            var input = document.getElementById('headerSearchInput');
            var results = document.getElementById('headerSearchResults');
            var closeBtn = document.getElementById('headerSearchClose');
            if (!toggle || !panel || !input || !results) { return; }

            function iconFor(y) {
                if (y === 'Country') { return 'fa-earth-americas'; }
                if (y === 'Apostille') { return 'fa-stamp'; }
                if (y === 'Countries') { return 'fa-globe'; }
                if (y === 'Company') { return 'fa-building'; }
                return 'fa-passport';
            }

            function render(query) {
                var q = query.trim().toLowerCase();
                results.innerHTML = '';
                if (!q) {
                    results.innerHTML = '<div class="header-search-empty">Start typing to search 200+ countries, visa types and services.</div>';
                    return;
                }
                function rank(item) {
                    var slug = item.s ? item.s.replace(/-/g, ' ') : '';
                    var title = item.t.toLowerCase();
                    if (slug === q) { return 0; }
                    if (title.indexOf(q) === 0) { return 1; }
                    if (slug.indexOf(q) === 0) { return 2; }
                    return 3;
                }
                var matches = HEADER_SEARCH_INDEX.filter(function (item) {
                    var haystack = item.t.toLowerCase() + ' ' + (item.s ? item.s.replace(/-/g, ' ') : '');
                    return haystack.indexOf(q) !== -1;
                }).sort(function (a, b) {
                    return rank(a) - rank(b);
                }).slice(0, 12);
                if (!matches.length) {
                    results.innerHTML = '<div class="header-search-empty">No matches. Try a country name, visa type or "apostille".</div>';
                    return;
                }
                matches.forEach(function (item) {
                    var a = document.createElement('a');
                    a.href = item.u;
                    a.innerHTML = '<i class="fa-solid ' + item.i + '"></i><span class="hsr-title">' + item.t + '</span><span class="hsr-type">' + item.y + '</span>';
                    results.appendChild(a);
                });
            }

            function openPanel() {
                panel.classList.add('is-open');
                panel.setAttribute('aria-hidden', 'false');
                render('');
                setTimeout(function () { input.focus(); }, 50);
            }
            function closePanel() {
                panel.classList.remove('is-open');
                panel.setAttribute('aria-hidden', 'true');
                input.value = '';
            }

            toggle.addEventListener('click', openPanel);
            closeBtn.addEventListener('click', closePanel);
            panel.addEventListener('click', function (e) {
                if (e.target === panel) { closePanel(); }
            });
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') { closePanel(); }
            });
            input.addEventListener('input', function () { render(input.value); });
        })();
        </script>
