<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use App\Models\Partner;
use App\Services\FinanceScope;
use App\Services\InvoiceWriter;
use App\Services\PartyResolver;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use InvalidArgumentException;

class InvoiceController extends Controller
{
    public function index(Request $request): View
    {
        $query = FinanceScope::visibleTo($request->user())
            ->with(['customer', 'partner', 'creator'])
            ->latest('created_at');

        if ($status = $request->query('status')) {
            $query->where('status', $status);
        }

        return view('finance.index', [
            'invoices' => $query->paginate(20)->withQueryString(),
            'statusFilter' => $status ?? '',
        ]);
    }

    public function create(): View
    {
        return view('finance.create', [
            'partners' => Partner::where('status', 'Active')->orderBy('name')->get(['id', 'name']),
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'email' => ['nullable', 'email', 'max:120'],
            'mobile' => ['nullable', 'string', 'max:30'],
            'partner_id' => ['nullable', 'exists:partners,id'],
            'description' => ['required', 'string', 'max:200'],
            'amount' => ['required', 'numeric', 'min:0.01'],
            'due_date' => ['nullable', 'date'],
        ]);

        if (empty($data['email']) && empty($data['mobile'])) {
            return back()->withErrors(['email' => 'Provide an email or mobile number.'])->withInput();
        }

        $user = $request->user();
        [$customer, $party] = PartyResolver::resolve(
            ['name' => $data['name'], 'email' => $data['email'] ?? '', 'mobile' => $data['mobile'] ?? ''],
            'Console'
        );

        $invoice = InvoiceWriter::create([
            'party_id' => $party->id,
            'customer_id' => $customer->id,
            'partner_id' => $data['partner_id'] ?? null,
            'description' => $data['description'],
            'amount' => $data['amount'],
            'due_date' => $data['due_date'] ?? null,
            'department_id' => $user->department_id,
            'branch_id' => $user->branch_id,
        ], $user->id);

        $message = $invoice->status === 'Pending Approval'
            ? "Invoice {$invoice->invoice_number} raised — over the four-eyes threshold, so it needs another reviewer's approval before it can be paid."
            : "Invoice {$invoice->invoice_number} raised and approved.";

        return redirect()->route('finance.show', $invoice)->with('flash', $message);
    }

    public function show(Request $request, Invoice $invoice): View
    {
        abort_unless(FinanceScope::canView($request->user(), $invoice), 404);

        $invoice->load(['customer', 'partner', 'creator', 'updater', 'approvals.actor', 'payments.receivedBy', 'ledgerEntries.creator']);

        return view('finance.show', [
            'invoice' => $invoice,
            'canApprove' => $request->user()->can('finance.invoices.approve') && $invoice->created_by !== $request->user()->id,
            'canRecordPayment' => $request->user()->can('finance.payments.record'),
        ]);
    }

    public function decide(Request $request, Invoice $invoice): RedirectResponse
    {
        $data = $request->validate([
            'action' => ['required', Rule::in(['Approved', 'Rejected'])],
            'notes' => ['nullable', 'string', 'max:500'],
        ]);

        abort_unless($request->user()->can('finance.invoices.approve'), 403);

        try {
            InvoiceWriter::decide($invoice, $data['action'], $request->user(), $data['notes'] ?? null);
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['action' => $e->getMessage()]);
        }

        return back()->with('flash', "Invoice {$data['action']}.");
    }

    public function recordPayment(Request $request, Invoice $invoice): RedirectResponse
    {
        abort_unless($request->user()->can('finance.payments.record'), 403);
        abort_unless(FinanceScope::canView($request->user(), $invoice), 404);

        $data = $request->validate([
            'amount' => ['required', 'numeric', 'min:0.01'],
            'method' => ['required', Rule::in(\App\Models\Payment::METHODS)],
            'reference_no' => ['nullable', 'string', 'max:80'],
            'notes' => ['nullable', 'string', 'max:300'],
        ]);

        try {
            InvoiceWriter::recordPayment($invoice, $data, $request->user()->id);
        } catch (InvalidArgumentException $e) {
            return back()->withErrors(['amount' => $e->getMessage()]);
        }

        return back()->with('flash', 'Payment recorded.');
    }
}
