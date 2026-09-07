-- Default document-requirement rules — the client spec's own worked
-- example (Business Visa -> Invitation Letter mandatory). Everything
-- else falls back to enquiry_default_document_requirements() in
-- includes/enquiry.php until an admin configures more rules from the
-- CRM's document-rules screen.
INSERT INTO enquiry_document_requirements (service_category, visa_type_id, country_id, document_category, is_mandatory, sort_order)
SELECT 'visa', id, NULL, 'invitation_letter', 1, 1 FROM visa_types WHERE slug = 'business';
