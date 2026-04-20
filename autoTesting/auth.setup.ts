import { test as setup } from '@playwright/test';

setup('authenticate with Entra ID using Edge', async ({ browser }) => {
  // ✅ Edge explizit auswählen
  const context = await browser.newContext({
    channel: 'msedge',
  });

  const page = await context.newPage();

  // Starte die App → Redirect zu Entra ID passiert automatisch
  await page.goto('https://cgs-assist-qs.germanywestcentral.cloudapp.azure.com/');

  /**
   * 👉 HIER passiert der Entra-ID-Login
   * - Benutzername
   * - Passwort
   * - MFA (falls aktiv)
   *
   * Du kannst das:
   * ✅ komplett manuell tun (empfohlen)
   * ✅ oder halb-automatisch
   */

  // Warten bis die App eingeloggt ist
  await page.waitForURL('**');
  await expect(page.locator('text=Portal')).toBeVisible();

  // ✅ Auth-State speichern
  await context.storageState({
    path: 'storage/storageState.json',
  });

  await browser.close();
}

export default globalSetup;
