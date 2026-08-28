<?php
/**
 * Site header: sticky nav with mega menus + login/get-started actions.
 * Expects $current_path to be set by the front controller (optional).
 */
$current_path = $current_path ?? ($_SERVER['REQUEST_URI'] ?? '/');
?>
<a class="sr-only" href="#main-content">Skip to main content</a>
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
              <div class="mega-col-title">Collect Payments</div>
              <a class="mega-link" href="/products#payment-gateway"><strong>Payment Gateway</strong><span>Accept cards, UPI, netbanking &amp; wallets</span></a>
              <a class="mega-link" href="/products#payment-links"><strong>Payment Links</strong><span>Get paid with a single shareable link</span></a>
              <a class="mega-link" href="/products#payment-pages"><strong>Payment Pages</strong><span>Branded, no-code checkout pages</span></a>
              <a class="mega-link" href="/products#payment-collection"><strong>Payment Collection</strong><span>Bulk and recurring collections</span></a>
            </div>
            <div>
              <div class="mega-col-title">Move &amp; Understand Money</div>
              <a class="mega-link" href="/products#payouts"><strong>Payouts</strong><span>Send money to vendors, staff &amp; partners</span></a>
              <a class="mega-link" href="/products#analytics"><strong>Payment Analytics</strong><span>Real-time visibility into every transaction</span></a>
              <a class="mega-link" href="/products#dashboard"><strong>Business Dashboard</strong><span>One console for collections and settlements</span></a>
              <a class="mega-link" href="/developers"><strong>API &amp; Integrations</strong><span>Build payments into your own products</span></a>
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
              <a class="mega-link" href="/solutions#education"><strong>Education</strong><span>Fee collection made simple</span></a>
              <a class="mega-link" href="/solutions#healthcare"><strong>Healthcare</strong><span>Secure billing for clinics &amp; hospitals</span></a>
            </div>
            <div>
              <div class="mega-col-title">&nbsp;</div>
              <a class="mega-link" href="/solutions#retail"><strong>Retail</strong><span>Online and in-store payment flows</span></a>
              <a class="mega-link" href="/solutions#services"><strong>Services</strong><span>Invoicing for professional services</span></a>
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
              <a class="mega-link" href="/blog"><strong>Blog</strong><span>Product updates &amp; payment insights</span></a>
              <a class="mega-link" href="/blog#guides"><strong>Payment Guides</strong><span>Practical guides for finance teams</span></a>
              <a class="mega-link" href="/support#faqs"><strong>FAQs</strong><span>Answers to common questions</span></a>
            </div>
            <div>
              <div class="mega-col-title">Support</div>
              <a class="mega-link" href="/support"><strong>Help Center</strong><span>Get help from our support team</span></a>
              <a class="mega-link" href="/security"><strong>Security</strong><span>How we protect every transaction</span></a>
              <a class="mega-link" href="/blog#news"><strong>News</strong><span>Company updates &amp; announcements</span></a>
            </div>
          </div>
        </li>
        <li class="nav-item">
          <button class="nav-link" aria-haspopup="true" aria-expanded="false">Company <i class="chev" aria-hidden="true"></i></button>
          <div class="mega-menu">
            <div>
              <div class="mega-col-title">About</div>
              <a class="mega-link" href="/about"><strong>About Paynancial</strong><span>Our mission &amp; story</span></a>
              <a class="mega-link" href="/leadership"><strong>Leadership</strong><span>The team steering Paynancial</span></a>
              <a class="mega-link" href="/careers"><strong>Careers</strong><span>Build the future of payments with us</span></a>
            </div>
            <div>
              <div class="mega-col-title">Connect</div>
              <a class="mega-link" href="/contact"><strong>Contact Us</strong><span>Talk to sales or support</span></a>
              <a class="mega-link" href="/partners"><strong>Partners</strong><span>Grow with the Paynancial partner program</span></a>
            </div>
          </div>
        </li>
      </ul>
    </nav>

    <div class="header-actions">
      <button type="button" class="btn btn-ghost btn-sm" data-login-open>Login</button>
      <a href="/contact" class="btn btn-primary btn-sm">Get Started</a>
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
      <li><a href="/products#payment-gateway">Payment Gateway</a></li>
      <li><a href="/products#payment-links">Payment Links</a></li>
      <li><a href="/products#payment-pages">Payment Pages</a></li>
      <li><a href="/products#payment-collection">Payment Collection</a></li>
      <li><a href="/products#payouts">Payouts</a></li>
      <li><a href="/products#analytics">Payment Analytics</a></li>
      <li><a href="/products#dashboard">Business Dashboard</a></li>
      <li><a href="/developers">API &amp; Integrations</a></li>
    </ul>
  </details>
  <details>
    <summary>Solutions <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/solutions#ecommerce">E-Commerce</a></li>
      <li><a href="/solutions#travel">Travel</a></li>
      <li><a href="/solutions#education">Education</a></li>
      <li><a href="/solutions#healthcare">Healthcare</a></li>
      <li><a href="/solutions#retail">Retail</a></li>
      <li><a href="/solutions#services">Services</a></li>
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
      <li><a href="/blog">Blog</a></li>
      <li><a href="/support#faqs">FAQs</a></li>
      <li><a href="/support">Help Center</a></li>
      <li><a href="/security">Security</a></li>
    </ul>
  </details>
  <details>
    <summary>Company <i class="chev" aria-hidden="true"></i></summary>
    <ul>
      <li><a href="/about">About Paynancial</a></li>
      <li><a href="/leadership">Leadership</a></li>
      <li><a href="/careers">Careers</a></li>
      <li><a href="/contact">Contact Us</a></li>
      <li><a href="/partners">Partners</a></li>
    </ul>
  </details>
  <div style="padding:20px 0; display:grid; gap:12px;">
    <a class="nav-link" href="/pricing" style="font-weight:700;">Pricing</a>
    <button type="button" class="btn btn-outline btn-block" data-login-open>Login</button>
    <a href="/contact" class="btn btn-primary btn-block">Get Started</a>
  </div>
</div>
