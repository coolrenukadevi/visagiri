<?php

namespace App\Http\Controllers;

use App\Models\Partner;
use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class PartnerController extends Controller
{
    public function index(): View
    {
        return view('b2b.index', [
            'partners' => Partner::withCount('invoices')->orderBy('name')->paginate(20),
        ]);
    }

    public function create(): View
    {
        return view('b2b.create');
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:150'],
            'type' => ['required', Rule::in(Partner::TYPES)],
            'contact_name' => ['nullable', 'string', 'max:120'],
            'email' => ['nullable', 'email', 'max:120'],
            'mobile' => ['nullable', 'string', 'max:30'],
            'commission_rate' => ['required', 'numeric', 'min:0', 'max:100'],
            'credit_limit' => ['required', 'numeric', 'min:0'],
        ]);

        $partner = Partner::create([...$data, 'created_by' => $request->user()->id]);

        return redirect()->route('b2b.show', $partner)->with('flash', "Partner \"{$partner->name}\" added.");
    }

    public function show(Partner $partner): View
    {
        $partner->load(['agreements.creator', 'invoices' => fn ($q) => $q->latest('created_at')->limit(10)]);

        return view('b2b.show', ['partner' => $partner]);
    }

    public function storeAgreement(Request $request, Partner $partner): RedirectResponse
    {
        $data = $request->validate([
            'terms' => ['nullable', 'string', 'max:2000'],
            'commission_rate' => ['required', 'numeric', 'min:0', 'max:100'],
            'start_date' => ['required', 'date'],
            'end_date' => ['nullable', 'date', 'after:start_date'],
        ]);

        $partner->agreements()->create([...$data, 'created_by' => $request->user()->id]);

        return back()->with('flash', 'Agreement added.');
    }
}
