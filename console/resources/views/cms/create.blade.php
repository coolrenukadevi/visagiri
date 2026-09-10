<x-console-layout title="New Page">
    <div class="max-w-3xl">
        <a href="{{ route('cms.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-5">New Page</h2>

            <form method="post" action="{{ route('cms.store') }}" class="space-y-5">
                @csrf
                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Title *</label>
                    <input type="text" name="title" value="{{ old('title') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                </div>
                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Slug <span class="text-slate-400">(optional — derived from the title if left blank)</span></label>
                    <input type="text" name="slug" value="{{ old('slug') }}" placeholder="about-us" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5 font-mono">
                </div>
                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Content (HTML) *</label>
                    <textarea name="content" rows="12" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5 font-mono">{{ old('content') }}</textarea>
                </div>
                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">Save as draft</button>
            </form>
        </div>
    </div>
</x-console-layout>
