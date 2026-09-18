<?php

declare(strict_types=1);

use App\Http\Controllers\DocumentDownloadController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', fn () => Inertia::render('Dashboard'))->name('home');

// Document foundation: private retrieval only, authorization checked
// inside the controller before any byte is streamed — never a public
// storage path (Architecture Phase 5/6).
Route::get('/documents/{key}', DocumentDownloadController::class)
    ->where('key', '.*')
    ->name('documents.download');
