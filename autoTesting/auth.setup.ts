import { chromium } from '@playwright/test';
import path from 'path';

async function globalSetup() {

    const headless = process.env.CI === 'true';
  // ✅ Edge starten
  const browser = await chromium.launch({
    channel: 'msedge',
    headless, 
  });

  const context = await browser.newContext();
  const page = await context.newPage();

  // App öffnen → Redirect zu Entra ID
  await page.goto('https://cgs-assist-qs.germanywestcentral.cloudapp.azure.com/');

  /**
   * - normal mit Entra ID anmelden
   * - MFA / "Angemeldet bleiben?" erlauben
   */

  // ✅ Warten bis Login abgeschlossen ist
  await page.waitForSelector('text=Portal');

  // ✅ Storage State speichern
  await context.storageState({
    path: path.resolve(__dirname, 'storage/storageState.json'),
  });

  await browser.close();
}

export default globalSetup;
