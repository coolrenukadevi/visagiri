import { forwardRef, type ButtonHTMLAttributes } from 'react';

type Variant = 'primary' | 'secondary' | 'danger';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
    variant?: Variant;
}

const variantClasses: Record<Variant, string> = {
    primary: 'bg-[--color-brand] text-white hover:bg-[--color-brand-hover]',
    secondary: 'bg-transparent text-[--color-text] border border-[--color-border] hover:bg-[--color-surface-muted]',
    danger: 'bg-[--color-status-breached] text-white hover:opacity-90',
};

/** One button component, one set of variants — no per-page one-off button styles. */
export const Button = forwardRef<HTMLButtonElement, ButtonProps>(function Button(
    { variant = 'primary', className = '', disabled, ...props },
    ref,
) {
    return (
        <button
            ref={ref}
            disabled={disabled}
            className={[
                'inline-flex items-center justify-center gap-2 rounded-md px-4 py-2 text-sm font-medium',
                'transition-colors focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[--color-brand]',
                'disabled:cursor-not-allowed disabled:opacity-50',
                variantClasses[variant],
                className,
            ].join(' ')}
            {...props}
        />
    );
});
