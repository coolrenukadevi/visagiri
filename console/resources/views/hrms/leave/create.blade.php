<x-console-layout title="Request Leave">
    <div class="max-w-xl">
        <a href="{{ route('hrms.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to HRMS</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-5">Request Leave</h2>

            <div class="flex gap-4 mb-5 pb-5 border-b border-slate-100">
                @foreach ($balances as $b)
                    <div class="text-[12.5px]"><span class="text-slate-500">{{ $b['type'] }}:</span> <b class="text-slate-800">{{ $b['remaining'] }} left</b></div>
                @endforeach
            </div>

            <form method="post" action="{{ route('hrms.leave.store') }}" class="space-y-5">
                @csrf
                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Leave type *</label>
                    <select name="leave_type" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                        @foreach (\App\Models\LeaveRequest::TYPES as $t)
                            <option value="{{ $t }}" @selected(old('leave_type') === $t)>{{ $t }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Start date *</label>
                        <input type="date" name="start_date" value="{{ old('start_date') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">End date *</label>
                        <input type="date" name="end_date" value="{{ old('end_date') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                </div>
                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Reason</label>
                    <textarea name="reason" rows="3" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">{{ old('reason') }}</textarea>
                </div>
                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">Submit request</button>
            </form>
        </div>
    </div>
</x-console-layout>
