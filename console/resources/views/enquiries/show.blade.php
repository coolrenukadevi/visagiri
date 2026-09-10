<x-console-layout :title="$title">
    <a href="{{ route("$routeBase.index") }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <span class="text-[11px] uppercase tracking-wide text-slate-400 font-medium">{{ ucfirst($enquiry->service_type) }} Enquiry</span>
                        <h2 class="font-head font-semibold text-xl text-slate-900 mt-1">{{ $enquiry->customer->name }}</h2>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full bg-slate-100 text-slate-600">{{ $enquiry->status }}</span>
                </div>
                <div class="grid grid-cols-3 gap-4 text-sm">
                    <div><p class="text-[12px] text-slate-400">Email</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->customer->email ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Mobile</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->customer->mobile ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Source</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->source }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Destination</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->destination ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Travel date</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->travel_date?->format('d M Y') ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Created</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->created_at->format('d M Y, H:i') }}</p></div>
                </div>
            </div>

            @if ($enquiry->service_type === 'visa' && $enquiry->visaDetail)
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Visa details</h3>
                    <div class="grid grid-cols-3 gap-4 text-sm">
                        <div><p class="text-[12px] text-slate-400">Country</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->visaDetail->country->name ?? '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Category</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->visaDetail->visaCategory->name ?? '—' }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Travellers</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->visaDetail->travellers_count }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Application status</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->visaDetail->application_status }}</p></div>
                        <div><p class="text-[12px] text-slate-400">Payment status</p><p class="font-medium text-slate-800 mt-0.5">{{ $enquiry->visaDetail->payment_status }}</p></div>
                    </div>
                </div>
            @elseif ($enquiry->generalDetail)
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Message</h3>
                    <p class="text-sm text-slate-600 mb-2"><b class="text-slate-800">{{ $enquiry->generalDetail->subject ?: 'No subject' }}</b></p>
                    <p class="text-sm text-slate-600 leading-relaxed">{{ $enquiry->generalDetail->message ?: 'No message provided.' }}</p>
                </div>
            @endif

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-3">Notes</h3>
                <pre class="whitespace-pre-wrap font-sans text-[13.5px] text-slate-700 bg-slate-50 rounded-lg p-4 mb-4 min-h-[40px]">{{ $enquiry->notes ?: 'No notes yet.' }}</pre>
                @if ($canEdit)
                    <form method="post" action="{{ route('enquiries.notes', $enquiry) }}">
                        @csrf
                        <textarea name="note" rows="2" required placeholder="Add an internal note..." class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5"></textarea>
                        <button type="submit" class="mt-2.5 text-sm font-medium text-white px-4 py-2 rounded-lg" style="background:#0a1b3d">Add note</button>
                    </form>
                @endif
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-3">Follow-ups</h3>
                <div class="flex flex-col gap-2.5 mb-4">
                    @forelse ($enquiry->followups as $f)
                        <div class="flex items-center justify-between px-4 py-2.5 border border-slate-100 rounded-lg">
                            <div>
                                <span class="text-[13.5px] font-medium text-slate-800">{{ $f->follow_up_date->format('d M Y') }}</span>
                                <span class="text-[13px] text-slate-500 ml-2">{{ $f->notes ?: 'No notes' }}</span>
                            </div>
                            @if ($f->status === 'Pending')
                                @if ($canEdit)
                                    <form method="post" action="{{ route('enquiries.followups.complete', [$enquiry, $f]) }}">
                                        @csrf
                                        <button type="submit" class="text-[12px] px-3 py-1.5 rounded-lg border border-slate-200 text-slate-600 hover:bg-slate-50">Mark done</button>
                                    </form>
                                @endif
                            @else
                                <span class="text-[11px] font-medium px-2 py-0.5 rounded-full bg-emerald-50 text-emerald-700">Done</span>
                            @endif
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No follow-ups scheduled.</p>
                    @endforelse
                </div>
                @if ($canEdit)
                    <form method="post" action="{{ route('enquiries.followups.store', $enquiry) }}" class="flex gap-3 items-end flex-wrap">
                        @csrf
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Date</label>
                            <input type="date" name="follow_up_date" required class="text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <div class="flex-1 min-w-[180px]">
                            <label class="text-[12px] text-slate-500 block mb-1">Notes</label>
                            <input type="text" name="followup_notes" placeholder="What's next?" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2">
                        </div>
                        <button type="submit" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Schedule</button>
                    </form>
                @endif
            </div>
        </div>

        <div class="space-y-6">
            @if ($canEdit)
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Update status</h3>
                    <form method="post" action="{{ route('enquiries.status', $enquiry) }}" class="space-y-4">
                        @csrf
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Pipeline status</label>
                            <select name="status" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                @foreach (\App\Models\Enquiry::STATUSES as $s)
                                    <option value="{{ $s }}" @selected($enquiry->status === $s)>{{ $s }}</option>
                                @endforeach
                            </select>
                        </div>

                        @if ($enquiry->service_type === 'visa' && $enquiry->visaDetail)
                            <div>
                                <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Visa application status</label>
                                <select name="application_status" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                    @foreach (\App\Models\Enquiry::VISA_APPLICATION_STATUSES as $s)
                                        <option value="{{ $s }}" @selected($enquiry->visaDetail->application_status === $s)>{{ $s }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div>
                                <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Payment status</label>
                                <select name="payment_status" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                    @foreach (\App\Models\Enquiry::PAYMENT_STATUSES as $s)
                                        <option value="{{ $s }}" @selected($enquiry->visaDetail->payment_status === $s)>{{ $s }}</option>
                                    @endforeach
                                </select>
                            </div>
                        @endif

                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Priority</label>
                            <select name="priority" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                @foreach (\App\Models\Enquiry::PRIORITIES as $p)
                                    <option value="{{ $p }}" @selected($enquiry->priority === $p)>{{ $p }}</option>
                                @endforeach
                            </select>
                        </div>

                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Assigned to</label>
                            <select name="assigned_to" @disabled(! $canAssign) class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5 disabled:bg-slate-50 disabled:text-slate-400">
                                <option value="">Unassigned</option>
                                @foreach ($assignees as $u)
                                    <option value="{{ $u->id }}" @selected($enquiry->assigned_to === $u->id)>{{ $u->name }}</option>
                                @endforeach
                            </select>
                            @unless ($canAssign)
                                <p class="text-[11.5px] text-slate-400 mt-1">You don't have permission to reassign enquiries.</p>
                            @endunless
                        </div>

                        <button type="submit" class="w-full text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Save changes</button>
                    </form>
                </div>
            @endif

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-2">Reference</h3>
                <p class="font-head font-semibold text-lg text-slate-900">{{ $enquiry->reference_no }}</p>
                <p class="text-[12px] text-slate-400 mt-1.5">
                    Last updated {{ $enquiry->updated_at->format('d M Y, H:i') }}
                    @if ($enquiry->updater) by {{ $enquiry->updater->name }} @endif
                </p>
                @can('enquiries.delete')
                    <form method="post" action="{{ route('enquiries.destroy', $enquiry) }}" class="mt-4" onsubmit="return confirm('Delete this enquiry? This cannot be undone.')">
                        @csrf @method('DELETE')
                        <button type="submit" class="text-[12.5px] text-rose-600 hover:underline">Delete enquiry</button>
                    </form>
                @endcan
            </div>
        </div>
    </div>
</x-console-layout>
