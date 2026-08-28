<footer class="site-footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-brand">
        <a href="/" class="brand"><img src="<?= asset('images/paynancial-logo.png') ?>" alt="Paynancial" class="brand-logo"></a>
        <p>Smart Solutions. Simplified Payments.</p>
      </div>
      <div>
        <h4>Products</h4>
        <ul>
          <li><a href="/products#payment-gateway">Payment Gateway</a></li>
          <li><a href="/products#payment-links">Payment Links</a></li>
          <li><a href="/products#payment-collection">Payment Collection</a></li>
          <li><a href="/products#payouts">Payouts</a></li>
          <li><a href="/products#analytics">Analytics</a></li>
        </ul>
      </div>
      <div>
        <h4>Solutions</h4>
        <ul>
          <li><a href="/solutions#ecommerce">E-Commerce</a></li>
          <li><a href="/solutions#travel">Travel</a></li>
          <li><a href="/solutions#healthcare">Healthcare</a></li>
          <li><a href="/solutions#education">Education</a></li>
          <li><a href="/solutions#retail">Retail</a></li>
          <li><a href="/solutions#enterprise">Enterprise</a></li>
        </ul>
      </div>
      <div>
        <h4>Company</h4>
        <ul>
          <li><a href="/about">About</a></li>
          <li><a href="/leadership">Leadership</a></li>
          <li><a href="/careers">Careers</a></li>
          <li><a href="/partners">Partners</a></li>
          <li><a href="/contact">Contact</a></li>
          <li><a href="/blog">News</a></li>
        </ul>
      </div>
      <div>
        <h4>Resources</h4>
        <ul>
          <li><a href="/developers">Developers</a></li>
          <li><a href="/developers#docs">API Documentation</a></li>
          <li><a href="/support#faqs">FAQs</a></li>
          <li><a href="/support">Support</a></li>
          <li><a href="/security">Security</a></li>
        </ul>
      </div>
      <div>
        <h4>Login</h4>
        <ul>
          <li><button type="button" class="btn-link-like" data-login-open="customer" style="background:none;border:none;color:inherit;padding:0;font:inherit;cursor:pointer;">Customer Login</button></li>
          <li><button type="button" data-login-open="partner" style="background:none;border:none;color:inherit;padding:0;font:inherit;cursor:pointer;">Partner Login</button></li>
          <li><button type="button" data-login-open="employee" style="background:none;border:none;color:inherit;padding:0;font:inherit;cursor:pointer;">Employee Login</button></li>
          <li><button type="button" data-login-open="hr" style="background:none;border:none;color:inherit;padding:0;font:inherit;cursor:pointer;">HRMS Login</button></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="footer-registry">
    <div class="container">
      <div class="footer-reg-row"><span>Legal Name</span><span>M/S Paynancial Technology Private Limited</span></div>
      <div class="footer-reg-row"><span>Email</span><a href="mailto:hello@paynancial.com">hello@paynancial.com</a></div>
      <div class="footer-reg-row"><span>GST No.</span><span class="mono">10AAOCP5173C1ZO</span></div>
      <div class="footer-reg-row"><span>CIN</span><span class="mono">U66190BR2024PTC067929</span></div>
    </div>
  </div>

  <div class="container">
    <div class="footer-bottom">
      <span>&copy; <?= date('Y') ?> Paynancial Technology Pvt. Ltd. All Rights Reserved.</span>
      <ul>
        <li><a href="/legal/privacy-policy">Privacy Policy</a></li>
        <li><a href="/legal/terms-conditions">Terms &amp; Conditions</a></li>
        <li><a href="/legal/refund-policy">Refund Policy</a></li>
        <li><a href="/legal/cookie-policy">Cookie Policy</a></li>
        <li><a href="/security">Security</a></li>
      </ul>
    </div>
  </div>
</footer>

<?php include __DIR__ . '/login-panel.php'; ?>

<script src="<?= asset('js/main.js') ?>" defer></script>
