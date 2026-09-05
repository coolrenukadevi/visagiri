<?php
$page_title = "Visa Agency &ndash; Trusted Visa Consultant in Patna, Ranchi, Raipur & Bhopal";
$page_description = "Visa Agency is a Ministry of Tourism recognised visa consultancy offering fast, reliable and hassle-free visa solutions in Patna, Ranchi, Raipur and Bhopal.";
require_once __DIR__ . '/includes/visa-content-db.php';
$vswPdo = visa_content_db();
$vswCountries = $vswPdo->query("SELECT name, slug, flag, iso2, iso3 FROM countries WHERE is_active = 1 ORDER BY popularity DESC, name ASC")->fetchAll(PDO::FETCH_ASSOC);
include __DIR__ . '/includes/header-home.php';
?>

        <!-- ============ HERO ============ -->
        <section class="hr-hero">
            <div class="container hr-hero-grid">
                <div>
                    <p class="hr-eyebrow">Case Intake</p>
                    <h1>We don't simplify visas. <em>We handle them.</em></h1>
                    <p class="hr-hero-sub">One consultant owns your case from first document to final stamp &mdash; across 200+ countries, apostille &amp; attestation, and outward forex. Recognised by the Ministry of Tourism, Government of India.</p>
                    <div class="hr-hero-meta">
                        <span><strong><?php echo count($VISA_AGENCY_COUNTRIES); ?>+</strong> destination countries</span>
                        <span><strong>4</strong> city offices &mdash; Patna, Ranchi, Raipur, Bhopal</span>
                        <span><strong>Ministry of Tourism</strong> recognised</span>
                    </div>
                </div>

                <div class="hr-checker" id="visa-search">
                    <div class="hr-checker-top">
                        <div class="hr-checker-tab">
                            <span class="hr-tag">FORM VA-01 / ELIGIBILITY</span>
                            <span class="hr-stamp">Live Tool</span>
                        </div>
                        <h3>Check your visa route</h3>
                        <p class="hr-checker-intro">Tell us where and why you're travelling &mdash; we'll take you straight to the right visa page.</p>
                    </div>
                    <div class="hr-checker-body">
                        <div class="visa-search-widget">
                            <div class="vsw-title">Find Your Visa Requirements</div>
                            <div class="vsw-sub">Tell us where you're travelling and we'll take you straight to the right visa page.</div>
                            <form id="visa-search-form" class="vsw-grid" autocomplete="off">
                                <div class="vsw-field vsw-field-autocomplete">
                                    <label for="vsw-country-input">Where are you travelling?</label>
                                    <input type="text" id="vsw-country-input" placeholder="Search country e.g. Australia, AUS, tourist visa Australia" required>
                                    <input type="hidden" id="vsw-country-slug" name="country_slug">
                                    <div id="vsw-country-results" class="vsw-autocomplete-results" hidden></div>
                                    <span class="vsw-field-error" id="vsw-country-error"></span>
                                </div>
                                <div class="vsw-field">
                                    <label for="vsw-purpose">What is your purpose?</label>
                                    <select id="vsw-purpose">
                                        <?php foreach (VISA_CATEGORY_DEFS as $cat): ?>
                                        <option value="<?php echo htmlspecialchars($cat['slug']); ?>"><?php echo htmlspecialchars($cat['name']); ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                </div>
                                <div class="vsw-field">
                                    <label for="vsw-passport">Passport</label>
                                    <select id="vsw-passport">
                                        <option>India 🇮🇳</option>
                                    </select>
                                </div>
                                <button type="submit" class="vsw-submit">Check requirements</button>
                            </form>
                            <div id="vsw-result" class="vsw-result"></div>
                        </div>
                        <script>window.VSW_COUNTRIES = <?php echo json_encode($vswCountries, JSON_UNESCAPED_SLASHES); ?>;</script>
                        <p class="hr-checker-fine">Indicative only, based on commonly published rules for Indian passport holders &mdash; your consultant confirms the exact current requirement before you apply.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ CREDIBILITY BAND ============ -->
        <section class="hr-cred">
            <div class="container hr-cred-grid">
                <div class="hr-cred-seal">
                    <svg width="44" height="44" viewBox="0 0 44 44" fill="none" aria-hidden="true">
                        <circle cx="22" cy="22" r="20" stroke="var(--brand-gold)" stroke-width="1.4"/>
                        <circle cx="22" cy="22" r="15" stroke="var(--brand-gold)" stroke-width="1" stroke-dasharray="2 3"/>
                        <path d="M15 22l5 5 9-11" stroke="var(--brand-gold)" stroke-width="1.8" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                    <p><strong>Ministry of Tourism Recognised</strong>Government of India &mdash; registered travel &amp; visa trade entity.</p>
                </div>
                <div class="hr-plaques" aria-label="Application centres we regularly file through">
                    <span class="hr-plaque"><b>UK</b> Visa Application Centre Network</span>
                    <span class="hr-plaque"><b>Schengen</b> VAC &mdash; Multiple Missions</span>
                    <span class="hr-plaque"><b>USA</b> Consular Filing Support</span>
                    <span class="hr-plaque"><b>UAE</b> e-Channel Coordination</span>
                    <span class="hr-plaque"><b>Canada</b> VAC Partner Network</span>
                </div>
                <div class="hr-cred-stat">
                    <span class="hr-num"><?php echo count($VISA_AGENCY_COUNTRIES); ?>+</span>
                    <span class="hr-lbl">Destination countries covered</span>
                </div>
            </div>
        </section>

        <!-- ============ SERVICES ============ -->
        <section class="hr-section" id="services">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Services</p>
                    <h2>Six ways in, one point of contact</h2>
                    <p>Every category below is run by a consultant who has personally filed that visa type before &mdash; not a shared queue.</p>
                </div>
                <div class="hr-svc-grid">

                    <a href="visa-tourist" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="14" y="6" width="28" height="40" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <circle cx="28" cy="20" r="6" stroke="var(--brand-navy)" stroke-width="1.2"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Tourist Visa</h3>
                        <p>Leisure, sightseeing and family visits &mdash; itinerary and funding documentation prepared to the destination's exact format.</p>
                    </a>

                    <a href="visa-business" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="14" y="6" width="28" height="40" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <rect x="20" y="16" width="16" height="12" rx="1.5" stroke="var(--brand-navy)" stroke-width="1.2"/>
                            <path d="M25 16v-2a3 3 0 0 1 6 0v2" stroke="var(--brand-navy)" stroke-width="1.2" fill="none"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Business Visa</h3>
                        <p>Meetings, conferences and trade visits &mdash; invitation letters and company documentation reviewed line by line.</p>
                    </a>

                    <a href="visa-family" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="12" y="8" width="22" height="36" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <rect x="24" y="14" width="20" height="32" rx="4" fill="#fff" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <circle cx="34" cy="30" r="5" stroke="var(--brand-navy)" stroke-width="1.1"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Family &amp; Dependent Visa</h3>
                        <p>Spouse, child and parent applications &mdash; relationship evidence and sponsorship proof assembled as one coherent file.</p>
                    </a>

                    <a href="visa-transit" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="14" y="6" width="28" height="40" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <path d="M20 26l16-4-5 8 5 8-16-4z" stroke="var(--brand-navy)" stroke-width="1.2" fill="none" stroke-linejoin="round"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Transit Visa</h3>
                        <p>Layovers and onward connections &mdash; confirmed against your exact routing so nothing is missed at the connecting airport.</p>
                    </a>

                    <a href="visa-medical" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="14" y="6" width="28" height="40" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <path d="M28 16v12M22 22h12" stroke="var(--brand-navy)" stroke-width="1.6" stroke-linecap="round"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Medical Visa</h3>
                        <p>Treatment invitation letters, hospital correspondence and attendant visas, coordinated against appointment dates.</p>
                    </a>

                    <a href="visa-extension" class="hr-svc-card">
                        <svg viewBox="0 0 56 56" fill="none" aria-hidden="true">
                            <rect x="14" y="6" width="28" height="40" rx="4" stroke="var(--brand-navy)" stroke-width="1.4"/>
                            <path d="M22 24a6 6 0 1 1 1.8 4.3M22 24v-5M22 24h5" stroke="var(--brand-navy)" stroke-width="1.3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                            <circle cx="38" cy="38" r="9" fill="#fff" stroke="var(--brand-gold)" stroke-width="1.4"/>
                            <path d="M34.5 38l2.5 2.6 5-5.6" stroke="var(--brand-gold)" stroke-width="1.4" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        <h3>Visa Extension</h3>
                        <p>Already travelling and need more time? We prepare and file extension requests before your current visa lapses.</p>
                    </a>

                </div>
            </div>
        </section>

        <!-- ============ WHY US ============ -->
        <section class="hr-section" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
            <div class="container hr-why-grid">
                <div class="hr-why-copy">
                    <p class="hr-eyebrow">The Difference</p>
                    <h2>A case manager, not a call centre</h2>
                    <p>Most agencies route you through whoever's free. We assign one consultant to your file on day one &mdash; the same person reviews every document, books every appointment, and reads every refusal letter, so nothing gets lost in a handoff.</p>
                </div>
                <div class="hr-diff-list">
                    <div class="hr-diff-item">
                        <span class="hr-diff-index">A</span>
                        <div><h4>One dedicated consultant, start to finish</h4><p>No rotating agents. Your consultant knows your case history and is reachable directly by phone or WhatsApp throughout.</p></div>
                    </div>
                    <div class="hr-diff-item">
                        <span class="hr-diff-index">B</span>
                        <div><h4>Refusal guidance, not just filing</h4><p>If a prior application was refused, we read the actual refusal letter and rebuild the case around what it cited &mdash; not a generic reapplication.</p></div>
                    </div>
                    <div class="hr-diff-item">
                        <span class="hr-diff-index">C</span>
                        <div><h4>24&times;7 support during travel-critical windows</h4><p>Appointment day, biometrics, or an embassy query the week before departure &mdash; your consultant is reachable outside office hours when it matters.</p></div>
                    </div>
                    <div class="hr-diff-item">
                        <span class="hr-diff-index">D</span>
                        <div><h4>Transparent, itemised pricing</h4><p>Government fee and our service fee are always quoted as two separate lines &mdash; you see exactly what goes to the embassy and what comes to us.</p></div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ PROCESS ============ -->
        <section class="hr-section" id="process">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">The Process</p>
                    <h2>Six stages, one file, start to finish</h2>
                </div>
                <div class="hr-timeline">
                    <div class="hr-tl-step"><span class="hr-n">01</span><h4>Discovery Call</h4><p>20 minutes to understand your destination, timeline and travel history.</p></div>
                    <div class="hr-tl-step"><span class="hr-n">02</span><h4>Document Audit</h4><p>We tell you exactly what's missing before the embassy does.</p></div>
                    <div class="hr-tl-step"><span class="hr-n">03</span><h4>Application Drafting</h4><p>Every field cross-checked against your supporting documents.</p></div>
                    <div class="hr-tl-step"><span class="hr-n">04</span><h4>Embassy Filing</h4><p>Appointment booked, fees paid, application submitted on your behalf.</p></div>
                    <div class="hr-tl-step"><span class="hr-n">05</span><h4>Interview Prep</h4><p>A mock run-through where the destination requires one.</p></div>
                    <div class="hr-tl-step"><span class="hr-n">06</span><h4>Decision &amp; Beyond</h4><p>We track the outcome and stay on call for onward travel questions.</p></div>
                </div>
            </div>
        </section>

        <!-- ============ DESTINATION EXPLORER (reuses existing search/filter widget) ============ -->
        <section class="hr-section hr-dest country-explorer-section" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Destinations</p>
                    <h2>Search <?php echo count($VISA_AGENCY_COUNTRIES); ?>+ countries by destination</h2>
                    <p>Browse every destination we assist with, or jump straight to the one you need.</p>
                </div>
                <div class="country-explorer-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" class="country-nav-search" placeholder="Search country or visa destination...">
                </div>
                <div class="country-explorer-filters country-nav-filters">
                    <button type="button" class="active" data-region="all">All</button>
                    <button type="button" data-region="Asia">Asia</button>
                    <button type="button" data-region="Europe">Europe</button>
                    <button type="button" data-region="North America">North America</button>
                    <button type="button" data-region="Middle East">Middle East</button>
                    <button type="button" data-region="Oceania">Oceania</button>
                </div>
                <div class="country-explorer-grid country-nav-grid">
                    <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                    <a href="country-<?php echo $c['slug']; ?>" class="country-chip" data-name="<?php echo strtolower($c['name']); ?>" data-region="<?php echo $c['region']; ?>">
                        <span class="flag"><?php echo $c['flag']; ?></span>
                        <span><?php echo $c['name']; ?></span>
                    </a>
                    <?php endforeach; ?>
                </div>
                <div class="text-center mt-4">
                    <a href="country-list" class="theme-btn style-2">View All Countries</a>
                </div>
            </div>
        </section>

        <!-- ============ CHECKLIST TOOL (reuses existing checklist widget) ============ -->
        <section class="hr-section" id="checklist">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Document Checklist</p>
                    <h2>Build your document list</h2>
                    <p>Choose a country and visa type to see what's typically required.</p>
                </div>
                <div class="hr-checklist-wrap">
                    <div class="checklist-widget">
                        <form id="checklist-form" class="checklist-controls">
                            <select id="cl-country">
                                <option value="">Select Country</option>
                                <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                                <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo $c['flag'] . ' ' . htmlspecialchars($c['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                            <select id="cl-visa-type">
                                <option value="tourist">Tourist Visa</option>
                                <option value="business">Business Visa</option>
                                <option value="work">Work Visa</option>
                                <option value="family">Family Visa</option>
                                <option value="transit">Transit Visa</option>
                                <option value="medical">Medical Visa</option>
                            </select>
                            <select id="cl-profile">
                                <option>Indian Passport</option>
                                <option>NRI / Foreign Resident</option>
                                <option>First-time Applicant</option>
                                <option>Previous Visa Holder</option>
                            </select>
                            <button type="submit">Create My Checklist</button>
                        </form>
                        <p id="cl-error" class="checklist-error" hidden>Please select a country to continue.</p>
                        <div id="checklist-output" class="checklist-output">
                            <h4 id="checklist-heading">Your Checklist</h4>
                            <ul id="checklist-items" class="checklist-items"></ul>
                            <div class="checklist-actions">
                                <a href="contact"><i class="fa-solid fa-paper-plane"></i> Start Enquiry</a>
                                <a href="https://wa.me/917844819819" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> Send on WhatsApp</a>
                                <button type="button" onclick="window.print()"><i class="fa-solid fa-download"></i> Download / Print</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ============ PRICING ============ -->
        <section class="hr-section" id="pricing" style="background:#fff; border-top:1px solid var(--border-color); border-bottom:1px solid var(--border-color);">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Engagement Models</p>
                    <h2>Two ways to work with us</h2>
                    <p>Every application is different, so fees are quoted for your specific visa type and destination &mdash; not a flat subscription.</p>
                </div>
                <div class="hr-pricing-grid">

                    <div class="hr-price-card">
                        <h3>Self-Guided</h3>
                        <p style="font-size:14.5px; color:var(--text); margin:0;">For applicants who know their process and just need a documentation check.</p>
                        <ul class="hr-price-list">
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Document checklist &amp; review</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Application form guidance</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Email support</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Status tracking</li>
                            <li class="hr-no"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 6l12 12M18 6L6 18"/></svg>Dedicated consultant</li>
                        </ul>
                        <a href="contact" class="hr-link" data-open-quick-enquiry>Get a free quote &rarr;</a>
                    </div>

                    <div class="hr-price-card is-primary">
                        <span class="hr-tag">Most Chosen</span>
                        <h3>Fully Assisted</h3>
                        <p style="font-size:14.5px; color:var(--text); margin:0;">End-to-end support from a dedicated consultant, start to visa decision.</p>
                        <ul class="hr-price-list">
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Everything in Self-Guided</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Dedicated visa consultant</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Visa interview preparation</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Priority processing support</li>
                            <li><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12l5 5L20 6"/></svg>Phone &amp; WhatsApp support</li>
                        </ul>
                        <a href="contact" class="theme-btn hr-btn-gold" data-open-quick-enquiry>Get a free quote <i class="fa-solid fa-arrow-right"></i></a>
                    </div>

                </div>
            </div>
        </section>

        <!-- ============ TESTIMONIALS ============ -->
        <section class="hr-section" id="stories">
            <div class="container">
                <div class="hr-head">
                    <p class="hr-eyebrow">Closed Files</p>
                    <h2>Recently approved</h2>
                </div>
                <div class="hr-test-grid">

                    <article class="hr-test-card">
                        <span class="hr-test-stamp">Approved</span>
                        <blockquote>&ldquo;Excellent service! The team guided me through every step, managed documents perfectly, and ensured my visa approval quickly. Truly reliable and professional consultancy service.&rdquo;</blockquote>
                        <div class="hr-test-who"><b>David Lee</b>Tourist Visa, Australia</div>
                    </article>

                    <article class="hr-test-card">
                        <span class="hr-test-stamp">Approved</span>
                        <blockquote>&ldquo;From document checklist to embassy submission, everything was handled smoothly. The consultant flagged an issue with my paperwork before it became a problem &mdash; saved me weeks of delay.&rdquo;</blockquote>
                        <div class="hr-test-who"><b>Ananya Sharma</b>Work Visa, Germany</div>
                    </article>

                    <article class="hr-test-card">
                        <span class="hr-test-stamp">Approved</span>
                        <blockquote>&ldquo;We used Visa Agency for our whole team's corporate travel visas. Clear communication, on-time processing, and a single point of contact for every application &mdash; exactly what we needed.&rdquo;</blockquote>
                        <div class="hr-test-who"><b>Rajeev Menon</b>Corporate Travel Desk, UAE</div>
                    </article>

                </div>
            </div>
        </section>

        <!-- ============ APOSTILLE / FOREX CROSS-SELL ============ -->
        <section class="hr-crosssell">
            <div class="container hr-cross-grid">
                <div class="hr-cross-item">
                    <h4>Apostille &amp; attestation</h4>
                    <p>MEA apostille, HRD attestation and Chamber of Commerce legalisation for documents travelling alongside your visa &mdash; degree certificates, marriage certificates, company papers.</p>
                    <a href="apostille" class="hr-link">See apostille services &rarr;</a>
                </div>
                <div class="hr-cross-item">
                    <h4>Forex for your trip</h4>
                    <p>Currency notes, a prepaid forex card, or a compliant outward remittance &mdash; arranged alongside your visa so you're not juggling two providers.</p>
                    <a href="forex" class="hr-link">See forex services &rarr;</a>
                </div>
            </div>
        </section>

        <!-- ============ FINAL CTA ============ -->
        <section class="hr-section">
            <div class="container">
                <div class="hr-final-cta">
                    <h2>Your case, one consultant, from first document to final stamp.</h2>
                    <p>Free discovery call &mdash; no obligation, no generic script.</p>
                    <a href="contact" class="theme-btn hr-btn-gold" data-open-quick-enquiry>Book your discovery call <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <p class="compliance-note mt-4">
                    Visa Agency provides visa consultancy and documentation assistance. Visa decisions are made
                    solely by the relevant embassy, consulate, immigration authority or government department.
                    Visa approval is not guaranteed. Requirements, fees and processing times may change without
                    notice. Applicants should verify current requirements before submission. Visa Agency is a
                    technology-enabled visa consultancy and a unit of Tripgation Private Limited.
                </p>
            </div>
        </section>

<?php include __DIR__ . '/includes/footer.php'; ?>
