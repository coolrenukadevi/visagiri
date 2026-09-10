<x-console-layout title="Employee Directory">
    <a href="{{ route('hrms.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to HRMS</a>
    <div class="mb-6">
        <h2 class="font-head font-semibold text-2xl text-slate-900">Employee Directory</h2>
        <p class="text-sm text-slate-500 mt-1">{{ $employees->count() }} {{ Str::plural('employee', $employees->count()) }} visible to you.</p>
    </div>

    <div class="bg-white rounded-lg border border-slate-200 overflow-hidden">
        <table class="w-full text-sm">
            <thead>
                <tr class="border-b border-slate-200 text-left text-[12px] uppercase tracking-wide text-slate-400">
                    <th class="px-5 py-3 font-medium">Name</th>
                    <th class="px-5 py-3 font-medium">Designation</th>
                    <th class="px-5 py-3 font-medium">Department</th>
                    <th class="px-5 py-3 font-medium">Type</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($employees as $employee)
                    <tr class="border-b border-slate-100 last:border-0 hover:bg-slate-50 cursor-pointer" onclick="location.href='{{ route('hrms.employees.show', $employee) }}'">
                        <td class="px-5 py-3 text-slate-800 font-medium">{{ $employee->user->name }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $employee->designation ?: '—' }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $employee->user->department->name ?? '—' }}</td>
                        <td class="px-5 py-3 text-slate-600">{{ $employee->employment_type }}</td>
                        <td class="px-5 py-3">
                            <span class="text-[11.5px] font-medium px-2 py-0.5 rounded-full {{ $employee->status === 'Active' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">{{ $employee->status }}</span>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="5" class="px-5 py-10 text-center text-slate-400 text-sm">No employees visible to you.</td></tr>
                @endforelse
            </tbody>
        </table>
    </div>
</x-console-layout>
