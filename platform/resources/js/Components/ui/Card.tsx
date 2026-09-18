import type { ReactNode } from 'react';

export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
    return (
        <div
            className={[
                'rounded-lg border border-[--color-border] bg-[--color-surface] p-4 sm:p-6',
                className,
            ].join(' ')}
        >
            {children}
        </div>
    );
}
