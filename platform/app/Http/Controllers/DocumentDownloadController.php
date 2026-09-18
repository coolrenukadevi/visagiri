<?php

declare(strict_types=1);

namespace App\Http\Controllers;

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
 */
final class DocumentDownloadController extends Controller
{
    public function __invoke(Request $request, string $key, DocumentAuthorization $authorization, DocumentStorage $storage): Response
    {
        $actorId = $request->user()?->id;

        if ($actorId === null || ! $authorization->canDownload($actorId, $key)) {
            abort(404);
        }

        return response($storage->get($key));
    }
}
