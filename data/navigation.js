/*
 * Navigation information architecture for Convercession.
 *
 * Single source of truth for BOTH the header mega-menu and the footer columns.
 * Exported to JSON by tools/export-data.js and consumed by the PHP includes.
 *
 * IA:
 *   Visa Services   -> "What visa can I get?"
 *   Countries       -> "Where am I travelling?"      (by region, not 216 flat)
 *   Global Mobility -> "We move people for work."    (corporate)
 *   Resources       -> "What do I need to know?"
 *   Company         -> who we are
 *
 * RULE: every entry resolves to a real page. There are no `todo` placeholders
 * and no "#" hrefs — each destination below is a live route (see data/pages.php,
 * visa-type.php and visa.php). If you add an item here, build the page first.
 */
"use strict";

const NAV = [
  {
    label: "Visa Services",
    summary: "Find the right visa for your trip.",
    columns: [
      {
        heading: "By purpose",
        items: [
          { label: "Tourist Visa", href: "/visa/tourist" },
          { label: "Business Visa", href: "/visa/business" },
          { label: "Student Visa", href: "/visa/student" },
          { label: "Schengen Visa", href: "/visa/schengen" },
        ],
      },
      {
        heading: "More categories",
        items: [
          { label: "Family & Dependent Visa", href: "/visa/family-dependent" },
          { label: "Transit Visa", href: "/visa/transit" },
          { label: "Medical Visa", href: "/visa/medical" },
          { label: "Conference Visa", href: "/visa/conference" },
          { label: "Visa Renewal & Extension", href: "/visa/renewal" },
        ],
      },
      {
        heading: "Start here",
        items: [
          { label: "Visa Finder", href: "/visa-finder" },
          { label: "Visa by Country", href: "/countries" },
          { label: "Visa Requirements", href: "/visa-requirements" },
          { label: "Official / Diplomatic Visa", href: "/visa/official-diplomatic" },
        ],
      },
    ],
  },
  {
    label: "Countries",
    summary: "Visa information for 216 countries and territories.",
    regionMenu: true,
    footerLink: { label: "View all 216 countries", href: "/countries" },
  },
  {
    label: "Visa Management",
    flagship: true,
    summary: "Your visa journey, managed end-to-end.",
    columns: [
      {
        heading: "Application",
        items: [
          { label: "Application Management", href: "/application-management" },
          { label: "Document Verification", href: "/document-verification" },
          { label: "Appointment & Biometrics", href: "/appointment-management" },
          { label: "Visa Renewal & Extension", href: "/visa/renewal" },
        ],
      },
      {
        heading: "Track & monitor",
        items: [
          { label: "Track Visa", href: "/track-visa" },
          { label: "Visa Status Tracking", href: "/visa-status-tracking" },
          { label: "Pay Invoice", href: "/payments" },
          // /login, not /account: an anonymous visitor (or a crawler) gets a
          // 200 here, whereas /account would redirect them straight back.
          { label: "Sign In / My Account", href: "/login" },
        ],
      },
      {
        // "Our Technology" was removed from the menus on request. The AI
        // assistant is a separate page and stays.
        heading: "Assistance",
        items: [
          { label: "AI Visa Assistant", href: "/ai-visa-assistant" },
        ],
      },
    ],
  },
  {
    label: "Global Mobility",
    summary: "Visa and mobility support for organisations.",
    columns: [
      {
        heading: "For business",
        items: [
          { label: "Global Mobility", href: "/global-mobility" },
          { label: "Corporate Visa Management", href: "/corporate-visa-management" },
          { label: "Employee Immigration", href: "/employee-immigration" },
        ],
      },
      {
        heading: "Groups & compliance",
        items: [
          { label: "Group & Family Applications", href: "/group-visa-management" },
          { label: "Business Travel Compliance", href: "/business-travel-compliance" },
          { label: "Visa Renewal", href: "/visa/renewal" },
        ],
      },
    ],
  },
  {
    label: "Resources",
    summary: "Visa intelligence, guides and reference data.",
    columns: [
      {
        heading: "Reference",
        items: [
          { label: "Visa Requirements", href: "/visa-requirements" },
          { label: "Visa Fees", href: "/visa-fees" },
          { label: "Processing Times", href: "/processing-times" },
          { label: "Embassy Information", href: "/embassies" },
        ],
      },
      {
        heading: "Guides",
        items: [
          { label: "Visa Guides", href: "/visa-guides" },
          { label: "Visa Refusal Guide", href: "/visa-rejection-guide" },
          { label: "Visa FAQs", href: "/visa-faqs" },
        ],
      },
      {
        heading: "Updates",
        items: [
          { label: "Travel Advisories", href: "/travel-advisories" },
          { label: "Visa News", href: "/visa-news" },
        ],
      },
    ],
  },
  {
    label: "Company",
    summary: "About Convercession.",
    columns: [
      {
        heading: "Company",
        items: [
          { label: "About Convercession", href: "/about" },
          { label: "Global Network", href: "/global-network" },
          { label: "Contact Us", href: "/contact" },
        ],
      },
      {
        heading: "More",
        items: [
          { label: "Leadership", href: "/leadership" },
          { label: "Partners", href: "/partners" },
          { label: "Careers", href: "/careers" },
          { label: "Payments", href: "/payments" },
        ],
      },
    ],
  },
];

