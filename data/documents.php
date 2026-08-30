<?php
/**
 * The document checklist model.
 *
 * WHAT THIS IS
 * A structured preparation checklist, assembled from three layers:
 *
 *   1. CORE      — documents essentially every visa application asks for.
 *   2. BY TYPE   — what a tourist / student / work / medical … application
 *                  additionally asks for. These are category-defining, not
 *                  country-specific: a student application asks for an
 *                  admission letter wherever you are going.
 *   3. BY PROFILE — what changes because of who the applicant is (salaried,
 *                  self-employed, student, retired, minor).
 *
 * WHAT THIS IS NOT
 * It is NOT a per-country legal requirement list, and nothing here should be
 * presented as one. Visa rules are nationality-specific, mission-specific and
 * change often. Exact photo dimensions, financial thresholds, apostille and
 * translation rules, and which of these a given consulate wants in original
 * versus copy are all things only the mission handling that nationality can
 * state. Every page that renders this says so.
 *
 * Where Convercession has confirmed a real list for a country (via the import
 * pipeline in data/import/), that verified list is shown INSTEAD of this one —
 * see checklist_for() and the `documents` key on an imported visa type.
 *
 * Each item is [id, label, why, essential]:
 *   essential = true   asked for in effectively every case
 *   essential = false  commonly requested / strengthens the application
 */
declare(strict_types=1);

/** Applicant situations the checklist can be tailored to. */
function checklist_profiles(): array
{
    return [
        'employed'      => 'Salaried employee',
        'self-employed' => 'Self-employed / business owner',
        'student'       => 'Student',
        'retired'       => 'Retired',
        'minor'         => 'Child under 18',
    ];
}

/**
 * Maps the many visaTypeSlug values in the content data onto the ten canonical
 * categories the checklist is written for. Anything unrecognised falls back to
 * the tourist set, which is the closest thing to a neutral baseline.
 */
function checklist_category(string $visaTypeSlug, string $visaTypeLabel = ''): string
{
    $s = strtolower($visaTypeSlug . ' ' . $visaTypeLabel);
    $map = [
        'student'    => ['student', 'study', 'academic'],
        'employment' => ['employment', 'work', 'job', 'labour', 'skilled'],
        'business'   => ['business', 'commercial', 'trade'],
        'family'     => ['family', 'dependent', 'dependant', 'spouse', 'visit-relative', 'join'],
        'medical'    => ['medical', 'treatment', 'health'],
        'transit'    => ['transit', 'airport'],
        'conference' => ['conference', 'event', 'seminar', 'exhibition'],
        'official'   => ['official', 'diplomatic', 'service'],
        'renewal'    => ['renewal', 'extension', 'extend', 'renew'],
        'schengen'   => ['schengen'],
        'tourist'    => ['tourist', 'visitor', 'leisure', 'holiday', 'evisa'],
    ];
    foreach ($map as $key => $needles) {
        foreach ($needles as $n) {
            if (str_contains($s, $n)) {
                return $key;
            }
        }
    }
    return 'tourist';
}

/** Layer 1 — asked for in effectively every visa application, anywhere. */
function checklist_core(): array
{
    return [
        'Passport & identity' => [
            ['passport', 'Current passport',
                'Most missions want validity well beyond your return date (six months is the common benchmark) and at least two blank facing pages.', true],
            ['old-passports', 'Previous passports',
                'Evidence of your travel history, and of visas you have held and complied with before.', false],
            ['photos', 'Passport photographs',
                'Photo rules differ by country — size, background colour, headwear and how recent. Get the destination\'s exact specification before you have them taken.', true],
            ['id-proof', 'National identity document',
                'Government photo ID from your country of residence, plus proof of address where asked.', false],
        ],
        'The application' => [
            ['form', 'Completed application form',
                'Signed, and consistent with your supporting documents — mismatched dates and spellings are a common cause of delay.', true],
            ['fee', 'Visa fee payment receipt',
                'Fees are usually non-refundable, including if the application is refused.', true],
            ['appointment', 'Appointment confirmation',
                'Where the mission or visa application centre requires you to attend in person.', false],
        ],
        'Your travel plan' => [
            ['itinerary', 'Travel itinerary',
                'A booking or reservation showing entry and exit. Consider a held reservation rather than a paid ticket until the visa is granted.', true],
            ['accommodation', 'Accommodation for the whole stay',
                'Hotel bookings, or the address and contact details of the person hosting you.', true],
            ['insurance', 'Travel medical insurance',
                'Compulsory for some destinations and merely advisable for others — but worth having on any international trip.', false],
        ],
        'Funds' => [
            ['bank', 'Bank statements',
                'Usually the last three to six months, stamped or issued by the bank. A balance that appears suddenly before you apply invites questions.', true],
            ['income', 'Proof of income',
                'Payslips, tax returns or business accounts, depending on how you earn.', true],
            ['sponsor', 'Sponsor\'s financial documents',
                'Where somebody else is funding the trip: their statements, proof of income and a letter accepting responsibility.', false],
        ],
    ];
}

