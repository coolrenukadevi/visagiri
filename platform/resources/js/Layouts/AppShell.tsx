import { useState, type ReactNode } from 'react';
import { LayoutDashboard, Menu, X } from 'lucide-react';

interface NavItem {
    label: string;
    href: string;
    icon: typeof LayoutDashboard;
}

// Wave 1 exposes only foundation-level navigation. Later-domain items
// (Enquiries, Visa, Forex, HRMS, ...) are added per Architecture Phase
// 8's wave plan, not invented here (Section 6/22: no new top-level
// modules, no navigation ahead of what's actually built).
const navItems: NavItem[] = [{ label: 'Dashboard', href: '/', icon: LayoutDashboard }];

/**
 * Responsive shell: a real sidebar on desktop, a slide-over on mobile
 * — not a compressed copy of the desktop layout (Architecture Phase 8
 * Section 9/21: "mobile must not simply be a shrunken desktop").
 * Navigation visibility here is a UI convenience only; the server-side
 * permission middleware is the actual authorization boundary
 * (Architecture Phase 5: UI hiding is never security).
 */
export function AppShell({ title, children }: { title: string; children: ReactNode }) {
    const [mobileNavOpen, setMobileNavOpen] = useState(false);

    return (
        <div className="min-h-screen bg-[--color-surface-muted] text-[--color-text]">
            <a href="#main-content" className="sr-only focus:not-sr-only focus:absolute focus:left-2 focus:top-2 focus:z-50 focus:rounded focus:bg-[--color-brand] focus:px-3 focus:py-2 focus:text-white">
                Skip to content
            </a>

            <div className="flex min-h-screen">
                <aside className="hidden w-60 shrink-0 border-r border-[--color-border] bg-[--color-surface] md:block">
                    <SidebarContent />
                </aside>

                {mobileNavOpen && (
                    <div className="fixed inset-0 z-40 md:hidden">
                        <div className="absolute inset-0 bg-black/40" onClick={() => setMobileNavOpen(false)} aria-hidden />
                        <div role="dialog" aria-modal="true" aria-label="Navigation" className="relative z-50 h-full w-64 bg-[--color-surface] shadow-lg">
                            <div className="flex items-center justify-between p-4">
                                <span className="font-semibold">Menu</span>
                                <button
                                    onClick={() => setMobileNavOpen(false)}
                                    aria-label="Close navigation"
                                    className="rounded p-1 hover:bg-[--color-surface-muted] focus-visible:outline focus-visible:outline-2 focus-visible:outline-[--color-brand]"
                                >
                                    <X className="h-5 w-5" aria-hidden />
                                </button>
                            </div>
                            <SidebarContent />
                        </div>
                    </div>
                )}

                <div className="flex min-w-0 flex-1 flex-col">
                    <header className="flex items-center gap-3 border-b border-[--color-border] bg-[--color-surface] px-4 py-3 md:px-6">
                        <button
                            onClick={() => setMobileNavOpen(true)}
                            aria-label="Open navigation"
                            className="rounded p-1 hover:bg-[--color-surface-muted] focus-visible:outline focus-visible:outline-2 focus-visible:outline-[--color-brand] md:hidden"
                        >
                            <Menu className="h-5 w-5" aria-hidden />
                        </button>
                        <h1 className="text-lg font-semibold">{title}</h1>
                    </header>

                    <main id="main-content" className="flex-1 p-4 md:p-6">
                        {children}
                    </main>
                </div>
            </div>
        </div>
    );
}

function SidebarContent() {
    return (
        <nav aria-label="Primary" className="flex flex-col gap-1 p-4">
            {navItems.map(({ label, href, icon: Icon }) => (
                <a
                    key={href}
                    href={href}
                    className="flex items-center gap-3 rounded-md px-3 py-2 text-sm font-medium text-[--color-text] hover:bg-[--color-surface-muted] focus-visible:outline focus-visible:outline-2 focus-visible:outline-[--color-brand]"
                >
                    <Icon className="h-4 w-4" aria-hidden />
                    {label}
                </a>
            ))}
        </nav>
    );
}
