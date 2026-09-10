<x-console-layout :title="$page->title">
    <a href="{{ route('cms.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <h2 class="font-head font-semibold text-xl text-slate-900">{{ $page->title }}</h2>
                        <p class="text-[12.5px] text-slate-400 font-mono mt-0.5">/{{ $page->slug }}</p>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full {{ $page->status === 'Published' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-600' }}">{{ $page->status }}</span>
                </div>

                @can('cms.pages.edit')
                    <form method="post" action="{{ route('cms.update', $page) }}" class="space-y-3">
                        @csrf @method('PUT')
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Title</label>
                            <input type="text" name="title" value="{{ $page->title }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Content (HTML)</label>
                            <textarea name="content" rows="14" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2 font-mono">{{ $page->content }}</textarea>
                        </div>
                        <button type="submit" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Save (logs a new revision)</button>
                    </form>
                @else
                    <div class="text-sm text-slate-700 leading-relaxed border border-slate-100 rounded-lg p-4 bg-slate-50">{!! $page->content !!}</div>
                @endcan
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Revision history</h3>
                <div class="flex flex-col gap-2.5">
                    @foreach ($page->revisions as $rev)
                        <div class="flex items-center justify-between px-4 py-2 text-[13px]">
                            <span class="text-slate-700">{{ $rev->title }}</span>
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $rev->status }}</span>
                            <span class="text-[11.5px] text-slate-400">{{ $rev->created_at->format('d M Y, H:i') }} &middot; {{ $rev->changedBy->name ?? '—' }}</span>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>

        <div class="space-y-6">
            @can('cms.pages.advance')
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-3">Workflow</h3>
                    @if ($nextStatus)
                        <form method="post" action="{{ route('cms.advance', $page) }}" class="mb-3">
                            @csrf
                            <button type="submit" class="w-full text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">
                                {{ $page->status === 'Approved' ? 'Publish' : "Move to {$nextStatus}" }}
                            </button>
                        </form>
                        @if ($page->status === 'In Review' && $page->updated_by === auth()->id())
                            <p class="text-[11.5px] text-slate-400 mb-3">You last edited this page, so you can't be the one to approve it — ask someone else to review.</p>
                        @endif
                    @else
                        <p class="text-[12.5px] text-slate-500 mb-3">Published — no further stage.</p>
                    @endif

                    @if ($page->status !== 'Draft')
                        <form method="post" action="{{ route('cms.sendBack', $page) }}">
                            @csrf
                            <input type="text" name="reason" placeholder="Reason (optional)" class="w-full text-[12.5px] border border-slate-200 rounded-lg px-3 py-2 mb-2">
                            <button type="submit" class="w-full text-[12.5px] font-medium text-slate-600 px-4 py-2 rounded-lg border border-slate-200">Send back to draft</button>
                        </form>
                    @endif
                </div>
            @endcan

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <p class="text-[12px] text-slate-400">
                    Created by {{ $page->creator->name ?? '—' }}<br>
                    Last updated {{ $page->updated_at->format('d M Y, H:i') }} by {{ $page->updater->name ?? '—' }}
                    @if ($page->published_at)<br>Published {{ $page->published_at->format('d M Y, H:i') }}@endif
                </p>
                @can('cms.pages.delete')
                    <form method="post" action="{{ route('cms.destroy', $page) }}" class="mt-4" onsubmit="return confirm('Delete this page? This cannot be undone.')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-[12.5px] text-rose-600">Delete page</button>
                    </form>
                @endcan
            </div>
        </div>
    </div>
</x-console-layout>
