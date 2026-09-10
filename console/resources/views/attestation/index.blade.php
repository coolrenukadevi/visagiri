<x-console-layout title="Attestation">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="font-head font-semibold text-2xl text-slate-900">Attestation</h2>
            <p class="text-sm text-slate-500 mt-1">{{ $cases->total() }} {{ Str::plural('case', $cases->total()) }} visible to you.</p>
        </div>
        @can('attestation.create')
            <a href="{{ route('attestation.create') }}" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">
                + New Case
            </a>
        @endcan
    </div>

    <form method="get" class="flex flex-wrap gap-3 mb-5">
        <select name="status" onchange="this.form.submit()" class="text-sm border border-slate-200 rounded-lg px-3 py-2 bg-white">
            <option value="">All statuses</option>
            @foreach (\App\Models\AttestationCase::STATUSES as $s)
                <option value="{{ $s }}" @selected($statusFilter === $s)>{{ $s }}</option>
            @endforeach
        </select>
        <select name="priority" onchange="this.form.submit()" class="text-sm border border-slate-200 rounded-lg px-3 py-2 bg-white">
            <option value="">All priorities</option>
            @foreach (\App\Models\AttestationCase::PRIORITIES as $p)
                <option value="{{ $p }}" @selected($priorityFilter === $p)>{{ $p }}</option>
            @endforeach
        </select>
        @if ($statusFilter || $priorityFilter)
            <a href="{{ route('attestation.index') }}" class="text-sm text-slate-500 self-center">Clear filters</a>
        @endif
    </form>

    <div class="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table class="w-full text-sm">
            <thead>
                <tr class="border-b border-slate-200 text-left text-[12px] uppercase tracking-wide text-slate-400">
                    <th class="px-5 py-3 font-medium">Case</th>
                    <th class="px-5 py-3 font-medium">Customer</th>
                    <th class="px-5 py-3 font-medium">Document</th>
                    <th class="px-5 py-3 font-medium">Assigned</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                    <th class="px-5 py-3 font-medium">Priority</th>
                    <th class="px-5 py-3 font-medium">Opened</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($cases as $case)
                    <tr class="border-b border-slate-100 last:border-0 hover:bg-slate-50 cursor-pointer" onclick="location.href='{{ route('attestation.show', $case) }}'">
                        <td class="px-5 py-3 font-mono text-[12.5px] text-slate-700">{{ $case->case_number }}</td>
                        <td class="px-5 py-3 text-slate-800">{{ $case->customer->name }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $case->document_type }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $case->assignedTo->name ?? 'Unassigned' }}</td>
                        <td class="px-5 py-3">
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $case->status }}</span>
                        </td>
                        <td class="px-5 py-3 text-slate-600">{{ $case->priority }}</td>
                        <td class="px-5 py-3 text-slate-500 text-[12.5px]">{{ $case->created_at->format('d M Y') }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="7" class="px-5 py-10 text-center text-slate-400 text-sm">
                            No cases yet{{ $statusFilter || $priorityFilter ? ' matching these filters' : '' }}.
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-5">{{ $cases->links() }}</div>
</x-console-layout>
