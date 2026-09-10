<x-console-layout title="New Attestation Case">
    <div class="max-w-2xl">
        <a href="{{ route('attestation.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-5">New Attestation Case</h2>

            <form method="post" action="{{ route('attestation.store') }}" class="space-y-5">
                @csrf

                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Name *</label>
                        <input type="text" name="name" value="{{ old('name') }}" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Nationality</label>
                        <input type="text" name="nationality" value="{{ old('nationality') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
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
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Document type *</label>
                        <select name="document_type" required class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                            <option value="">Select type</option>
                            @foreach (\App\Models\AttestationCase::DOC_TYPES_REQUIRED as $t)
                                <option value="{{ $t }}" @selected(old('document_type') === $t)>{{ $t }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div></div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Issuing country</label>
                        <select name="issuing_country_id" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                            <option value="">Select country</option>
                            @foreach ($countries as $c)
                                <option value="{{ $c->id }}" @selected(old('issuing_country_id') == $c->id)>{{ $c->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div>
                        <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Destination country</label>
                        <select name="destination_country_id" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                            <option value="">Select country</option>
                            @foreach ($countries as $c)
                                <option value="{{ $c->id }}" @selected(old('destination_country_id') == $c->id)>{{ $c->name }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>

                <div>
                    <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Notes</label>
                    <textarea name="notes" rows="3" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">{{ old('notes') }}</textarea>
                </div>

                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">
                    Open case
                </button>
            </form>
        </div>
    </div>
</x-console-layout>
