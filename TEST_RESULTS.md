# Izveštaj o rezultatima testiranja

**Projekat:** Prodavnica auto delova (SE321 ispit)  
**Datum izvršavanja:** 25. jun 2026, 19:14–19:15h  
**Izvršio:** Automatizovano pokretanje svih test nivoa  

---

## 1. Sumarni rezultat

| Kategorija testova | Alat | Ukupno testova | Prošlo ✅ | Palo ❌ | Preskočeno ⏭️ | Vreme |
|---|---|---|---|---|---|---|
| Backend integracioni (REST API) i Unit (Mockito) | JUnit 5 + Mockito + MockMvc | 38 | 38 | 0 | 0 | 12.77s |
| Frontend unit/integracioni (MSW) | Vitest + React Testing Library | 20 | 20 | 0 | 0 | 1.72s |
| Frontend produkcioni build | Vite | — | ✅ | — | — | 0.16s |
| E2E (browser simulacija) | Playwright + Chromium | 2 | 2 | 0 | 0 | 8.9s |
| **UKUPNO** | | **60** | **60** | **0** | **0** | **~24s** |

> **Rezultat: SVE PROLAZI ✅ — 60/60 testova prošlo bez grešaka.**

---

## 2. Backend testovi — detalji

**Komanda:** `cd backend && ./mvnw test`  
**Baza podataka:** `auto_parts_shop_test` (MySQL 8.0.40 preko MAMP-a, port 8889)  
**Framework:** Spring Boot Test + @AutoConfigureMockMvc + JaCoCo coverage  

### 2.1 Rezultati po test klasi

| Test klasa | Testova | Prošlo | Palo | Vreme |
|---|---|---|---|---|
| `AutoPartsBackendApplicationTests` | 1 | 1 | 0 | 0.45s |
| `RestockNotificationApiTests` | 5 | 5 | 0 | 0.84s |
| `PartApiTests` | 5 | 5 | 0 | 0.51s |
| `SpecialOrderApiTests` | 5 | 5 | 0 | 0.45s |
| `CartApiTests` | 3 | 3 | 0 | 0.66s |
| `OrderServiceUnitTests` (Mockito) | 5 | 5 | 0 | — |
| `AuthApiTests` | 5 | 5 | 0 | — |
| `OrderApiTests` | 9 | 9 | 0 | — |
| **Ukupno** | **38** | **38** | **0** | **~3.5s** (testovi) |

### 2.2 Pokriveni scenariji

| Domen | Šta se testira |
|---|---|
| **Autentifikacija** | Registracija klijenta, login sa validnim/nevalidnim kredencijalima, pristup zaštićenim rutama bez tokena, `/api/auth/me` hidracija |
| **Katalog artikala** | Prikaz svih artikala, pretraga po nazivu, filtriranje po kategoriji, pregled detalja artikla, employee CRUD (kreiranje, ažuriranje, brisanje) |
| **Korpa** | Dodavanje artikla u korpu, ažuriranje količine, uklanjanje stavke, prikaz korpe za ulogovanog klijenta |
| **Porudžbine** | Kreiranje porudžbine iz korpe, izračunavanje ukupne cene, umanjenje zaliha, pregled klijentskih porudžbina, employee pregled svih porudžbina, promena statusa porudžbine |
| **Obaveštenja** | Kreiranje zahteva za obaveštenje o dostupnosti (restock notification), validacija email/telefon podataka |
| **Specijalne porudžbine** | Kreiranje specijalnog zahteva, pregled od strane zaposlenog, promena statusa sa porukom |

### 2.3 JaCoCo coverage (Pokrivenost koda)

JaCoCo izveštaj je generisan i dostupan na lokaciji:  
`backend/target/site/jacoco/index.html`

- **Analizirano:** 74 klase
- **Pokrivenost instrukcija (Instructions covered):** 3475 / 3846
- **Ukupan procenat:** **90.35%** (Odličan nivo pokrivenosti celog Spring Boot bekenda)

---

