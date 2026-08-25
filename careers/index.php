<?php
declare(strict_types=1);

/**
 * Careers section — three states in one handler, mirroring
 * attestation/index.php's pattern:
 *   /careers/                    listing of published vacancies
 *   /careers/{slug}/             job detail page (SEO'd, JobPosting schema)
 *   /careers/{slug}/apply/       application form; job is auto-attached
 *                                 from the URL, never re-selected by the
 *                                 candidate. Success is rendered in the
 *                                 same request as the POST (no reference
 *                                 number ever appears in a URL).
 *
 * Data comes from hr_vacancies/hr_application_questions/hr_candidates/
 * hr_applications (includes/hrms.php) — see AUDIT.md for the HRMS
 * Phase A entry. Email notifications (application received, etc.) are
 * Phase B, once real SMTP credentials are configured; nothing here
 * claims an email was sent.
 */

$slug = $segments[1] ?? null;
$subAction = $segments[2] ?? null;

// ---------------------------------------------------------------
// /careers/{slug}/apply/ — application form + submission
// ---------------------------------------------------------------
if ($slug !== null && $subAction === 'apply') {
    $vacancy = hrms_published_vacancy_by_slug($slug);
    if (!$vacancy) {
        render_not_found("We couldn't find that vacancy, or it's no longer accepting applications.");
    }
    $questions = hrms_vacancy_questions((int) $vacancy['id']);

    // Carried from the query string into a hidden field so a
    // ?source=linkedin (or ?source=...&ref_name=...) link used to
    // reach this page is still attributed correctly once the form
    // POSTs back to this same URL without that query string.
    $allowedSources = ['website', 'linkedin', 'facebook', 'whatsapp', 'referral', 'job_portal', 'other'];
    $sourceValue = in_array($_GET['source'] ?? $_POST['source'] ?? '', $allowedSources, true) ? ($_GET['source'] ?? $_POST['source']) : 'website';
    $refNameValue = trim((string) ($_GET['ref_name'] ?? $_POST['ref_name'] ?? ''));

    $submitted = false;
    $applicationReference = null;
    $errors = [];
    $values = [
        'full_name' => '', 'date_of_birth' => '', 'gender' => '', 'mobile' => '', 'whatsapp_number' => '',
        'email' => '', 'address' => '', 'city' => '', 'state' => '', 'pincode' => '',
        'current_company' => '', 'current_designation' => '', 'total_experience' => '', 'relevant_experience' => '',
        'current_salary' => '', 'expected_salary' => '', 'notice_period' => '', 'employment_status' => '',
        'reason_for_leaving' => '', 'preferred_location' => '', 'willing_to_relocate' => '',
        'highest_qualification' => '', 'course_degree' => '', 'institution' => '', 'passing_year' => '', 'additional_certifications' => '',
        'primary_skills' => '', 'secondary_skills' => '', 'computer_skills' => '', 'language_skills' => '',
    ];
    $answerValues = [];

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        csrf_require();

        if (trim((string) ($_POST['website'] ?? '')) !== '') {
            redirect("/careers/{$slug}/apply/");
        }

        foreach ($values as $key => $default) {
            $values[$key] = trim((string) ($_POST[$key] ?? ''));
        }
        foreach ($questions as $q) {
            $answerValues[$q['id']] = trim((string) ($_POST['q' . $q['id']] ?? ''));
        }
        $consentAccurate = isset($_POST['consent_accurate_info']);
        $consentDataUse = isset($_POST['consent_data_use']);
        $consentPrivacy = isset($_POST['consent_privacy_terms']);
        $consentNoGuarantee = isset($_POST['consent_no_guarantee']);

        if (!rate_limit_check('careers-apply:' . ($_SERVER['REMOTE_ADDR'] ?? ''), 5, 900)) {
            $errors[] = 'Too many submissions. Please try again later.';
        }
        if ($values['full_name'] === '') {
            $errors[] = 'Please enter your full name.';
        }
        if (!is_valid_mobile($values['mobile'])) {
            $errors[] = 'Please enter a valid mobile number.';
        }
        if (!is_valid_email($values['email'])) {
            $errors[] = 'Please enter a valid email address.';
        }
        if (!in_array($values['gender'], ['male', 'female', 'other', ''], true)) {
            $values['gender'] = '';
        }
        if (!in_array($values['employment_status'], ['employed', 'unemployed', 'serving_notice', 'freelancer', 'student', 'other', ''], true)) {
            $values['employment_status'] = '';
        }
        if (!$consentAccurate || !$consentDataUse || !$consentPrivacy || !$consentNoGuarantee) {
            $errors[] = 'Please confirm all four declaration checkboxes before submitting.';
        }
        foreach ($questions as $q) {
            if ((int) $q['is_required'] === 1 && trim((string) $answerValues[$q['id']]) === '') {
                $errors[] = "Please answer: {$q['question_label']}";
            }
        }

        $documentError = validate_document_upload($_FILES['cv'] ?? []);
        if ($documentError) {
            $errors[] = "CV/Resume: $documentError";
        }
        $optionalDocs = ['photograph' => 'Photograph', 'cover_letter' => 'Cover Letter', 'experience_certificate' => 'Experience Certificate', 'educational_certificate' => 'Educational Certificate', 'other' => 'Other Supporting Document'];
        foreach ($optionalDocs as $field => $label) {
            if (($_FILES[$field]['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
                $err = validate_document_upload($_FILES[$field]);
                if ($err) {
                    $errors[] = "$label: $err";
                }
            }
        }

        if (!$errors) {
            $submitted = true;
            try {
                $pdo = db();
                $pdo->beginTransaction();

                [$candidateId, $isDuplicate, $duplicateOfApplicationId] = hrms_find_or_create_candidate([
                    'full_name' => $values['full_name'],
                    'date_of_birth' => $values['date_of_birth'] !== '' ? $values['date_of_birth'] : null,
                    'gender' => $values['gender'] !== '' ? $values['gender'] : null,
                    'mobile' => $values['mobile'],
                    'whatsapp_number' => $values['whatsapp_number'] !== '' ? $values['whatsapp_number'] : null,
                    'email' => $values['email'],
                    'address' => $values['address'] !== '' ? $values['address'] : null,
                    'city' => $values['city'] !== '' ? $values['city'] : null,
                    'state' => $values['state'] !== '' ? $values['state'] : null,
                    'pincode' => $values['pincode'] !== '' ? $values['pincode'] : null,
                ]);

                for ($attempt = 0; $attempt < 2; $attempt++) {
                    $applicationReference = generate_reference_number('HR', 'hr_applications', 'application_reference_no');
                    try {
                        $stmt = $pdo->prepare(
                            'INSERT INTO hr_applications (
                                application_reference_no, candidate_id, vacancy_id,
                                current_company, current_designation, total_experience, relevant_experience,
                                current_salary, expected_salary, notice_period, employment_status, reason_for_leaving,
                                preferred_location, willing_to_relocate,
                                primary_skills, secondary_skills, computer_skills, language_skills,
                                source, source_detail, is_possible_duplicate, duplicate_of_application_id,
                                consent_accurate_info, consent_data_use, consent_privacy_terms, consent_no_guarantee, consent_given_at, ip_address
                            ) VALUES (
                                :ref, :candidate_id, :vacancy_id,
                                :company, :designation, :total_exp, :relevant_exp,
                                :current_salary, :expected_salary, :notice_period, :employment_status, :reason,
                                :preferred_location, :relocate,
                                :primary_skills, :secondary_skills, :computer_skills, :language_skills,
                                :source, :source_detail, :is_duplicate, :duplicate_of,
                                :c1, :c2, :c3, :c4, NOW(), :ip
                            )'
                        );
                        $stmt->execute([
                            'ref' => $applicationReference,
                            'candidate_id' => $candidateId,
                            'vacancy_id' => $vacancy['id'],
                            'company' => $values['current_company'] !== '' ? $values['current_company'] : null,
                            'designation' => $values['current_designation'] !== '' ? $values['current_designation'] : null,
                            'total_exp' => $values['total_experience'] !== '' ? $values['total_experience'] : null,
                            'relevant_exp' => $values['relevant_experience'] !== '' ? $values['relevant_experience'] : null,
                            'current_salary' => $values['current_salary'] !== '' ? $values['current_salary'] : null,
                            'expected_salary' => $values['expected_salary'] !== '' ? $values['expected_salary'] : null,
                            'notice_period' => $values['notice_period'] !== '' ? $values['notice_period'] : null,
                            'employment_status' => $values['employment_status'] !== '' ? $values['employment_status'] : null,
                            'reason' => $values['reason_for_leaving'] !== '' ? $values['reason_for_leaving'] : null,
                            'preferred_location' => $values['preferred_location'] !== '' ? $values['preferred_location'] : null,
                            'relocate' => $values['willing_to_relocate'] === 'yes' ? 1 : ($values['willing_to_relocate'] === 'no' ? 0 : null),
                            'primary_skills' => $values['primary_skills'] !== '' ? $values['primary_skills'] : null,
                            'secondary_skills' => $values['secondary_skills'] !== '' ? $values['secondary_skills'] : null,
                            'computer_skills' => $values['computer_skills'] !== '' ? $values['computer_skills'] : null,
                            'language_skills' => $values['language_skills'] !== '' ? $values['language_skills'] : null,
                            'source' => $sourceValue,
                            'source_detail' => $refNameValue !== '' ? $refNameValue : null,
                            'is_duplicate' => $isDuplicate ? 1 : 0,
                            'duplicate_of' => $duplicateOfApplicationId,
                            'c1' => 1, 'c2' => 1, 'c3' => 1, 'c4' => 1,
                            'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
                        ]);
                        break;
                    } catch (PDOException $e) {
                        if ($e->getCode() === '23000' && $attempt === 0) {
                            continue;
                        }
                        throw $e;
                    }
                }
                $applicationId = (int) $pdo->lastInsertId();

                $pdo->prepare(
                    'INSERT INTO hr_education (application_id, highest_qualification, course_degree, institution, passing_year, additional_certifications)
                     VALUES (:app_id, :qual, :degree, :institution, :year, :certs)'
                )->execute([
                    'app_id' => $applicationId,
                    'qual' => $values['highest_qualification'] !== '' ? $values['highest_qualification'] : null,
                    'degree' => $values['course_degree'] !== '' ? $values['course_degree'] : null,
                    'institution' => $values['institution'] !== '' ? $values['institution'] : null,
                    'year' => $values['passing_year'] !== '' ? (int) $values['passing_year'] : null,
                    'certs' => $values['additional_certifications'] !== '' ? $values['additional_certifications'] : null,
                ]);

                if ($values['current_company'] !== '' || $values['current_designation'] !== '') {
                    $pdo->prepare(
                        'INSERT INTO hr_employment_history (application_id, company_name, designation, duration)
                         VALUES (:app_id, :company, :designation, :duration)'
                    )->execute([
                        'app_id' => $applicationId,
                        'company' => $values['current_company'] !== '' ? $values['current_company'] : null,
                        'designation' => $values['current_designation'] !== '' ? $values['current_designation'] : null,
                        'duration' => $values['total_experience'] !== '' ? $values['total_experience'] : null,
                    ]);
                }

                foreach ($questions as $q) {
                    if (trim((string) $answerValues[$q['id']]) !== '') {
                        $pdo->prepare('INSERT INTO hr_candidate_answers (application_id, question_id, answer_text) VALUES (:app_id, :q_id, :answer)')
                            ->execute(['app_id' => $applicationId, 'q_id' => $q['id'], 'answer' => $answerValues[$q['id']]]);
                    }
                }

                store_hrms_document_upload($_FILES['cv'], 'cv', $applicationId);
                foreach ($optionalDocs as $field => $label) {
                    if (($_FILES[$field]['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_OK) {
                        $docTypeMap = ['photograph' => 'photograph', 'cover_letter' => 'cover_letter', 'experience_certificate' => 'experience_certificate', 'educational_certificate' => 'educational_certificate', 'other' => 'other'];
                        store_hrms_document_upload($_FILES[$field], $docTypeMap[$field], $applicationId);
                    }
                }

                hrms_record_status_change($applicationId, null, 'new', 'Application submitted via careers website.');

                $pdo->commit();
            } catch (Throwable $e) {
                if (isset($pdo) && $pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                if (APP_DEBUG) {
                    error_log('[careers apply] failed to save application: ' . $e->getMessage());
                }
                $submitted = false;
                $errors[] = 'Something went wrong submitting your application. Please try again.';
            }
        }
    }

    $pageTitle = "Apply — {$vacancy['job_title']} | Visagiri Careers";
    $pageDescription = "Application form for {$vacancy['job_title']} at Visagiri.";
    $canonicalUrl = APP_URL . "/careers/{$slug}/apply/";
    $noindex = true;
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="section" style="padding-top:var(--space-8)">
        <div class="container" style="max-width:760px">
            <?php if ($submitted && $applicationReference): ?>
            <div class="card" style="text-align:center;padding:var(--space-8)">
                <h1 style="color:var(--color-success, #1a7f37)">Application Submitted Successfully</h1>
                <p style="margin-top:var(--space-4)"><strong>Candidate Name:</strong> <?= e($values['full_name']) ?></p>
                <p><strong>Job Applied For:</strong> <?= e($vacancy['job_title']) ?></p>
                <p><strong>Application ID:</strong> <?= e($applicationReference) ?></p>
                <p><strong>Submission Date:</strong> <?= e(date('d M Y')) ?></p>
                <p style="margin-top:var(--space-4)">Our recruitment team will review your application and reach out to you at <?= e($values['email']) ?> or <?= e($values['mobile']) ?> if you're shortlisted for the next step.</p>
                <p style="margin-top:var(--space-6)"><a href="/careers/" class="btn btn-primary">Back to Careers</a></p>
            </div>
            <?php else: ?>
            <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
                <span class="section-eyebrow">Apply Now</span>
                <h1><?= e($vacancy['job_title']) ?></h1>
                <p><?= e($vacancy['department_name'] ?? '') ?><?= $vacancy['location'] ? ' · ' . e($vacancy['location']) : '' ?> · Ref. <?= e($vacancy['job_reference_no']) ?></p>
            </div>

            <?php foreach ($errors as $error): ?>
            <div class="alert alert-danger"><?= e($error) ?></div>
            <?php endforeach; ?>

            <form method="post" action="/careers/<?= e($slug) ?>/apply/" enctype="multipart/form-data" novalidate>
                <?= csrf_field() ?>
                <input type="hidden" name="source" value="<?= e($sourceValue) ?>">
                <input type="hidden" name="ref_name" value="<?= e($refNameValue) ?>">
                <div class="form-group" style="position:absolute;left:-9999px" aria-hidden="true">
                    <label for="website">Leave this field blank</label>
                    <input type="text" id="website" name="website" tabindex="-1" autocomplete="off">
                </div>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">Personal Information</div>
                    <div class="admin-form-grid">
                        <div class="form-group"><label class="form-label" for="full_name">Full Name *</label><input class="form-input" type="text" id="full_name" name="full_name" value="<?= e($values['full_name']) ?>" required></div>
                        <div class="form-group"><label class="form-label" for="date_of_birth">Date of Birth</label><input class="form-input" type="date" id="date_of_birth" name="date_of_birth" value="<?= e($values['date_of_birth']) ?>"></div>
                        <div class="form-group">
                            <label class="form-label" for="gender">Gender</label>
                            <select class="form-select" id="gender" name="gender">
                                <option value="">— Not specified —</option>
                                <?php foreach (['male' => 'Male', 'female' => 'Female', 'other' => 'Other'] as $val => $label): ?>
                                <option value="<?= $val ?>"<?= $values['gender'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="form-group"><label class="form-label" for="mobile">Mobile Number *</label><input class="form-input" type="tel" id="mobile" name="mobile" value="<?= e($values['mobile']) ?>" required></div>
                        <div class="form-group"><label class="form-label" for="whatsapp_number">WhatsApp Number</label><input class="form-input" type="tel" id="whatsapp_number" name="whatsapp_number" value="<?= e($values['whatsapp_number']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="email">Email Address *</label><input class="form-input" type="email" id="email" name="email" value="<?= e($values['email']) ?>" required></div>
                        <div class="form-group"><label class="form-label" for="city">City</label><input class="form-input" type="text" id="city" name="city" value="<?= e($values['city']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="state">State</label><input class="form-input" type="text" id="state" name="state" value="<?= e($values['state']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="pincode">PIN Code</label><input class="form-input" type="text" id="pincode" name="pincode" value="<?= e($values['pincode']) ?>"></div>
                    </div>
                    <div class="form-group"><label class="form-label" for="address">Current Address</label><textarea class="form-input" id="address" name="address" rows="2"><?= e($values['address']) ?></textarea></div>
                </div>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">Professional Information</div>
                    <div class="admin-form-grid">
                        <div class="form-group"><label class="form-label" for="current_company">Current/Previous Company</label><input class="form-input" type="text" id="current_company" name="current_company" value="<?= e($values['current_company']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="current_designation">Current Designation</label><input class="form-input" type="text" id="current_designation" name="current_designation" value="<?= e($values['current_designation']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="total_experience">Total Work Experience</label><input class="form-input" type="text" id="total_experience" name="total_experience" placeholder="e.g. 3 years 4 months" value="<?= e($values['total_experience']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="relevant_experience">Relevant Experience</label><input class="form-input" type="text" id="relevant_experience" name="relevant_experience" value="<?= e($values['relevant_experience']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="current_salary">Current/Last Salary</label><input class="form-input" type="text" id="current_salary" name="current_salary" value="<?= e($values['current_salary']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="expected_salary">Expected Salary</label><input class="form-input" type="text" id="expected_salary" name="expected_salary" value="<?= e($values['expected_salary']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="notice_period">Notice Period</label><input class="form-input" type="text" id="notice_period" name="notice_period" value="<?= e($values['notice_period']) ?>"></div>
                        <div class="form-group">
                            <label class="form-label" for="employment_status">Current Employment Status</label>
                            <select class="form-select" id="employment_status" name="employment_status">
                                <option value="">— Select —</option>
                                <?php foreach (['employed' => 'Employed', 'unemployed' => 'Unemployed', 'serving_notice' => 'Serving Notice', 'freelancer' => 'Freelancer', 'student' => 'Student', 'other' => 'Other'] as $val => $label): ?>
                                <option value="<?= $val ?>"<?= $values['employment_status'] === $val ? ' selected' : '' ?>><?= $label ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="form-group"><label class="form-label" for="preferred_location">Preferred Location</label><input class="form-input" type="text" id="preferred_location" name="preferred_location" value="<?= e($values['preferred_location']) ?>"></div>
                        <div class="form-group">
                            <label class="form-label" for="willing_to_relocate">Willing to Relocate</label>
                            <select class="form-select" id="willing_to_relocate" name="willing_to_relocate">
                                <option value="">— Select —</option>
                                <option value="yes"<?= $values['willing_to_relocate'] === 'yes' ? ' selected' : '' ?>>Yes</option>
                                <option value="no"<?= $values['willing_to_relocate'] === 'no' ? ' selected' : '' ?>>No</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group"><label class="form-label" for="reason_for_leaving">Reason for Leaving</label><textarea class="form-input" id="reason_for_leaving" name="reason_for_leaving" rows="2"><?= e($values['reason_for_leaving']) ?></textarea></div>
                </div>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">Education</div>
                    <div class="admin-form-grid">
                        <div class="form-group"><label class="form-label" for="highest_qualification">Highest Qualification</label><input class="form-input" type="text" id="highest_qualification" name="highest_qualification" value="<?= e($values['highest_qualification']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="course_degree">Course/Degree</label><input class="form-input" type="text" id="course_degree" name="course_degree" value="<?= e($values['course_degree']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="institution">Institution/University</label><input class="form-input" type="text" id="institution" name="institution" value="<?= e($values['institution']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="passing_year">Passing Year</label><input class="form-input" type="number" id="passing_year" name="passing_year" min="1960" max="2100" value="<?= e($values['passing_year']) ?>"></div>
                    </div>
                    <div class="form-group"><label class="form-label" for="additional_certifications">Additional Certifications</label><textarea class="form-input" id="additional_certifications" name="additional_certifications" rows="2"><?= e($values['additional_certifications']) ?></textarea></div>
                </div>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">Skills</div>
                    <div class="admin-form-grid">
                        <div class="form-group"><label class="form-label" for="primary_skills">Primary Skills</label><input class="form-input" type="text" id="primary_skills" name="primary_skills" value="<?= e($values['primary_skills']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="secondary_skills">Secondary Skills</label><input class="form-input" type="text" id="secondary_skills" name="secondary_skills" value="<?= e($values['secondary_skills']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="computer_skills">Computer Skills</label><input class="form-input" type="text" id="computer_skills" name="computer_skills" value="<?= e($values['computer_skills']) ?>"></div>
                        <div class="form-group"><label class="form-label" for="language_skills">Language Skills</label><input class="form-input" type="text" id="language_skills" name="language_skills" value="<?= e($values['language_skills']) ?>"></div>
                    </div>
                </div>

                <?php if ($questions): ?>
                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">About This Role</div>
                    <?php foreach ($questions as $q): ?>
                    <div class="form-group">
                        <label class="form-label" for="q<?= (int) $q['id'] ?>"><?= e($q['question_label']) ?><?= (int) $q['is_required'] === 1 ? ' *' : '' ?></label>
                        <?php if ($q['question_type'] === 'textarea'): ?>
                        <textarea class="form-input" id="q<?= (int) $q['id'] ?>" name="q<?= (int) $q['id'] ?>" rows="3"<?= (int) $q['is_required'] === 1 ? ' required' : '' ?>><?= e($answerValues[$q['id']] ?? '') ?></textarea>
                        <?php elseif ($q['question_type'] === 'select'): ?>
                        <select class="form-select" id="q<?= (int) $q['id'] ?>" name="q<?= (int) $q['id'] ?>"<?= (int) $q['is_required'] === 1 ? ' required' : '' ?>>
                            <option value="">— Select —</option>
                            <?php foreach ((json_decode((string) $q['options'], true) ?: []) as $opt): ?>
                            <option value="<?= e($opt) ?>"<?= ($answerValues[$q['id']] ?? '') === $opt ? ' selected' : '' ?>><?= e($opt) ?></option>
                            <?php endforeach; ?>
                        </select>
                        <?php elseif ($q['question_type'] === 'yesno'): ?>
                        <select class="form-select" id="q<?= (int) $q['id'] ?>" name="q<?= (int) $q['id'] ?>"<?= (int) $q['is_required'] === 1 ? ' required' : '' ?>>
                            <option value="">— Select —</option>
                            <option value="Yes"<?= ($answerValues[$q['id']] ?? '') === 'Yes' ? ' selected' : '' ?>>Yes</option>
                            <option value="No"<?= ($answerValues[$q['id']] ?? '') === 'No' ? ' selected' : '' ?>>No</option>
                        </select>
                        <?php else: ?>
                        <input class="form-input" type="<?= $q['question_type'] === 'number' ? 'number' : 'text' ?>" id="q<?= (int) $q['id'] ?>" name="q<?= (int) $q['id'] ?>" value="<?= e($answerValues[$q['id']] ?? '') ?>"<?= (int) $q['is_required'] === 1 ? ' required' : '' ?>>
                        <?php endif; ?>
                    </div>
                    <?php endforeach; ?>
                </div>
                <?php endif; ?>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">CV &amp; Documents</div>
                    <div class="form-group"><label class="form-label" for="cv">CV/Resume * <small style="color:var(--text-muted)">(PDF, DOC, DOCX, JPG, PNG — max 10MB)</small></label><input class="form-input" type="file" id="cv" name="cv" required></div>
                    <div class="form-group"><label class="form-label" for="photograph">Photograph (optional)</label><input class="form-input" type="file" id="photograph" name="photograph"></div>
                    <div class="form-group"><label class="form-label" for="cover_letter">Cover Letter (optional)</label><input class="form-input" type="file" id="cover_letter" name="cover_letter"></div>
                    <div class="form-group"><label class="form-label" for="experience_certificate">Experience Certificate (optional)</label><input class="form-input" type="file" id="experience_certificate" name="experience_certificate"></div>
                    <div class="form-group"><label class="form-label" for="educational_certificate">Educational Certificate (optional)</label><input class="form-input" type="file" id="educational_certificate" name="educational_certificate"></div>
                    <div class="form-group"><label class="form-label" for="other">Other Supporting Document (optional)</label><input class="form-input" type="file" id="other" name="other"></div>
                </div>

                <div class="card" style="margin-bottom:var(--space-6)">
                    <div class="card-title">Declaration &amp; Consent</div>
                    <label style="display:flex;gap:var(--space-2);align-items:flex-start;margin-bottom:var(--space-2)"><input type="checkbox" name="consent_accurate_info" required> <span>I confirm the information provided in this application is accurate to the best of my knowledge.</span></label>
                    <label style="display:flex;gap:var(--space-2);align-items:flex-start;margin-bottom:var(--space-2)"><input type="checkbox" name="consent_data_use" required> <span>I authorize Visagiri to use this information for recruitment purposes.</span></label>
                    <label style="display:flex;gap:var(--space-2);align-items:flex-start;margin-bottom:var(--space-2)"><input type="checkbox" name="consent_privacy_terms" required> <span>I agree to Visagiri's recruitment and <a href="/privacy/" target="_blank" rel="noopener">privacy terms</a>.</span></label>
                    <label style="display:flex;gap:var(--space-2);align-items:flex-start"><input type="checkbox" name="consent_no_guarantee" required> <span>I understand that submitting this application does not guarantee employment.</span></label>
                </div>

                <button type="submit" class="btn btn-primary" style="width:100%">Submit Application</button>
            </form>
            <?php endif; ?>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

// ---------------------------------------------------------------
// /careers/{slug}/ — job detail page
// ---------------------------------------------------------------
if ($slug !== null) {
    $vacancy = hrms_published_vacancy_by_slug($slug);
    if (!$vacancy) {
        render_not_found("We couldn't find that vacancy, or it's no longer accepting applications.");
    }

    $pageTitle = "{$vacancy['job_title']} — Careers at Visagiri";
    $pageDescription = "Apply for {$vacancy['job_title']}" . ($vacancy['department_name'] ? " in {$vacancy['department_name']}" : '') . ($vacancy['location'] ? " at Visagiri, {$vacancy['location']}." : ' at Visagiri.');
    $canonicalUrl = APP_URL . "/careers/{$slug}/";
    $structuredData = [array_filter([
        '@context' => 'https://schema.org',
        '@type' => 'JobPosting',
        'title' => $vacancy['job_title'],
        'description' => $vacancy['job_description'],
        'identifier' => ['@type' => 'PropertyValue', 'name' => 'Visagiri', 'value' => $vacancy['job_reference_no']],
        'datePosted' => $vacancy['published_at'] ? date('Y-m-d', strtotime((string) $vacancy['published_at'])) : date('Y-m-d', strtotime((string) $vacancy['created_at'])),
        'validThrough' => $vacancy['application_closing_date'] ? date('Y-m-d', strtotime((string) $vacancy['application_closing_date'])) . 'T23:59:59' : null,
        'employmentType' => strtoupper((string) $vacancy['employment_type']),
        'hiringOrganization' => ['@type' => 'Organization', 'name' => 'Visagiri', 'sameAs' => APP_URL . '/'],
        'jobLocation' => $vacancy['location'] ? [
            '@type' => 'Place',
            'address' => ['@type' => 'PostalAddress', 'addressLocality' => $vacancy['location'], 'addressCountry' => 'IN'],
        ] : null,
        'baseSalary' => ($vacancy['salary_min'] || $vacancy['salary_max']) ? [
            '@type' => 'MonetaryAmount',
            'currency' => $vacancy['salary_currency'],
            'value' => ['@type' => 'QuantitativeValue', 'minValue' => (float) $vacancy['salary_min'], 'maxValue' => (float) $vacancy['salary_max'], 'unitText' => 'MONTH'],
        ] : null,
    ], static fn($v) => $v !== null)];
    require __DIR__ . '/../includes/header.php';
    ?>
    <section class="visa-detail">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="/">Home</a></li>
                <li><a href="/careers/">Careers</a></li>
                <li><?= e($vacancy['job_title']) ?></li>
            </ul>
            <div class="visa-detail__header">
                <div>
                    <h1><?= e($vacancy['job_title']) ?></h1>
                    <p>
                        <?= e($vacancy['department_name'] ?? 'Visagiri') ?>
                        <?= $vacancy['location'] ? ' · ' . e($vacancy['location']) : '' ?>
                        · <?= e(ucwords(str_replace('_', ' ', $vacancy['employment_type']))) ?>
                        · Ref. <?= e($vacancy['job_reference_no']) ?>
                    </p>
                    <a href="/careers/<?= e($slug) ?>/apply/" class="btn btn-gold" target="_blank" rel="noopener noreferrer">Apply Now</a>
                </div>
            </div>
            <div class="visa-spec-grid">
                <?php if ($vacancy['experience_required']): ?><div class="card"><div class="card-title">Experience Required</div><p><?= e($vacancy['experience_required']) ?></p></div><?php endif; ?>
                <?php if ($vacancy['qualification']): ?><div class="card"><div class="card-title">Qualification</div><p><?= e($vacancy['qualification']) ?></p></div><?php endif; ?>
                <?php if ($vacancy['salary_min'] || $vacancy['salary_max']): ?>
                <div class="card"><div class="card-title">Salary Range</div><p><?= e($vacancy['salary_currency']) ?> <?= e(number_format((float) $vacancy['salary_min'])) ?> – <?= e(number_format((float) $vacancy['salary_max'])) ?> / month</p></div>
                <?php endif; ?>
                <?php if ($vacancy['application_closing_date']): ?><div class="card"><div class="card-title">Application Deadline</div><p><?= e(date('d M Y', strtotime((string) $vacancy['application_closing_date']))) ?></p></div><?php endif; ?>
            </div>

            <div class="card" style="margin-top:var(--space-6)">
                <div class="card-title">Job Description</div>
                <p style="white-space:pre-line"><?= e($vacancy['job_description']) ?></p>
            </div>
            <?php if ($vacancy['responsibilities']): ?>
            <div class="card" style="margin-top:var(--space-6)">
                <div class="card-title">Responsibilities</div>
                <p style="white-space:pre-line"><?= e($vacancy['responsibilities']) ?></p>
            </div>
            <?php endif; ?>
            <?php if ($vacancy['required_skills']): ?>
            <div class="card" style="margin-top:var(--space-6)">
                <div class="card-title">Skills Required</div>
                <p style="white-space:pre-line"><?= e($vacancy['required_skills']) ?></p>
            </div>
            <?php endif; ?>
            <?php if ($vacancy['benefits']): ?>
            <div class="card" style="margin-top:var(--space-6)">
                <div class="card-title">Benefits</div>
                <p style="white-space:pre-line"><?= e($vacancy['benefits']) ?></p>
            </div>
            <?php endif; ?>

            <div style="margin-top:var(--space-8);text-align:center">
                <a href="/careers/<?= e($slug) ?>/apply/" class="btn btn-primary" target="_blank" rel="noopener noreferrer">Apply Now</a>
            </div>
        </div>
    </section>
    <?php
    require __DIR__ . '/../includes/footer.php';
    exit;
}

// ---------------------------------------------------------------
// /careers/ — listing
// ---------------------------------------------------------------
$vacancies = hrms_published_vacancies();

$pageTitle = 'Careers at Visagiri';
$pageDescription = 'Explore current job openings at Visagiri and apply online.';
$canonicalUrl = APP_URL . '/careers/';
require __DIR__ . '/../includes/header.php';
?>
<section class="section">
    <div class="container">
        <div class="section-heading" style="text-align:left;margin-left:0;max-width:none">
            <span class="section-eyebrow">Join Our Team</span>
            <h1>Careers</h1>
            <p>Current opportunities at Visagiri.</p>
        </div>
        <?php if ($vacancies): ?>
        <div class="card-grid">
            <?php foreach ($vacancies as $v): ?>
            <a href="/careers/<?= e($v['slug']) ?>/" class="card service-card">
                <div class="card-title"><?= e($v['job_title']) ?></div>
                <p><?= e($v['department_name'] ?? 'Visagiri') ?><?= $v['location'] ? ' · ' . e($v['location']) : '' ?></p>
                <p><?= e(ucwords(str_replace('_', ' ', $v['employment_type']))) ?><?= $v['experience_required'] ? ' · ' . e($v['experience_required']) : '' ?></p>
            </a>
            <?php endforeach; ?>
        </div>
        <?php else: ?>
        <p class="empty-state">There are no open positions at the moment. Check back soon, or follow us for updates.</p>
        <?php endif; ?>
    </div>
</section>
<?php require __DIR__ . '/../includes/footer.php'; ?>
