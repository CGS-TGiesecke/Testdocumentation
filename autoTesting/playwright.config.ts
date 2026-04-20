import { defineConfig } from '@playwright/test';
import path from 'path';

export default defineConfig({
  globalSetup: path.resolve(__dirname, './auth.setup'),
  reporter: [['html', { outputFolder: 'autoTesting/playwright-report' }]],
  
  use: {
    browserName: 'chromium',
    channel: 'msedge',
    baseURL: 'https://cgs-assist-qs.germanywestcentral.cloudapp.azure.com/',
    storageState: 'storage/storageState.json',
    trace: 'retain-on-failure',
  },
});
