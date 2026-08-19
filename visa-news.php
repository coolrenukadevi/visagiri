<?php
$page_title = "Visa News &amp; Updates &ndash; Visa Agency";
$page_description = "Guides, requirement changes and practical tips from Visa Agency's consultants &ndash; filter by topic or search.";
include __DIR__ . '/includes/header.php';
?>
        <!-- Breadcrumb-Wrapper Section Start -->
        <section class="breadcrumb-wrapper fix bg-cover" style="background-image: url(assets/img/inner-page/breadcrumb.jpg);">
            <div class="shape">
                <img src="assets/img/inner-page/shape.png" alt="img">
            </div>
            <div class="container">
                <div class="page-heading">
                    <h1 class="breadcrumb-title">Visa News &amp; Updates</h1>
                    <ul class="breadcrumb-list">
                        <li><a href="/">Home</a></li>
                        <li><i class="fa-solid fa-chevron-right"></i></li>
                        <li>Visa News</li>
                    </ul>
                </div>
            </div>
        </section>

        <section class="console-intro">
            <div class="console-intro-inner">
                <div class="console-tag"><span class="blink"></span> news.feed() &middot; guides &middot; updates</div>
                <p class="lede">Guides, requirement changes and practical tips from our consultants &mdash; filter by topic or search to find what's relevant to your application.</p>
            </div>
        </section>

        <section class="section-padding fix">
            <div class="container">
                <div class="console-tool-panel">
                    <div class="console-tool-panel-bar"><span class="dot"></span><span class="dot"></span><span class="dot"></span><span class="path">news / all-articles</span></div>
                    <div class="console-tool-panel-body">
                        <div class="console-search-row">
                            <div class="console-search-input-wrap">
                                <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg>
                                <input type="text" id="newsSearch" placeholder="Search articles&hellip;">
                            </div>
                            <div class="console-tab-row" id="newsTabs">
                                <button class="console-tab-btn active" data-cat="all">All</button>
                                <button class="console-tab-btn" data-cat="visa">Visa Updates</button>
                                <button class="console-tab-btn" data-cat="country">Country Guides</button>
                                <button class="console-tab-btn" data-cat="documents">Documentation</button>
                                <button class="console-tab-btn" data-cat="tips">Travel Tips</button>
                            </div>
                        </div>
                        <p class="console-count" id="newsCount">8 articles</p>
                        <div class="console-news-grid" id="newsGrid"></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section-padding fix section-bg-1">
            <div class="container">
                <div class="console-cta-band">
                    <div class="console-cta-inner">
                        <div>
                            <h3>Want Case-Specific Guidance Instead?</h3>
                            <p>Articles are general &mdash; for advice on your exact situation, talk to a consultant.</p>
                        </div>
                        <div class="console-cta-buttons">
                            <a class="console-btn console-btn-primary" href="contact">Start Your Visa Enquiry</a>
                            <a class="console-btn console-btn-outline-dark" href="tel:+917844819819">Talk to a Visa Expert</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<script>
var ARTICLES = [
  {cat:"visa", tag:"Visa Updates", title:"Step-by-Step Guide to Applying for a Business Visa", desc:"What documents and invitation letters embassies typically expect for business travel.", date:"Aug 2026"},
  {cat:"documents", tag:"Documentation", title:"Tips to Prepare Financial Documents for Visa Approval", desc:"How to present bank statements and proof of funds clearly for your application.", date:"Aug 2026"},
  {cat:"tips", tag:"Travel Tips", title:"Post-Arrival Guide: What Every Traveller Should Know", desc:"Practical steps to take in your first few days after arriving on a new visa.", date:"Jul 2026"},
  {cat:"country", tag:"Country Guides", title:"UK Visitor Visa: Common Interview Questions Explained", desc:"What to expect and how to prepare if your application requires an interview.", date:"Jul 2026"},
  {cat:"documents", tag:"Documentation", title:"MEA Apostille vs Embassy Attestation: What's the Difference", desc:"A plain-language breakdown of when you need which document process.", date:"Jun 2026"},
  {cat:"visa", tag:"Visa Updates", title:"Understanding Multiple-Entry Tourist Visas", desc:"Which destinations offer multi-entry options and how eligibility is assessed.", date:"Jun 2026"},
  {cat:"country", tag:"Country Guides", title:"Schengen Visa: Documents Checklist for First-Time Applicants", desc:"A category-by-category look at what a Schengen application typically requires.", date:"May 2026"},
  {cat:"tips", tag:"Travel Tips", title:"How Far in Advance Should You Apply for a Visa?", desc:"General timing guidance across tourist, business and family visa categories.", date:"May 2026"}
];

(function(){
  var grid = document.getElementById('newsGrid');
  var count = document.getElementById('newsCount');
  var search = document.getElementById('newsSearch');
  var tabs = document.querySelectorAll('#newsTabs .console-tab-btn');
  var activeCat = 'all';

  function renderList(){
    var q = search.value.trim().toLowerCase();
    grid.innerHTML = '';
    var shown = 0;
    ARTICLES.forEach(function(a){
      var matchesCat = activeCat === 'all' || a.cat === activeCat;
      var matchesQ = !q || a.title.toLowerCase().indexOf(q) !== -1 || a.desc.toLowerCase().indexOf(q) !== -1;
      if(matchesCat && matchesQ){
        shown++;
        var card = document.createElement('article');
        card.className = 'console-news-card';
        card.innerHTML = '<div class="tag-row"><span class="tag">'+a.tag+'</span><span class="date">'+a.date+'</span></div><h3>'+a.title+'</h3><p>'+a.desc+'</p>';
        grid.appendChild(card);
      }
    });
    count.textContent = shown + (shown === 1 ? ' article' : ' articles');
  }

  tabs.forEach(function(btn){
    btn.addEventListener('click', function(){
      tabs.forEach(function(b){ b.classList.remove('active'); });
      btn.classList.add('active');
      activeCat = btn.getAttribute('data-cat');
      renderList();
    });
  });
  search.addEventListener('input', renderList);
  renderList();
})();
</script>

<?php include __DIR__ . '/includes/footer.php'; ?>