/** Layer 2 — what the purpose of the trip adds. */
function checklist_by_category(): array
{
    return [
        'tourist' => ['Purpose of your visit', [
            ['day-plan', 'Day-by-day plan',
                'A short outline of where you will be and when. It makes an itinerary credible rather than notional.', false],
            ['ties', 'Evidence of ties to home',
                'Employment, property, family or study commitments that show why you will return. This is what most visitor refusals turn on.', true],
            ['prior-travel', 'Previous travel history',
                'Earlier visas and entry stamps, particularly to countries with comparable entry requirements.', false],
        ]],
        'schengen' => ['Schengen specifics', [
            ['sch-main', 'Proof of your main destination',
                'You apply at the mission of the country where you spend the most nights — or, if nights are equal, where you enter the area first. Bookings should make that obvious at a glance.', true],
            ['sch-insurance', 'Travel medical insurance valid across the Schengen area',
                'A standard requirement for this category, covering the whole stay including repatriation. Check the minimum cover and that the policy names every Schengen state.', true],
            ['sch-itinerary', 'Itinerary across every country you will visit',
                'Dates, cities and how you move between them. It must be consistent with the mission you applied through.', true],
            ['sch-ties', 'Evidence of ties to home',
                'Employment, property, family or study commitments. Short-stay refusals turn on this more than on anything else.', true],
            ['sch-cover', 'Cover letter',
                'A short letter setting out the purpose, the route and who is paying.', false],
            ['sch-prior', 'Previous Schengen or comparable visas',
                'A record of having entered and left within the permitted period counts for a lot.', false],
        ]],
        'business' => ['Business purpose', [
            ['invitation-biz', 'Invitation from the host company',
                'On their letterhead: who you are meeting, why, on what dates, and who is paying for what.', true],
            ['employer-letter', 'Letter from your employer',
                'Confirming your role, salary, approved leave and that you are expected back.', true],
            ['company-proof', 'Company registration documents',
                'Your employer\'s or your own business\'s registration, and trade references where relevant.', false],
            ['meeting-proof', 'Correspondence with the host',
                'Emails or contracts showing the business relationship is real.', false],
        ]],
        'student' => ['Study documents', [
            ['admission', 'Admission letter from the institution',
                'The unconditional offer, or the sponsorship reference number your destination uses in its place.', true],
            ['tuition', 'Proof of tuition payment',
                'The deposit or full fee receipt, as your offer requires.', true],
            ['transcripts', 'Academic transcripts and certificates',
                'Previous qualifications, usually attested or apostilled — start this early, it is the slowest step.', true],
            ['language', 'Language test result',
                'Where the course or the visa route requires one; check which tests are accepted and how recent they must be.', false],
            ['living-costs', 'Proof of living costs',
                'Many study routes set a specific amount that must have been held for a specific number of days. Check the exact rule.', true],
            ['health-cover', 'Student health cover',
                'Some destinations charge a health surcharge with the application rather than accepting private insurance.', false],
        ]],
        'employment' => ['Work authorisation', [
            ['offer', 'Job offer or employment contract',
                'Signed, showing role, salary and duration.', true],
            ['sponsorship', 'Employer sponsorship documents',
                'Most work routes are employer-led: the sponsorship certificate or work permit is issued to them, not to you.', true],
            ['qualifications', 'Qualification and experience certificates',
                'Degrees and professional registrations, usually attested — and evaluated against the destination\'s framework in some countries.', true],
            ['police', 'Police clearance certificate',
                'From every country you have lived in for an extended period. These expire, so time the request.', false],
            ['medical-fitness', 'Medical examination',
                'Often at a panel clinic the destination nominates, not a doctor of your choosing.', false],
        ]],
        'family' => ['Relationship evidence', [
            ['relationship', 'Proof of your relationship',
                'Marriage, birth or civil partnership certificates — often needing to be recent copies rather than the original issue.', true],
            ['sponsor-status', 'Sponsor\'s status in the country',
                'Their passport, residence permit or citizenship document.', true],
            ['invitation-family', 'Invitation from your relative',
                'Confirming the relationship, the dates, and where you will stay.', true],
            ['relationship-history', 'History of the relationship',
                'Photographs, correspondence and evidence of visits, where a genuine relationship must be shown.', false],
            ['accommodation-proof', 'Sponsor\'s accommodation',
                'Tenancy agreement or property deed, and sometimes a statement that it is adequate for the number of people.', false],
        ]],
        'medical' => ['Medical treatment', [
            ['hospital-letter', 'Letter from the treating hospital',
                'Naming the treatment, the expected duration and the estimated cost.', true],
            ['referral', 'Referral from your own doctor',
                'Diagnosis and the reason treatment abroad is being sought.', true],
            ['treatment-funds', 'Proof you can pay for treatment',
                'Funds or a financial guarantee covering the estimate, not only the travel.', true],
            ['attendant', 'Documents for anyone travelling with you',
                'Attendant visas are usually a separate category with their own proof of relationship.', false],
        ]],
        'transit' => ['Transit documents', [
            ['onward-ticket', 'Confirmed onward ticket',
                'Showing you leave within the transit period allowed.', true],
            ['final-visa', 'Visa for your final destination',
                'Where one is needed. Some countries also require it even if you never leave the airport.', true],
            ['airport-note', 'Details of your connection',
                'Terminal changes and long layovers can turn a no-visa transit into one that needs a visa.', false],
        ]],
        'conference' => ['Event documents', [
            ['conference-invite', 'Invitation from the organiser',
                'Naming you as a delegate, speaker or exhibitor, with the dates and venue.', true],
            ['registration', 'Registration or payment confirmation',
                'Your delegate registration, and the receipt where the fee has been paid.', true],
            ['employer-approval', 'Employer authorisation',
                'Confirming you attend on their behalf and who is meeting the cost.', false],
        ]],
        'official' => ['Official travel', [
            ['note-verbale', 'Note verbale from the sending authority',
                'Issued government to government; individuals cannot normally submit this category themselves.', true],
            ['official-id', 'Official or diplomatic passport',
                'Together with the assignment or deputation order.', true],
        ]],
        'renewal' => ['Renewal and extension', [
            ['current-visa', 'Your current visa or permit',
                'Along with the entry stamp for your most recent arrival.', true],
            ['status-proof', 'Proof you have kept to its conditions',
                'Continued study, employment or business as the original grant required.', true],
            ['reason', 'Reason for extending',
                'Why the further stay is needed and how long it will be.', true],
            ['no-overstay', 'Confirmation of no overstay',
                'Apply before the current permission expires — applying late is treated very differently almost everywhere.', true],
        ]],
    ];
}

