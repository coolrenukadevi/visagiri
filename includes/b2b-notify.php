<?php
declare(strict_types=1);

/**
 * B2B Travel Partner Portal notification centre (Phase B8). Same
 * shape as notify_partner() (includes/partner-enrollment.php) against
 * the separate b2b_partner_notifications table.
 */

function notify_b2b_partner(int $b2bPartnerId, string $type, string $title, ?string $body = null, ?string $link = null): void
{
    db()->prepare(
        'INSERT INTO b2b_partner_notifications (b2b_partner_id, type, title, body, link) VALUES (:partner_id, :type, :title, :body, :link)'
    )->execute(['partner_id' => $b2bPartnerId, 'type' => $type, 'title' => $title, 'body' => $body, 'link' => $link]);
}

/** VG-B2BTKT-YYYY-NNNNNN */
function b2b_generate_ticket_reference(): string
{
    return generate_reference_number('B2BTKT', 'b2b_support_tickets', 'ticket_reference_no');
}

const B2B_TICKET_CATEGORIES = [
    'general' => 'General Question',
    'technical' => 'Technical Issue',
    'billing' => 'Billing / Payment',
    'enquiry_support' => 'Help With a Visa Enquiry',
    'account' => 'Account / Profile',
    'other' => 'Other',
];

const B2B_TICKET_PRIORITY_LABELS = ['low' => 'Low', 'normal' => 'Normal', 'high' => 'High', 'urgent' => 'Urgent'];

const B2B_TICKET_STATUS_LABELS = [
    'open' => 'Open',
    'in_progress' => 'In Progress',
    'resolved' => 'Resolved',
    'closed' => 'Closed',
];
