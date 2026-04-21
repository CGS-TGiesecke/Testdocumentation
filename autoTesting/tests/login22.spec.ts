
import { test, expect } from '@playwright/test';


test('Startseite wird angezeigt', async ({ page }) => {

  await page.goto('/');

  page.on("dialog", async (dialog) => {

    expect(dialog.type()).toContain("confirm");
    expect(dialog.message()).toContain("Confirmation required");
    await dialog.accept(); // Click OK
  });

  await page.getByRole('button', { name: 'OK' }).click();
  await page.waitForTimeout(3000);


  await expect('link', { name: 'Automation' }).toBeVisible();

  await page.getByRole('link', { name: 'Automation' }).click();

  await page.waitForURL('**/automation');

  await expect(page.getByText('Automated Use Cases')).toBeVisible();

});
