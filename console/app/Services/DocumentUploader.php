<?php

namespace App\Services;

use App\Models\Document;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use InvalidArgumentException;

/**
 * The one place a document ever gets written to disk. Every safeguard the
 * architecture doc's audit called out as missing lives here:
 *  - stored under the `local` disk, which Laravel 11+ roots at
 *    storage/app/private — outside the public web root by default
 *  - the on-disk filename is a random UUID; the user's original name is
 *    kept only as a display string, never as a filesystem path
 *  - the MIME type is sniffed from the actual file bytes (finfo), not
 *    trusted from the client's declared Content-Type — a renamed .exe
 *    fails here even if its extension claims to be a .pdf
 */
class DocumentUploader
{
    private const ALLOWED_EXTENSIONS = ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'];

    private const ALLOWED_MIME_TYPES = [
        'application/pdf',
        'image/jpeg',
        'image/png',
        'application/msword',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    ];

    private const MAX_SIZE_BYTES = 10 * 1024 * 1024;

    public static function store(Model $documentable, UploadedFile $file, string $docType, int $uploadedBy): Document
    {
        if (! in_array($docType, Document::DOC_TYPES, true)) {
            throw new InvalidArgumentException("Unknown doc_type: {$docType}");
        }

        $extension = strtolower($file->getClientOriginalExtension());
        if (! in_array($extension, self::ALLOWED_EXTENSIONS, true)) {
            throw new InvalidArgumentException('That file type is not allowed. Allowed: '.implode(', ', self::ALLOWED_EXTENSIONS));
        }

        if ($file->getSize() > self::MAX_SIZE_BYTES) {
            throw new InvalidArgumentException('File exceeds the 10MB limit.');
        }

        $finfo = finfo_open(FILEINFO_MIME_TYPE);
        $detectedMime = finfo_file($finfo, $file->getRealPath());
        finfo_close($finfo);

        if (! in_array($detectedMime, self::ALLOWED_MIME_TYPES, true)) {
            throw new InvalidArgumentException("The file's actual content ({$detectedMime}) doesn't match an allowed document type.");
        }

        $directory = 'documents/'.Str::snake(class_basename($documentable)).'/'.$documentable->getKey();
        $storedFilename = Str::uuid()->toString().'.'.$extension;
        $storedPath = Storage::disk('local')->putFileAs($directory, $file, $storedFilename);

        return $documentable->documents()->create([
            'doc_type' => $docType,
            'original_filename' => self::sanitizeDisplayName($file->getClientOriginalName()),
            'stored_filename' => $storedPath,
            'disk' => 'local',
            'mime_type' => $detectedMime,
            'size_bytes' => $file->getSize(),
            'status' => 'Uploaded',
            'uploaded_by' => $uploadedBy,
        ]);
    }

    private static function sanitizeDisplayName(string $name): string
    {
        $name = basename($name);

        return Str::limit(preg_replace('/[^\w.\-() ]/', '_', $name) ?? 'document', 150, '');
    }
}
