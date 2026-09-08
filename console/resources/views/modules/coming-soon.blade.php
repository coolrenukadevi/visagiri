<x-console-layout :title="$title">
    <div class="max-w-xl">
        <div class="bg-white rounded-lg border border-slate-200 p-8">
            <span class="inline-block text-[11px] font-semibold uppercase tracking-wide px-2.5 py-1 rounded-full mb-4" style="background:#e4faf9;color:#0b7a7e">
                Not built yet
            </span>
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-2">{{ $title }}</h2>
            <p class="text-sm text-slate-600 leading-relaxed">
                You can see this in the sidebar because your role has permission for it once it exists —
                that's the permission engine working correctly, not the module itself.
                @if($milestone)
                    Per the roadmap, this lands in <b>Milestone {{ $milestone }}</b>.
                @endif
            </p>
            <a href="{{ route('dashboard') }}" class="inline-block mt-6 text-sm font-medium" style="color:#17c3c9">&larr; Back to dashboard</a>
        </div>
    </div>
</x-console-layout>
