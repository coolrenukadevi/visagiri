<?php
/**
 * Site header: navy/blue/purple glass nav with dropdowns + login/get-started
 * actions. Expects $current_path to be set by the front controller (optional).
 */
$current_path = $current_path ?? ($_SERVER['REQUEST_URI'] ?? '/');
?>
<a class="sr-only" href="#main-content">Skip to main content</a>
<div class="utility-bar">
  <span>AI-Powered Financial Infrastructure</span>
  <span>Global Payments</span>
  <span>Secure &amp; Trusted</span>
  <span class="utility-support">
    <a href="https://wa.me/917066820820" target="_blank" rel="noopener">
      <i class="support-dot" aria-hidden="true"></i>24&times;7 Support
    </a>
  </span>
</div>
<header class="site-header">
  <div class="container">
    <a href="/" class="brand" aria-label="Paynancial home">
      <img src="<?= asset('images/paynancial-logo.png') ?>" alt="Paynancial" class="brand-logo">
    </a>

    <nav aria-label="Primary">
      <ul class="main-nav">
        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>

        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Solutions <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu mega-menu-solutions">
            <a class="mega-link-icon" href="/products">
              <span class="mega-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="5" r="2"/><circle cx="5" cy="19" r="2"/><circle cx="19" cy="19" r="2"/><path d="M12 7v4M12 11 5 17M12 11l7 6"/></svg></span>
              <span><strong>Payment Infrastructure</strong><span>Smart payment processing and orchestration</span></span>
            </a>
            <a class="mega-link-icon" href="/solutions">
              <span class="mega-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M2 12h20M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg></span>
              <span><strong>Global Payments</strong><span>Move money securely across markets</span></span>
            </a>
            <a class="mega-link-icon" href="/solutions">
              <span class="mega-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m12 2 1.9 5.8L20 10l-6.1 2.2L12 18l-1.9-5.8L4 10l6.1-2.2L12 2Z"/></svg></span>
              <span><strong>AI Financial Solutions</strong><span>Intelligent automation and decision-making</span></span>
            </a>
            <a class="mega-link-icon" href="/security">
              <span class="mega-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10Z"/></svg></span>
              <span><strong>Risk &amp; Fraud Management</strong><span>AI-powered transaction protection</span></span>
            </a>
            <a class="mega-link-icon" href="/products/payment-analytics">
              <span class="mega-icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 3v18h18"/><path d="M7 15v3M12 11v7M17 7v11"/></svg></span>
              <span><strong>Analytics &amp; Insights</strong><span>Real-time financial intelligence</span></span>
            </a>
          </div>
        </li>

        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Products <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">Accept &amp; Move Money</div>
              <a class="mega-link" href="/products/payment-gateway"><strong>Payment Gateway</strong><span>Accept cards, UPI, netbanking, and wallets</span></a>
              <a class="mega-link" href="/products"><strong>Payment Orchestration</strong><span>Smart routing across payment methods</span></a>
              <a class="mega-link" href="/products/payouts"><strong>Payouts</strong><span>Vendor, employee, and partner payouts</span></a>
            </div>
            <div>
              <div class="mega-col-title">Collect &amp; Build</div>
              <a class="mega-link" href="/products/payment-links"><strong>Payment Links</strong><span>Collect payments without code</span></a>
              <a class="mega-link" href="/products/payment-collection"><strong>Virtual Accounts</strong><span>Dedicated accounts for reconciliation</span></a>
              <a class="mega-link" href="/developers"><strong>Financial APIs</strong><span>Developer-first integrations</span></a>
            </div>
          </div>
        </li>

        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Company <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">About</div>
              <a class="mega-link" href="/about"><strong>About Paynancial</strong><span>Our mission &amp; story</span></a>
              <a class="mega-link" href="/about"><strong>Our Story</strong><span>How Paynancial came to be</span></a>
              <a class="mega-link" href="/leadership"><strong>Leadership</strong><span>The team steering Paynancial</span></a>
            </div>
            <div>
              <div class="mega-col-title">Connect</div>
              <a class="mega-link" href="/careers"><strong>Careers</strong><span>Build the future of payments with us</span></a>
              <a class="mega-link" href="/contact"><strong>Contact</strong><span>Talk to sales or support</span></a>
            </div>
          </div>
        </li>

        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Resources <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">Build</div>
              <a class="mega-link" href="/developers#docs"><strong>Documentation</strong><span>Everything you need to integrate</span></a>
              <a class="mega-link" href="/developers#api-reference"><strong>API Reference</strong><span>Every endpoint, request &amp; response</span></a>
              <a class="mega-link" href="/developers"><strong>Developer Portal</strong><span>Sandbox, SDKs &amp; guides</span></a>
            </div>
            <div>
              <div class="mega-col-title">Learn</div>
              <a class="mega-link" href="/blog"><strong>Blog</strong><span>Company updates &amp; announcements</span></a>
              <a class="mega-link" href="/blog"><strong>Insights</strong><span>Payment industry perspectives</span></a>
              <a class="mega-link" href="/support#faqs"><strong>FAQs</strong><span>Answers to common questions</span></a>
            </div>
          </div>
        </li>
      </ul>
    </nav>

    <div class="header-actions">
      <a href="/contact" class="btn-contact">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
        Contact Us
      </a>
      <button type="button" class="btn-login-signup" data-login-open>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
        Login / Sign Up
      </button>
      <div class="lang-select" aria-label="Language: English">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M2 12h20M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>
        EN <i class="chev" aria-hidden="true"></i>
      </div>
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
  <a href="/" class="nav-link">Home</a>
  <details>
    <summary>Solutions <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/products">Payment Infrastructure</a></li>
      <li><a href="/solutions">Global Payments</a></li>
      <li><a href="/solutions">AI Financial Solutions</a></li>
      <li><a href="/security">Risk &amp; Fraud Management</a></li>
      <li><a href="/products/payment-analytics">Analytics &amp; Insights</a></li>
    </ul>
  </details>
  <details>
    <summary>Products <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/products/payment-gateway">Payment Gateway</a></li>
      <li><a href="/products">Payment Orchestration</a></li>
      <li><a href="/products/payouts">Payouts</a></li>
      <li><a href="/products/payment-links">Payment Links</a></li>
      <li><a href="/products/payment-collection">Virtual Accounts</a></li>
      <li><a href="/developers">Financial APIs</a></li>
    </ul>
  </details>
  <details>
    <summary>Company <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/about">About Paynancial</a></li>
      <li><a href="/about">Our Story</a></li>
      <li><a href="/leadership">Leadership</a></li>
      <li><a href="/careers">Careers</a></li>
      <li><a href="/contact">Contact</a></li>
    </ul>
  </details>
  <details>
    <summary>Resources <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/developers#docs">Documentation</a></li>
      <li><a href="/developers#api-reference">API Reference</a></li>
      <li><a href="/developers">Developer Portal</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/blog">Insights</a></li>
      <li><a href="/support#faqs">FAQs</a></li>
    </ul>
  </details>
  <div class="mobile-nav-actions">
    <a href="/contact" class="btn-contact">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
      Contact Us
    </a>
    <button type="button" class="btn-login-signup" data-login-open>
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
      Login / Sign Up
    </button>
  </div>
</div>
