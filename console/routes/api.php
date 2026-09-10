<?php

use App\Http\Controllers\Api\EnquiryApiController;
use Illuminate\Support\Facades\Route;

// Required from web.php (not registered via withRouting's `api:` entry) so
// these routes run inside the `web` middleware group — session auth, not
// Sanctum tokens, since the only caller today is the console's own
// logged-in browser session. Revisit when a real external client shows up.
Route::middleware('auth')->prefix('api/v1')->group(function () {
    Route::get('/enquiries', [EnquiryApiController::class, 'index']);
    Route::post('/enquiries', [EnquiryApiController::class, 'store']);
    Route::get('/enquiries/{enquiry}', [EnquiryApiController::class, 'show']);
});
