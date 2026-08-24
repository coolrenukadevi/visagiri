<?php require_once __DIR__ . '/countries-data.php'; ?>
<div class="enquiry-modal" id="enquiryModal" role="dialog" aria-modal="true" aria-labelledby="enquiryModalTitle" hidden>
    <div class="enquiry-modal-backdrop" data-enquiry-close></div>
    <div class="enquiry-modal-dialog">
        <button type="button" class="enquiry-modal-close" data-enquiry-close aria-label="Close enquiry form">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <div class="enquiry-modal-body">
            <form id="enquiryForm" class="enquiry-form" novalidate>
                <div class="enquiry-modal-header">
                    <h2 id="enquiryModalTitle">Submit Your Enquiry</h2>
                    <p>Share your requirements and our visa/travel expert will get back to you shortly.</p>
                </div>

                <!-- Honeypot — hidden from real users, bots tend to fill every field -->
                <div class="enquiry-honeypot" aria-hidden="true">
                    <label for="enquiryWebsite">Leave this field empty</label>
                    <input type="text" id="enquiryWebsite" name="website" tabindex="-1" autocomplete="off">
                </div>

                <input type="hidden" name="submission_token" id="enquirySubmissionToken">
                <input type="hidden" name="source_url" id="enquirySourceUrl">
                <input type="hidden" name="utm_source" id="enquiryUtmSource">
                <input type="hidden" name="utm_medium" id="enquiryUtmMedium">
                <input type="hidden" name="utm_campaign" id="enquiryUtmCampaign">
                <input type="hidden" name="utm_term" id="enquiryUtmTerm">
                <input type="hidden" name="utm_content" id="enquiryUtmContent">

                <div class="enquiry-section">
                    <h3><i class="fa-solid fa-user"></i> Personal Details</h3>
                    <div class="enquiry-grid">
                        <div class="enquiry-field">
                            <label for="enqFullName">Full Name *</label>
                            <input type="text" id="enqFullName" name="full_name" required maxlength="150">
                            <span class="enquiry-error" data-error-for="full_name"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqEmail">Email Address *</label>
                            <input type="email" id="enqEmail" name="email" required>
                            <span class="enquiry-error" data-error-for="email"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqMobile">Mobile Number *</label>
                            <div class="enquiry-phone-input">
                                <span class="enquiry-phone-prefix">+91</span>
                                <input type="tel" id="enqMobile" name="mobile" required inputmode="numeric" maxlength="10" placeholder="10-digit mobile number">
                            </div>
                            <span class="enquiry-error" data-error-for="mobile"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqPassportNumber">Passport Number *</label>
                            <input type="text" id="enqPassportNumber" name="passport_number" required maxlength="12" placeholder="e.g. N1234567" style="text-transform:uppercase;">
                            <span class="enquiry-error" data-error-for="passport_number"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqCountryResidence">Country of Residence</label>
                            <select id="enqCountryResidence" name="country_residence">
                                <option value="">Select country</option>
                                <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                                <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqContactMethod">Preferred Contact Method</label>
                            <select id="enqContactMethod" name="contact_method">
                                <option value="">Select method</option>
                                <option value="Phone">Phone</option>
                                <option value="WhatsApp">WhatsApp</option>
                                <option value="Email">Email</option>
                            </select>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqServiceRequired">Service Required *</label>
                            <select id="enqServiceRequired" name="service_required" required>
                                <option value="">Select service</option>
                                <option>Tourist Visa</option>
                                <option>Business Visa</option>
                                <option>Student Visa</option>
                                <option>Work Visa</option>
                                <option>Transit Visa</option>
                                <option>Family Visa</option>
                                <option>Sports Visa</option>
                                <option>Medical Visa</option>
                                <option>Crew Visa</option>
                                <option>Visa Extension</option>
                                <option>Other</option>
                            </select>
                            <span class="enquiry-error" data-error-for="service_required"></span>
                        </div>
                    </div>
                </div>

                <div class="enquiry-section">
                    <h3><i class="fa-solid fa-plane-departure"></i> Travel Details</h3>
                    <div class="enquiry-grid">
                        <div class="enquiry-field">
                            <label for="enqDestinationCountry">Destination Country *</label>
                            <select id="enqDestinationCountry" name="destination_country" required>
                                <option value="">Select destination</option>
                                <?php foreach ($VISA_AGENCY_COUNTRIES as $c): ?>
                                <option value="<?php echo htmlspecialchars($c['name']); ?>"><?php echo htmlspecialchars($c['name']); ?></option>
                                <?php endforeach; ?>
                            </select>
                            <span class="enquiry-error" data-error-for="destination_country"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqVisaType">Visa Type *</label>
                            <select id="enqVisaType" name="visa_type" required>
                                <option value="">Select visa type</option>
                                <option>Tourist Visa</option>
                                <option>Business Visa</option>
                                <option>Student Visa</option>
                                <option>Work Visa</option>
                                <option>Transit Visa</option>
                                <option>Family Visa</option>
                                <option>Sports Visa</option>
                                <option>Medical Visa</option>
                                <option>Crew Visa</option>
                                <option>Visa Extension</option>
                                <option>Other</option>
                            </select>
                            <span class="enquiry-error" data-error-for="visa_type"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqTravelDate">Expected Travel Date *</label>
                            <input type="date" id="enqTravelDate" name="travel_date" required>
                            <span class="enquiry-error" data-error-for="travel_date"></span>
                        </div>
                        <div class="enquiry-field">
                            <label for="enqTravellers">Number of Travellers *</label>
                            <input type="number" id="enqTravellers" name="travellers" min="1" max="50" required>
                            <span class="enquiry-error" data-error-for="travellers"></span>
                        </div>
                        <div class="enquiry-field enquiry-field-full">
                            <label for="enqPurpose">Purpose of Travel</label>
                            <input type="text" id="enqPurpose" name="purpose" maxlength="200">
                        </div>
                        <div class="enquiry-field enquiry-field-full">
                            <label for="enqMessage">Additional Requirements / Message</label>
                            <textarea id="enqMessage" name="message" rows="3" maxlength="1000"></textarea>
                        </div>
                    </div>
                </div>

                <div class="enquiry-section">
                    <h3><i class="fa-solid fa-paperclip"></i> Upload Supporting Documents</h3>
                    <p class="enquiry-upload-hint">Accepted formats: PDF, JPG, JPEG, PNG &mdash; maximum 5MB per file.</p>
                    <div class="enquiry-upload-grid">
                        <div class="enquiry-upload-box" data-category="photo" data-label="Photo">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-image"></i>
                                <span>Photo</span>
                                <small>Drag &amp; drop or click to browse</small>
                            </div>
                            <input type="file" name="photo" accept=".pdf,.jpg,.jpeg,.png" hidden>
                            <div class="enquiry-upload-list"></div>
                        </div>
                        <div class="enquiry-upload-box" data-category="passport_copy" data-label="Passport Copy">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-passport"></i>
                                <span>Passport Copy</span>
                                <small>Drag &amp; drop or click to browse</small>
                            </div>
                            <input type="file" name="passport_copy" accept=".pdf,.jpg,.jpeg,.png" hidden>
                            <div class="enquiry-upload-list"></div>
                            <p class="enquiry-upload-note">Please upload a clear printer/scanner copy of your passport. Mobile camera photographs or unclear photocopies may not be accepted.</p>
                        </div>
                        <div class="enquiry-upload-box" data-category="flight_tickets" data-label="Flight Tickets">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-ticket"></i>
                                <span>Flight Tickets</span>
                                <small>Drag &amp; drop or click to browse</small>
                            </div>
                            <input type="file" name="flight_tickets" accept=".pdf,.jpg,.jpeg,.png" hidden>
                            <div class="enquiry-upload-list"></div>
                        </div>
                        <div class="enquiry-upload-box" data-category="hotel_reservations" data-label="Hotel Reservations">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-hotel"></i>
                                <span>Hotel Reservations</span>
                                <small>Drag &amp; drop or click to browse</small>
                            </div>
                            <input type="file" name="hotel_reservations" accept=".pdf,.jpg,.jpeg,.png" hidden>
                            <div class="enquiry-upload-list"></div>
                        </div>
                        <div class="enquiry-upload-box" data-category="cover_letter" data-label="Cover Letter">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-file-lines"></i>
                                <span>Cover Letter</span>
                                <small>Drag &amp; drop or click to browse</small>
                            </div>
                            <input type="file" name="cover_letter" accept=".pdf,.jpg,.jpeg,.png" hidden>
                            <div class="enquiry-upload-list"></div>
                        </div>
                        <div class="enquiry-upload-box" data-category="other_documents" data-label="Other Documents" data-multiple="true">
                            <div class="enquiry-upload-drop">
                                <i class="fa-solid fa-folder-open"></i>
                                <span>Other Documents</span>
                                <small>Multiple files allowed</small>
                            </div>
                            <input type="file" name="other_documents[]" accept=".pdf,.jpg,.jpeg,.png" multiple hidden>
                            <div class="enquiry-upload-list"></div>
                        </div>
                    </div>
                </div>

                <div class="enquiry-section">
                    <label class="enquiry-checkbox">
                        <input type="checkbox" name="consent_accurate" required>
                        <span>I confirm that the information provided is accurate and complete.</span>
                    </label>
                    <label class="enquiry-checkbox">
                        <input type="checkbox" name="consent_contact" required>
                        <span>I agree to be contacted regarding my enquiry and understand that visa approval is subject to the decision of the relevant embassy/immigration authority.</span>
                    </label>
                    <span class="enquiry-error" data-error-for="consent"></span>
                </div>

                <div class="enquiry-form-error" id="enquiryFormError" hidden></div>

                <div class="enquiry-submit-bar">
                    <button type="button" class="enquiry-btn-secondary" data-enquiry-close>Cancel</button>
                    <button type="submit" class="enquiry-btn-primary" id="enquirySubmitBtn">
                        <span class="enquiry-btn-label">Submit Enquiry</span>
                        <span class="enquiry-btn-spinner" hidden></span>
                    </button>
                </div>
            </form>

            <div class="enquiry-success" id="enquirySuccess" hidden>
                <div class="enquiry-success-icon"><i class="fa-solid fa-circle-check"></i></div>
                <h2>Enquiry Submitted Successfully</h2>
                <p>Thank you for submitting your visa enquiry. Your enquiry has been successfully registered with our visa management team.</p>

                <div class="enquiry-tracking-code">
                    <span class="etc-label">Tracking Code</span>
                    <span class="etc-value" id="enquirySuccessCode"></span>
                </div>
                <p class="enquiry-success-warn"><i class="fa-solid fa-triangle-exclamation"></i> Please save your Tracking Code. You will need it to check your application status.</p>

                <div class="enquiry-success-grid">
                    <div><label>Applicant Name</label><span id="esFullName"></span></div>
                    <div><label>Passport Number</label><span id="esPassport"></span></div>
                    <div><label>Mobile Number</label><span id="esMobile"></span></div>
                    <div><label>Email Address</label><span id="esEmail"></span></div>
                    <div><label>Visa Country</label><span id="esCountry"></span></div>
                    <div><label>Visa Type</label><span id="esVisaType"></span></div>
                    <div class="enquiry-field-full"><label>Submission Date &amp; Time</label><span id="esSubmittedAt"></span></div>
                </div>

                <p class="enquiry-success-warnings" id="enquirySuccessWarnings" hidden></p>

                <div class="enquiry-success-actions">
                    <a class="enquiry-btn-primary" id="esTrackBtn" href="track-application" target="_blank" rel="noopener">Track Application</a>
                    <a class="enquiry-btn-secondary" id="esDownloadBtn" href="#" target="_blank" rel="noopener">Download Confirmation</a>
                    <button type="button" class="enquiry-btn-secondary" data-enquiry-close>Back to Home</button>
                </div>
            </div>
        </div>
    </div>
</div>
