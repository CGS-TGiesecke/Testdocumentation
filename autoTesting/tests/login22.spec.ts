
import { test, expect } from '@playwright/test';

test('Startseite wird angezeigt', async ({ page }) => {

  await page.goto('/');

  await expect( page.getByText('Confirmation required')).toBeVisible();

  await expect('button', { name: 'OK' }).toBeVisible();

  await page.getByRole('button', { name: 'OK' }).click();

  await expect('link', { name: 'Automation' }).toBeVisible();

  await page.getByRole('link', { name: 'Automation' }).click();

  await page.waitForURL('**/automation');

  await expect(page.getByText('Automated Use Cases')).toBeVisible();

});
