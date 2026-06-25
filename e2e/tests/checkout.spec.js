import { test, expect } from '@playwright/test'

test.describe('Kupovina i procesuiranje', () => {
  test('Ceo tok od porucivanja do zaposlenog', async ({ page, browser }) => {
    const uniqueEmail = `kupac${Date.now()}@test.com`

    // === 1. Registracija ===
    await page.goto('/register')
    await page.getByLabel('Ime', { exact: true }).fill('Test')
    await page.getByLabel('Prezime').fill('Kupac')
    await page.getByLabel('Email').fill(uniqueEmail)
    await page.getByLabel('Lozinka', { exact: true }).fill('Sifra123!')
    await page.getByLabel('Potvrdite lozinku').fill('Sifra123!')
    await page.getByRole('button', { name: 'Registruj se' }).click()
    await expect(page.getByText('Test Kupac')).toBeVisible()

    // === 2. Dodavanje u korpu ===
    await page.getByRole('link', { name: 'Pregled kataloga' }).click()
    await expect(page.getByRole('heading', { name: 'Katalog artikala' })).toBeVisible()
    
    // Trazimo "Filter ulja"
    await page.getByPlaceholder('Pretraga po nazivu...').fill('Filter ulja')
    await page.getByRole('button', { name: 'Trazi' }).click()
    
    // Klik na dodaj u korpu bas za taj artikal
    page.on('dialog', dialog => dialog.accept()) // Automatski prihvati window.alert
    const filterUljaCard = page.locator('article').filter({ hasText: 'Filter ulja' }).first()
    await filterUljaCard.getByRole('button', { name: 'Dodaj u korpu' }).click()
    
    // === 3. Checkout ===
    await page.getByRole('link', { name: 'Korpa', exact: true }).click()
    await expect(page.getByText('Filter ulja')).toBeVisible()
    await page.getByRole('link', { name: 'Nastavi na placanje' }).click()
    
    // Popuni formu za checkout
    await page.getByLabel('Ime i prezime').fill('Test Kupac')
    await page.getByLabel('Telefon').fill('123456')
    await page.getByLabel('Email').fill(uniqueEmail)
    await page.getByLabel('Adresa (ulica i broj)').fill('Glavna 1')
    await page.getByLabel('Grad').fill('Beograd')
    await page.getByLabel('Postanski broj').fill('11000')
    
    await page.getByRole('button', { name: 'Zavrsi porudzbinu' }).click()

    // === 4. Provera na "Moje porudzbine" ===
    await expect(page.getByRole('heading', { name: 'Moje porudzbine' })).toBeVisible()
    await page.screenshot({ path: 'orders_page.png', fullPage: true })
    await expect(page.getByText('CREATED')).toBeVisible()
    await expect(page.getByText('Filter ulja x 1')).toBeVisible()

    // === 5. Prijava kao Zaposleni ===
    // Odjavi se pa prijavi
    await page.getByRole('button', { name: 'Odjavi se' }).click()
    await page.getByRole('link', { name: 'Prijava' }).click()
    await page.getByLabel('Email').fill('employee@autodelovi.test')
    await page.getByLabel('Lozinka').fill('Password1!') // Prema seed podacima, pass is Password1!
    await page.getByRole('button', { name: 'Prijavi se' }).click()

    await expect(page.getByText('Employee User')).toBeVisible()

    // Odi na porudzbine
    await page.getByRole('link', { name: 'Porudzbine' }).click()
    await expect(page.getByRole('heading', { name: 'Sve porudzbine (Zaposleni)' })).toBeVisible()
    
    // Pronadji red sa ovim klijentom
    const orderRow = page.locator('tr').filter({ hasText: uniqueEmail })
    await expect(orderRow).toBeVisible()

    // Promeni status iz PENDING u PROCESSING
    await orderRow.locator('select').selectOption('PROCESSING')
    // Sacekamo malko jer alert skace
  })
})