/**
 * Layer 2b — what an INDIAN passport holder is asked for.
 *
 * Convercession's applicants are overwhelmingly Indian, and "proof of income"
 * is close to useless as instruction when the thing actually handed over is an
 * ITR-V and a Form 16. What follows is India-side and category-level: the
 * documents Indian issuing authorities produce, and the attestation route
 * Indian documents take. None of it asserts what a particular destination
 * requires — that stays nationality- and mission-specific, and the page says so.
 *
 * India joined the Hague Apostille Convention in 2005, so the MEA apostilles
 * documents for member states; for non-member states the route is MEA
 * attestation followed by that country's mission. That distinction is the
 * single most common cause of a rejected document set from India, which is why
 * it is called out rather than buried.
 */
function checklist_nationalities(): array
{
    return ['india' => 'an Indian passport', 'other' => 'another passport'];
}

/** Replaces the generic Funds section for Indian applicants. */
function checklist_india_funds(): array
{
    return ['Funds — Indian documents', [
        ['in-bank', 'Bank statements, last 6 months',
            'On bank letterhead or stamped and signed at the branch. A downloaded PDF with no bank mark is refused more often than people expect.', true],
        ['in-itr', 'ITR-V acknowledgement, last 2–3 years',
            'The income tax return acknowledgement is the standard proof of income from India, and carries more weight than a salary slip alone.', true],
        ['in-form16', 'Form 16',
            'For salaried applicants, covering the same years as the ITR.', true],
        ['in-payslips', 'Salary slips, last 3–6 months',
            'They should reconcile with the credits showing in the bank statement.', true],
        ['in-pan', 'PAN card',
            'Routinely asked for alongside financial documents.', true],
        ['in-aadhaar', 'Aadhaar card',
            'Commonly accepted as proof of address. Consider masking the number where the form does not require it in full.', false],
        ['in-sponsor', 'Sponsor\'s ITR, bank statements and affidavit',
            'Where a parent, spouse or employer is funding the trip.', false],
    ]];
}

