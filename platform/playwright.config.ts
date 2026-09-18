import { defineConfig, devices } from '@playwright/test';

/**
 * Playwright Test only — no other browser test runner (Architecture
 * Phase 8 Section 19/28). Runs against a locally-served instance of
 * this Foundation app only; never points at staging or production.
 */
export default defineConfig({
    testDir: './tests/e2e',
    fullyParallel: true,
    forbidOnly: !!process.env.CI,
    retries: process.env.CI ? 1 : 0,
    reporter: 'list',
    use: {
        baseURL: process.env.PLAYWRIGHT_BASE_URL ?? 'http://127.0.0.1:8877',
        trace: 'on-first-retry',
    },
    projects: [
        {
            name: 'chromium',
            use: {
                ...devices['Desktop Chrome'],
                launchOptions: {
                    executablePath: '/opt/pw-browsers/chromium',
                },
            },
        },
    ],
});
