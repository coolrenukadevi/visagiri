<x-console-layout :title="$title">
    <div class="max-w-2xl">
        <a href="{{ route("$routeBase.index") }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>
        <div class="bg-white rounded-lg border border-slate-200 p-7">
            <h2 class="font-head font-semibold text-xl text-slate-900 mb-5">{{ $title }}</h2>

            <form method="post" action="{{ route("$routeBase.store") }}" class="space-y-5">
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

                @if ($serviceType === 'visa')
                    <div class="grid grid-cols-2 gap-4 pt-2 border-t border-slate-100">
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Destination country</label>
                            <select name="country_id" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                <option value="">Select country</option>
                                @foreach ($countries as $c)
                                    <option value="{{ $c->id }}" @selected(old('country_id') == $c->id)>{{ $c->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Visa category</label>
                            <select name="visa_category_id" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                <option value="">Select category</option>
                                @foreach ($visaCategories as $c)
                                    <option value="{{ $c->id }}" @selected(old('visa_category_id') == $c->id)>{{ $c->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Travel date</label>
                            <input type="date" name="travel_date" value="{{ old('travel_date') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Travellers</label>
                            <input type="number" name="travellers_count" min="1" value="{{ old('travellers_count', 1) }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                        </div>
                    </div>
                @else
                    <div class="space-y-4 pt-2 border-t border-slate-100">
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Subject</label>
                            <input type="text" name="subject" value="{{ old('subject') }}" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Message</label>
                            <textarea name="message" rows="4" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">{{ old('message') }}</textarea>
                        </div>
                    </div>
                @endif

                <button type="submit" class="text-sm font-medium text-white px-5 py-2.5 rounded-lg" style="background:#0a1b3d">
                    Create {{ $serviceType === 'visa' ? 'lead' : 'enquiry' }}
                </button>
            </form>
        </div>
    </div>
</x-console-layout>
