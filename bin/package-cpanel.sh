#!/usr/bin/env bash
#
# Packages this project as a single flat folder for hosts where the
# document root can't be pointed at public/ (typical basic shared
# cPanel) — everything ends up as siblings ready to upload straight
# into public_html/, instead of needing public/'s contents in one
# place and includes/ etc. in another. No database is involved: this
# build has none (see AUDIT.md, "Single-folder no-database rebuild").
#
# What this does NOT do: change how the app is developed or how it's
# deployed on hosts that DO support a custom document root — this
# script only ever reads the working tree and writes to a separate
# build directory; nothing here is required for local development.
#
# Security note: with this layout, includes/ physically sits inside
# the web-servable folder (as does storage/, local rate-limiter
# state). Both are blocked from direct web access by rules already in
# public/.htaccess (carried into the package as the root .htaccess) —
# see that file for the reasoning. That's a real, if smaller, security
# trade-off versus keeping includes/ truly outside the web root; see
# AUDIT.md.
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
  --exclude '.env' \
  --exclude 'legacy-site' \
  --exclude 'docs' \
  --exclude 'bin' \
  --exclude 'google-apps-script' \
  --exclude '*.zip' \
  --exclude '*.log' \
  --exclude '.DS_Store' \
  ./ "$BUILD_DIR/"

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
echo "  2. Copy .env.example to .env and set https://yourdomain.com as APP_URL."
echo "     No database setup needed — this build has none."
echo "  3. (Optional) Set up Google Sheets/Drive for enquiries: see docs/google-sheets-setup.md,"
echo "     then add the resulting URL to .env as GOOGLE_APPS_SCRIPT_URL."
echo "     Until then, enquiries are still emailed to MAIL_ENQUIRY_RECIPIENTS."
echo "  4. cPanel > MultiPHP Manager: set PHP 8.1+ for the domain."
echo "  5. cPanel > SSL/TLS Status: run AutoSSL (the app force-redirects to HTTPS)."
