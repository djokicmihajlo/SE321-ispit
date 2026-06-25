# SE321 Dokumentacija - Rezultati testiranja Auto Parts aplikacije

## 1. Frontend testiranje

Frontend testovi su napisani pomoću:
- Vitest
- React Testing Library
- Mock Service Worker (MSW)
- `@vitest/coverage-v8`

**Frontend test komanda:**
```bash
npm run test:frontend
```
Ili direktno iz korenskog direktorijuma:
```bash
cd frontend && npm run test
```

### 1.1 Frontend test fajlovi
Frontend testovi su raspoređeni po komponentama, servisima i glavnim tokovima.

**Fajlovi:**
- `src/App.test.jsx`
- `src/__tests__/auth.test.jsx`
- `src/__tests__/catalog.test.jsx`
- `src/__tests__/employee-admin.test.jsx`

**Ukupno:**
- 4 frontend test fajlova
- 20 frontend testova

### 1.2 Šta je testirano na frontendu
- Renderovanje zaštićenih ruta.
- Autentifikacioni tokovi (prijava, odjava, redirekcija neprijavljenih).
- Katalog i filtriranje (uspešan fetch preko MSW-a).
- Korpa (dodavanje artikla u korpu).
- "Obavesti me" tok (prikaz i podnošenje email forme).
- Rad u uslovima pada mreže (API errors).

### 1.3 Frontend coverage
Poslednji zabeleženi rezultat:

| Metrika | Pokrivenost |
|---|---|
| Izvršeni testovi | 20 / 20 (100%) |
| Lines (Linije koda) | 64.31% |
| Statements (Naredbe) | 62.88% |
| Functions (Funkcije) | 58.18% |
| Branches (Grane) | 54.62% |

## 2. Backend testiranje

Backend testovi su napisani pomoću:
- JUnit 5
- Mockito (za izolovane Unit testove)
- Spring Boot Test + MockMvc (za integracione API testove)
- JaCoCo (za pokrivenost koda)

**Backend test komanda:**
```bash
cd backend && ./mvnw test
```

**Generisanje coverage izveštaja:**
```bash
cd backend && ./mvnw test jacoco:report
```

### 2.1 Backend test fajlovi
Testovi su podeljeni na Unit (izolovane) i Integracione (sa bazom).

**Glavni backend test fajlovi:**
- `AutoPartsBackendApplicationTests.java`
- `RestockNotificationApiTests.java`
- `PartApiTests.java`
- `SpecialOrderApiTests.java`
- `CartApiTests.java`
- `AuthApiTests.java`
- `OrderApiTests.java`
- `OrderServiceUnitTests.java` (Mockito Unit Test)

**Ukupno:**
- 8 backend test klasa
- 38 backend testova

### 2.2 Šta je testirano na backendu
- Kreiranje, verifikacija i procesuiranje porudžbina (sa i bez mock-ova).
- Validacija JWT tokena, rola korisnika (`ADMIN`, `EMPLOYEE`, `CLIENT`).
- Validacija poslovne logike i manipulacija zalihama.
- Zabrana nelegalnih statusnih prelaza porudžbina.

### 2.3 Backend coverage
Poslednji zabeleženi rezultat (JaCoCo):

| Metrika | Pokrivenost |
|---|---|
| Analizirane klase | 74 |
| Instructions (Instrukcije) | 3475 / 3846 (90.35%) |

*Zaključak:* Backend ima odličnu pokrivenost koda od **90.35%**, što prelazi očekivani minimum za stabilan razvoj (80%).

## 3. End-to-end testiranje

E2E testovi su napisani pomoću Playwright-a.

**E2E test komanda:**
```bash
npm run test:e2e
```

### 3.1 E2E test fajlovi
- `e2e/checkout.spec.js`
- `e2e/auth.spec.js`

**Ukupno:**
- 2 E2E test toka (pokrivaju od početka do kraja aplikaciju)

### 3.2 Šta je testirano
1. Registracija klijenta, dodavanje artikala u korpu i naručivanje.
2. Logovanje zaposlenog i manipulacija narudžbinom (kreiranje -> obrada -> isporuka).

## 4. Regresiono testiranje

Regresioni testovi proveravaju da nova izmena nije pokvarila prethodno ispravne funkcionalnosti.

**Kompletna regresija:**
```bash
npm run test:regression
```
Ova komanda na klik pokreće:
1. Backend Unit i API testove (`mvnw test`).
2. Frontend komponentne testove (`npm run test`).
3. Frontend produkcioni build (`npm run build`).
4. Playwright E2E testove nad build-ovanim projektom.

## 5. Zaključak

SE321 deo projekta je nadogradio postojeću Auto Parts aplikaciju kompletnim QA slojem.

**Najvažniji rezultati:**
- plan testiranja je definisan i uspešno ispunjen.
- napisani su frontend testovi uz Mock Service Worker (MSW).
- napisani su backend API (integracioni) testovi uz lokalnu MySQL test bazu.
- napisani su backend Unit testovi uz Mockito (izolovani).
- napisani su Playwright E2E testovi.
- dodata je objedinjena regresiona komanda.
- izveštaji o pokrivenosti koda su dokumentovani (preko 90%).

**Ključni brojevi:**

| Oblast | Rezultat |
|---|---|
| Frontend testovi | 4 fajla, 20 testova |
| Backend testovi | 8 fajlova, 38 testova |
| E2E testovi | 2 fajla, 2 duga toka |
| Backend instrukcijski coverage | 90.35% |
| **Ukupno prolaženje testova** | **60 / 60 (100% SUCCESS)** |

Ovim je aplikacija dobila automatizovan sistem provere kvaliteta koji olakšava dalji razvoj i drastično smanjuje rizik da nove izmene naruše postojeće poslovne tokove i funkcionalnosti.