## 3. Frontend testovi — detalji

**Komanda:** `cd frontend && npm run test`  
**Framework:** Vitest 4.1.9 + React Testing Library + MSW (Mock Service Worker)  

### 3.1 Rezultati po test fajlu

| Test fajl | Testova | Prošlo | Palo | Vreme |
|---|---|---|---|---|
| `src/App.test.jsx` | 5 | 5 | 0 | 263ms |
| `src/__tests__/auth.test.jsx` | 7 | 7 | 0 | 964ms |
| `src/__tests__/catalog.test.jsx` | 6 | 6 | 0 | 552ms |
| `src/__tests__/employee-admin.test.jsx` | 2 | 2 | 0 | 390ms |
| **Ukupno** | **20** | **20** | **0** | **~2.1s** |

### 3.2 Detalji po testu

#### `App.test.jsx` (5 testova)

| # | Naziv testa | Status |
|---|---|---|
| 1 | Prikazuje landing stranicu | ✅ |
| 2 | Prikazuje feature kartice | ✅ |
| 3 | Prikazuje placeholder rutu za specijalno poručivanje | ✅ |
| 4 | Prikazuje login stranu | ✅ |
| 5 | Prikazuje register stranu | ✅ |

#### `auth.test.jsx` (7 testova)

| # | Naziv testa | Status |
|---|---|---|
| 1 | Prikazuje login formu i salje zahtev | ✅ |
| 2 | Prikazuje gresku za nevalidne kredencijale | ✅ |
| 3 | Prikazuje register formu i salje zahtev | ✅ |
| 4 | Validira da se lozinke poklapaju | ✅ |
| 5 | Prikazuje gresku kada je email zauzet | ✅ |
| 6 | Preusmerava neautorizovane korisnike na login | ✅ |
| 7 | Prikazuje korisnicke podatke nakon hidracije | ✅ |

#### `catalog.test.jsx` (6 testova)

| # | Naziv testa | Status |
|---|---|---|
| 1 | Prikazuje listu artikala | ✅ |
| 2 | Prikazuje detalje artikla | ✅ |
| 3 | Pretrazuje artikle po nazivu | ✅ |
| 4 | Dodaje artikal u korpu sa uspesnom porukom | ✅ |
| 5 | Prikazuje poruku o grešci kada API nije dostupan | ✅ |
| 6 | Prikazuje opciju Obavesti me i uspešno šalje zahtev | ✅ |

#### `employee-admin.test.jsx` (2 testa)

| # | Naziv testa | Status |
|---|---|---|
| 1 | Prikazuje listu porudžbina za zaposlenog i menja status | ✅ |
| 2 | Prikazuje zaposlene za admina i kreira novog zaposlenog | ✅ |

---

## 4. Frontend produkcioni build

**Komanda:** `cd frontend && npm run build`  
**Framework:** Vite 8.1.0  

| Metrika | Vrednost |
|---|---|
| Status | ✅ Uspešno |
| Vreme kompajliranja | 158ms |
| Transformisano modula | 42 |
| `index.html` | 0.45 kB (gzip: 0.29 kB) |
| CSS bundle | 11.86 kB (gzip: 2.85 kB) |
| JS bundle | 274.28 kB (gzip: 83.42 kB) |

---

## 5. E2E testovi (Playwright) — detalji

**Komanda:** `cd e2e && npx playwright test`  
**Browser:** Chromium (headless)  
**Konfiguracija:** Playwright automatski podiže backend (Spring Boot na portu 8080) i frontend (Vite dev server na portu 5173)  

### 5.1 Rezultati

| Test fajl | Naziv testa | Status | Vreme |
|---|---|---|---|
| `tests/auth.spec.js` | Gost može da se registruje i prijavi | ✅ | ~3s |
| `tests/checkout.spec.js` | Ceo tok od poručivanja do zaposlenog | ✅ | ~6s |
| **Ukupno** | | **2/2 ✅** | **8.9s** |

### 5.2 Pokriveni E2E tokovi

