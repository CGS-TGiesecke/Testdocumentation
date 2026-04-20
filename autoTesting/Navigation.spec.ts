import { test, expect } from '@playwright/test';


test('Login wird angezeigt', async ({ page }) => {
  // ✅ Seite laden (nutzt baseURL aus config)
  await page.goto('/');

  // ✅ Überschrift prüfen
  await expect(
    page.getByRole('heading', { name: 'CGS Assist' })
  ).toBeVisible();

  // ✅ Portal-Text prüfen
  await expect(
    page.getByText('Portal')
  ).toBeVisible();
});