/** Category-specific additions for Indian applicants. */
function checklist_india_by_category(): array
{
    return [
        'tourist' => ['Indian applicants — also expect', [
            ['in-noc', 'Employer NOC or leave sanction letter',
                'On company letterhead, naming the travel dates and confirming you return to the role.', true],
            ['in-ties', 'Proof of ties to India',
                'Property papers, continuing employment, or family responsibilities — the heart of a visitor application from India.', true],
            ['in-oldvisas', 'Previous visas and entry stamps',
                'A clean travel history to countries with comparable entry rules helps considerably.', false],
        ]],
        'schengen' => ['Indian applicants — also expect', [
            ['in-sch-vfs', 'Appointment at the right VFS or BLS centre',
                'Most Schengen missions in India outsource submission. Book at the centre for your main destination, in the jurisdiction covering your address — jurisdiction is by state, and applying outside yours is refused at the counter.', true],
            ['in-sch-noc', 'Employer NOC and leave sanction letter',
                'On company letterhead, matching the travel dates exactly.', true],
            ['in-sch-itr', 'ITR-V for the last 2–3 years',
                'Alongside six months of bank statements stamped at the branch.', true],
            ['in-sch-cover', 'Cover letter naming your main destination',
                'State plainly which country you spend the most nights in and why you apply there.', false],
        ]],
        'business' => ['Indian applicants — also expect', [
            ['in-gst', 'GST registration certificate',
                'Where you own the business. Company applicants should also carry the incorporation certificate from the MCA.', true],
            ['in-bizletter', 'Covering letter on company letterhead',
                'Signed by an authorised signatory, naming the host, purpose and who bears the cost.', true],
            ['in-iec', 'Import-Export Code',
                'Where the trip concerns trade.', false],
            ['in-bizbank', 'Business bank statements and business ITR',
                'Separate from personal accounts.', true],
        ]],
        'student' => ['Indian applicants — also expect', [
            ['in-marksheets', 'Class 10 and 12 marksheets, plus degree and consolidated marksheet',
                'Originals and sets of photocopies. Start collecting these first — reissues from an Indian university are slow.', true],
            ['in-apostille', 'MEA apostille or attestation on academic documents',
                'India is a Hague Apostille member, so member states take an MEA apostille. Non-member states need MEA attestation and then that country\'s mission. Getting this the wrong way round is the most common reason an Indian document set is sent back.', true],
            ['in-loan', 'Education loan sanction letter',
                'From the bank, if the course is loan-funded. It is usually accepted as evidence of funds in its own right.', false],
            ['in-english', 'IELTS, TOEFL or PTE score report',
                'Check which tests the institution and the visa route accept, and how recent the score must be.', true],
            ['in-gap', 'Gap justification affidavit',
                'Where there is a break between qualifications — employment letters, or a notarised affidavit explaining the gap.', false],
            ['in-sop', 'Statement of purpose',
                'Required by most institutions and read by some visa officers.', false],
        ]],
        'employment' => ['Indian applicants — also expect', [
            ['in-ecnr', 'ECR / ECNR status in your passport',
                'An ECR passport needs emigration clearance from the Protector of Emigrants for employment in certain notified countries. Check the status page before you accept an offer, not after.', true],
            ['in-degree-attest', 'Degree and experience certificates, attested',
                'MEA apostille for Hague member states; MEA attestation plus embassy attestation otherwise.', true],
            ['in-pcc', 'Police Clearance Certificate',
                'Issued through Passport Seva Kendra or the Regional Passport Office. Apply early — appointment availability drives the timeline, and a PCC expires.', true],
            ['in-experience', 'Experience and relieving letters',
                'From each employer, on letterhead with contactable references.', true],
            ['in-medical', 'Medical examination at a nominated clinic',
                'Many destinations accept results only from clinics they have themselves approved.', false],
        ]],
        'family' => ['Indian applicants — also expect', [
            ['in-marriage', 'Marriage certificate',
                'Registered under the Hindu Marriage Act or the Special Marriage Act. A religious ceremony certificate alone is usually not enough.', true],
            ['in-birth', 'Birth certificate from the municipal authority',
                'Where none was ever registered, the route is a non-availability certificate plus a notarised affidavit — allow time for it.', true],
            ['in-family-apostille', 'MEA apostille or attestation on civil documents',
                'Marriage and birth certificates almost always need it for family categories.', true],
            ['in-relationship', 'Evidence of the relationship over time',
                'Photographs, travel together, remittances and correspondence.', false],
        ]],
        'medical' => ['Indian applicants — also expect', [
            ['in-referral', 'Referral from your Indian treating doctor',
                'On hospital letterhead with the registration number, stating the diagnosis and why treatment abroad is sought.', true],
            ['in-records', 'Medical records and test reports',
                'The history the receiving hospital based its letter on.', true],
            ['in-attendant', 'Attendant documents',
                'Attendant visas are a separate category and need proof of relationship — usually a passport copy plus the marriage or birth certificate.', false],
        ]],
        'transit' => ['Indian applicants — also expect', [
            ['in-transit-check', 'Confirm whether your connection needs a transit visa',
                'Indian passport holders need one for several common hubs even without leaving the airport, and airlines deny boarding at check-in for it.', true],
        ]],
        'conference' => ['Indian applicants — also expect', [
            ['in-conf-noc', 'Employer or institution NOC',
                'Confirming you attend on their behalf and who bears the cost.', true],
            ['in-conf-clearance', 'Political or event clearance where required',
                'Some countries require clearance for delegates from India for certain event types — check the lead time early.', false],
        ]],
        'official' => ['Indian applicants — also expect', [
            ['in-note', 'Note verbale routed through the ministry',
                'Official and diplomatic categories are submitted government to government, not by the traveller.', true],
            ['in-official-passport', 'Official or diplomatic passport plus deputation order',
                'Together with the political clearance where the ministry requires it.', true],
        ]],
        'renewal' => ['Indian applicants — also expect', [
            ['in-current', 'Current visa or residence permit and latest entry stamp',
                'Plus the passport that carried the previous grant, if you have since been reissued one.', true],
            ['in-compliance', 'Evidence you kept to the conditions',
                'Continued employment, enrolment or business, as the original grant required.', true],
        ]],
    ];
}

