-- Country-grouping memberships — stable, publicly verifiable
-- political/geographic facts (which countries belong to the GCC,
-- ASEAN, SAARC, and the commonly-used "Middle East"/"Caribbean"
-- travel groupings), not visa policy. India is deliberately excluded
-- from is_saarc here even though it's a real SAARC member — this
-- site is an outbound consultancy for Indian travellers, so an
-- Indian-passport-holder "visa to India" listing has no purpose here.
-- visa_policy_for_indians is intentionally NOT set for anyone in this
-- file — that's real visa-policy data that needs a staff-verified
-- source, entered later through /admin/countries/, not assumed here.

UPDATE countries SET is_gcc = 1 WHERE slug IN (
    'saudi-arabia', 'uae', 'qatar', 'kuwait', 'bahrain', 'oman'
);

UPDATE countries SET is_asean = 1 WHERE slug IN (
    'brunei', 'cambodia', 'indonesia', 'laos', 'malaysia',
    'myanmar', 'philippines', 'singapore', 'thailand', 'vietnam'
);

UPDATE countries SET is_saarc = 1 WHERE slug IN (
    'afghanistan', 'bangladesh', 'bhutan', 'maldives', 'nepal', 'pakistan', 'sri-lanka'
);

UPDATE countries SET is_middle_east = 1 WHERE slug IN (
    'bahrain', 'iran', 'iraq', 'israel', 'jordan', 'kuwait', 'lebanon',
    'oman', 'palestine', 'qatar', 'saudi-arabia', 'syria', 'uae', 'yemen'
);

UPDATE countries SET is_caribbean = 1 WHERE slug IN (
    'antigua-and-barbuda', 'bahamas', 'barbados', 'cuba', 'dominica',
    'dominican-republic', 'grenada', 'haiti', 'jamaica', 'saint-kitts-and-nevis',
    'saint-lucia', 'saint-vincent-and-the-grenadines', 'trinidad-and-tobago'
);
