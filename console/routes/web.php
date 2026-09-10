<?php

use App\Http\Controllers\AttestationCaseController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DocumentController;
use App\Http\Controllers\EnquiryController;
use App\Http\Controllers\ModuleController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('/dashboard', DashboardController::class)->name('dashboard');
    Route::get('/modules/{module}', [ModuleController::class, 'comingSoon'])->name('modules.comingSoon');

    foreach (['sales-crm' => 'visa', 'general-enquiry' => 'general'] as $prefix => $serviceType) {
        Route::get("/{$prefix}", [EnquiryController::class, 'index'])
            ->name("{$prefix}.index")->defaults('serviceType', $serviceType)->middleware('can:enquiries.access');
        Route::get("/{$prefix}/create", [EnquiryController::class, 'create'])
            ->name("{$prefix}.create")->defaults('serviceType', $serviceType)->middleware('can:enquiries.create');
        Route::post("/{$prefix}", [EnquiryController::class, 'store'])
            ->name("{$prefix}.store")->defaults('serviceType', $serviceType)->middleware('can:enquiries.create');
    }

    Route::get('/enquiries/{enquiry}', [EnquiryController::class, 'show'])->name('enquiries.show');
    Route::post('/enquiries/{enquiry}/status', [EnquiryController::class, 'updateStatus'])->name('enquiries.status');
    Route::post('/enquiries/{enquiry}/notes', [EnquiryController::class, 'addNote'])->name('enquiries.notes');
    Route::post('/enquiries/{enquiry}/followups', [EnquiryController::class, 'addFollowup'])->name('enquiries.followups.store');
    Route::post('/enquiries/{enquiry}/followups/{followup}/complete', [EnquiryController::class, 'completeFollowup'])->name('enquiries.followups.complete');
    Route::delete('/enquiries/{enquiry}', [EnquiryController::class, 'destroy'])->name('enquiries.destroy');

    Route::get('/attestation', [AttestationCaseController::class, 'index'])->name('attestation.index')->middleware('can:attestation.access');
    Route::get('/attestation/create', [AttestationCaseController::class, 'create'])->name('attestation.create')->middleware('can:attestation.create');
    Route::post('/attestation', [AttestationCaseController::class, 'store'])->name('attestation.store')->middleware('can:attestation.create');
    Route::get('/attestation/{case}', [AttestationCaseController::class, 'show'])->name('attestation.show');
    Route::post('/attestation/{case}/transition', [AttestationCaseController::class, 'transition'])->name('attestation.transition');
    Route::post('/attestation/{case}/documents', [AttestationCaseController::class, 'uploadDocument'])->name('attestation.documents.store');

    Route::get('/documents/{document}/download', [DocumentController::class, 'download'])->name('documents.download')->middleware('signed');
    Route::delete('/documents/{document}', [DocumentController::class, 'destroy'])->name('documents.destroy');
});

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
require __DIR__.'/api.php';
