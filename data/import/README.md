# Real-data import

Drop a `.csv` or `.json` file in this folder matching the schema below, then
run `node build.js` from the project root. Every file here is picked up
automatically — no code changes needed.

**Priority**: imported data always wins over both the hand-authored entries
in `data/countries.js` and the generic auto-generated pages. Import a row for
`Kenya` / `Tourist Visa` and it replaces whatever was there before, whether
that was hand-written or auto-generated.

**The sample-content banner disappears automatically** for any page sourced
from here (imported rows default to `verified=true` — set it to `false`
explicitly on a row if you're still fact-checking it and want the banner to
stay up until you're confident).

**A country not already on the site gets added automatically**, both as a
generated page and as a searchable option in the homepage dropdown — you
don't need to touch `data/all-countries.json` separately.

## CSV schema

One row = one country + visa type. See `TEMPLATE.csv` in this folder for a
copy-pasteable starting point (the example row in it is placeholder text —
replace it, don't publish it).

| Column | Required | Notes |
|---|---|---|
| `country` | **Yes** | e.g. `Kenya` |
| `visaType` | **Yes** | e.g. `Tourist Visa` |
| `flag` | No | An emoji flag, e.g. `🇰🇪`. Omit to use the generic 🌍 icon. |
| `verified` | No | `true` (default) or `false`. Controls the sample banner. |
| `heroSummary` | No | One sentence, shown under the page H1. |
| `overview` | No | The "Visa Overview" section paragraph. |
| `categories` | No | Pipe-separated, e.g. `Single-entry\|Multiple-entry` |
| `eligibility` | No | Pipe-separated list |
| `processingTime` | No | e.g. `3–5 business days` |
| `visaFee` | No | e.g. `USD 51` |
| `validity` | No | e.g. `90 days from issue` |
| `entryType` | No | e.g. `Single entry` |
| `embassyName` | No | e.g. `High Commission of Kenya` |
| `embassyPhone` | No | |
| `embassyEmail` | No | |
| `appointmentInfo` | No | Free text |
| `procedureSteps` | No | Pipe-separated, in order |
| `importantNotes` | No | Pipe-separated list |
| `travelAdvisory` | No | Free text |
| `faq1_q`, `faq1_a` … `faq6_q`, `faq6_a` | No | Up to 6 Q&A pairs |
| `countrySlug`, `visaTypeSlug` | No | Auto-generated from the names if omitted — only set these if you need a specific URL. |

Quoted fields may contain commas and newlines (`"like this, with a comma"`);
use `""` for a literal quote inside a quoted field.

## JSON schema

Same fields, but as native JSON types instead of pipe-separated strings —
`categories`, `eligibility`, `procedureSteps`, `importantNotes` are real
arrays, and `faqs` is an array of `{ "q": "...", "a": "..." }` objects
instead of the numbered `faqN_q`/`faqN_a` columns. See `TEMPLATE.json`.

A JSON file can be a single object or an array of objects (one per
country + visa type, same as CSV rows).

## Where this data should actually come from

Not from an LLM guessing. Visa rules are nationality-specific and change
often — getting them wrong costs a real traveler money or a missed flight.
Legitimate sources:

- **IATA Timatic** — the industry-standard database airlines/travel agents
  use for exactly this. Export or query it, transform to this schema.
- **A licensed visa-data API** (Sherpa³, VisaHQ, Visa Guide World, etc.) —
  write a small script that pulls from their API and writes a JSON file here
  in this shape.
- **Your own team**, manually verified per country against the official
  embassy/consulate source, entered into a spreadsheet and exported as CSV.
