# Videshia — AI-Powered Visa Management

Marketing site and auth screens for videshia.com, built in plain PHP (no framework, no build step).

## Structure

```
index.php, about.php, services.php, contact.php   Public pages
login.php, signup.php, forgot-password.php        Auth screens (right-side login panel)
dashboard.php, logout.php                         Session-gated demo landing
includes/                                          Shared header, footer, config, auth, brand mark
assets/css/style.css                               Site-wide styles & design tokens
assets/css/auth.css                                Split-screen auth layout
assets/js/main.js                                  Nav toggle, password visibility, form UX
```

## Running locally

```bash
php -S localhost:8000
```

Then open `http://localhost:8000`.

## Demo login

The auth flow uses an in-memory demo account (no database wired up yet):

- Email: `demo@videshia.com`
- Password: `Videshia@123`

Sign-up submissions are validated but not persisted — replace `includes/auth.php` with real
user storage when a database is introduced.

## Brand

Colors and the logo mark in `includes/functions.php` (`videshia_logo()`) are sourced directly
from the Videshia brand mark: deep navy (`#0A1B3D`) to bright teal (`#17C3C9`).
