
import { test, expect } from '@playwright/test';

test('Startseite wird angezeigt', async ({ page }) => {

  await page.goto('/');

  await expect(
    page.getByText('Portal')
  ).toBeVisible();

  await page.getByRole('link', { name: 'Automation' }).click();

  await page.goto('/automation');

});
