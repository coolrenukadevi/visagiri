/*
 * Real-data import pipeline for the Convercession visa platform.
 *
 * WHY THIS EXISTS: visa requirements are nationality-specific, change
 * frequently, and getting them wrong has real consequences for a traveler
 * (rejected applications, missed flights, money lost). Nobody should ask an
 * LLM to invent that data for 200+ countries and publish it as fact. This
 * module instead gives the platform a real place to plug in real data —
 * an IATA Timatic export, a licensed visa-data API pull, or a spreadsheet
 * your own team has manually verified — and have it flow into the site
 * exactly like the hand-authored entries in data/countries.js do.
 *
 * HOW TO USE: drop a .csv or .json file into data/import/ matching the
 * schema in data/import/README.md, then run `node build.js`. Every file in
 * that folder is loaded automatically. Rows here take priority over both
 * the hand-authored "rich" entries in data/countries.js and the generic
 * quickTouristVisa-generated bulk pages — see the merge logic in build.js.
 *
 * Imported rows are marked verified by default (on the assumption you
 * wouldn't import data you don't trust), which turns off the on-page
 * "sample content" banner. Set verified=false explicitly on a row if you're
 * still checking it and want the banner to stay up.
 */
"use strict";
const fs = require("fs");
const path = require("path");

const LIST_FIELDS = ["categories", "eligibility", "procedureSteps", "importantNotes"];
const REQUIRED_FIELDS = ["country", "visaType"];

function slugify(value) {
  return String(value).normalize("NFD").replace(/[\u0300-\u036f]/g, "")
    .toLowerCase().replace(/&/g, "and").replace(/[^a-z0-9]+/g, "-").replace(/^-+|-+$/g, "");
}

// ---------- minimal RFC4180-ish CSV parser (no dependency) ----------
// Handles quoted fields, embedded commas/newlines inside quotes, and "" as an escaped quote.
function parseCSV(text) {
  const rows = [];
  let row = [];
  let field = "";
  let inQuotes = false;
  let i = 0;
  const len = text.length;
  while (i < len) {
    const c = text[i];
    if (inQuotes) {
      if (c === '"') {
        if (text[i + 1] === '"') { field += '"'; i += 2; continue; }
        inQuotes = false; i++; continue;
      }
      field += c; i++; continue;
    }
    if (c === '"') { inQuotes = true; i++; continue; }
    if (c === ",") { row.push(field); field = ""; i++; continue; }
    if (c === "\r") { i++; continue; }
    if (c === "\n") { row.push(field); rows.push(row); row = []; field = ""; i++; continue; }
    field += c; i++;
  }
  if (field.length || row.length) { row.push(field); rows.push(row); }
  if (!rows.length) return [];
  const header = rows[0].map((h) => h.trim());
  return rows.slice(1)
    .filter((r) => r.some((cell) => cell.trim() !== ""))
    .map((r) => {
      const obj = {};
      header.forEach((key, idx) => { obj[key] = (r[idx] || "").trim(); });
      return obj;
    });
}

// ---------- normalize one raw row (from CSV or JSON) into the platform's visaType shape ----------
function normalizeRow(raw, sourceFile, rowIndex) {
  const errors = [];
  REQUIRED_FIELDS.forEach((f) => {
    if (!raw[f] || !String(raw[f]).trim()) errors.push(`missing required field "${f}"`);
  });
  if (errors.length) {
    throw new Error(`${sourceFile} row ${rowIndex}: ${errors.join("; ")}`);
  }

  const splitList = (val) => {
    if (Array.isArray(val)) return val.filter(Boolean);
    if (!val) return [];
    return String(val).split("|").map((s) => s.trim()).filter(Boolean);
  };

  const faqs = [];
  if (Array.isArray(raw.faqs)) {
    raw.faqs.forEach((f) => { if (f && f.q && f.a) faqs.push({ q: String(f.q), a: String(f.a) }); });
  } else {
    for (let n = 1; n <= 6; n++) {
      const q = raw[`faq${n}_q`], a = raw[`faq${n}_a`];
      if (q && a) faqs.push({ q: String(q).trim(), a: String(a).trim() });
    }
  }

  const country = String(raw.country).trim();
  const visaType = String(raw.visaType).trim();
  const countrySlug = raw.countrySlug ? String(raw.countrySlug).trim() : slugify(country);
  const visaTypeSlug = raw.visaTypeSlug ? String(raw.visaTypeSlug).trim() : slugify(visaType);

  return {
    countrySlug,
    flag: raw.flag ? String(raw.flag).trim() : "🌍",
    country,
    visaType: {
      visaType,
      visaTypeSlug,
      verified: raw.verified === undefined || raw.verified === "" ? true : String(raw.verified).toLowerCase() !== "false",
      heroSummary: raw.heroSummary || `Everything you need to apply for your ${country} ${visaType} — eligibility, documents, fees, and processing time.`,
      overview: raw.overview || "",
      categories: splitList(raw.categories),
      eligibility: splitList(raw.eligibility),
      processingTime: raw.processingTime || "",
      visaFee: raw.visaFee || "",
      validity: raw.validity || "",
      entryType: raw.entryType || "",
      embassyName: raw.embassyName || `Embassy / Consulate of ${country}`,
      embassyPhone: raw.embassyPhone || "",
      embassyEmail: raw.embassyEmail || "",
      appointmentInfo: raw.appointmentInfo || "",
      procedureSteps: splitList(raw.procedureSteps),
      faqs,
      importantNotes: splitList(raw.importantNotes),
      travelAdvisory: raw.travelAdvisory || `Check the latest government travel advisory for ${country} before finalising travel plans.`,
    },
  };
}

// ---------- load every file in data/import/, group rows by country ----------
function loadImportedCountries(importDir) {
  if (!fs.existsSync(importDir)) return [];
  const files = fs.readdirSync(importDir).filter((f) => /\.(csv|json)$/i.test(f) && !f.startsWith("TEMPLATE"));
  const byCountry = new Map(); // slug -> { country, flag, slug, visaTypes: [] }

  files.forEach((file) => {
    const full = path.join(importDir, file);
    const text = fs.readFileSync(full, "utf-8");
    let rawRows;
    if (file.toLowerCase().endsWith(".json")) {
      const parsed = JSON.parse(text);
      rawRows = Array.isArray(parsed) ? parsed : [parsed];
    } else {
      rawRows = parseCSV(text);
    }

    rawRows.forEach((raw, idx) => {
      const normalized = normalizeRow(raw, file, idx + 2); // +2: header row + 1-index
      const key = normalized.countrySlug;
      if (!byCountry.has(key)) {
        byCountry.set(key, { country: normalized.country, flag: normalized.flag, slug: key, visaTypes: [] });
      }
      const entry = byCountry.get(key);
      const existingIdx = entry.visaTypes.findIndex((v) => v.visaTypeSlug === normalized.visaType.visaTypeSlug);
      if (existingIdx >= 0) entry.visaTypes[existingIdx] = normalized.visaType; // later file/row wins on duplicate
      else entry.visaTypes.push(normalized.visaType);
    });
  });

  return Array.from(byCountry.values());
}

module.exports = { loadImportedCountries, parseCSV, normalizeRow, slugify };
