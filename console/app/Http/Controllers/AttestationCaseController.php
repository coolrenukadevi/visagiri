<?php

namespace App\Http\Controllers;

use App\Models\AttestationCase;
use App\Models\Country;
use App\Models\Document;
use App\Models\User;
use App\Services\AttestationCaseWriter;
use App\Services\AttestationScope;
use App\Services\DocumentUploader;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class AttestationCaseController extends Controller
{
    public function index(Request $request): View
    {
        $query = AttestationScope::visibleTo($request->user())
            ->with(['customer', 'assignedTo'])
            ->latest('created_at');

        if ($status = $request->query('status')) {
            $query->where('status', $status);
        }
        if ($priority = $request->query('priority')) {
            $query->where('priority', $priority);
        }

        return view('attestation.index', [
            'cases' => $query->paginate(20)->withQueryString(),
            'statusFilter' => $status ?? '',
            'priorityFilter' => $priority ?? '',
        ]);
    }

    public function create(): View
    {
        return view('attestation.create', [
            'countries' => Country::orderBy('name')->get(['id', 'name']),
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'email' => ['nullable', 'email', 'max:120'],
            'mobile' => ['nullable', 'string', 'max:30'],
            'nationality' => ['nullable', 'string', 'max:80'],
            'document_type' => ['required', Rule::in(AttestationCase::DOC_TYPES_REQUIRED)],
            'issuing_country_id' => ['nullable', 'exists:countries,id'],
            'destination_country_id' => ['nullable', 'exists:countries,id'],
            'notes' => ['nullable', 'string', 'max:2000'],
        ]);

        if (empty($data['email']) && empty($data['mobile'])) {
            return back()->withErrors(['email' => 'Provide an email or mobile number.'])->withInput();
        }

        $case = AttestationCaseWriter::create(
            ['name' => $data['name'], 'email' => $data['email'] ?? '', 'mobile' => $data['mobile'] ?? '', 'nationality' => $data['nationality'] ?? null],
            [
                'document_type' => $data['document_type'],
                'issuing_country_id' => $data['issuing_country_id'] ?? null,
                'destination_country_id' => $data['destination_country_id'] ?? null,
                'notes' => $data['notes'] ?? null,
            ],
            'Console',
            $request->user()->id,
        );

        return redirect()->route('attestation.show', $case)->with('flash', "Case {$case->case_number} opened.");
    }

    public function show(Request $request, AttestationCase $case): View
    {
        abort_unless(AttestationScope::canView($request->user(), $case), 404);

        $case->load(['customer', 'assignedTo', 'issuingCountry', 'destinationCountry', 'statusHistory.changedBy', 'documents.uploadedBy']);

        return view('attestation.show', [
            'case' => $case,
            'canEdit' => AttestationScope::canEdit($request->user(), $case),
            'canAssign' => $request->user()->can('attestation.assign'),
            'canUpload' => $request->user()->can('attestation.documents.upload'),
            'assignees' => $request->user()->can('attestation.assign') ? User::where('status', 'active')->orderBy('name')->get(['id', 'name']) : collect(),
        ]);
    }

    public function transition(Request $request, AttestationCase $case): RedirectResponse
    {
        $user = $request->user();
        abort_unless(AttestationScope::canEdit($user, $case), 404);

        $data = $request->validate([
            'status' => ['required', Rule::in(AttestationCase::STATUSES)],
            'priority' => ['required', Rule::in(AttestationCase::PRIORITIES)],
            'assigned_to' => ['nullable', 'exists:users,id'],
            'status_note' => ['nullable', 'string', 'max:500'],
        ]);

        if (array_key_exists('assigned_to', $data) && $data['assigned_to'] != $case->assigned_to && ! $user->can('attestation.assign')) {
            unset($data['assigned_to']);
        }

        $case->update([
            'priority' => $data['priority'],
            'assigned_to' => $data['assigned_to'] ?? $case->assigned_to,
        ]);

        AttestationCaseWriter::transition($case, $data['status'], $user->id, $data['status_note'] ?? null);

        return back()->with('flash', 'Case updated.');
    }

    public function uploadDocument(Request $request, AttestationCase $case): RedirectResponse
    {
        $user = $request->user();
        abort_unless(AttestationScope::canEdit($user, $case), 404);
        abort_unless($user->can('attestation.documents.upload'), 403);

        $data = $request->validate([
            'doc_type' => ['required', Rule::in(Document::DOC_TYPES)],
            'file' => ['required', 'file', 'max:10240'],
        ]);

        try {
            DocumentUploader::store($case, $data['file'], $data['doc_type'], $user->id);
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['file' => $e->getMessage()]);
        }

        return back()->with('flash', 'Document uploaded.');
    }
}
