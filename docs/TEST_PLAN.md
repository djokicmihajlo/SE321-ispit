# SE321 Dokumentacija - Plan testiranja Auto Parts aplikacije

## 1. Osnovni podaci
**Naziv projekta:** Auto Parts Shop
**Predmet:** SE321 - Obezbeđenje kvaliteta, testiranje i evolucija softvera
**Glavni cilj:** Uspostavljanje celokupnog QA sloja, automatizovanog testiranja (Frontend, Backend, E2E) i osiguranje stabilnosti aplikacije pre puštanja u rad.

## 2. Test strategija
Testiranje je podeljeno na više nivoa kako bi se obezbedila potpuna stabilnost:

| Nivo | Alati | Svrha |
|---|---|---|
| **Jedinično (Unit)** | JUnit 5, Mockito | Provera izolovane poslovne logike (npr. `OrderService`), uz mock-ovanje zavisnosti. |
| **Integraciono (Backend)** | Spring Boot Test, MockMvc | Provera Express/Spring REST API-ja i integracije sa MySQL bazom podataka. |
| **Frontend (Komponente)**| Vitest, React Testing Library, MSW | Provera React komponenti, formi, korisničkih interakcija i simulacija API poziva. |
| **End-to-end (E2E)** | Playwright, Chromium | Provera glavnih korisničkih tokova kroz stvarni brauzer. |
| **Regresiono testiranje** | npm scripts | Provera da nove izmene ne kvare postojeće funkcionalnosti. |

## 3. Plan testiranja

### 3.1 Cilj testiranja
Cilj je da se proveri stabilnost postojeće prodavnice auto delova kroz automatizovani QA proces. Testiranjem se proverava da li ključne funkcionalnosti (katalog, korpa, poručivanje, autentifikacija, obrada porudžbina) rade ispravno.

### 3.2 Opseg testiranja
**U opsegu testiranja su:**
- frontend komponente, forme, state management (Context API)
- backend REST API rute (Spring Boot)
- MySQL integracija kroz lokalnu bazu
- glavni korisnički tokovi kroz browser (E2E)
- regresioni test paket

**Van opsega su:**
- produkcioni deployment na cloud platformu
- provera stvarnih naplata karticom (koristi se mock)
- slanje pravih email/SMS poruka (koristi se mock)
- kompletno performance/load testiranje

### 3.3 Test okruženje
Lokalno test okruženje koristi:
- Java 17+ (Spring Boot backend)
- Node.js 20+ (React/Vite frontend)
- MySQL 8.0+ (MAMP ili lokalni servis)

Za testiranje se koriste posebne baze kako se ne bi oštetili podaci za razvoj:
- **Razvojna baza:** `auto_parts_shop_dev`
- **Testna baza:** `auto_parts_shop_test`

### 3.4 Ulazni i izlazni kriterijumi
**Ulazni kriterijumi:**
- backend može da se poveže na bazu
- frontend build uspešno prolazi
- aplikacija se uspešno podiže na portovima 8080 i 5173

**Izlazni kriterijumi:**
- svi frontend testovi prolaze
- svi backend (Unit i API) testovi prolaze
- svi E2E testovi prolaze
- coverage rezultati su na zadovoljavajućem nivou (preko 80%)

### 3.5 Rizici i mere ublažavanja
| Rizik | Uticaj | Mera |
|---|---|---|
| Testovi slučajno brišu razvojne podatke | Visok | Striktno korišćenje `auto_parts_shop_test` baze u test profilima. |
| E2E testovi pucaju usled sporog mrežnog odziva | Srednji | Povećati timeout u Playwright konfiguraciji i koristiti stabilne selektore. |
| Frontend testovi postaju krhki zbog CSS izmena | Srednji | Korišćenje `getByRole` i semantičkog HTML-a umesto CSS klasa. |

## 4. Osnovni test scenariji

Definisano je preko 60 test scenarija. Izdvajamo ključne:

| ID | Modul | Scenario | Tip |
|---|---|---|---|
| TS-001 | Auth | Registracija klijenta sa validnim podacima | Pozitivan |
| TS-002 | Auth | Login sa pogrešnom lozinkom | Negativan |
| TS-003 | Catalog | Pretraga artikala po filterima | Pozitivan |
| TS-004 | Catalog | Dugme "Obavesti me" šalje request kad nema zaliha | Pozitivan |
| TS-005 | Catalog | Pad API-ja prikazuje grešku korisniku | Negativan |
| TS-006 | Cart | Dodavanje dostupnog artikla u korpu | Pozitivan |
| TS-007 | Order (Unit) | `createOrder` sa praznom korpom (Mockito) | Negativan |
| TS-008 | Order (API) | Dozvoljen statusni prelaz (CREATED -> PROCESSING) | Pozitivan |
| TS-009 | Order (API) | Nedozvoljen statusni prelaz (DELIVERED -> CREATED) | Negativan |
| TS-010 | E2E | Kompletan proces od dodavanja u korpu do porudžbine | Pozitivan |
