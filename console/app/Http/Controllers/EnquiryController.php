<?php

namespace App\Http\Controllers;

use App\Models\Country;
use App\Models\Enquiry;
use App\Models\Followup;
use App\Models\User;
use App\Models\VisaCategory;
use App\Services\EnquiryScope;
use App\Services\EnquiryWriter;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

/**
 * Drives both the "Sales CRM" (visa enquiries) and "General Enquiry" nav
 * items off the one enquiries pipeline the public site already has —
 * the two routes below just pin serviceType via Route::defaults() and
 * share every other method. Every action re-checks EnquiryScope itself
 * rather than trusting the sidebar having hidden the link.
 */
class EnquiryController extends Controller
{
    public function index(Request $request): View
    {
        $serviceType = $request->route('serviceType');
        $user = $request->user();

        $query = EnquiryScope::visibleTo($user)
            ->where('service_type', $serviceType)
            ->with(['customer', 'assignedTo'])
            ->latest('created_at');

        if ($status = $request->query('status')) {
            $query->where('status', $status);
        }
        if ($priority = $request->query('priority')) {
            $query->where('priority', $priority);
        }

        return view('enquiries.index', [
            'serviceType' => $serviceType,
            'routeBase' => $this->routeBase($serviceType),
            'title' => $serviceType === 'visa' ? 'Sales CRM' : 'General Enquiry',
            'enquiries' => $query->paginate(20)->withQueryString(),
            'statusFilter' => $status ?? '',
            'priorityFilter' => $priority ?? '',
        ]);
    }

    public function create(Request $request): View
    {
        $serviceType = $request->route('serviceType');

        return view('enquiries.create', [
            'serviceType' => $serviceType,
            'routeBase' => $this->routeBase($serviceType),
            'title' => $serviceType === 'visa' ? 'New Sales Lead' : 'New General Enquiry',
            'countries' => $serviceType === 'visa' ? Country::orderBy('name')->get(['id', 'name']) : collect(),
            'visaCategories' => $serviceType === 'visa' ? VisaCategory::orderBy('name')->get(['id', 'name']) : collect(),
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $serviceType = $request->route('serviceType');

        $data = $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'email' => ['nullable', 'email', 'max:120'],
            'mobile' => ['nullable', 'string', 'max:30'],
            'nationality' => ['nullable', 'string', 'max:80'],
            'country_id' => ['nullable', 'exists:countries,id'],
            'visa_category_id' => ['nullable', 'exists:visa_categories,id'],
            'travel_date' => ['nullable', 'date'],
            'travellers_count' => ['nullable', 'integer', 'min:1'],
            'subject' => ['nullable', 'string', 'max:150'],
            'message' => ['nullable', 'string', 'max:2000'],
        ]);

        if (empty($data['email']) && empty($data['mobile'])) {
            return back()->withErrors(['email' => 'Provide an email or mobile number.'])->withInput();
        }

        $countryName = $data['country_id'] ?? null ? Country::find($data['country_id'])->name : null;

        $enquiry = EnquiryWriter::create(
            $serviceType,
            ['name' => $data['name'], 'email' => $data['email'] ?? '', 'mobile' => $data['mobile'] ?? '', 'nationality' => $data['nationality'] ?? null],
            [
                'country' => $countryName,
                'country_id' => $data['country_id'] ?? null,
                'visa_category_id' => $data['visa_category_id'] ?? null,
                'travel_date' => $data['travel_date'] ?? null,
                'travellers_count' => $data['travellers_count'] ?? 1,
                'nationality' => $data['nationality'] ?? null,
                'subject' => $data['subject'] ?? null,
                'message' => $data['message'] ?? null,
            ],
            'Console',
            $request->user()->id,
        );

        return redirect()->route('enquiries.show', $enquiry)
            ->with('flash', "Enquiry {$enquiry->reference_no} created.");
    }

