<?php
declare(strict_types=1);

/**
 * Logout must be a POST, not a GET link — a plain <a href="/logout/">
 * lets any third-party page force it via <img src="…">, and while
 * forcing a logout is low-impact compared to state-changing GETs
 * elsewhere, it's still inconsistent with the CSRF-gated POST pattern
 * used for every other mutation in this app (Phase 16 security pass).
 */
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    redirect('/');
}

csrf_require();
log_out_user();
redirect('/');
