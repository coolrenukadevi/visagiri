<?php
/**
 * Site header: light glass nav with mega menus + login/get-started actions.
 * Expects $current_path to be set by the front controller (optional).
 */
$current_path = $current_path ?? ($_SERVER['REQUEST_URI'] ?? '/');
?>
<a class="sr-only" href="#main-content">Skip to main content</a>
<div class="utility-bar">
  <div class="utility-left">
    <span>AI-Powered Financial Infrastructure</span>
    <span>Global Payments</span>
    <span>Secure &amp; Trusted</span>
  </div>
  <div class="utility-right">
    <span class="utility-support">
      <a href="https://wa.me/917066820820" target="_blank" rel="noopener">
        <i class="support-dot" aria-hidden="true"></i>24&times;7 Support
      </a>
    </span>
    <div class="utility-lang" data-lang-select>
      <button type="button" class="utility-lang-btn" aria-haspopup="true" aria-expanded="false">
        EN <i class="chev" aria-hidden="true"></i>
      </button>
      <div class="utility-lang-menu" role="menu" aria-label="Select language">
        <button type="button" class="utility-lang-option is-active" role="menuitem">English</button>
        <button type="button" class="utility-lang-option" role="menuitem" disabled>हिन्दी <span class="soon">Coming soon</span></button>
        <button type="button" class="utility-lang-option" role="menuitem" disabled>தமிழ் <span class="soon">Coming soon</span></button>
        <button type="button" class="utility-lang-option" role="menuitem" disabled>తెలుగు <span class="soon">Coming soon</span></button>
        <button type="button" class="utility-lang-option" role="menuitem" disabled>বাংলা <span class="soon">Coming soon</span></button>
        <button type="button" class="utility-lang-option" role="menuitem" disabled>मराठी <span class="soon">Coming soon</span></button>
      </div>
    </div>
  </div>
</div>
<header class="site-header">
  <div class="container">
    <a href="/" class="brand" aria-label="Paynancial home">
      <img src="<?= asset('images/paynancial-logo.png') ?>" alt="Paynancial" class="brand-logo">
    </a>

    <nav aria-label="Primary">
      <ul class="main-nav">
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Products <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">Accept &amp; Collect</div>
              <a class="mega-link" href="/products/payment-gateway"><strong>Payment Gateway</strong><span>Accept cards, UPI, netbanking, and wallets</span></a>
              <a class="mega-link" href="/products/payment-links"><strong>Payment Links</strong><span>Collect payments without code</span></a>
              <a class="mega-link" href="/products/payment-collection"><strong>Payment Collection</strong><span>Recurring and bulk collection workflows</span></a>
            </div>
            <div>
              <div class="mega-col-title">Move &amp; Understand Money</div>
              <a class="mega-link" href="/products/payouts"><strong>Payouts</strong><span>Vendor, employee, and partner payouts</span></a>
              <a class="mega-link" href="/products/payment-analytics"><strong>Payment Analytics</strong><span>Performance, settlements, and reconciliation</span></a>
              <a class="mega-link" href="/developers"><strong>APIs &amp; Webhooks</strong><span>Developer-first integrations</span></a>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Solutions <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">By Industry</div>
              <a class="mega-link" href="/solutions#ecommerce"><strong>E-Commerce</strong><span>Fast, reliable checkout at scale</span></a>
              <a class="mega-link" href="/solutions#travel"><strong>Travel</strong><span>High-value, multi-currency bookings</span></a>
              <a class="mega-link" href="/solutions#healthcare"><strong>Healthcare</strong><span>Secure billing for clinics &amp; hospitals</span></a>
              <a class="mega-link" href="/solutions#education"><strong>Education</strong><span>Fee collection made simple</span></a>
            </div>
            <div>
              <div class="mega-col-title">&nbsp;</div>
              <a class="mega-link" href="/solutions#retail"><strong>Retail</strong><span>Online and in-store payment flows</span></a>
              <a class="mega-link" href="/solutions#hospitality"><strong>Hospitality</strong><span>Bookings, deposits, and on-site payments</span></a>
              <a class="mega-link" href="/solutions#professional-services"><strong>Professional Services</strong><span>Simple invoicing and collection</span></a>
              <a class="mega-link" href="/solutions#enterprise"><strong>Enterprise</strong><span>Custom infrastructure for scale</span></a>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Developers <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">Build</div>
              <a class="mega-link" href="/developers#docs"><strong>API Documentation</strong><span>Everything you need to integrate</span></a>
              <a class="mega-link" href="/developers#integration-guide"><strong>Integration Guide</strong><span>Step-by-step setup for your stack</span></a>
              <a class="mega-link" href="/developers#sdks"><strong>SDKs</strong><span>PHP, JavaScript, Python client libraries</span></a>
            </div>
            <div>
              <div class="mega-col-title">Reference</div>
              <a class="mega-link" href="/developers#api-reference"><strong>API Reference</strong><span>Every endpoint, request &amp; response</span></a>
              <a class="mega-link" href="/developers#sandbox"><strong>Sandbox</strong><span>Test integrations safely</span></a>
              <a class="mega-link" href="/developers#webhooks"><strong>Webhooks</strong><span>Real-time event notifications</span></a>
            </div>
          </div>
        </li>
        <li class="nav-item"><a class="nav-link" href="/pricing">Pricing</a></li>
        <li class="nav-item"><a class="nav-link" href="/partners">Partners</a></li>
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Resources <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">Learn</div>
              <a class="mega-link" href="/developers#docs"><strong>API Documentation</strong><span>Everything you need to integrate</span></a>
              <a class="mega-link" href="/developers#integration-guide"><strong>Integration Guides</strong><span>Step-by-step setup for your stack</span></a>
              <a class="mega-link" href="/support#faqs"><strong>FAQs</strong><span>Answers to common questions</span></a>
            </div>
            <div>
              <div class="mega-col-title">Get Help</div>
              <a class="mega-link" href="/support"><strong>Support Center</strong><span>Get help from our support team</span></a>
              <a class="mega-link" href="/security"><strong>Security &amp; Compliance</strong><span>How we protect every transaction</span></a>
              <a class="mega-link" href="/blog"><strong>Blog / Insights</strong><span>Product updates &amp; payment insights</span></a>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Company <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">About</div>
              <a class="mega-link" href="/about"><strong>About Us</strong><span>Our mission &amp; story</span></a>
              <a class="mega-link" href="/leadership"><strong>Leadership</strong><span>The team steering Paynancial</span></a>
              <a class="mega-link" href="/careers"><strong>Careers</strong><span>Build the future of payments with us</span></a>
            </div>
            <div>
              <div class="mega-col-title">Connect</div>
              <a class="mega-link" href="/contact"><strong>Contact</strong><span>Talk to sales or support</span></a>
              <a class="mega-link" href="/blog"><strong>News / Blog</strong><span>Company updates &amp; announcements</span></a>
              <a class="mega-link" href="/partners"><strong>Partners</strong><span>Grow with the Paynancial partner program</span></a>
            </div>
          </div>
        </li>
      </ul>
    </nav>

    <div class="header-actions">
      <a href="/contact" class="btn-contact btn-contact-outline">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
        Contact Us
      </a>
      <button type="button" class="btn-login-signup" data-login-open>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
        Login / Sign Up
      </button>
      <button class="hamburger" aria-label="Open menu"><span></span></button>
    </div>
  </div>
