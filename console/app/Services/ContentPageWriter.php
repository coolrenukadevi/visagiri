<?php

namespace App\Services;

use App\Models\ContentPage;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use InvalidArgumentException;

/**
 * Every save (create, edit, or a status move) writes a content_revisions
 * row in the same transaction — the append-only editorial history the
 * architecture doc's CMS section calls for. Moving In Review → Approved
 * needs someone other than whoever last edited the page, the same
 * "second pair of eyes" property Finance's four-eyes approval enforces.
 */
class ContentPageWriter
{
    public static function create(array $data, int $createdBy): ContentPage
    {
        return DB::transaction(function () use ($data, $createdBy) {
            $page = ContentPage::create([
                'slug' => $data['slug'] ?? Str::slug($data['title']),
                'title' => $data['title'],
                'content' => $data['content'],
                'status' => 'Draft',
                'created_by' => $createdBy,
                'updated_by' => $createdBy,
            ]);

            self::logRevision($page, $createdBy);

            return $page;
        });
    }

    public static function update(ContentPage $page, array $data, int $updatedBy): ContentPage
    {
        return DB::transaction(function () use ($page, $data, $updatedBy) {
            $page->update([
                'title' => $data['title'],
                'content' => $data['content'],
                'updated_by' => $updatedBy,
            ]);

            self::logRevision($page, $updatedBy);

            return $page->fresh();
        });
    }

    public static function advance(ContentPage $page, User $actor): ContentPage
    {
        $next = ContentPage::NEXT_STATUS[$page->status] ?? null;
        if (! $next) {
            throw new InvalidArgumentException("{$page->status} has no next stage.");
        }

        if ($page->status === 'In Review' && $page->updated_by === $actor->id) {
            throw new InvalidArgumentException('Approval needs a second person — you cannot approve a page you last edited.');
        }

        return DB::transaction(function () use ($page, $next, $actor) {
            $page->update([
                'status' => $next,
                'updated_by' => $actor->id,
                'published_at' => $next === 'Published' ? now() : $page->published_at,
            ]);

            self::logRevision($page, $actor->id);

            return $page->fresh();
        });
    }

    public static function sendBackToDraft(ContentPage $page, User $actor, ?string $reason = null): ContentPage
    {
        return DB::transaction(function () use ($page, $actor, $reason) {
            $page->update(['status' => 'Draft', 'updated_by' => $actor->id]);

            self::logRevision($page, $actor->id, $reason);

            return $page->fresh();
        });
    }

    private static function logRevision(ContentPage $page, int $changedBy, ?string $note = null): void
    {
        $page->revisions()->create([
            'title' => $page->title,
            'content' => $note ? $page->content."\n\n[Sent back: {$note}]" : $page->content,
            'status' => $page->status,
            'changed_by' => $changedBy,
        ]);
    }
}
