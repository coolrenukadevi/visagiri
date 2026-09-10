<x-console-layout title="New Partner">
    <div class="max-w-2xl">
        <a href="{{ route('b2b.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-5">New Partner</h2>

            <form method="post" action="{{ route('b2b.store') }}" class="space-y-5">
                @csrf

                <div class="grid grid-cols-2 gap-4">
                    <div class="col-span-2">
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Partner name *</label>
                        <input type="text" name="name" value="{{ old('name') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Type *</label>
                        <select name="type" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                            @foreach (\App\Models\Partner::TYPES as $t)
                                <option value="{{ $t }}" @selected(old('type') === $t)>{{ $t }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Contact name</label>
                        <input type="text" name="contact_name" value="{{ old('contact_name') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Email</label>
                        <input type="email" name="email" value="{{ old('email') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Mobile</label>
                        <input type="text" name="mobile" value="{{ old('mobile') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Commission rate (%) *</label>
                        <input type="number" step="0.01" min="0" max="100" name="commission_rate" value="{{ old('commission_rate', 0) }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Credit limit (&#8377;) *</label>
                        <input type="number" step="0.01" min="0" name="credit_limit" value="{{ old('credit_limit', 0) }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                </div>

                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">
                    Add partner
                </button>
            </form>
        </div>
    </div>
</x-console-layout>
