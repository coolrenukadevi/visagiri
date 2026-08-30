#!/usr/bin/env node
/*
 * Exports the JS-authored content into JSON so PHP and the browser can both
 * read ONE source of truth. Run via `node tools/export-data.js` (build.js
 * calls it automatically).
 */
"use strict";
const fs = require("fs");
const path = require("path");
const ROOT = path.join(__dirname, "..");
const { COUNTRIES: RICH, STANDARD_DOCS, EMBASSY_CITIES, quickTouristVisa } = require(path.join(ROOT, "data/countries.js"));
const { loadImportedCountries } = require(path.join(ROOT, "lib/import-data.js"));
const { NAV, FOOTER_COLUMNS, FOOTER_DESTINATIONS } = require(path.join(ROOT, "data/navigation.js"));

const slug = (s) => String(s).normalize("NFD").replace(/[̀-ͯ]/g, "")
  .toLowerCase().replace(/&/g, "and").replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");

const ALL_NAMES = JSON.parse(fs.readFileSync(path.join(ROOT, "data/all-countries.json"), "utf-8"));

/*
 * Real national flags, derived rather than stored.
 *
 * A flag emoji is just the country's two ISO letters written as regional
 * indicator symbols (U+1F1E6 is "A"). So one code table gives all 216 correct
 * flags with no image assets, no CDN and nothing to keep in sync — and if a
 * code is wrong the flag is visibly wrong, which is easy to spot.
 *
 * The ISO code is exported alongside the flag so the page can fall back to a
 * country-code chip on platforms that ship no flag glyphs (Windows, mainly).
 */
const CODES = JSON.parse(fs.readFileSync(path.join(ROOT, "data/country-codes.json"), "utf-8"));
delete CODES._comment;
// XK is a user-assigned code, not an official ISO one, so no platform ships a
// flag glyph for it. Emitting the pair anyway would leave Kosovo showing bare
// letters next to 215 real flags; the chip fallback is the consistent answer.
const NO_EMOJI_FLAG = new Set(["XK"]);
const flagOf = (code) =>
  /^[A-Z]{2}$/.test(code || "") && !NO_EMOJI_FLAG.has(code)
    ? String.fromCodePoint(...[...code].map((ch) => 0x1f1e6 + ch.charCodeAt(0) - 65))
    : "";
const richSlugs = new Set(RICH.map((c) => c.slug));
const GENERIC_FLAG = "🌍";
const bulk = ALL_NAMES.filter((n) => !richSlugs.has(slug(n))).map((n) => quickTouristVisa(n, GENERIC_FLAG, slug(n)));
const imported = loadImportedCountries(path.join(ROOT, "data/import"));

const map = new Map();
const merge = (list) => list.forEach((c) => {
  if (!map.has(c.slug)) map.set(c.slug, { country: c.country, flag: c.flag, slug: c.slug, visaTypes: [] });
  const e = map.get(c.slug);
  if (c.flag && c.flag !== GENERIC_FLAG) e.flag = c.flag;
  c.visaTypes.forEach((v) => {
    const i = e.visaTypes.findIndex((x) => x.visaTypeSlug === v.visaTypeSlug);
    if (i >= 0) e.visaTypes[i] = v; else e.visaTypes.push(v);
  });
});
merge(bulk); merge(RICH); merge(imported);

// The code table is authoritative for flags. Hand-written flags in
// data/countries.js were only ever there because the bulk factory had no
// better answer, and a stale one there would silently outrank the real one.
const missingCode = [];
for (const c of map.values()) {
  const code = CODES[c.country] || "";
  const flag = flagOf(code);
  c.code = code;
  if (flag) {
    c.flag = flag;
  } else {
    // Kosovo (XK) and anything imported that we have no code for: no emoji
    // exists, so the page renders the country-code chip instead.
    c.flag = "";
    missingCode.push(c.country);
  }
}

const countries = Array.from(map.values()).sort((a, b) => a.country.localeCompare(b.country));

const known = new Set(ALL_NAMES.map(slug));
const searchable = [...ALL_NAMES, ...imported.filter((c) => !known.has(c.slug)).map((c) => c.country)]
  .sort((a, b) => a.localeCompare(b));

const out = path.join(ROOT, "data/generated");
fs.mkdirSync(out, { recursive: true });
fs.writeFileSync(path.join(out, "countries.json"), JSON.stringify({ countries, standardDocs: STANDARD_DOCS, embassyCities: EMBASSY_CITIES, searchable }, null, 1));
fs.writeFileSync(path.join(out, "navigation.json"), JSON.stringify({ nav: NAV, footer: FOOTER_COLUMNS, destinations: FOOTER_DESTINATIONS }, null, 1));

/*
 * Keep js/data.js's marker-delimited lists in sync with the same source data.
 *
 * PHP reads data/generated/*.json; the browser reads js/data.js. If the two
 * drift, the search dropdown offers a country whose page doesn't exist (or
 * misses one that does). This sync used to live in build.js — the static-HTML
 * generator that the PHP controllers replaced — so it moved here when that file
 * was removed. Editing between the markers by hand is pointless: it is
 * overwritten on every run. Edit data/all-countries.json instead.
 */
const dataJsPath = path.join(ROOT, "js/data.js");
let dataJs = fs.readFileSync(dataJsPath, "utf-8");
let syncedAll = true;
function syncBlock(marker, items) {
  const list = items.map((v) => `    ${JSON.stringify(v)}`).join(",\n");
  const re = new RegExp(`(\\/\\* ${marker}:START \\*\\/)[\\s\\S]*?(\\/\\* ${marker}:END \\*\\/)`);
  if (!re.test(dataJs)) {
    console.warn(`WARNING: ${marker} markers not found in js/data.js — list NOT synced.`);
    syncedAll = false;
    return;
  }
  dataJs = dataJs.replace(re, `$1\n${list}\n    $2`);
}
syncBlock("GENERATED_PAGES", countries.map((c) => c.slug));
syncBlock("COUNTRIES", searchable);
fs.writeFileSync(dataJsPath, dataJs, "utf-8");

console.log(`exported ${countries.length} countries + navigation to data/generated/`);
if (missingCode.length) {
  console.warn(`no flag emoji for ${missingCode.length}: ${missingCode.join(", ")} — these render as a country-code chip`);
}
console.log(syncedAll ? "synced js/data.js (COUNTRIES + GENERATED_PAGES)" : "js/data.js sync INCOMPLETE — see warnings above");
