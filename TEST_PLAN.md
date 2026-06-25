# SE321 Dokumentacija - Plan testiranja Auto Parts aplikacije

## 1. Osnovni podaci
**Naziv projekta:** Auto Parts Shop  
**Predmet:** SE321 - Obezbedjenje kvaliteta, testiranje i evolucija softvera

## 2. Cilj i obim testiranja

### 2.1 Cilj testiranja
Proveriti da aplikacija prodavnice auto delova ispravno podrzava registraciju i prijavljivanje korisnika, pretragu i filtriranje artikala, dodavanje u korpu, kreiranje i placanje porudzbina, opciju "Obavesti me", specijalno porucivanje, obradu porudzbina od strane zaposlenih i administraciju zaposlenih.

### 2.2 Funkcionalnosti koje se testiraju
- Registracija klijenta i prijavljivanje (klijent, zaposleni, administrator).
- Autorizacija po ulogama (CLIENT, EMPLOYEE, ADMIN).
- Pregled i filtriranje artikala po proizvodjacu, modelu, kategoriji i tekstu.
- Dodavanje artikala u korpu i upravljanje korpom.
- Kreiranje porudzbine i placanje (karticom ili pouzecem).
- Opcija "Obavesti me" za artikle koji nisu na stanju.
- Specijalno porucivanje delova koji ne postoje u katalogu.
- Obrada porudzbina od strane zaposlenog (promena statusa).
- Administracija zaposlenih od strane administratora.

### 2.3 Funkcionalnosti koje nisu obuhvacene testiranjem
- Stvarna naplata preko karticnog payment gateway-a (koristi se mock).
- Stvarno slanje email i SMS poruka (koristi se mock).
- Load/performance testiranje.
- Penetraciono testiranje.
- Testiranje na svim browserima i mobilnim uredjajima.

## 3. Vrste testiranja

### 3.1 Jedinicno testiranje (Unit Testing)
Provera izolovane poslovne logike bez prave baze podataka i bez podizanja Spring konteksta. Zavisnosti se simuliraju pomocu Mockito framework-a. Fokus je na `OrderService.createOrder()` metodi.

### 3.2 Integraciono testiranje
Provera komunikacije izmedju vise komponenti zajedno: Controller, Service, Repository i testna MySQL baza. Koristi se `@SpringBootTest` i `MockMvc`.

### 3.3 Testiranje REST API-ja
Provera ugovora izmedju frontenda i backenda. Za svaki endpoint se proveravaju HTTP status kodovi, JSON struktura odgovora, validacione poruke i autorizacija. Testira se pomocu `MockMvc`.

### 3.4 Testiranje React komponenti
Provera ponasanja koje korisnik moze da vidi ili izvrsi. Koriste se Vitest, React Testing Library i MSW. Ne testira se unutrasnja implementacija vec korisnicke interakcije, loading/error stanja i HTTP tokovi.

### 3.5 Sistemsko testiranje
Provera kompletne aplikacije u lokalnom okruzenju: React frontend salje HTTP zahteve Spring Boot API-ju koji komunicira sa MySQL bazom. Glavni tok: registracija, login, filtriranje, dodavanje u korpu, placanje, pregled istorije.

### 3.6 Testiranje prihvatljivosti
Provera iz perspektive krajnjeg korisnika. Klijent moze da pregleda artikle kao gost. Klijent mora da se prijavi pre finalne porudzbine. Zaposleni vidi samo radne funkcije. Admin moze da doda zaposlenog. Sistem ne dozvoljava negativnu zalihu.

## 4. Testno okruzenje

| Komponenta | Tehnologija |
|---|---|
| Frontend | React + Vite |
| Backend | Spring Boot REST API |
| Baza podataka | MySQL 8.0+ (MAMP, port 8889) |
| Autentifikacija | Spring Security + JWT |
| Razvojna baza | `auto_parts_shop_dev` |
| Testna baza | `auto_parts_shop_test` |

Testovi nikada ne koriste razvojnu ili produkcionu bazu.

## 5. Alati i biblioteke

### Backend
- JUnit 5 (unit i integracioni testovi)
- Mockito (simuliranje repozitorijuma i eksternih zavisnosti)
- Spring Boot Test + MockMvc (REST API testovi)
- Spring Security Test (provera autorizacije)
- JaCoCo (izvestaj pokrivenosti koda)

### Frontend
- Vitest (test runner)
- React Testing Library (testiranje korisnickog ponasanja)
- `@testing-library/user-event` (interakcije)
- MSW - Mock Service Worker (simulacija HTTP komunikacije)

### E2E
- Playwright (Chromium browser)

## 6. Kriterijumi za pocetak i zavrsetak testiranja

### Kriterijumi za pocetak
- Backend ima definisane entitete, repozitorijume i servise.
- Frontend ima React/Vite setup.
- MySQL server je pokrenut i baze `auto_parts_shop_dev` i `auto_parts_shop_test` postoje.
- Migracije su primenjene i seed podaci su dostupni.

