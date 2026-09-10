<x-console-layout title="New Invoice">
    <div class="max-w-2xl">
        <a href="{{ route('finance.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-1">New Invoice</h2>
            <p class="text-[12.5px] text-slate-400 mb-5">Invoices of &#8377;{{ number_format(\App\Models\Invoice::APPROVAL_THRESHOLD, 0) }} or more need a second person's approval before they can be paid.</p>

            <form method="post" action="{{ route('finance.store') }}" class="space-y-5">
                @csrf

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Bill to (name) *</label>
                        <input type="text" name="name" value="{{ old('name') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">B2B partner (optional)</label>
                        <select name="partner_id" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                            <option value="">None — direct customer</option>
                            @foreach ($partners as $p)
                                <option value="{{ $p->id }}" @selected(old('partner_id') == $p->id)>{{ $p->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Email</label>
                        <input type="email" name="email" value="{{ old('email') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Mobile</label>
                        <input type="text" name="mobile" value="{{ old('mobile') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                </div>
                <p class="text-[12px] text-slate-400 -mt-2">Provide at least an email or a mobile number.</p>

                <div class="grid grid-cols-2 gap-4 pt-2 border-t border-slate-100">
                    <div class="col-span-2">
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Description *</label>
                        <input type="text" name="description" value="{{ old('description') }}" required maxlength="200" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Amount (&#8377;) *</label>
                        <input type="number" step="0.01" min="0.01" name="amount" value="{{ old('amount') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Due date</label>
                        <input type="date" name="due_date" value="{{ old('due_date') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                </div>

                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">
                    Raise invoice
                </button>
            </form>
        </div>
    </div>
</x-console-layout>