    public function show(Request $request, Enquiry $enquiry): View
    {
        abort_unless(EnquiryScope::canView($request->user(), $enquiry), 404);

        $enquiry->load(['customer', 'party', 'assignedTo', 'creator', 'updater', 'visaDetail.country', 'visaDetail.visaCategory', 'generalDetail', 'followups' => fn ($q) => $q->orderByDesc('follow_up_date')]);

        return view('enquiries.show', [
            'enquiry' => $enquiry,
            'routeBase' => $this->routeBase($enquiry->service_type),
            'title' => $enquiry->reference_no,
            'canEdit' => EnquiryScope::canEdit($request->user(), $enquiry),
            'canAssign' => $request->user()->can('enquiries.assign'),
            'assignees' => $request->user()->can('enquiries.assign') ? User::where('status', 'active')->orderBy('name')->get(['id', 'name']) : collect(),
        ]);
    }

    public function updateStatus(Request $request, Enquiry $enquiry): RedirectResponse
    {
        $user = $request->user();
        abort_unless(EnquiryScope::canEdit($user, $enquiry), 404);

        $data = $request->validate([
            'status' => ['required', Rule::in(Enquiry::STATUSES)],
            'priority' => ['required', Rule::in(Enquiry::PRIORITIES)],
            'assigned_to' => ['nullable', 'exists:users,id'],
            'application_status' => ['nullable', Rule::in(Enquiry::VISA_APPLICATION_STATUSES)],
            'payment_status' => ['nullable', Rule::in(Enquiry::PAYMENT_STATUSES)],
        ]);

        if (array_key_exists('assigned_to', $data) && $data['assigned_to'] != $enquiry->assigned_to && ! $user->can('enquiries.assign')) {
            unset($data['assigned_to']);
        }

        $enquiry->update([
            'status' => $data['status'],
            'priority' => $data['priority'],
            'assigned_to' => $data['assigned_to'] ?? $enquiry->assigned_to,
            'updated_by' => $user->id,
        ]);

        if ($enquiry->service_type === 'visa' && $enquiry->visaDetail) {
            $enquiry->visaDetail->update([
                'application_status' => $data['application_status'] ?? $enquiry->visaDetail->application_status,
                'payment_status' => $data['payment_status'] ?? $enquiry->visaDetail->payment_status,
            ]);
        }

        return back()->with('flash', 'Enquiry updated.');
    }

    public function addNote(Request $request, Enquiry $enquiry): RedirectResponse
    {
        $user = $request->user();
        abort_unless(EnquiryScope::canEdit($user, $enquiry), 404);

        $data = $request->validate(['note' => ['required', 'string', 'max:2000']]);

        $stamp = '['.now()->format('d M Y H:i').' — '.$user->name.'] '.trim($data['note']);
        $enquiry->update(['notes' => trim(($enquiry->notes ?? '')."\n".$stamp)]);

        return back()->with('flash', 'Note added.');
    }

    public function addFollowup(Request $request, Enquiry $enquiry): RedirectResponse
    {
        $user = $request->user();
        abort_unless(EnquiryScope::canEdit($user, $enquiry), 404);

        $data = $request->validate([
            'follow_up_date' => ['required', 'date'],
            'followup_notes' => ['nullable', 'string', 'max:500'],
        ]);

        $enquiry->followups()->create([
            'follow_up_date' => $data['follow_up_date'],
            'notes' => $data['followup_notes'] ?? null,
            'status' => 'Pending',
            'assigned_to' => $user->id,
        ]);

        return back()->with('flash', 'Follow-up scheduled.');
    }

    public function completeFollowup(Request $request, Enquiry $enquiry, Followup $followup): RedirectResponse
    {
        abort_unless(EnquiryScope::canEdit($request->user(), $enquiry), 404);
        abort_unless($followup->enquiry_id === $enquiry->id, 404);

        $followup->update(['status' => 'Done']);

        return back()->with('flash', 'Follow-up marked done.');
    }

    public function destroy(Request $request, Enquiry $enquiry): RedirectResponse
    {
        $user = $request->user();
        abort_unless(EnquiryScope::canView($user, $enquiry), 404);
        abort_unless($user->can('enquiries.delete'), 403);

        $routeBase = $this->routeBase($enquiry->service_type);
        $enquiry->delete();

        return redirect()->route("{$routeBase}.index")->with('flash', 'Enquiry deleted.');
    }

    private function routeBase(string $serviceType): string
    {
        return $serviceType === 'visa' ? 'sales-crm' : 'general-enquiry';
    }
}
