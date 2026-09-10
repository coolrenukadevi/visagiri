<x-console-layout :title="$invoice->invoice_number">
    <a href="{{ route('finance.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <span class="text-[11px] uppercase tracking-wide text-slate-400 font-medium">Invoice</span>
                        <h2 class="font-head font-semibold text-xl text-slate-900 mt-1">{{ $invoice->partner->name ?? $invoice->customer->name ?? '—' }}</h2>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full bg-slate-100 text-slate-600">{{ $invoice->status }}</span>
                </div>
                <p class="text-sm text-slate-700 mb-4">{{ $invoice->description }}</p>
                <div class="grid grid-cols-3 gap-4 text-sm">
                    <div><p class="text-[12px] text-slate-400">Amount</p><p class="font-head font-semibold text-lg text-slate-900 mt-0.5">&#8377;{{ number_format($invoice->amount, 2) }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Paid</p><p class="font-medium text-slate-800 mt-0.5">&#8377;{{ number_format((float) $invoice->totalPaid(), 2) }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Balance due</p><p class="font-medium text-slate-800 mt-0.5">&#8377;{{ number_format((float) $invoice->balanceDue(), 2) }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Due date</p><p class="font-medium text-slate-800 mt-0.5">{{ $invoice->due_date?->format('d M Y') ?: '—' }}{{ $invoice->isOverdue() ? ' · overdue' : '' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Raised by</p><p class="font-medium text-slate-800 mt-0.5">{{ $invoice->creator->name ?? '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Raised on</p><p class="font-medium text-slate-800 mt-0.5">{{ $invoice->created_at->format('d M Y, H:i') }}</p></div>
                </div>
            </div>

            @if ($invoice->status === 'Pending Approval')
                <div class="rounded-lg border p-6" style="background:#fbf0dc;border-color:#e8d3a0">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-1.5">Awaiting approval</h3>
                    <p class="text-[13px] text-slate-600 mb-4">This invoice is &#8377;{{ number_format(\App\Models\Invoice::APPROVAL_THRESHOLD, 0) }} or more, so four-eyes applies — {{ $invoice->creator->name ?? 'the creator' }} cannot approve their own invoice.</p>
                    @if ($canApprove)
                        <form method="post" action="{{ route('finance.decide', $invoice) }}" class="space-y-3">
                            @csrf
                            <input type="text" name="notes" placeholder="Note (optional)" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5 bg-white">
                            <div class="flex gap-3">
                                <button type="submit" name="action" value="Approved" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#1c7a4f">Approve</button>
                                <button type="submit" name="action" value="Rejected" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#a23434">Reject</button>
                            </div>
                        </form>
                    @else
                        <p class="text-[12.5px] text-slate-500">You can't act on this one — either you don't hold finance.invoices.approve, or you're the person who raised it.</p>
                    @endif
                </div>
            @endif

            @if ($canRecordPayment && in_array($invoice->status, ['Approved', 'Partially Paid']))
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Record a payment</h3>
                    <form method="post" action="{{ route('finance.payments.store', $invoice) }}" class="grid grid-cols-2 gap-4">
                        @csrf
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Amount (&#8377;)</label>
                            <input type="number" step="0.01" min="0.01" max="{{ $invoice->balanceDue() }}" name="amount" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Method</label>
                            <select name="method" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                                @foreach (\App\Models\Payment::METHODS as $m)
                                    <option value="{{ $m }}">{{ $m }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Reference no.</label>
                            <input type="text" name="reference_no" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Notes</label>
                            <input type="text" name="notes" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div class="col-span-2">
                            <button type="submit" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Record payment</button>
                        </div>
                    </form>
                </div>
            @endif

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Payments</h3>
                <div class="flex flex-col gap-2">
                    @forelse ($invoice->payments as $p)
                        <div class="flex items-center justify-between px-4 py-2.5 border border-slate-100 rounded-lg text-sm">
                            <div>
                                <span class="font-medium text-slate-800">&#8377;{{ number_format($p->amount, 2) }}</span>
                                <span class="text-slate-500 ml-2">{{ $p->method }}{{ $p->reference_no ? ' · '.$p->reference_no : '' }}</span>
                            </div>
                            <span class="text-[12px] text-slate-400">{{ $p->received_at->format('d M Y, H:i') }} &middot; {{ $p->receivedBy->name ?? '—' }}</span>
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No payments recorded yet.</p>
                    @endforelse
                </div>
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Ledger</h3>
                <div class="flex flex-col gap-2">
                    @forelse ($invoice->ledgerEntries as $entry)
                        <div class="flex items-center justify-between px-4 py-2 text-[13px]">
                            <span class="text-slate-700">{{ $entry->entry_type }}</span>
                            <span class="font-mono {{ $entry->direction === 'Debit' ? 'text-slate-700' : 'text-emerald-700' }}">{{ $entry->direction === 'Debit' ? '+' : '-' }}&#8377;{{ number_format($entry->amount, 2) }}</span>
                            <span class="text-[11.5px] text-slate-400">{{ $entry->created_at->format('d M Y, H:i') }}</span>
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No ledger activity yet.</p>
                    @endforelse
                </div>
            </div>
        </div>

        <div class="space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-3">Approval history</h3>
                @forelse ($invoice->approvals as $a)
                    <div class="mb-3 last:mb-0">
                        <p class="text-[13.5px] text-slate-800"><b>{{ $a->action }}</b> by {{ $a->actor->name ?? '—' }}</p>
                        <p class="text-[11.5px] text-slate-400">{{ $a->created_at->format('d M Y, H:i') }}{{ $a->notes ? ' · '.$a->notes : '' }}</p>
                    </div>
                @empty
                    <p class="text-[12.5px] text-slate-400">{{ $invoice->status === 'Approved' ? 'Auto-approved — below the four-eyes threshold.' : 'No approval activity yet.' }}</p>
                @endforelse
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-2">Invoice number</h3>
                <p class="font-head font-semibold text-lg text-slate-900">{{ $invoice->invoice_number }}</p>
                <p class="text-[12px] text-slate-400 mt-1.5">
                    Last updated {{ $invoice->updated_at->format('d M Y, H:i') }}
                    @if ($invoice->updater) by {{ $invoice->updater->name }} @endif
                </p>
            </div>
        </div>
    </div>
</x-console-layout>
