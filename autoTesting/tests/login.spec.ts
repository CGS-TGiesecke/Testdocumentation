import { test, expect } from '@playwright/test';

test.describe('Validierung Login', () => {

	test.beforeEach(async ({ page }) => {
	  
		await page.goto('http://cgs-assist-demo-arc.westeurope.cloudapp.azure.com:8000/login');
	
	});

	test('Login wird angezeigt', async ({ page }) => {
	
		await expect(page.getByRole('heading', { name: 'ARC AI Audit Assist'})).toBeVisible();
  
	});

	test('Login ohne name und ohne pwd', async ({ page }) => {
	
  //await page.goto('http://cgs-assist-demo-arc.westeurope.cloudapp.azure.com:8000/login');
	
		await page.getByRole('textbox', { name: 'Enter username' }).fill('');

		await page.getByRole('button', { name: 'Login' }).click();

		const password = page.locator('#username');

		await expect(page.locator('#username:invalid')).toBeVisible();


	});

	test('Login mit name und ohne pwd', async ({ page }) => {
	
  // await page.goto('http://cgs-assist-demo-arc.westeurope.cloudapp.azure.com:8000/login');
	
		await page.getByRole('textbox', { name: 'Enter username' }).fill('Tester');
  
		await page.getByRole('textbox', { name: 'Enter password'}).fill('');

		await page.getByRole('button', { name: 'Login' }).click();

		const password = page.locator('#password');

		await expect(page.locator('#password:invalid')).toBeVisible();

	});

	test('Login mit name und mit pwd, aber nicht erlaubt', async ({ page }) => {
	
 // await page.goto('http://cgs-assist-demo-arc.westeurope.cloudapp.azure.com:8000/login');
	
		await page.getByRole('textbox', { name: 'Enter username' }).fill('Tester');
  
		await page.getByRole('textbox', { name: 'Enter password'}).fill('123');

		await page.getByRole('button', { name: 'Login' }).click();

		await page.getByText('Error').highlight();

	});

});


