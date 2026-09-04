-- Videshia platform schema (SQLite). Normalized core: identity, CRM, content.
-- Portable to MySQL/Postgres later; only AUTOINCREMENT/PRAGMA are SQLite-specific.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_id INTEGER NOT NULL REFERENCES roles(id),
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'active',
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT,
    mobile TEXT,
    nationality TEXT,
    passport_number TEXT,
    source TEXT DEFAULT 'website',
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE(email, mobile)
);

CREATE TABLE IF NOT EXISTS countries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    iso2 TEXT,
    iso3 TEXT,
    region TEXT,
    capital TEXT,
    currency TEXT,
    hero_summary TEXT,
    seo_title TEXT,
    seo_description TEXT,
    indexable INTEGER NOT NULL DEFAULT 0,
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS states (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT 'State',   -- 'State' | 'Union Territory'
    capital TEXT,
    zone TEXT,
    major_cities TEXT,             -- JSON array of real city names (display only, no dedicated city pages yet)
    seo_title TEXT,
    seo_description TEXT,
    indexable INTEGER NOT NULL DEFAULT 1,
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS visa_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS country_visa_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_id INTEGER NOT NULL REFERENCES countries(id) ON DELETE CASCADE,
    visa_category_id INTEGER NOT NULL REFERENCES visa_categories(id),
    overview TEXT,
    eligibility TEXT,
    documents_required TEXT,      -- JSON array
    process_steps TEXT,           -- JSON array
    processing_time TEXT,
    visa_fee TEXT,
    validity TEXT,
    stay_duration TEXT,
    entry_requirements TEXT,
    financial_requirements TEXT,
    common_rejection_reasons TEXT,
    important_notes TEXT,
    seo_title TEXT,
    seo_description TEXT,
    indexable INTEGER NOT NULL DEFAULT 0,
    last_reviewed_at TEXT,
    UNIQUE(country_id, visa_category_id)
);

CREATE TABLE IF NOT EXISTS faqs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    scope_type TEXT NOT NULL,     -- 'country_visa' | 'service' | 'general'
    scope_id INTEGER,             -- country_visa_categories.id when scope_type = country_visa
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    sort_order INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS enquiries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    reference_no TEXT NOT NULL UNIQUE,
    service_type TEXT NOT NULL,   -- visa|hotel|flight|tour|insurance|forex|general|corporate
    customer_id INTEGER NOT NULL REFERENCES customers(id),
    country TEXT,
    destination TEXT,
    travel_date TEXT,
    status TEXT NOT NULL DEFAULT 'New',
    priority TEXT NOT NULL DEFAULT 'Normal',
    source TEXT DEFAULT 'Website',
    assigned_to INTEGER REFERENCES users(id),
    notes TEXT,
    dedupe_key TEXT,
    created_by TEXT,
    updated_by TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now')),
    updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_enquiries_status ON enquiries(status);
CREATE INDEX IF NOT EXISTS idx_enquiries_service ON enquiries(service_type);
CREATE INDEX IF NOT EXISTS idx_enquiries_created ON enquiries(created_at);
CREATE UNIQUE INDEX IF NOT EXISTS idx_enquiries_dedupe ON enquiries(dedupe_key);

CREATE TABLE IF NOT EXISTS visa_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    passport_number TEXT,
    nationality TEXT,
    country_id INTEGER REFERENCES countries(id),
    visa_category_id INTEGER REFERENCES visa_categories(id),
    travel_date TEXT,
    return_date TEXT,
    travellers_count INTEGER DEFAULT 1,
    appointment_date TEXT,
    visa_fee TEXT,
    service_fee TEXT,
    payment_status TEXT DEFAULT 'Pending',
    application_status TEXT DEFAULT 'New'
);

CREATE TABLE IF NOT EXISTS hotel_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    destination TEXT,
    check_in TEXT,
    check_out TEXT,
    rooms INTEGER DEFAULT 1,
    adults INTEGER DEFAULT 1,
    children INTEGER DEFAULT 0,
    hotel_category TEXT,
    budget TEXT
);

CREATE TABLE IF NOT EXISTS flight_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    from_city TEXT,
    to_city TEXT,
    departure_date TEXT,
    return_date TEXT,
    trip_type TEXT DEFAULT 'One-way',
    adults INTEGER DEFAULT 1,
    children INTEGER DEFAULT 0,
    cabin_class TEXT DEFAULT 'Economy'
);

CREATE TABLE IF NOT EXISTS tour_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    destination TEXT,
    travel_date TEXT,
    duration TEXT,
    travellers INTEGER DEFAULT 1,
    budget TEXT
);

CREATE TABLE IF NOT EXISTS forex_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    currency TEXT,
    amount TEXT,
    travel_country TEXT,
    travel_date TEXT,
    forex_type TEXT,
    delivery_pref TEXT
);

CREATE TABLE IF NOT EXISTS insurance_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    destination TEXT,
    travel_start TEXT,
    travel_end TEXT,
    traveller_count INTEGER DEFAULT 1,
    traveller_ages TEXT,
    insurance_type TEXT
);

CREATE TABLE IF NOT EXISTS general_enquiries (
    enquiry_id INTEGER PRIMARY KEY REFERENCES enquiries(id) ON DELETE CASCADE,
    subject TEXT,
    message TEXT
);

CREATE TABLE IF NOT EXISTS newsletter_subscribers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT NOT NULL UNIQUE,
    subscribed_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS documents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
    doc_type TEXT NOT NULL,
    original_name TEXT NOT NULL,
    stored_path TEXT NOT NULL,
    size_bytes INTEGER,
    status TEXT NOT NULL DEFAULT 'Uploaded',
    uploaded_by TEXT,
    uploaded_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS followups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    enquiry_id INTEGER NOT NULL REFERENCES enquiries(id) ON DELETE CASCADE,
    follow_up_date TEXT NOT NULL,
    notes TEXT,
    status TEXT NOT NULL DEFAULT 'Pending',
    assigned_to INTEGER REFERENCES users(id),
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER REFERENCES users(id),
    action TEXT NOT NULL,
    entity_type TEXT,
    entity_id INTEGER,
    meta TEXT,
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS redirects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    old_path TEXT NOT NULL UNIQUE,
    new_path TEXT,
    redirect_type INTEGER NOT NULL DEFAULT 301,
    status TEXT NOT NULL DEFAULT 'active',
    created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS enquiry_counters (
    year INTEGER PRIMARY KEY,
    last_value INTEGER NOT NULL DEFAULT 0
);
