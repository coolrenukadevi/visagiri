#!/usr/bin/env bash
#
# Packages this project as a single flat folder for hosts where the
# document root can't be pointed at public/ (typical basic shared
# cPanel) — everything ends up as siblings ready to upload straight
# into public_html/, instead of needing public/'s contents in one
# place and includes/ etc. in another.
#
# What this does NOT do: change how the app is developed or how it's
# deployed on hosts that DO support a custom document root — this
# script only ever reads the working tree and writes to a separate
# build directory; nothing here is required for local development.
#
# Security note: with this layout, includes/ and config/ (which holds
# the real database password — see config/database.php) physically
# sit inside the web-servable folder, as does storage/ (local rate-
# limiter fallback state). All three are blocked from direct web
# access by rules already in public/.htaccess (carried into the
# package as the root .htaccess) — see that file for the reasoning.
# That's a real, if smaller, security trade-off versus keeping those
# folders truly outside the web root; see AUDIT.md.
#
# Usage: bin/package-cpanel.sh [output-zip-path]
# Defaults to ./visagiri-cpanel-YYYYMMDD.zip in the project root.

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

OUTPUT_ZIP="${1:-$PROJECT_ROOT/visagiri-cpanel-$(date +%Y%m%d).zip}"
BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

echo "==> Building flattened cPanel package in $BUILD_DIR"

rsync -a \
  --exclude '.git' \
  --exclude '.gitignore' \
  --exclude 'legacy-site' \
  --exclude 'docs' \
  --exclude 'bin' \
  --exclude 'google-apps-script' \
  --exclude '*.zip' \
  --exclude '*.log' \
  --exclude '.DS_Store' \
  --exclude 'config/database.php' \
  --exclude 'config/encryption.php' \
  ./ "$BUILD_DIR/"

# config/database.php and config/encryption.php are gitignored for a
# reason (the real DB password and the real AES key that will encrypt
# the client's live passport/PAN data) — this working tree's copies
# are real secrets for THIS sandbox, not placeholders, and must never
# leave it inside a zip that travels over chat/email. The package
# ships each one's .example.php sibling as a starting point instead;
# the client fills in real values directly on the server per the
# instructions printed at the end of this script.
cp "$BUILD_DIR/config/database.example.php" "$BUILD_DIR/config/database.php"
cp "$BUILD_DIR/config/encryption.example.php" "$BUILD_DIR/config/encryption.php"

echo "==> Moving public/ contents up to the package root"
# public/index.php, public/assets/, public/.htaccess, public/favicon.ico,
# public/robots.txt all become top-level; the (now empty) public/
# folder itself is removed. (rsync rather than `mv .../public/. .../`
# — the dot-slash form of mv is unreliable across filesystems.)
rsync -a "$BUILD_DIR/public/" "$BUILD_DIR/"
rm -rf "$BUILD_DIR/public"

echo "==> Patching the front controller's root path for the new (flattened) layout"
# In the two-folder layout, index.php lives one level below the real
# root (inside public/), so $root = dirname(__DIR__). Flattened,
# index.php IS the root, so $root = __DIR__. This is the one line
# that differs between the two layouts; asset_url() in
# includes/functions.php already checks both layouts on its own and
# needs no patching.
if ! grep -q '^\$root = dirname(__DIR__);$' "$BUILD_DIR/index.php"; then
    echo "!! Expected line not found in index.php — front controller may have changed." >&2
    echo "!! Aborting so a stale/broken package doesn't get produced silently." >&2
    exit 1
fi
sed -i 's/^\$root = dirname(__DIR__);$/\$root = __DIR__;/' "$BUILD_DIR/index.php"

echo "==> Verifying every .php file in the package still parses"
find "$BUILD_DIR" -name '*.php' -print0 | xargs -0 -n1 php -l > /dev/null

echo "==> Zipping to $OUTPUT_ZIP"
rm -f "$OUTPUT_ZIP"
(cd "$BUILD_DIR" && zip -r -q "$OUTPUT_ZIP" .)

echo "==> Done: $OUTPUT_ZIP ($(du -h "$OUTPUT_ZIP" | cut -f1))"
echo ""
echo "Next steps on cPanel:"
echo "  1. Upload and extract this zip's CONTENTS directly into public_html/"
echo "     (not into a subfolder — the files should sit right in public_html/)."
echo "  2. cPanel > MySQL Databases: create a database + user, then import the SQL files via"
echo "     phpMyAdmin IN THIS EXACT ORDER (later files depend on tables/rows the earlier ones create):"
echo "       database/schema.sql                        database/seed.sql"
echo "       database/schema-crm.sql                    database/seed-crm.sql"
echo "       database/schema-hrms.sql                   database/seed-hrms.sql"
echo "       database/schema-forex.sql                  database/seed-forex.sql"
echo "       database/schema-visa-portal.sql             database/seed-visa-portal.sql"
echo "       database/schema-customer-partner-portal.sql (no seed file — schema only)"
echo "       database/schema-b2b.sql                    database/seed-b2b.sql"
echo "       database/schema-b2b-phase2.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase3.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase5.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase6.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase7.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase8.sql              (no seed file — schema only)"
echo "       database/schema-b2b-phase9.sql              (no seed file — schema only)"
echo "       database/schema-legal-phase1.sql           database/seed-legal-phase1.sql"
echo "  3. config/database.php and config/encryption.php ship as their .example.php templates"
echo "     (CHANGE-ME placeholders) — the real secrets never leave the dev sandbox. On the server:"
echo "       - Edit config/database.php with the real DB host/name/user/password."
echo "       - Edit config/encryption.php with a freshly generated key:"
echo "         php -r \"echo bin2hex(random_bytes(32));\""
echo "         (back this key up somewhere safe outside the repo the moment it's set — losing it"
echo "         makes any already-encrypted passport/PAN data permanently undecryptable)."
echo "  4. Edit config/site.php on the server: app_env=production, app_debug=false,"
echo "     app_url=https://yourdomain.com, session_secure_cookie=true."
echo "  5. Log into /admin/ and /hrms/ with the credentials delivered separately, outside this package"
echo "     (see AUDIT.md's credential-delivery entry) — change both passwords immediately after first"
echo "     login, and set contact details + (optionally) the Google Apps Script URL under Settings."
echo "  6. cPanel > MultiPHP Manager: set PHP 8.2+ for the domain."
echo "  7. cPanel > SSL/TLS Status: run AutoSSL (the app force-redirects to HTTPS)."