#### Test 1: Autentifikacija (auth.spec.js)
1. Otvaranje pocetne stranice
2. Navigacija na registraciju
3. Popunjavanje forme (ime, prezime, email, telefon, lozinka)
4. Slanje registracije → automatski login
5. Verifikacija da je korisnik prijavljen (ime vidljivo u navigaciji)
6. Odjava
7. Ponovna prijava sa istim kredencijalima
8. Verifikacija ponovnog prijavljivanja

#### Test 2: Kupovina i procesuiranje (checkout.spec.js)
1. Registracija novog kupca
2. Navigacija na katalog
3. Pretraga artikla "Filter ulja"
4. Dodavanje u korpu
5. Navigacija na korpu → verifikacija da stavka postoji
6. Prelazak na checkout (popunjavanje kontakt i adresnih podataka)
7. Završavanje porudžbine
8. Verifikacija na "Moje porudžbine" (status CREATED, artikal vidljiv)
9. Odjava klijenta
10. Prijava kao zaposleni (employee@autodelovi.test)
11. Navigacija na employee porudžbine
12. Pronalaženje porudžbine po email-u klijenta
13. Promena statusa iz CREATED u PROCESSING

---

## 6. Mapiranje testova na TEST_PLAN.md zahteve

| TEST_PLAN ID | Zahtev | Pokriven testom | Status |
|---|---|---|---|
| IT-AUTH-02 | Registracija i login | `auth.test.jsx`, `auth.spec.js` | ✅ |
| IT-AUTH-01 | Neautorizovan pristup employee endpointu | `auth.test.jsx` (test 6) | ✅ |
| FE-PARTS-01 | Lista artikala | `catalog.test.jsx` (test 1) | ✅ |
| FE-PARTS-02 | Filteri | `catalog.test.jsx` (test 3) | ✅ |
| FE-CART-01 | Dodavanje u korpu | `catalog.test.jsx` (test 4) | ✅ |
| FE-NOTIFY-01 | Obavesti me (frontend tok) | `catalog.test.jsx` (test 6) | ✅ |
| FE-API-01 | API greška | `catalog.test.jsx` (test 5) | ✅ |
| FE-ORDER-01 | Slanje porudžbine | `checkout.spec.js` (koraci 5-7) | ✅ |
| FE-AUTH-01 | Login | `auth.test.jsx` (test 1) | ✅ |
| TS-01 | Registracija klijenta | `auth.spec.js` | ✅ |
| TS-02 | Prijavljivanje korisnika | `auth.spec.js`, `checkout.spec.js` | ✅ |
| TS-04 | Dodavanje artikla u korpu | `checkout.spec.js` (korak 4) | ✅ |
| TS-06 | Plaćanje pouzećem | `checkout.spec.js` (koraci 5-7) | ✅ |
| TS-09 | Obrada porudžbine od strane zaposlenog | `checkout.spec.js` (koraci 9-13) | ✅ |
| IT-CART-01 | Dodavanje u korpu (backend) | `CartApiTests` | ✅ |
| IT-NOTIFY-01 | Obavesti me | `RestockNotificationApiTests` | ✅ |

---

## 7. Zaključak

Sva četiri nivoa testiranja su uspešno izvršena bez ikakvih grešaka:

- **38 backend testova** (uključujući Unit testove sa Mockito framework-om i Integracione REST testove) pokrivaju autentifikaciju, katalog, korpu, porudžbine, obaveštenja i specijalne porudžbine sa **90.35%** linija koda pokrivenim.
- **20 frontend testova** pokrivaju renderovanje komponenti, korisničke interakcije, greške i komunikaciju sa backendom preko MSW mock servera.
- **Produkcioni build** se kompajlira uspešno sa optimizovanim bundle-om od ~83 kB (gzip).
- **2 E2E testa** pokrivaju kompletne korisničke tokove od registracije do obrade porudžbine, prolaze kroz ceo stek (Chromium → React → Spring Boot → MySQL).

**Projekat je stabilan i spreman za isporuku.**
