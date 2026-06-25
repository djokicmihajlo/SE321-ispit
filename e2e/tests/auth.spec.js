import { test, expect } from '@playwright/test'

test.describe('Autentifikacija', () => {
  test('Gost moze da se registruje i prijavi', async ({ page }) => {
    await page.goto('/')

    // Idi na registraciju
    await page.getByRole('link', { name: 'Registracija' }).click()
    await expect(page.getByRole('heading', { name: 'Registracija' })).toBeVisible()

    const uniqueEmail = `noviklijent${Date.now()}@autodelovi.test`

    // Popuni formu
    await page.getByLabel('Ime', { exact: true }).fill('Novi')
    await page.getByLabel('Prezime').fill('Klijent')
    await page.getByLabel('Email').fill(uniqueEmail)
    await page.getByLabel('Telefon (opciono)').fill('+38165123456')
    await page.getByLabel('Lozinka', { exact: true }).fill('Sifra123!')
    await page.getByLabel('Potvrdite lozinku').fill('Sifra123!')
    
    // Submit
    await page.getByRole('button', { name: 'Registruj se' }).click()

    // Ocekujemo da nas baci na pocetnu i prikaze ime
    await expect(page.getByText('Novi Klijent')).toBeVisible()

    // Odjava
    await page.getByRole('button', { name: 'Odjavi se' }).click()
    await expect(page.getByRole('link', { name: 'Prijava' })).toBeVisible()

    // Ponovna prijava
    await page.getByRole('link', { name: 'Prijava' }).click()
    await page.getByLabel('Email').fill(uniqueEmail)
    await page.getByLabel('Lozinka').fill('Sifra123!')
    await page.getByRole('button', { name: 'Prijavi se' }).click()

    await expect(page.getByText('Novi Klijent')).toBeVisible()
  })
})
