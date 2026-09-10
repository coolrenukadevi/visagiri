<?php

namespace App\Http\Controllers;

use App\Models\AttestationCase;
use App\Models\Document;
use App\Services\AttestationScope;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\StreamedResponse;

class DocumentController extends Controller
{
    /**
     * The link is signed and short-lived (generated per-view with an
     * expiry), but the signature only proves the link came from us —
     * it is not itself an access grant. Scope is re-checked here against
     * the document's actual owner on every request, matching the
     * architecture doc's "re-checked server-side, every layer" rule.
     */
    public function download(Request $request, Document $document): StreamedResponse
    {
        $owner = $document->documentable;

        $canAccess = match (true) {
            $owner instanceof AttestationCase => AttestationScope::canView($request->user(), $owner),
            default => false,
        };

        abort_unless($canAccess, 404);
        abort_unless(Storage::disk($document->disk)->exists($document->stored_filename), 404);

        return Storage::disk($document->disk)->download($document->stored_filename, $document->original_filename);
    }

    public function destroy(Request $request, Document $document): RedirectResponse
    {
        $owner = $document->documentable;
        abort_unless($owner instanceof AttestationCase, 404);
        abort_unless(AttestationScope::canEdit($request->user(), $owner), 404);
        abort_unless($request->user()->can('attestation.documents.upload'), 403);

        Storage::disk($document->disk)->delete($document->stored_filename);
        $document->delete();

        return back()->with('flash', 'Document removed.');
    }
}
