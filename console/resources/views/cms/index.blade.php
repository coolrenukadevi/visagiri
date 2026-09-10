<x-console-layout title="Website CMS">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="font-head font-semibold text-2xl text-slate-900">Website CMS</h2>
            <p class="text-sm text-slate-500 mt-1">{{ $pages->total() }} {{ Str::plural('page', $pages->total()) }}. Manages content here — the public site isn't wired to read from it yet.</p>
        </div>
        @can('cms.pages.create')
            <a href="{{ route('cms.create') }}" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">+ New Page</a>
        @endcan
    </div>

    <form method="get" class="flex flex-wrap gap-3 mb-5">
        <select name="status" onchange="this.form.submit()" class="text-sm border border-slate-200 rounded-lg px-3 py-2 bg-white">
            <option value="">All statuses</option>
            @foreach (\App\Models\ContentPage::STATUSES as $s)
                <option value="{{ $s }}" @selected($statusFilter === $s)>{{ $s }}</option>
            @endforeach
        </select>
        @if ($statusFilter)
            <a href="{{ route('cms.index') }}" class="text-sm text-slate-500 self-center">Clear filter</a>
        @endif
    </form>

    <div class="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table class="w-full text-sm">
            <thead>
                <tr class="border-b border-slate-200 text-left text-[12px] uppercase tracking-wide text-slate-400">
                    <th class="px-5 py-3 font-medium">Title</th>
                    <th class="px-5 py-3 font-medium">Slug</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                    <th class="px-5 py-3 font-medium">Last updated</th>
                    <th class="px-5 py-3 font-medium">By</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($pages as $page)
                    <tr class="border-b border-slate-100 last:border-0 hover:bg-slate-50 cursor-pointer" onclick="location.href='{{ route('cms.show', $page) }}'">
                        <td class="px-5 py-3 text-slate-800 font-medium">{{ $page->title }}</td>
                        <td class="px-5 py-3 text-slate-500 font-mono text-[12.5px]">/{{ $page->slug }}</td>
                        <td class="px-5 py-3">
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full {{ $page->status === 'Published' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-600' }}">{{ $page->status }}</span>
                        </td>
                        <td class="px-5 py-3 text-slate-500 text-[12.5px]">{{ $page->updated_at->format('d M Y, H:i') }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $page->updater->name ?? $page->creator->name ?? '—' }}</td>
                    </tr>
                @empty
                    <tr><td colspan="5" class="px-5 py-10 text-center text-slate-400 text-sm">No pages yet{{ $statusFilter ? ' matching this filter' : '' }}.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="mt-5">{{ $pages->links() }}</div>
</x-console-layout>
