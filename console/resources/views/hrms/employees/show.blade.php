<x-console-layout :title="$employee->user->name">
    <a href="{{ route('hrms.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to HRMS</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <h2 class="font-head font-semibold text-xl text-slate-900">{{ $employee->user->name }}</h2>
                        <p class="text-sm text-slate-500 mt-0.5">{{ $employee->designation ?: 'No designation on file' }}</p>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full {{ $employee->status === 'Active' ? 'bg-emerald-50 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">{{ $employee->status }}</span>
                </div>
                <div class="grid grid-cols-3 gap-4 text-sm">
                    <div><p class="text-[12px] text-slate-400">Email</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->user->email }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Department</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->user->department->name ?? '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Branch</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->user->branch->name ?? '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Employment type</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->employment_type }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Date of joining</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->date_of_joining?->format('d M Y') ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Reports to</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->user->manager->name ?? '—' }}</p></div>
                    @if ($canManage)
                        <div><p class="text-[12px] text-slate-400">Salary (&#8377;/year)</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->salary ? number_format($employee->salary, 2) : 'Not on file' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Date of birth</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->date_of_birth?->format('d M Y') ?: '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">PAN</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->pan_number ?: '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Personal email</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->personal_email ?: '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Personal phone</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->personal_phone ?: '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Emergency contact</p><p class="font-medium text-slate-800 mt-0.5">{{ $employee->emergency_contact_name ? "{$employee->emergency_contact_name} ({$employee->emergency_contact_phone})" : '—' }}</p></div>
                    @endif
                </div>
            </div>
        </div>

        @if ($canManage)
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Edit record</h3>
                <form method="post" action="{{ route('hrms.employees.update', $employee) }}" class="space-y-3">
                    @csrf @method('PATCH')
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Designation</label>
                        <input type="text" name="designation" value="{{ $employee->designation }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Employment type</label>
                        <select name="employment_type" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                            @foreach (\App\Models\Employee::EMPLOYMENT_TYPES as $t)
                                <option value="{{ $t }}" @selected($employee->employment_type === $t)>{{ $t }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Status</label>
                        <select name="status" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                            @foreach (\App\Models\Employee::STATUSES as $s)
                                <option value="{{ $s }}" @selected($employee->status === $s)>{{ $s }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Date of joining</label>
                        <input type="date" name="date_of_joining" value="{{ $employee->date_of_joining?->format('Y-m-d') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Salary (&#8377;/year)</label>
                        <input type="number" step="0.01" min="0" name="salary" value="{{ $employee->salary }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Personal email</label>
                        <input type="email" name="personal_email" value="{{ $employee->personal_email }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Personal phone</label>
                        <input type="text" name="personal_phone" value="{{ $employee->personal_phone }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Emergency contact name</label>
                        <input type="text" name="emergency_contact_name" value="{{ $employee->emergency_contact_name }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Emergency contact phone</label>
                        <input type="text" name="emergency_contact_phone" value="{{ $employee->emergency_contact_phone }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                    </div>
                    <div>
                        <label class="text-[12px] text-slate-500 block mb-1">Address</label>
                        <textarea name="address" rows="2" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">{{ $employee->address }}</textarea>
                    </div>
                    <button type="submit" class="w-full text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Save changes</button>
                </form>
            </div>
        @endif
    </div>
</x-console-layout>
