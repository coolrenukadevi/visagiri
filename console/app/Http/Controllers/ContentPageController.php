<?php

namespace App\Http\Controllers;

use App\Models\ContentPage;
use App\Services\ContentPageWriter;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use InvalidArgumentException;

class ContentPageController extends Controller
{
    public function index(Request $request): View
    {
        $query = ContentPage::with(['creator', 'updater'])->latest('updated_at');

        if ($status = $request->query('status')) {
            $query->where('status', $status);
        }

        return view('cms.index', [
            'pages' => $query->paginate(20)->withQueryString(),
            'statusFilter' => $status ?? '',
        ]);
    }

    public function create(): View
    {
        return view('cms.create');
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'title' => ['required', 'string', 'max:150'],
            'slug' => ['nullable', 'string', 'max:150', 'alpha_dash', 'unique:content_pages,slug'],
            'content' => ['required', 'string'],
        ]);

        $page = ContentPageWriter::create($data, $request->user()->id);

        return redirect()->route('cms.show', $page)->with('flash', "\"{$page->title}\" saved as a draft.");
    }

    public function show(ContentPage $page): View
    {
        $page->load('creator', 'updater', 'revisions.changedBy');

        return view('cms.show', [
            'page' => $page,
            'nextStatus' => ContentPage::NEXT_STATUS[$page->status] ?? null,
        ]);
    }

    public function update(Request $request, ContentPage $page): RedirectResponse
    {
        abort_unless($request->user()->can('cms.pages.edit'), 403);

        $data = $request->validate([
            'title' => ['required', 'string', 'max:150'],
            'content' => ['required', 'string'],
        ]);

        ContentPageWriter::update($page, $data, $request->user()->id);

        return redirect()->route('cms.show', $page)->with('flash', 'Changes saved — a new revision was logged.');
    }

    public function advance(Request $request, ContentPage $page): RedirectResponse
    {
        abort_unless($request->user()->can('cms.pages.advance'), 403);

        try {
            ContentPageWriter::advance($page, $request->user());
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['status' => $e->getMessage()]);
        }

        return back()->with('flash', "Moved to {$page->fresh()->status}.");
    }

    public function sendBack(Request $request, ContentPage $page): RedirectResponse
    {
        abort_unless($request->user()->can('cms.pages.advance'), 403);

        $data = $request->validate(['reason' => ['nullable', 'string', 'max:300']]);

        ContentPageWriter::sendBackToDraft($page, $request->user(), $data['reason'] ?? null);

        return back()->with('flash', 'Sent back to draft.');
    }

    public function destroy(Request $request, ContentPage $page): RedirectResponse
    {
        abort_unless($request->user()->can('cms.pages.delete'), 403);

        $page->delete();

        return redirect()->route('cms.index')->with('flash', 'Page deleted.');
    }
}
