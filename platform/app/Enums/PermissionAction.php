<?php

declare(strict_types=1);

namespace App\Enums;

/**
 * The distinct, never-bundled actions a permission can grant. Mirrors
 * the existing PHP app's discipline (e.g. content.manage currently
 * bundles create+edit+delete+publish — Architecture Phase 5 flagged
 * that as a pattern to unbundle going forward, not repeat).
 */
enum PermissionAction: string
{
    case View = 'view';
    case Create = 'create';
    case Edit = 'edit';
    case Delete = 'delete';
    case Approve = 'approve';
    case Assign = 'assign';
    case Reassign = 'reassign';
    case Download = 'download';
    case Export = 'export';
    case Publish = 'publish';
    case Administer = 'administer';
}