</header>

<div class="tape" aria-hidden="true">
  <div class="tape-track">
    <?php
      $tape_items = ["INITIATE → VERIFY → <strong>SETTLE</strong>", "BUILT FOR SPEED", "MADE IN INDIA", "AGENT-READY APIS", "INITIATE → VERIFY → <strong>SETTLE</strong>", "BUILT FOR SPEED", "MADE IN INDIA", "AGENT-READY APIS"];
      foreach ($tape_items as $tape_item) {
          echo '<span class="tape-item">' . $tape_item . '</span>';
      }
    ?>
  </div>
</div>

<div class="mobile-nav" aria-hidden="true">
  <div class="mobile-nav-header">
    <span class="brand"><img src="<?= asset('images/paynancial-logo.png') ?>" alt="Paynancial" class="brand-logo"></span>
    <button class="login-close mobile-nav-close" aria-label="Close menu">&times;</button>
  </div>
  <details>
    <summary>Products <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/products/payment-gateway">Payment Gateway</a></li>
      <li><a href="/products/payment-links">Payment Links</a></li>
      <li><a href="/products/payment-collection">Payment Collection</a></li>
      <li><a href="/products/payouts">Payouts</a></li>
      <li><a href="/products/payment-analytics">Payment Analytics</a></li>
      <li><a href="/developers">APIs &amp; Webhooks</a></li>
    </ul>
  </details>
  <details>
    <summary>Solutions <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/solutions#ecommerce">E-Commerce</a></li>
      <li><a href="/solutions#travel">Travel</a></li>
      <li><a href="/solutions#healthcare">Healthcare</a></li>
      <li><a href="/solutions#education">Education</a></li>
      <li><a href="/solutions#retail">Retail</a></li>
      <li><a href="/solutions#hospitality">Hospitality</a></li>
      <li><a href="/solutions#professional-services">Professional Services</a></li>
      <li><a href="/solutions#enterprise">Enterprise</a></li>
    </ul>
  </details>
  <details>
    <summary>Developers <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/developers#docs">API Documentation</a></li>
      <li><a href="/developers#integration-guide">Integration Guide</a></li>
      <li><a href="/developers#sdks">SDKs</a></li>
      <li><a href="/developers#api-reference">API Reference</a></li>
      <li><a href="/developers#sandbox">Sandbox</a></li>
      <li><a href="/developers#webhooks">Webhooks</a></li>
    </ul>
  </details>
  <details>
    <summary>Resources <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/developers#docs">API Documentation</a></li>
      <li><a href="/developers#integration-guide">Integration Guides</a></li>
      <li><a href="/support#faqs">FAQs</a></li>
      <li><a href="/support">Support Center</a></li>
      <li><a href="/security">Security &amp; Compliance</a></li>
      <li><a href="/blog">Blog / Insights</a></li>
    </ul>
  </details>
  <details>
    <summary>Company <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/about">About Us</a></li>
      <li><a href="/leadership">Leadership</a></li>
      <li><a href="/careers">Careers</a></li>
      <li><a href="/contact">Contact</a></li>
      <li><a href="/blog">News / Blog</a></li>
      <li><a href="/partners">Partners</a></li>
    </ul>
  </details>
  <a href="/pricing" class="nav-link" style="font-weight:700;">Pricing</a>
  <div class="mobile-nav-actions">
    <a href="/contact" class="btn-contact btn-contact-outline">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
      Contact Us
    </a>
    <button type="button" class="btn-login-signup" data-login-open>
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
      Login / Sign Up
    </button>
  </div>
</div>
