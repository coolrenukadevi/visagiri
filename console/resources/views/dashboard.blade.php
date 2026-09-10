<x-console-layout title="Dashboard">
    <div class="mb-6">
        <h2 class="font-head font-semibold text-2xl text-slate-900">Good to see you, {{ explode(' ', auth()->user()->name)[0] }}.</h2>
        <p class="text-sm text-slate-500 mt-1">
            Signed in as <b>{{ auth()->user()->getRoleNames()->first() }}</b>
            @if(auth()->user()->department)
                &middot; {{ auth()->user()->department->name }}
            @endif
            @if(auth()->user()->branch)
                &middot; {{ auth()->user()->branch->name }}
            @endif
        </p>
    </div>

    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        @foreach ($stats as $label => $value)
            <div class="bg-white rounded-lg border border-slate-200 p-5">
                <p class="text-[13px] text-slate-500">{{ $label }}</p>
                <p class="font-head font-semibold text-3xl text-slate-900 mt-1">{{ $value }}</p>
            </div>
        @endforeach
    </div>

    <div class="grid lg:grid-cols-3 gap-6">
        <div class="lg:col-span-2 bg-white rounded-lg border border-slate-200 p-6">
            <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-1">This is the real foundation, not a mockup</h3>
            <p class="text-sm text-slate-600 leading-relaxed mb-4">
                Every number above comes from this Laravel + MySQL app you're actually looking at &mdash;
                seeded roles, seeded permissions, seeded departments. The sidebar only shows modules your
                <code class="text-[12.5px] bg-slate-100 px-1.5 py-0.5 rounded">{{ auth()->user()->getRoleNames()->first() }}</code>
                role has a real permission for; log in as a different demo role and the menu itself changes.
            </p>
            <div class="flex flex-wrap gap-2">
                @foreach ($branches as $branch)
                    <span class="text-xs px-3 py-1.5 rounded-full bg-slate-100 text-slate-600">{{ $branch->name }} &middot; {{ $branch->users_count }} {{ Str::plural('user', $branch->users_count) }}</span>
                @endforeach
            </div>
        </div>

        <div class="bg-white rounded-lg border border-slate-200 p-6">
            <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-3">Your permissions</h3>
            <div class="flex flex-col gap-1.5 max-h-64 overflow-y-auto">
                @forelse ($permissions as $permission)
                    <div class="flex items-center gap-2 text-[12.5px] text-slate-600">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#17c3c9" stroke-width="3"><path d="M4 12l5 5L20 6"/></svg>
                        {{ $permission }}
                    </div>
                @empty
                    <p class="text-[12.5px] text-slate-400">No permissions assigned.</p>
                @endforelse
            </div>
        </div>
    </div>
</x-console-layout>
