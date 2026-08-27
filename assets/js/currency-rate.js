/**
 * Header currency ticker. The value is already server-rendered on
 * first paint (see includes/header-topbar.php) so there's no flash of
 * empty content; this script just re-polls the same cached endpoint
 * periodically to pick up anything that changed since page load, and
 * fills the widget in on the rare case the server had no cached rate
 * yet at all.
 */
document.addEventListener('DOMContentLoaded', function () {
    var REFRESH_INTERVAL_MS = 5 * 60 * 1000; // 5 minutes — the endpoint itself
    // only re-checks the live API when its own cache is older than 30
    // minutes, so polling more often than that here would be wasted effort.

    var widgets = document.querySelectorAll('.header-fx-widget[data-pair]');
    if (!widgets.length) { return; }

    function renderWidget(widget, data) {
        var rateEl = widget.querySelector('#fxRateValue, .fx-rate');
        var dotEl = widget.querySelector('#fxLiveDot, .fx-live-dot');
        var labelEl = widget.querySelector('#fxLiveLabel, .fx-live-label');
        var pairEl = widget.querySelector('#fxPairLabel, .fx-pair');
        var unavailableEl = widget.querySelector('#fxUnavailable, .fx-unavailable');

        if (!data || data.success === false) {
            return; // keep whatever was last shown rather than blanking it
        }

        if (unavailableEl) { unavailableEl.hidden = true; }
        if (pairEl) { pairEl.hidden = false; pairEl.innerHTML = data.label || pairEl.innerHTML; }
        if (rateEl) {
            rateEl.hidden = false;
            rateEl.textContent = '₹' + Number(data.rate).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }
        if (dotEl) {
            dotEl.hidden = false;
            dotEl.classList.toggle('is-stale', !!data.stale);
            dotEl.classList.toggle('is-live', !data.stale);
        }
        if (labelEl) {
            labelEl.hidden = false;
            labelEl.textContent = data.stale ? 'Updated' : 'Live';
        }
    }

    function refresh(widget) {
        var pair = widget.getAttribute('data-pair');
        fetch('exchange-rate?pair=' + encodeURIComponent(pair), { credentials: 'same-origin' })
            .then(function (res) { return res.json(); })
            .then(function (data) { renderWidget(widget, data); })
            .catch(function () { /* keep last known value on the screen */ });
    }

    widgets.forEach(function (widget) {
        refresh(widget);
        setInterval(function () { refresh(widget); }, REFRESH_INTERVAL_MS);
    });
});
