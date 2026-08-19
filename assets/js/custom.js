document.addEventListener('DOMContentLoaded', function () {

    /* ---- Nav mega-menu country search/filter ---- */
    function wireCountryFilter(root) {
        if (!root) return;
        var search = root.querySelector('.country-nav-search, .country-explorer-search-input');
        var filters = root.querySelectorAll('.country-nav-filters button, .country-explorer-filters button');
        var chips = root.querySelectorAll('.country-chip');

        function applyFilter() {
            var q = (search && search.value ? search.value : '').toLowerCase().trim();
            var activeBtn = root.querySelector('.country-nav-filters button.active, .country-explorer-filters button.active');
            var region = activeBtn ? activeBtn.getAttribute('data-region') : 'all';
            chips.forEach(function (chip) {
                var name = chip.getAttribute('data-name') || '';
                var chipRegion = chip.getAttribute('data-region') || '';
                var matchesQuery = !q || name.indexOf(q) !== -1;
                var matchesRegion = region === 'all' || region === chipRegion;
                chip.classList.toggle('is-hidden', !(matchesQuery && matchesRegion));
            });
        }

        if (search) {
            search.addEventListener('input', applyFilter);
        }
        filters.forEach(function (btn) {
            btn.addEventListener('click', function () {
                filters.forEach(function (b) { b.classList.remove('active'); });
                btn.classList.add('active');
                applyFilter();
            });
        });
    }

    document.querySelectorAll('.mega-panel-countries, .country-explorer-section').forEach(wireCountryFilter);

    /* ---- Homepage visa search widget (demo — no backend, shows a sample result) ---- */
    var vswForm = document.getElementById('visa-search-form');
    if (vswForm) {
        vswForm.addEventListener('submit', function (e) {
            e.preventDefault();
            var country = document.getElementById('vsw-country').value || 'your destination';
            var purpose = document.getElementById('vsw-purpose').value || 'Tourism';
            var result = document.getElementById('vsw-result');
            result.innerHTML =
                '<strong>' + country + ' — ' + purpose + ' visa</strong><br>' +
                'Based on what you have told us, our consultants can guide you through eligibility, ' +
                'the recommended visa category and the documents you will need. Processing time and ' +
                'exact requirements vary by embassy/consulate — an actual visa decision is made solely ' +
                'by the relevant authority.' +
                '<div class="vsw-result-actions">' +
                '<a href="contact.php">Speak with a consultant &rarr;</a>' +
                '<a href="#checklist">See a sample document checklist &rarr;</a>' +
                '</div>';
            result.classList.add('show');
        });
    }

    /* ---- Document checklist widget (demo dataset, client-side only) ---- */
    var checklistData = {
        tourist: ['Valid passport (6+ months validity)', 'Passport-size photographs', 'Visa application form', 'Confirmed travel itinerary', 'Hotel/accommodation booking', 'Bank statements (last 3-6 months)', 'Proof of employment / business', 'Travel insurance'],
        business: ['Valid passport (6+ months validity)', 'Invitation letter from host company', 'Company registration documents', 'Bank statements (last 3-6 months)', 'Cover letter explaining purpose of visit', 'Travel itinerary', 'Travel insurance'],
        work: ['Valid passport (6+ months validity)', 'Employment contract / offer letter', 'Educational certificates', 'Experience letters', 'Medical examination report', 'Police clearance certificate', 'Passport-size photographs'],
        family: ['Valid passport (6+ months validity)', 'Invitation letter from family member', 'Proof of relationship', 'Sponsor’s financial documents', 'Accommodation proof', 'Travel itinerary'],
        transit: ['Valid passport (6+ months validity)', 'Onward journey ticket', 'Visa for final destination (if required)', 'Passport-size photographs'],
        medical: ['Valid passport (6+ months validity)', 'Medical report / doctor’s letter', 'Hospital appointment confirmation', 'Proof of funds for treatment', 'Attendant’s documents (if applicable)']
    };

    var checklistForm = document.getElementById('checklist-form');
    if (checklistForm) {
        checklistForm.addEventListener('submit', function (e) {
            e.preventDefault();
            var country = document.getElementById('cl-country').value || 'your destination';
            var visaType = document.getElementById('cl-visa-type').value || 'tourist';
            var visaTypeLabel = document.getElementById('cl-visa-type').selectedOptions[0].text;
            var items = checklistData[visaType] || checklistData.tourist;

            var out = document.getElementById('checklist-output');
            var heading = document.getElementById('checklist-heading');
            var list = document.getElementById('checklist-items');

            heading.textContent = 'Your ' + country + ' ' + visaTypeLabel + ' Checklist';
            list.innerHTML = '';
            items.forEach(function (item) {
                var li = document.createElement('li');
                li.innerHTML = '<i class="fa-solid fa-circle-check"></i> ' + item;
                list.appendChild(li);
            });
            out.classList.add('show');
            out.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        });
    }

    /* ---- FAQ accordion ---- */
    document.querySelectorAll('.faq-question').forEach(function (q) {
        q.addEventListener('click', function () {
            var item = q.closest('.faq-item');
            var wasActive = item.classList.contains('active');
            item.parentElement.querySelectorAll('.faq-item').forEach(function (i) {
                i.classList.remove('active');
            });
            if (!wasActive) {
                item.classList.add('active');
            }
        });
    });

    /* ---- Footer accordions: always expanded on desktop, native
       collapsible <details> accordions on mobile ---- */
    var footerAccordions = document.querySelectorAll('.footer-accordion');
    if (footerAccordions.length) {
        var lastFooterAccordionIsDesktop = null;
        var applyFooterAccordionState = function () {
            var isDesktop = window.innerWidth >= 768;
            if (isDesktop === lastFooterAccordionIsDesktop) return;
            lastFooterAccordionIsDesktop = isDesktop;
            footerAccordions.forEach(function (d) {
                if (isDesktop) {
                    d.setAttribute('open', '');
                } else {
                    d.removeAttribute('open');
                }
            });
        };
        applyFooterAccordionState();
        window.addEventListener('resize', applyFooterAccordionState);
    }

    /* ---- Back to top ---- */
    var backToTop = document.getElementById('backToTop');
    if (backToTop) {
        window.addEventListener('scroll', function () {
            backToTop.classList.toggle('is-visible', window.scrollY > 500);
        }, { passive: true });
        backToTop.addEventListener('click', function () {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    }

    /* ---- Floating contact FAB ---- */
    var fab = document.getElementById('floatingFab');
    var fabToggle = document.getElementById('floatingFabToggle');
    if (fab && fabToggle) {
        var fabOptions = fab.querySelector('.floating-fab-options');
        var closeFab = function () {
            fab.classList.remove('is-open');
            fabToggle.setAttribute('aria-expanded', 'false');
            if (fabOptions) { fabOptions.setAttribute('aria-hidden', 'true'); }
        };
        fabToggle.addEventListener('click', function () {
            var isOpen = fab.classList.toggle('is-open');
            fabToggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
            if (fabOptions) { fabOptions.setAttribute('aria-hidden', isOpen ? 'false' : 'true'); }
        });
        document.addEventListener('click', function (e) {
            if (fab.classList.contains('is-open') && !fab.contains(e.target)) {
                closeFab();
            }
        });
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') { closeFab(); }
        });
    }

});