/** Layer 3 — what changes because of who you are. */
function checklist_by_profile(): array
{
    return [
        'employed' => ['If you are employed', [
            ['leave-letter', 'Leave approval letter',
                'From your employer, covering the exact travel dates.', true],
            ['payslips', 'Recent payslips',
                'Usually three to six months.', true],
            ['employment-letter', 'Employment confirmation',
                'Role, joining date, salary and that your position is held open.', true],
        ]],
        'self-employed' => ['If you are self-employed', [
            ['business-reg', 'Business registration',
                'Incorporation or trade licence in your name.', true],
            ['tax-returns', 'Business tax returns',
                'Typically the last two to three years.', true],
            ['business-bank', 'Business bank statements',
                'Separate from your personal account.', true],
            ['delegation', 'Who is running things while you travel',
                'Useful where the trip is long and you are the sole operator.', false],
        ]],
        'student' => ['If you are a student', [
            ['enrolment', 'Enrolment certificate',
                'Confirming you are currently registered.', true],
            ['school-noc', 'No-objection letter from your institution',
                'Approving the absence and confirming you are expected back.', true],
            ['parent-funds', 'Parent or guardian\'s financial documents',
                'With a letter confirming they are funding the trip.', true],
        ]],
        'retired' => ['If you are retired', [
            ['pension', 'Pension statements',
                'Or other regular income, for the same period as bank statements.', true],
            ['retirement-proof', 'Proof of retirement',
                'A retirement order or service certificate.', false],
            ['assets', 'Evidence of assets',
                'Property or investments, where income alone is modest.', false],
        ]],
        'minor' => ['If the applicant is under 18', [
            ['birth-cert', 'Birth certificate',
                'Showing both parents\' names.', true],
            ['parental-consent', 'Parental consent',
                'Signed by both parents, notarised in many cases — and normally required even when one parent travels with the child.', true],
            ['parent-id', 'Parents\' passports or identity documents',
                'Copies of the photo pages.', true],
            ['custody', 'Custody documents',
                'Where the parents are separated, or one has sole responsibility.', false],
        ]],
    ];
}

