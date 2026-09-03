<?php
/**
 * Shared "request status dashboard" partial — the overview card + timeline
 * originally built for forex-track.php, now also used by the logged-in
 * customer portal's forex-my-request.php so the two don't maintain two
 * copies of the same markup. Expects $request, $docStats, $lastUpdate,
 * $stages, $labels, $isCancelled to already be set by the caller.
 */
?>
                <div class="track-dashboard">
                    <div class="track-dash-header">
                        <span class="td-label">Forex Reference</span>
                        <span class="td-code"><?php echo htmlspecialchars($request['forex_ref']); ?></span>
                    </div>

                    <?php if ($isCancelled): ?>
                    <div class="track-cancelled-banner"><i class="fa-solid fa-circle-info"></i> This forex request has been <?php echo strtolower($request['status']); ?>. Please contact our team if you have questions.</div>
                    <?php endif; ?>

                    <div class="track-overview-card">
                        <h3>Request Overview</h3>
                        <div class="track-overview-grid">
                            <div><label>Customer Name</label><span><?php echo htmlspecialchars($request['full_name']); ?></span></div>
                            <div><label>Destination</label><span><?php echo htmlspecialchars($request['country_visit'] ?: '—'); ?></span></div>
                            <div><label>Currency</label><span><?php echo htmlspecialchars($request['currency_code']); ?> <?php echo number_format((float) $request['amount_required'], 2); ?></span></div>
                            <div><label>Submitted Date</label><span><?php echo htmlspecialchars(substr($request['created_at'], 0, 10)); ?></span></div>
                            <div><label>Current Status</label><span class="track-status-badge"><?php echo htmlspecialchars($request['status']); ?></span></div>
                            <div><label>Documents Verified</label><span><?php echo (int) ($docStats['verified'] ?? 0); ?> of <?php echo (int) ($docStats['total'] ?? 0); ?></span></div>
                            <div><label>Last Updated</label><span><?php echo $lastUpdate ? htmlspecialchars(substr($lastUpdate['created_at'], 0, 16)) . ' UTC' : htmlspecialchars(substr($request['created_at'], 0, 16)) . ' UTC'; ?></span></div>
                        </div>
                        <?php if ($lastUpdate && !empty($lastUpdate['message'])): ?>
                        <div class="track-latest-message"><i class="fa-solid fa-message"></i> <?php echo htmlspecialchars($lastUpdate['message']); ?></div>
                        <?php endif; ?>
                    </div>

                    <div class="track-timeline-card">
                        <h3>Request Timeline</h3>
                        <div class="track-timeline">
                            <?php foreach ($labels as $i => $label): $state = $stages[$i]; ?>
                            <div class="track-tl-step tl-<?php echo $state; ?>">
                                <div class="tl-dot">
                                    <?php if ($state === 'done'): ?><i class="fa-solid fa-check"></i>
                                    <?php elseif ($state === 'current'): ?><i class="fa-solid fa-spinner"></i>
                                    <?php endif; ?>
                                </div>
                                <div class="tl-info">
                                    <span class="tl-label"><?php echo htmlspecialchars($label); ?></span>
                                    <span class="tl-state"><?php echo $state === 'done' ? 'Completed' : ($state === 'current' ? 'In Progress' : 'Pending'); ?></span>
                                </div>
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
