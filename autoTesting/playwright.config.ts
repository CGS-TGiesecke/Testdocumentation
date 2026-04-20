import { defineConfig } from '@playwright/test';
import path from 'path';

export default defineConfig({

  reporter: [['html', { open: 'never' }]],

  globalSetup: './auth.setup.ts',


  use: {
    browserName: 'chromium',
    channel: 'msedge',
    baseURL: 'https://cgs-assist-qs.germanywestcentral.cloudapp.azure.com/',
    storageState: 'storage/storageState.json',
    trace: 'retain-on-failure',
  },
});