/**
 * Builds the checklist for a visa type.
 *
 * Returns ['verified' => bool, 'source' => ?string, 'updated' => ?string,
 *          'sections' => [ ['title' => …, 'kind' => 'core|purpose|profile',
 *                           'profile' => ?key, 'items' => [[id,label,why,essential], …]] ]]
 *
 * A visa type carrying a verified `documents` list from the import pipeline
 * uses that instead — real data always wins over the generic model.
 */
function checklist_for(array $visaType): array
{
    if (!empty($visaType['documents']) && !empty($visaType['verified'])) {
        $sections = [];
        foreach ($visaType['documents'] as $title => $items) {
            $sections[] = [
                'title'   => (string) $title,
                'kind'    => 'core',
                'profile' => null,
                'nationality' => null,
                'items'   => array_map(
                    static fn($d, $i) => is_array($d)
                        ? [$d['id'] ?? ('v' . $i), $d['label'] ?? '', $d['why'] ?? '', !empty($d['essential'])]
                        : ['v' . $i, (string) $d, '', true],
                    $items,
                    array_keys($items)
                ),
            ];
        }
        return [
            'verified' => true,
            'source'   => $visaType['source'] ?? null,
            'updated'  => $visaType['sourceUpdated'] ?? null,
            'sections' => $sections,
        ];
    }

    $category = checklist_category($visaType['visaTypeSlug'] ?? '', $visaType['visaType'] ?? '');
    $sections = [];

    // Core, minus Funds — Funds has an India variant and a generic one, and
    // the two are mutually exclusive rather than additive.
    foreach (checklist_core() as $title => $items) {
        if ($title === 'Funds') continue;
        $sections[] = ['title' => $title, 'kind' => 'core', 'profile' => null, 'nationality' => null, 'items' => $items];
    }

    [$inTitle, $inItems] = checklist_india_funds();
    $sections[] = ['title' => $inTitle, 'kind' => 'core', 'profile' => null, 'nationality' => 'india', 'items' => $inItems];
    $sections[] = ['title' => 'Funds', 'kind' => 'core', 'profile' => null, 'nationality' => 'other', 'items' => checklist_core()['Funds']];

    $byCat = checklist_by_category();
    if (isset($byCat[$category])) {
        [$title, $items] = $byCat[$category];
        $sections[] = ['title' => $title, 'kind' => 'purpose', 'profile' => null, 'nationality' => null, 'items' => $items];
    }

    $byIndia = checklist_india_by_category();
    if (isset($byIndia[$category])) {
        [$title, $items] = $byIndia[$category];
        $sections[] = ['title' => $title, 'kind' => 'india', 'profile' => null, 'nationality' => 'india', 'items' => $items];
    }

    foreach (checklist_by_profile() as $key => [$title, $items]) {
        $sections[] = ['title' => $title, 'kind' => 'profile', 'profile' => $key, 'nationality' => null, 'items' => $items];
    }

    return ['verified' => false, 'source' => null, 'updated' => null, 'sections' => $sections];
}

/**
 * Items visible on first load: everything except the profile sections (hidden
 * until a profile is chosen) and the sections belonging to the non-default
 * nationality. Counting both Funds variants would make the progress bar
 * unreachable.
 */
function checklist_base_count(array $checklist, string $nationality = 'india'): int
{
    $n = 0;
    foreach ($checklist['sections'] as $s) {
        if (($s['kind'] ?? '') === 'profile') continue;
        $sectionNat = $s['nationality'] ?? null;
        if ($sectionNat !== null && $sectionNat !== $nationality) continue;
        $n += count($s['items']);
    }
    return $n;
}
