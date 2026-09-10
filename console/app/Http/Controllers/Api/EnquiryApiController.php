<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Country;
use App\Models\Enquiry;
use App\Services\EnquiryScope;
use App\Services\EnquiryWriter;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

/**
 * The same internal API the architecture doc's UI Architecture section
 * describes every console page eventually calling — /api/v1/enquiries —
 * sharing EnquiryScope + EnquiryWriter with the Blade EnquiryController
 * so there is exactly one authorization path and one creation path,
 * not two that could quietly drift apart.
 */
class EnquiryApiController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = EnquiryScope::visibleTo($request->user())
            ->with(['customer', 'assignedTo'])
            ->latest('created_at');

        if ($type = $request->query('service_type')) {
            $query->where('service_type', $type);
        }

        $enquiries = $query->paginate(20);

        return response()->json([
            'data' => $enquiries->getCollection()->map(fn (Enquiry $e) => $this->summarize($e))->all(),
            'meta' => [
                'current_page' => $enquiries->currentPage(),
                'per_page' => $enquiries->perPage(),
                'total' => $enquiries->total(),
            ],
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        abort_unless($request->user()->can('enquiries.create'), 403);

        $data = $request->validate([
            'service_type' => ['required', 'in:'.implode(',', EnquiryWriter::VALID_SERVICE_TYPES)],
            'customer' => ['required', 'array'],
            'customer.name' => ['required', 'string', 'max:120'],
            'customer.email' => ['nullable', 'email', 'max:120'],
            'customer.mobile' => ['nullable', 'string', 'max:30'],
            'customer.nationality' => ['nullable', 'string', 'max:80'],
            'country' => ['nullable', 'string'],
            'visa_category_id' => ['nullable', 'exists:visa_categories,id'],
            'travel_date' => ['nullable', 'date'],
        ]);

        if (empty($data['customer']['email']) && empty($data['customer']['mobile'])) {
            return response()->json(['message' => 'customer.email or customer.mobile is required.'], 422);
        }

        $country = isset($data['country']) ? Country::where('slug', $data['country'])->first() : null;

        $enquiry = EnquiryWriter::create(
            $data['service_type'],
            $data['customer'],
            [
                'country' => $country->name ?? $data['country'] ?? null,
                'country_id' => $country->id ?? null,
                'visa_category_id' => $data['visa_category_id'] ?? null,
                'travel_date' => $data['travel_date'] ?? null,
            ],
            'API',
            $request->user()->id,
        );

        return response()->json([
            'id' => $enquiry->id,
            'reference_no' => $enquiry->reference_no,
            'status' => $enquiry->status,
            'party_id' => 'PTY-'.str_pad((string) $enquiry->party_id, 6, '0', STR_PAD_LEFT),
            'created_at' => $enquiry->created_at->toIso8601String(),
        ], 201);
    }

    public function show(Request $request, Enquiry $enquiry): JsonResponse
    {
        // Scope-filtered 404, not 403: matches the API contract's own rule
        // that scope must never be probeable by guessing a record ID.
        abort_unless(EnquiryScope::canView($request->user(), $enquiry), 404);

        $enquiry->load(['assignedTo', 'visaDetail.country', 'visaDetail.visaCategory', 'generalDetail', 'followups']);

        return response()->json($this->detail($enquiry));
    }

    private function summarize(Enquiry $enquiry): array
    {
        return [
            'id' => $enquiry->id,
            'reference_no' => $enquiry->reference_no,
            'service_type' => $enquiry->service_type,
            'status' => $enquiry->status,
            'customer' => ['name' => $enquiry->customer->name],
            'assigned_to' => $enquiry->assignedTo ? ['id' => $enquiry->assignedTo->id, 'name' => $enquiry->assignedTo->name] : null,
            'created_at' => $enquiry->created_at->toIso8601String(),
        ];
    }

    private function detail(Enquiry $enquiry): array
    {
        $timeline = collect([['event' => 'Enquiry created', 'at' => $enquiry->created_at->toIso8601String()]])
            ->concat($enquiry->followups->map(fn ($f) => [
                'event' => $f->status === 'Done' ? "Follow-up completed: {$f->notes}" : "Follow-up scheduled: {$f->notes}",
                'at' => $f->created_at->toIso8601String(),
            ]))
            ->sortBy('at')
            ->values();

        return [
            'id' => $enquiry->id,
            'reference_no' => $enquiry->reference_no,
            'status' => $enquiry->status,
            'assigned_to' => $enquiry->assignedTo ? ['id' => $enquiry->assignedTo->id, 'name' => $enquiry->assignedTo->name] : null,
            'visa' => $enquiry->service_type === 'visa' && $enquiry->visaDetail ? [
                'country' => $enquiry->visaDetail->country->name ?? null,
                'category' => $enquiry->visaDetail->visaCategory->name ?? null,
                'travel_date' => $enquiry->visaDetail->travel_date?->toDateString(),
            ] : null,
            'general' => $enquiry->service_type === 'general' && $enquiry->generalDetail ? [
                'subject' => $enquiry->generalDetail->subject,
                'message' => $enquiry->generalDetail->message,
            ] : null,
            'timeline' => $timeline->all(),
        ];
    }
}