### Kriterijumi za zavrsetak
- Svi unit testovi prolaze.
- Svi integracioni REST API testovi prolaze.
- Svi frontend testovi prolaze.
- E2E tok prolazi.
- Nema otvorenih kriticnih gresaka.
- Pokrivenost koda na backendu prelazi 80%.

## 7. Nacin evidentiranja pronadjenih gresaka

Svaka pronadjena greska evidentira se sa sledecim poljima:

| Polje | Opis |
|---|---|
| ID | Jedinstvena oznaka, npr. `BUG-001` |
| Naslov | Kratak opis problema |
| Okruzenje | Frontend / Backend / Baza |
| Koraci za reprodukciju | Tacni koraci kojima se greska moze ponoviti |
| Ocekivano ponasanje | Sta je trebalo da se desi |
| Stvarno ponasanje | Sta se zaista desilo |
| Ozbiljnost | Critical, High, Medium, Low |
| Prioritet | P1, P2, P3 |
| Dokaz | Screenshot, log, response body |
| Status | Open, In Progress, Fixed, Retest, Closed |

Primer:
```
BUG-001
Naslov: Klijent moze da promeni status porudzbine preko employee endpointa
Ozbiljnost: Critical
Ocekivano: 403 Forbidden
Stvarno: 200 OK
```

## 8. Glavni rizici pri testiranju

| Rizik | Uticaj | Mera |
|---|---|---|
| Testovi greskom koriste dev bazu | Gubitak podataka | Posebna `auto_parts_shop_test` baza i zastita u test profilu |
| MAMP port nije standardni 3306 | Backend se ne konektuje | Uvek koristiti port 8889 u test profilima |
| Eksterni servisi nisu dostupni | Flaky testovi | Mock adapteri za payment, email i SMS |
| JWT konfiguracija pogresna | Sigurnosni propusti | Pokriti 401 i 403 testovima |
| Frontend testovi zavise od CSS klasa | Krhki testovi | Koristiti role, label i tekst selektore |
| Nedozvoljeni statusni prelazi prolaze | Logicka greska | Poseban test za state machine logiku |

## 9. Test scenariji

| ID | Funkcionalnost | Preduslovi | Koraci testiranja | Testni podaci | Ocekivani rezultat | Prioritet |
|---|---|---|---|---|---|---|
| TS-01 | Registracija klijenta | Email nije zauzet | Otvoriti registraciju, uneti podatke, poslati formu | `ana@example.com`, `Password1!`, telefon `+38164111222` | Klijent je registrovan, vracen JWT token | Visok |
| TS-02 | Prijavljivanje korisnika | Postoji klijent, zaposleni i admin | Uneti email i lozinku za svaku ulogu | 3 korisnika sa razlicitim ulogama | Svaki dobija JWT i vidi dozvoljeni deo aplikacije | Visok |
| TS-03 | Pretraga artikala po filterima | U bazi postoje artikli razlicitih kategorija | Izabrati proizvodjaca, model i kategoriju | `Volkswagen`, `Golf 7`, `Kocioni sistem` | Prikazani samo odgovarajuci artikli | Visok |
| TS-04 | Dodavanje artikla u korpu | Artikal je na stanju | Kliknuti "Dodaj u korpu", proveriti korpu | Artikal `Brake Pad A`, kolicina 1 | Korpa sadrzi artikal, total je azuriran | Visok |
| TS-05 | Placanje karticom | Korpa ima dostupne artikle | Izabrati karticu, uneti mock podatke, potvrditi | `4111111111111111`, validan datum, CVV | Porudzbina kreirana, zaliha smanjena | Visok |
| TS-06 | Placanje pouzecem | Korpa ima dostupne artikle | Izabrati pouzece, uneti adresu, potvrditi | Adresa isporuke, payment method CASH_ON_DELIVERY | Porudzbina kreirana sa statusom CREATED | Visok |
| TS-07 | Obavesti me | Artikal nije na stanju | Kliknuti "Obavesti me", uneti email, poslati | `ana@example.com` | Kreiran zahtev za obavestenje, korisnik dobija potvrdu | Srednji |
| TS-08 | Specijalno porucivanje | Deo ne postoji u katalogu | Otvoriti formu, uneti podatke vozila i dela, poslati | Marka, model, godiste, opis dela | Kreiran specijalni zahtev vidljiv zaposlenom | Srednji |
| TS-09 | Obrada porudzbine | Postoji porudzbina CREATED, zaposleni ulogovan | Promeniti status porudzbine | CREATED -> PROCESSING -> SHIPPED -> DELIVERED | Statusi su promenjeni i sacuvani | Visok |
| TS-10 | Neautorizovan pristup | Klijent je ulogovan | Klijent pokusava PATCH /api/employee/orders/{id}/status | Client JWT | Backend vraca 403 Forbidden | Visok |
| TS-11 | Nedozvoljen statusni prelaz | Porudzbina je DELIVERED | Pokusati promenu na CREATED | Employee JWT | Backend odbija zahtev, status ostaje DELIVERED | Visok |
| TS-12 | Pad API-ja na frontendu | Backend nije pokrenut | Otvoriti katalog stranicu | Nema | Prikazuje se poruka o gresci umesto prazne strane | Srednji |
