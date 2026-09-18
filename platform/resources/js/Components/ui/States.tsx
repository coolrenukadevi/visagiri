import type { ReactNode } from 'react';
import { AlertCircle, Inbox, Loader2, ShieldOff } from 'lucide-react';

/** Deliberate loading state — never a blank screen while data resolves. */
export function LoadingState({ label = 'Loading…' }: { label?: string }) {
    return (
        <div role="status" aria-live="polite" className="flex items-center justify-center gap-2 py-12 text-[--color-text-muted]">
            <Loader2 aria-hidden className="h-5 w-5 animate-spin" />
            <span>{label}</span>
        </div>
    );
}

/** Deliberate empty state — no decorative illustration, just a clear reason and (optionally) an action. */
export function EmptyState({ title, description, action }: { title: string; description?: string; action?: ReactNode }) {
    return (
        <div className="flex flex-col items-center gap-2 py-12 text-center">
            <Inbox aria-hidden className="h-8 w-8 text-[--color-text-muted]" />
            <p className="font-medium text-[--color-text]">{title}</p>
            {description && <p className="max-w-sm text-sm text-[--color-text-muted]">{description}</p>}
            {action}
        </div>
    );
}

/** Deliberate system-error state, distinct from a validation error and from permission-denied. */
export function ErrorState({ message = 'Something went wrong. Please try again.' }: { message?: string }) {
    return (
        <div role="alert" className="flex flex-col items-center gap-2 py-12 text-center">
            <AlertCircle aria-hidden className="h-8 w-8" style={{ color: 'var(--color-status-breached)' }} />
            <p className="font-medium text-[--color-text]">{message}</p>
        </div>
    );
}

/** Explicit permission-denied state — never silently hidden, never a generic error. */
export function PermissionDeniedState() {
    return (
        <div role="alert" className="flex flex-col items-center gap-2 py-12 text-center">
            <ShieldOff aria-hidden className="h-8 w-8 text-[--color-text-muted]" />
            <p className="font-medium text-[--color-text]">You don&apos;t have permission to view this.</p>
        </div>
    );
}
