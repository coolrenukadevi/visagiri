<x-console-layout title="B2B Partners">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="font-head font-semibold text-2xl text-slate-900">B2B Partners</h2>
            <p class="text-sm text-slate-500 mt-1">{{ $partners->total() }} {{ Str::plural('partner', $partners->total()) }}.</p>
        </div>
        @can('b2b.partners.manage')
            <a href="{{ route('b2b.create') }}" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">
                + New Partner
            </a>
        @endcan
    </div>

    <div class="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table class="w-full text-sm">
            <thead>
                <tr class="border-b border-slate-200 text-left text-[12px] uppercase tracking-wide text-slate-400">
                    <th class="px-5 py-3 font-medium">Name</th>
                    <th class="px-5 py-3 font-medium">Type</th>
                    <th class="px-5 py-3 font-medium">Contact</th>
                    <th class="px-5 py-3 font-medium">Commission</th>
                    <th class="px-5 py-3 font-medium">Invoices</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($partners as $partner)
                    <tr class="border-b border-slate-100 last:border-0 hover:bg-slate-50 cursor-pointer" onclick="location.href='{{ route('b2b.show', $partner) }}'">
                        <td class="px-5 py-3 text-slate-800 font-medium">{{ $partner->name }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $partner->type }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $partner->contact_name ?: ($partner->email ?: $partner->mobile ?: '—') }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ number_format($partner->commission_rate, 2) }}%</td>
                        <td class="px-5 py-3 text-slate-600">{{ $partner->invoices_count }}</td>
                        <td class="px-5 py-3">
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full {{ $partner->status === 'Active' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">{{ $partner->status }}</span>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="6" class="px-5 py-10 text-center text-slate-400 text-sm">No partners yet.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-5">{{ $partners->links() }}</div>
</x-console-layout>
