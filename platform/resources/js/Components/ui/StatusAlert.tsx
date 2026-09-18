import type { ReactNode } from 'react';
import { AlertTriangle, CheckCircle2, Info, XCircle } from 'lucide-react';

type Status = 'breached' | 'at-risk' | 'pending' | 'on-track' | 'info';

const config: Record<Status, { icon: typeof Info; label: string; color: string }> = {
    breached: { icon: XCircle, label: 'Breached', color: 'var(--color-status-breached)' },
    'at-risk': { icon: AlertTriangle, label: 'At risk', color: 'var(--color-status-at-risk)' },
    pending: { icon: AlertTriangle, label: 'Pending', color: 'var(--color-status-pending)' },
    'on-track': { icon: CheckCircle2, label: 'On track', color: 'var(--color-status-on-track)' },
    info: { icon: Info, label: 'Info', color: 'var(--color-status-info)' },
};

/**
 * Status is never conveyed by color alone — every use pairs the
 * semantic color with an icon and a text label (Architecture Phase 8
 * Section 9: "semantic status colors must not be color-only").
 */
export function StatusAlert({ status, children }: { status: Status; children: ReactNode }) {
    const { icon: Icon, label, color } = config[status];

    return (
        <div
            role="status"
            className="flex items-start gap-3 rounded-md border p-3 text-sm"
            style={{ borderColor: color, color }}
        >
            <Icon aria-hidden className="mt-0.5 h-4 w-4 shrink-0" />
            <div>
                <span className="sr-only">{label}: </span>
                {children}
            </div>
        </div>
    );
}
