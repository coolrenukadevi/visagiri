<x-console-layout :title="$case->case_number">
    <a href="{{ route('attestation.index') }}" class="text-sm text-slate-500 mb-4 inline-block">&larr; Back to list</a>

    <div class="grid lg:grid-cols-3 gap-6 items-start">
        <div class="lg:col-span-2 space-y-6">
            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <div class="flex items-start justify-between mb-4">
                    <div>
                        <span class="text-[11px] uppercase tracking-wide text-slate-400 font-medium">{{ $case->document_type }} Attestation</span>
                        <h2 class="font-head font-semibold text-xl text-slate-900 mt-1">{{ $case->customer->name }}</h2>
                    </div>
                    <span class="text-[11.5px] font-medium px-2.5 py-1 rounded-full bg-slate-100 text-slate-600">{{ $case->status }}</span>
                </div>
                <div class="grid grid-cols-3 gap-4 text-sm">
                    <div><p class="text-[12px] text-slate-400">Email</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->customer->email ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Mobile</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->customer->mobile ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Nationality</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->customer->nationality ?: '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Issuing country</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->issuingCountry->name ?? '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Destination country</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->destinationCountry->name ?? '—' }}</p></div>
                    <div><p class="text-[12px] text-slate-400">Opened</p><p class="font-medium text-slate-800 mt-0.5">{{ $case->created_at->format('d M Y, H:i') }}</p></div>
                </div>
                @if ($case->notes)
                    <p class="text-sm text-slate-600 mt-4 pt-4 border-t border-slate-100 leading-relaxed">{{ $case->notes }}</p>
                @endif
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Documents</h3>
                <div class="flex flex-col gap-2 mb-5">
                    @forelse ($case->documents as $doc)
                        <div class="flex items-center justify-between px-4 py-2.5 border border-slate-100 rounded-lg">
                            <div class="min-w-0">
                                <p class="text-[13.5px] font-medium text-slate-800 truncate">{{ $doc->original_filename }}</p>
                                <p class="text-[11.5px] text-slate-400">{{ $doc->doc_type }} &middot; {{ number_format($doc->size_bytes / 1024, 1) }} KB &middot; uploaded by {{ $doc->uploadedBy->name ?? 'Unknown' }}</p>
                            </div>
                            <div class="flex items-center gap-3 shrink-0 ml-3">
                                <a href="{{ \Illuminate\Support\Facades\URL::temporarySignedRoute('documents.download', now()->addMinutes(10), ['document' => $doc->id]) }}" class="text-[12.5px] font-medium" style="color:#17c3c9">Download</a>
                                @if ($canUpload)
                                    <form method="post" action="{{ route('documents.destroy', $doc) }}" onsubmit="return confirm('Remove this document?')">
                                        @csrf @method('DELETE')
                                        <button type="submit" class="text-[12.5px] text-rose-600">Remove</button>
                                    </form>
                                @endif
                            </div>
                        </div>
                    @empty
                        <p class="text-[13.5px] text-slate-400">No documents uploaded yet.</p>
                    @endforelse
                </div>

                @if ($canUpload)
                    <form method="post" action="{{ route('attestation.documents.store', $case) }}" enctype="multipart/form-data" class="flex gap-3 items-end flex-wrap pt-4 border-t border-slate-100">
                        @csrf
                        <div>
                            <label class="text-[12px] text-slate-500 block mb-1">Document type</label>
                            <select name="doc_type" required class="text-sm border border-slate-200 rounded-lg px-3 py-2">
                                @foreach (\App\Models\Document::DOC_TYPES as $t)
                                    <option value="{{ $t }}">{{ $t }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="flex-1 min-w-[200px]">
                            <label class="text-[12px] text-slate-500 block mb-1">File <span class="text-slate-400">(PDF, JPG, PNG, DOC — up to 10MB)</span></label>
                            <input type="file" name="file" required accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-1.5">
                        </div>
                        <button type="submit" class="text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Upload</button>
                    </form>
                @endif
            </div>

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Case history</h3>
                <div class="flex flex-col gap-4">
                    @foreach ($case->statusHistory as $entry)
                        <div class="flex gap-3">
                            <div class="w-1.5 h-1.5 rounded-full mt-1.5 shrink-0" style="background:#17c3c9"></div>
                            <div>
                                <p class="text-[13.5px] text-slate-800">
                                    @if ($entry->from_status)
                                        <span class="text-slate-400">{{ $entry->from_status }} &rarr;</span>
                                    @endif
                                    <b>{{ $entry->to_status }}</b>
                                </p>
                                <p class="text-[12px] text-slate-400 mt-0.5">
                                    {{ $entry->created_at->format('d M Y, H:i') }}
                                    @if ($entry->changedBy) &middot; {{ $entry->changedBy->name }} @endif
                                    @if ($entry->notes) &middot; {{ $entry->notes }} @endif
                                </p>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>

        <div class="space-y-6">
            @if ($canEdit)
                <div class="bg-white rounded-lg border border-slate-200 p-6">
                    <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-4">Update case</h3>
                    <form method="post" action="{{ route('attestation.transition', $case) }}" class="space-y-4">
                        @csrf
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Status</label>
                            <select name="status" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                @foreach (\App\Models\AttestationCase::STATUSES as $s)
                                    <option value="{{ $s }}" @selected($case->status === $s)>{{ $s }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Note on this change</label>
                            <input type="text" name="status_note" placeholder="Optional" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Priority</label>
                            <select name="priority" class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5">
                                @foreach (\App\Models\AttestationCase::PRIORITIES as $p)
                                    <option value="{{ $p }}" @selected($case->priority === $p)>{{ $p }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div>
                            <label class="text-[12.5px] font-medium text-slate-600 block mb-1.5">Assigned to</label>
                            <select name="assigned_to" @disabled(! $canAssign) class="w-full text-sm border border-slate-200 rounded-lg px-3 py-2.5 disabled:bg-slate-50 disabled:text-slate-400">
                                <option value="">Unassigned</option>
                                @foreach ($assignees as $u)
                                    <option value="{{ $u->id }}" @selected($case->assigned_to === $u->id)>{{ $u->name }}</option>
                                @endforeach
                            </select>
                            @unless ($canAssign)
                                <p class="text-[11.5px] text-slate-400 mt-1">You don't have permission to reassign cases.</p>
                            @endunless
                        </div>
                        <button type="submit" class="w-full text-sm font-medium text-white px-4 py-2.5 rounded-lg" style="background:#0a1b3d">Save changes</button>
                    </form>
                </div>
            @endif

            <div class="bg-white rounded-lg border border-slate-200 p-6">
                <h3 class="font-head font-semibold text-[15px] text-slate-900 mb-2">Case number</h3>
                <p class="font-head font-semibold text-lg text-slate-900">{{ $case->case_number }}</p>
                <p class="text-[12px] text-slate-400 mt-1.5">
                    Last updated {{ $case->updated_at->format('d M Y, H:i') }}
                    @if ($case->updater) by {{ $case->updater->name }} @endif
                </p>
            </div>
        </div>
    </div>
</x-console-layout>
