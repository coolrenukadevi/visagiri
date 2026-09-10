<x-console-layout title="Finance">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="font-head font-semibold text-2xl text-slate-900">Finance</h2>
            <p class="text-sm text-slate-500 mt-1">{{ $invoices->total() }} {{ Str::plural('invoice', $invoices->total()) }} visible to you.</p>
        </div>
        @can('finance.invoices.create')
            <a href="{{ route('finance.create') }}" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">
                + New Invoice
            </a>
        @endcan
    </div>

    <form method="get" class="flex flex-wrap gap-3 mb-5">
        <select name="status" onchange="this.form.submit()" class="text-sm border border-slate-200 rounded-lg px-3 py-2 bg-white">
            <option value="">All statuses</option>
            @foreach (\App\Models\Invoice::STATUSES as $s)
                <option value="{{ $s }}" @selected($statusFilter === $s)>{{ $s }}</option>
            @endforeach
        </select>
        @if ($statusFilter)
            <a href="{{ route('finance.index') }}" class="text-sm text-slate-500 self-center">Clear filter</a>
        @endif
    </form>

    <div class="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table class="w-full text-sm">
            <thead>
                <tr class="border-b border-slate-200 text-left text-[12px] uppercase tracking-wide text-slate-400">
                    <th class="px-5 py-3 font-medium">Invoice</th>
                    <th class="px-5 py-3 font-medium">Billed to</th>
                    <th class="px-5 py-3 font-medium">Description</th>
                    <th class="px-5 py-3 font-medium text-right">Amount</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                    <th class="px-5 py-3 font-medium">Raised by</th>
                    <th class="px-5 py-3 font-medium">Date</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($invoices as $invoice)
                    <tr class="border-b border-slate-100 last:border-0 hover:bg-slate-50 cursor-pointer" onclick="location.href='{{ route('finance.show', $invoice) }}'">
                        <td class="px-5 py-3 font-mono text-[12.5px] text-slate-700">{{ $invoice->invoice_number }}</td>
                        <td class="px-5 py-3 text-slate-800">{{ $invoice->partner->name ?? $invoice->customer->name ?? '—' }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $invoice->description }}</td>
                        <td class="px-5 py-3 text-slate-800 text-right font-medium">&#8377;{{ number_format($invoice->amount, 2) }}</td>
                        <td class="px-5 py-3">
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $invoice->status }}</span>
                        </td>
                        <td class="px-5 py-3 text-slate-600">{{ $invoice->creator->name ?? '—' }}</td>
                        <td class="px-5 py-3 text-slate-500 text-[12.5px]">{{ $invoice->created_at->format('d M Y') }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="7" class="px-5 py-10 text-center text-slate-400 text-sm">
                            No invoices yet{{ $statusFilter ? ' matching this filter' : '' }}.
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-5">{{ $invoices->links() }}</div>
</x-console-layout>
