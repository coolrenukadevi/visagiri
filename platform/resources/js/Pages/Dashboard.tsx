import { AppShell } from '@/Layouts/AppShell';
import { Card } from '@/Components/ui/Card';
import { StatusAlert } from '@/Components/ui/StatusAlert';
import { EmptyState } from '@/Components/ui/States';
import { Button } from '@/Components/ui/Button';

/**
 * Foundation proof-of-life page only — not a business dashboard.
 * Architecture Phase 8/Wave 1 explicitly forbids building CRM/Visa/
 * Finance/HRMS screens in this wave; this page exists to demonstrate
 * the application shell, design tokens, and state components work
 * end-to-end, nothing more.
 */
export default function Dashboard() {
    return (
        <AppShell title="Foundation">
            <div className="mx-auto flex max-w-2xl flex-col gap-6">
                <Card>
                    <h2 className="mb-2 text-base font-semibold">Wave 1 Foundation</h2>
                    <p className="text-sm text-[--color-text-muted]">
                        Application shell, design tokens, and state components are wired up. Domain screens
                        (Enquiries, Visa, Forex, HRMS, …) are deferred to a later, separately approved wave.
                    </p>
                </Card>

                <StatusAlert status="info">
                    Database-dependent features are deferred — PostgreSQL 18.x is not yet available in this
                    environment.
                </StatusAlert>

                <Card>
                    <EmptyState
                        title="No business data yet"
                        description="This foundation intentionally has no domain records — those are built in a later, separately approved wave."
                        action={
                            <Button variant="secondary" disabled>
                                Nothing to do here yet
                            </Button>
                        }
                    />
                </Card>
            </div>
        </AppShell>
    );
}
