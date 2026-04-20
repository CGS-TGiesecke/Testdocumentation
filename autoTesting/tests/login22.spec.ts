
import { test, expect } from '@playwright/test';

test('Login wird angezeigt', async ({ page }) => {
  await page.goto('/');

  await expect(
    page.getByText('Portal')
  ).toBeVisible();
});