// ---- Footer: 5 columns + popular destinations + legal row ----
const FOOTER_COLUMNS = [
  {
    heading: "Visa Services",
    items: [
      { label: "Tourist Visa", href: "/visa/tourist" },
      { label: "Business Visa", href: "/visa/business" },
      { label: "Student Visa", href: "/visa/student" },
      { label: "Schengen Visa", href: "/visa/schengen" },
      { label: "Family Visa", href: "/visa/family-dependent" },
      { label: "Transit Visa", href: "/visa/transit" },
      { label: "Medical Visa", href: "/visa/medical" },
      { label: "Conference Visa", href: "/visa/conference" },
    ],
  },
  {
    heading: "Visa Management",
    items: [
      { label: "Application Management", href: "/application-management" },
      { label: "Document Verification", href: "/document-verification" },
      { label: "Appointment Management", href: "/appointment-management" },
      { label: "Application Tracking", href: "/track-visa" },
      { label: "Visa Status", href: "/visa-status-tracking" },
      { label: "Group Applications", href: "/group-visa-management" },
      { label: "Corporate Visa Management", href: "/corporate-visa-management" },
      { label: "Visa Renewal", href: "/visa/renewal" },
      { label: "Sign In / My Account", href: "/login" },
    ],
  },
  {
    heading: "Explore",
    items: [
      { label: "Visa by Country", href: "/countries" },
      { label: "Visa Requirements", href: "/visa-requirements" },
      { label: "Visa Fees", href: "/visa-fees" },
      { label: "Processing Times", href: "/processing-times" },
      { label: "Embassy Information", href: "/embassies" },
      { label: "Travel Advisories", href: "/travel-advisories" },
      { label: "Visa Guides", href: "/visa-guides" },
      { label: "Visa News", href: "/visa-news" },
    ],
  },
  {
    heading: "Company",
    items: [
      { label: "About Convercession", href: "/about" },
      { label: "Global Network", href: "/global-network" },
      { label: "Leadership", href: "/leadership" },
      { label: "Partners", href: "/partners" },
      { label: "Careers", href: "/careers" },
      { label: "Contact", href: "/contact" },
    ],
  },
  {
    heading: "Legal & Support",
    items: [
      { label: "Privacy Policy", href: "/privacy-policy" },
      { label: "Terms & Conditions", href: "/terms" },
      { label: "Refund Policy", href: "/refund-policy" },
      { label: "Cookie Policy", href: "/cookie-policy" },
      { label: "Disclaimer", href: "/disclaimer" },
      { label: "Service Agreement", href: "/service-agreement" },
      { label: "Accessibility", href: "/accessibility" },
      { label: "Visa FAQs", href: "/visa-faqs" },
    ],
  },
];

/** Popular destinations strip in the footer. */
const FOOTER_DESTINATIONS = [
  { label: "USA", href: "/visa/united-states" },
  { label: "UK", href: "/visa/united-kingdom" },
  { label: "Canada", href: "/visa/canada" },
  { label: "Australia", href: "/visa/australia" },
  { label: "France", href: "/visa/france" },
  { label: "Germany", href: "/visa/germany" },
  { label: "UAE", href: "/visa/united-arab-emirates" },
  { label: "Singapore", href: "/visa/singapore" },
  { label: "Japan", href: "/visa/japan" },
  { label: "Kenya", href: "/visa/kenya" },
];

module.exports = { NAV, FOOTER_COLUMNS, FOOTER_DESTINATIONS };
