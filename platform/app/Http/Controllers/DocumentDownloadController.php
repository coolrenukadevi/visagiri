<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Contracts\Audit\AuditLogger;
use App\Contracts\Documents\DocumentAuthorization;
use App\Contracts\Documents\DocumentStorage;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

/**
 * Document foundation entry point. Mirrors the existing app's
 * verified-correct pattern (dashboard/pages/document-download.php):
 * authorization is checked BEFORE any file content is touched, and a
 * failed check returns 404 rather than a revealing 403 — an attacker
 * probing IDs cannot distinguish "not yours" from "does not exist".
 *
 * Both outcomes are audited (Wave 1 acceptance condition 3 — the
 * original version only logged permission-*denials* raised by
 * EnsurePermission; a document authorization failure here, and every
 * successful sensitive-document download, were both silent. Neither
 * is now.
 */
final class DocumentDownloadController extends Controller
{
    public function __invoke(Request $request, string $key, DocumentAuthorization $authorization, DocumentStorage $storage, AuditLogger $audit): Response
    {
        $actorId = $request->user()?->id;

        if ($actorId === null || ! $authorization->canDownload($actorId, $key)) {
            $audit->log(
                action: 'document_download_denied',
                module: 'documents',
                actorId: $actorId,
                context: ['storage_key' => $key, 'outcome' => 'denied'],
            );

            abort(404);
        }

        $audit->log(
            action: 'document_download',
            module: 'documents',
            actorId: $actorId,
            context: ['storage_key' => $key, 'outcome' => 'success'],
        );

        return response($storage->get($key));
    }
}
