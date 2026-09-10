<x-console-layout title="HRMS">
    <div class="flex items-center justify-between mb-6">
        <div>
            <h2 class="font-head font-semibold text-2xl text-slate-900">HRMS</h2>
            <p class="text-sm text-slate-500 mt-1">{{ auth()->user()->employee->designation ?? 'No profile on file yet' }}</p>
        </div>
        <div class="flex gap-3">
            @if ($canViewDirectory)
                <a href="{{ route('hrms.employees.index') }}" class="text-sm font-medium text-slate-700 px-4 py-2.5 rounded-lg border border-slate-200 bg-white">Employee directory</a>
            @endif
            @can('hrms.leave.create')
                <a href="{{ route('hrms.leave.create') }}" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">+ Request leave</a>
            @endcan
        </div>
    </div>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            @if ($pendingForMe->isNotEmpty())
                <div class="rounded-lg border p-6" style="background:#fbf0dc;border-color:#e8d3a0">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Awaiting your decision ({{ $pendingForMe->count() }})</h3>
                    <div class="flex flex-col gap-3">
                        @foreach ($pendingForMe as $leave)
                            <div class="bg-white rounded-lg p-4">
                                <div class="flex items-center justify-between mb-2">
                                    <p class="text-sm font-medium text-slate-800">{{ $leave->user->name }} &middot; {{ $leave->leave_type }} &middot; {{ $leave->days }} {{ Str::plural('day', $leave->days) }}</p>
                                    <span class="text-[11.5px] text-slate-400">{{ $leave->start_date->format('d M') }} &ndash; {{ $leave->end_date->format('d M Y') }}</span>
                                </div>
                                @if ($leave->reason)<p class="text-[12.5px] text-slate-500 mb-3">{{ $leave->reason }}</p>@endif
                                <form method="post" action="{{ route('hrms.leave.decide', $leave) }}" class="flex gap-2 items-center">
                                    @csrf
                                    <input type="text" name="notes" placeholder="Note (optional)" class="flex-1 text-[12.5px] border border-slate-200 rounded-lg px-3 py-1.5">
                                    <button type="submit" name="action" value="Approved" class="text-[12.5px] font-medium text-white px-3 py-1.5 rounded-lg" style="background:#1c7a4f">Approve</button>
                                    <button type="submit" name="action" value="Rejected" class="text-[12.5px] font-medium text-white px-3 py-1.5 rounded-lg" style="background:#a23434">Reject</button>
                                </form>
                            </div>
                        @endforeach
                    </div>
                </div>
            @endif

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">My leave requests</h3>
                <div class="flex flex-col gap-2">
                    @forelse ($myLeave as $leave)
                        <div class="flex items-center justify-between px-4 py-2.5 border border-slate-100 rounded-lg text-sm">
                            <div>
                                <span class="font-medium text-slate-800">{{ $leave->leave_type }}</span>
                                <span class="text-slate-500 ml-2">{{ $leave->start_date->format('d M') }} &ndash; {{ $leave->end_date->format('d M Y') }} &middot; {{ $leave->days }} {{ Str::plural('day', $leave->days) }}</span>
                            </div>
                            <div class="flex items-center gap-3">
                                <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full bg-slate-100 text-slate-600">{{ $leave->status }}</span>
                                @if ($leave->status === 'Pending')
                                    <form method="post" action="{{ route('hrms.leave.cancel', $leave) }}" onsubmit="return confirm('Cancel this leave request?')">
                                        @csrf
                                        <button type="submit" class="text-[12px] text-rose-600">Cancel</button>
                                    </form>
                                @endif
                            </div>
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No leave requests yet.</p>
                    @endforelse
                </div>
            </div>
        </div>

        <div class="bg-white rounded-lg border border-slate-200 p-6">
            <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Leave balance {{ now()->format('Y') }}</h3>
            <div class="flex flex-col gap-3">
                @forelse ($balances as $b)
                    <div>
                        <div class="flex items-center justify-between text-sm mb-1">
                            <span class="text-slate-700">{{ $b['type'] }}</span>
                            <span class="font-medium text-slate-800">{{ $b['remaining'] }} / {{ $b['allocated'] }}</span>
                        </div>
                        <div class="h-1.5 rounded-full bg-slate-100 overflow-hidden">
                            <div class="h-full rounded-full" style="width:{{ $b['allocated'] > 0 ? max(0, min(100, ($b['remaining'] / $b['allocated']) * 100)) : 0 }}%;background:#17c3c9"></div>
                        </div>
                    </div>
                @empty
                    <p class="text-[13.5px] text-slate-400">No leave allocation on file yet.</p>
                @endforelse
            </div>
        </div>
    </div>
</x-console-layout>
