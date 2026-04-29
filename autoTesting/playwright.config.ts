import { defineConfig } from '@playwright/test';
import path from 'path';

export default defineConfig({

  reporter: [['html', { open: 'never' }]],

  globalSetup: './auth.setup.ts',


  use: {
    browserName: 'chromium',
    channel: 'msedge',
    baseURL: 'http://ec2-16-16-195-24.eu-north-1.compute.amazonaws.com/',
    storageState: 'storage/storageState.json',
    trace: 'retain-on-failure',
  },
});
