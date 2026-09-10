<x-console-layout :title="$partner->name">
    <a href="{{ route('b2b.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <span class="text-[11px] uppercase tracking-wide text-slate-400 font-medium">{{ $partner->type }}</span>
                        <h2 class="font-head font-semibold text-xl text-slate-900 mt-1">{{ $partner->name }}</h2>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full {{ $partner->status === 'Active' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">{{ $partner->status }}</span>
                </div>
                <div class="grid grid-cols-3 gap-4 text-sm">
                    <div><p class="text-[12px] text-slate-400">Contact</p><p class="font-medium text-slate-800 mt-0.5">{{ $partner->contact_name ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Email</p><p class="font-medium text-slate-800 mt-0.5">{{ $partner->email ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Mobile</p><p class="font-medium text-slate-800 mt-0.5">{{ $partner->mobile ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Commission rate</p><p class="font-medium text-slate-800 mt-0.5">{{ number_format($partner->commission_rate, 2) }}%</p></div>
                    <div><p class="text-[12px] text-slate-400">Credit limit</p><p class="font-medium text-slate-800 mt-0.5">&#8377;{{ number_format($partner->credit_limit, 2) }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Added by</p><p class="font-medium text-slate-800 mt-0.5">{{ $partner->creator->name ?? '—' }}</p></div>
                </div>
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Recent invoices</h3>
                <div class="flex flex-col gap-2">
                    @forelse ($partner->invoices as $inv)
                        <a href="{{ route('finance.show', $inv) }}" class="flex items-center justify-between px-4 py-2.5 border border-slate-100 rounded-lg text-sm hover:bg-slate-50">
                            <span class="font-mono text-[12.5px] text-slate-700">{{ $inv->invoice_number }}</span>
                            <span class="text-slate-600">{{ $inv->description }}</span>
                            <span class="font-medium text-slate-800">&#8377;{{ number_format($inv->amount, 2) }}</span>
                            <span class="text-[11.5px] px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $inv->status }}</span>
                        </a>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No invoices billed to this partner yet.</p>
                    @endforelse
                </div>
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Agreements</h3>
                <div class="flex flex-col gap-2 mb-5">
                    @forelse ($partner->agreements as $a)
                        <div class="px-4 py-2.5 border border-slate-100 rounded-lg text-sm">
                            <div class="flex items-center justify-between mb-1">
                                <span class="font-medium text-slate-800">{{ number_format($a->commission_rate, 2) }}% commission</span>
                                <span class="text-[11.5px] px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $a->status }}</span>
                            </div>
                            <p class="text-[12px] text-slate-500">{{ $a->start_date->format('d M Y') }} &ndash; {{ $a->end_date?->format('d M Y') ?? 'ongoing' }}</p>
                            @if ($a->terms)<p class="text-[12.5px] text-slate-600 mt-1.5">{{ $a->terms }}</p>@endif
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No agreements on file yet.</p>
                    @endforelse
                </div>

                @can('b2b.partners.manage')
                    <form method="post" action="{{ route('b2b.agreements.store', $partner) }}" class="grid grid-cols-2 gap-3 pt-4 border-t border-slate-100">
                        @csrf
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Commission rate (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="commission_rate" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Start date</label>
                            <input type="date" name="start_date" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">End date (optional)</label>
                            <input type="date" name="end_date" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div class="col-span-2">
                            <label class="text-[12px] text-slate-500 block mb-1">Terms</label>
                            <textarea name="terms" rows="2" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2"></textarea>
                        </div>
                        <div class="col-span-2">
                            <button type="submit" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Add agreement</button>
                        </div>
                    </form>
                @endcan
            </div>
        </div>

        <div>
            @can('finance.invoices.create')
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-2">Bill this partner</h3>
                    <p class="text-[12.5px] text-slate-500 mb-4">Raise an invoice with this partner pre-selectable from the Finance module.</p>
                    <a href="{{ route('finance.create') }}" class="block text-center text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">New invoice</a>
                </div>
            @endcan
        </div>
    </div>
</x-console-layout>
