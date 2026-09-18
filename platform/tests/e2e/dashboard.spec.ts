import { test, expect } from '@playwright/test';

/**
 * Foundation smoke test: the app shell actually renders in a real
 * browser, the sidebar/mobile nav pattern works, and no console
 * errors occur. Domain-page E2E coverage is added per later,
 * separately approved waves.
 */
test.describe('Foundation shell', () => {
    test('renders the dashboard page with navigation', async ({ page }) => {
        const errors: string[] = [];
        page.on('pageerror', (err) => errors.push(err.message));

        await page.goto('/');

        await expect(page.getByRole('heading', { name: 'Foundation', exact: true })).toBeVisible();
        await expect(page.getByRole('navigation', { name: 'Primary' }).getByText('Dashboard')).toBeVisible();

        expect(errors).toEqual([]);
    });

    test('mobile viewport shows a hamburger toggle instead of the desktop sidebar', async ({ page }) => {
        await page.setViewportSize({ width: 375, height: 812 });
        await page.goto('/');

        await expect(page.getByRole('button', { name: 'Open navigation' })).toBeVisible();

        await page.getByRole('button', { name: 'Open navigation' }).click();
        await expect(page.getByRole('dialog', { name: 'Navigation' })).toBeVisible();
    });
});
