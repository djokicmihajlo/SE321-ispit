# Plan implementacije - Prodavnica auto delova

## Status dokumenta

Ovo je zivi plan implementacije. Azurira se tokom rada kako faze budu zavrsavane, kako se budu donosile tehnicke odluke i kako testovi budu dodavani.

Trenutni status: scaffold projekta je napravljen; sledeci radni korak je baza i Flyway migracije.

## 1. Cilj projekta

Napraviti kompletnu full-stack veb aplikaciju za prodavnicu auto delova prema `specs.md`.

Aplikacija mora da podrzi tri tipa korisnika:

- gost/klijent;
- zaposleni;
- administrator.

Klijent moze da pregleda katalog kao gost, registruje se, prijavi se, filtrira artikle, dodaje artikle u korpu, kreira porudzbinu, placa karticom ili pouzećem, trazi obavestenje za artikal koji nije na stanju i salje zahtev za specijalno porucivanje dela koji ne postoji u katalogu.

Zaposleni moze da pregleda i obradjuje porudzbine, vidi nove/neisporucene/isporucene/ponistene porudzbine i upravlja artiklima.

Administrator dodaje i upravlja zaposlenima.

## 2. Tehnoloske odluke

Specifikacija pominje PostgreSQL, ali u ovom projektu koristimo MAMP MySQL i phpMyAdmin.

### Backend

- Java 17.
- Spring Boot.
- Spring Web REST API.
- Spring Data JPA.
- Spring Security.
- JWT autentifikacija.
- MySQL preko MAMP-a.
- Flyway migracije.
- Maven.

### Frontend

- React.
- Vite.
- React Router.
- Context API za auth i korpu.
- Fetch API ili Axios za HTTP komunikaciju.
- CSS bez velikog framework-a, osim ako naknadno odlucimo drugacije.

### Testovi

- Backend unit: JUnit 5 + Mockito.
- Backend integration/API: Spring Boot Test + MockMvc.
- Frontend: Vitest + React Testing Library.
- HTTP mock na frontendu: MSW.
- E2E: Playwright kao dodatni sloj.
- Coverage: JaCoCo za backend, Vitest coverage za frontend.

## 3. MAMP MySQL konfiguracija

Lokalni MySQL parametri:

```text
Host: localhost / 127.0.0.1
Port: 8889
Username: root
Password: root
Socket: /Applications/MAMP/tmp/mysql/mysql.sock
```

Planirane baze:

```text
auto_parts_shop_dev
auto_parts_shop_test
```

`auto_parts_shop_dev` koristi aplikacija tokom lokalnog razvoja.

`auto_parts_shop_test` koriste integracioni testovi. Testovi ne smeju da koriste dev bazu.

Planirani Spring profili:

- `local-mysql` za lokalni razvoj preko MAMP-a;
- `test` za automatizovane testove nad `auto_parts_shop_test`.

## 4. Uzori iz foldera `projects`

Koristicemo postojece projekte kao prakticne sablone:

| Projekat | Sta preuzimamo kao obrazac |
| -------- | -------------------------- |
| `projects/PATHS-MERN-main` | Root regression skripte, Playwright organizaciju, jasne test helper-e, CI pristup |
| `projects/ecommerce-node-main` | E-commerce tokove: katalog, filtere, korpu, product detail, Playwright flow |
| `projects/ecommerce-vibe-main` | Sirinu domena: auth, admin, order, wishlist/notification slicne tokove, backend test plan |
| `projects/todo-list-master` | Spring Boot test slojeve, MockMvc ideju, frontend MSW testove |

Ne kopiramo tehnologiju doslovno iz Node/MERN primera, vec primenjujemo iste obrasce na Spring Boot + React + MySQL.

## 5. Planirana struktura projekta

Predlog root strukture:

```text
.
├── backend/
│   ├── pom.xml
│   ├── src/main/java/...
│   ├── src/main/resources/
│   │   ├── application.properties
│   │   ├── application-local-mysql.properties
│   │   ├── application-test.properties
│   │   └── db/migration/
│   └── src/test/java/...
├── frontend/
│   ├── package.json
│   ├── vite.config.js
│   └── src/
├── e2e/
│   ├── package.json
│   ├── playwright.config.js
│   └── tests/
├── specs.md
├── TEST_PLAN.md
├── IMPLEMENTATION_PLAN.md
└── package.json
```

Root `package.json` ce kasnije imati komande za regresioni prolaz, po uzoru na `PATHS-MERN-main`.

## 6. Domen i modeli

### Korisnici i role

Planirani entiteti:

- `User`
- `Role` ili enum `UserRole`

Role:

- `CLIENT`
- `EMPLOYEE`
- `ADMIN`

Klijent moze da se registruje.

Zaposlenog dodaje admin.

Admin korisnik se seeduje migracijom ili seed skriptom.

### Artikli

Planirani entiteti:

- `Part`
- `PartCategory`
- `VehicleMake`
- `VehicleModel`

Minimalna polja za `Part`:

- `id`
- `name`
- `description`
- `manufacturer`
- `price`
- `stockQuantity`
- `imageUrl`
- `category`
- kompatibilni proizvodjac/model vozila
- `createdAt`
- `updatedAt`

Svi artikli su vidljivi u katalogu, cak i kada je `stockQuantity = 0`.

### Korpa

Opcija A: korpa se cuva na backendu.

Opcija B: korpa se drzi na frontendu do checkout-a.

Planirana odluka: za jasnije API i integracione testove koristimo backend korpu za ulogovanog klijenta, a frontend lokalnu korpu za gosta dok se ne prijavi.

Planirani entiteti:

- `Cart`
- `CartItem`

### Porudzbine

Planirani entiteti:

- `Order`
- `OrderItem`
- `Payment`

Statusi porudzbine:

- `CREATED`
- `PROCESSING`
- `SHIPPED`
- `DELIVERED`
- `CANCELLED`

Payment metode:

- `CARD`
- `CASH_ON_DELIVERY`

Payment statusi:

- `PENDING`
- `PAID`
- `FAILED`
- `CASH_ON_DELIVERY`

### Obavestenja

Planirani entitet:

- `RestockNotificationRequest`

Polja:

- `part`
- `client` opciono
- `email`
- `phone`
- `channel`
- `status`
- `createdAt`

Kanali:

- `EMAIL`
- `SMS`

Eksterni email/SMS servis u prvoj verziji je mock/adaptiran servis.

### Specijalno porucivanje

Planirani entitet:

- `SpecialOrderRequest`

Polja:

- podaci o klijentu/kontaktu;
- marka vozila;
- model vozila;
- godiste;
- VIN opciono;
- opis trazenog dela;
- status;
- odgovor zaposlenog;
- procenjeni rok dolaska;
- mesto preuzimanja.

Statusi:

- `SUBMITTED`
- `CHECKING_SUPPLIER`
- `AVAILABLE`
- `UNAVAILABLE`
- `CLOSED`

## 7. Planirani REST API

### Auth

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `POST` | `/api/auth/register` | public | Registracija klijenta |
| `POST` | `/api/auth/login` | public | Login klijent/zaposleni/admin |
| `GET` | `/api/auth/me` | authenticated | Trenutni korisnik |

### Artikli

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `GET` | `/api/parts` | public | Lista i filter artikala |
| `GET` | `/api/parts/{id}` | public | Detalji artikla |
| `POST` | `/api/employee/parts` | employee/admin | Dodavanje artikla |
| `PUT` | `/api/employee/parts/{id}` | employee/admin | Izmena artikla |
| `DELETE` | `/api/employee/parts/{id}` | employee/admin | Brisanje artikla |

### Korpa

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `GET` | `/api/cart` | client | Pregled korpe |
| `POST` | `/api/cart/items` | client | Dodavanje stavke |
| `PATCH` | `/api/cart/items/{id}` | client | Promena kolicine |
| `DELETE` | `/api/cart/items/{id}` | client | Uklanjanje stavke |
| `DELETE` | `/api/cart` | client | Praznjenje korpe |

### Porudzbine

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `POST` | `/api/orders` | client | Kreiranje porudzbine |
| `GET` | `/api/orders/my` | client | Istorija porudzbina |
| `GET` | `/api/orders/{id}` | client/employee/admin | Detalji porudzbine uz autorizaciju |
| `GET` | `/api/employee/orders` | employee/admin | Pregled porudzbina |
| `PATCH` | `/api/employee/orders/{id}/status` | employee/admin | Promena statusa |

### Obavestenja

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `POST` | `/api/notifications/restock` | public/client | Zahtev "Obavesti me" |
| `GET` | `/api/employee/notifications` | employee/admin | Pregled zahteva |

### Specijalne porudzbine

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `POST` | `/api/special-orders` | public/client | Kreiranje zahteva |
| `GET` | `/api/special-orders/my` | client | Zahtevi klijenta |
| `GET` | `/api/employee/special-orders` | employee/admin | Pregled zahteva |
| `PATCH` | `/api/employee/special-orders/{id}/status` | employee/admin | Promena statusa/odgovor |

### Admin

| Metod | Putanja | Uloga | Opis |
| ----- | ------- | ----- | ---- |
| `POST` | `/api/admin/employees` | admin | Dodavanje zaposlenog |
| `GET` | `/api/admin/employees` | admin | Lista zaposlenih |
| `PATCH` | `/api/admin/employees/{id}` | admin | Izmena/deaktivacija zaposlenog |

## 8. Frontend plan

### Rute

| Ruta | Opis |
| ---- | ---- |
| `/` | Katalog artikala |
| `/parts/:id` | Detalji artikla |
| `/cart` | Korpa |
| `/checkout` | Checkout i placanje |
| `/login` | Login |
| `/register` | Registracija klijenta |
| `/orders` | Porudzbine klijenta |
| `/special-order` | Specijalno porucivanje |
| `/employee/orders` | Dashboard porudzbina za zaposlenog |
| `/employee/parts` | Upravljanje artiklima |
| `/employee/special-orders` | Obrada specijalnih zahteva |
| `/admin/employees` | Admin upravljanje zaposlenima |

### Glavne frontend celine

- `AuthContext`
- `CartContext`
- `api` servis
- `ProtectedRoute`
- `RoleRoute`
- `PartList`
- `PartFilters`
- `PartCard`
- `PartDetails`
- `CartPage`
- `CheckoutPage`
- `RestockNotificationForm`
- `SpecialOrderForm`
- `EmployeeOrdersPage`
- `EmployeePartsPage`
- `AdminEmployeesPage`

## 9. Plan testiranja

Detaljan test plan je u `TEST_PLAN.md`. Ovaj implementacioni plan preuzima sledeci redosled testiranja.

### Backend unit testovi

Prvi obavezni test paket:

- `OrderServiceTest`

Minimalni testovi:

- uspesno kreiranje porudzbine;
- prazna korpa;
- klijent ne postoji;
- artikal nije dostupan u trazenoj kolicini;
- tacno izracunavanje ukupne cene.

Prosirenja:

- payment card success;
- payment fail;
- pouzece;
- nedozvoljen statusni prelaz;
- notification request validacija.

### Backend integracioni/API testovi

Minimalni testovi:

- registracija + login + JWT;
- uspesno kreiranje porudzbine;
- porucivanje artikla koji nije na stanju;
- klijent ne moze da pristupi employee endpointu;
- zaposleni menja status `CREATED -> PROCESSING -> SHIPPED -> DELIVERED`;
- `DELIVERED -> CREATED` se odbija.

### Frontend testovi

Minimalni testovi:

- prikaz svih artikala nakon ucitavanja;
- filtriranje po proizvodjacu/modelu/kategoriji;
- dodavanje artikla u korpu;
- disabled "Dodaj u korpu" za artikal bez zaliha;
- prikaz "Obavesti me";
- API error state;
- checkout salje porudzbinu backendu i prikazuje potvrdu.

### E2E testovi

Minimalni Playwright scenario:

```text
Registracija klijenta
-> login
-> izbor filtera
-> dodavanje artikla u korpu
-> checkout
-> izbor nacina placanja
-> potvrda porudzbine
-> pregled porudzbine u istoriji
```

Drugi e2e scenario:

```text
Employee login
-> pregled novih porudzbina
-> promena statusa
-> provera da je status sacuvan
```

## 10. Faze implementacije

Legenda statusa:

- `[ ]` nije zapoceto
- `[~]` u toku
- `[x]` zavrseno
- `[!]` blokirano

### Faza 0 - Dokumentacija i priprema

- [x] Procitati `specs.md`.
- [x] Pregledati projekte iz `projects/`.
- [x] Napraviti `TEST_PLAN.md`.
- [x] Napraviti `IMPLEMENTATION_PLAN.md`.
- [ ] Potvrditi naziv baza u phpMyAdmin: `auto_parts_shop_dev` i `auto_parts_shop_test`.
- [ ] Potvrditi da MAMP MySQL radi na portu `8889`.

### Faza 1 - Scaffold projekta

- [x] Kreirati `backend/` Spring Boot projekat.
- [x] Kreirati `frontend/` React/Vite projekat.
- [x] Kreirati root `package.json` za komande.
- [x] Dodati osnovni `.gitignore`.
- [x] Dodati README sa pokretanjem.

Backend dependencies:

- [x] Spring Web.
- [x] Spring Data JPA.
- [x] Spring Security.
- [x] MySQL Connector/J.
- [x] Flyway.
- [x] Validation.
- [x] JJWT ili ekvivalent za JWT.
- [x] Spring Boot Test.
- [x] Mockito/JUnit.
- [x] JaCoCo.

Frontend dependencies:

- [x] React Router.
- [x] Vitest.
- [x] React Testing Library.
- [x] jest-dom.
- [x] user-event.
- [x] MSW.
- [ ] Playwright kasnije.

### Faza 2 - Baza i migracije

- [ ] Napraviti MySQL baze u phpMyAdmin.
- [x] Podesiti `application-local-mysql.properties`.
- [x] Podesiti `application-test.properties`.
- [ ] Dodati zastitu da test profil koristi samo `auto_parts_shop_test`.
- [ ] Dodati Flyway migracije.
- [ ] Dodati seed za admina, zaposlenog, klijenta i artikle.

Planirane migracije:

- [ ] `V1__create_users.sql`
- [ ] `V2__create_parts_catalog.sql`
- [ ] `V3__create_cart_tables.sql`
- [ ] `V4__create_orders.sql`
- [ ] `V5__create_notifications.sql`
- [ ] `V6__create_special_orders.sql`
- [ ] `V7__seed_initial_data.sql`

### Faza 3 - Backend auth i role

- [ ] Implementirati `User` model.
- [ ] Implementirati role.
- [ ] Implementirati password hashing.
- [ ] Implementirati JWT util/service.
- [ ] Implementirati register endpoint za klijente.
- [ ] Implementirati login endpoint.
- [ ] Implementirati `/api/auth/me`.
- [ ] Implementirati security config.
- [ ] Implementirati admin dodavanje zaposlenog.
- [ ] Napisati auth API testove.

### Faza 4 - Katalog artikala

- [ ] Implementirati entitete za artikle, kategorije i vozila.
- [ ] Implementirati repository sloj.
- [ ] Implementirati filter query.
- [ ] Implementirati public `GET /api/parts`.
- [ ] Implementirati public `GET /api/parts/{id}`.
- [ ] Implementirati employee CRUD nad artiklima.
- [ ] Dodati API testove za filtere i role.

### Faza 5 - Korpa

- [ ] Implementirati `Cart` i `CartItem`.
- [ ] Implementirati dodavanje dostupnog artikla.
- [ ] Implementirati zabranu dodavanja artikla bez zaliha.
- [ ] Implementirati promenu kolicine.
- [ ] Implementirati uklanjanje stavke.
- [ ] Implementirati praznjenje korpe.
- [ ] Dodati API testove za korpu.

### Faza 6 - Porudzbine i placanje

- [ ] Implementirati `Order`, `OrderItem`, `Payment`.
- [ ] Implementirati `CreateOrderRequest`.
- [ ] Implementirati `OrderService.createOrder`.
- [ ] Implementirati izracunavanje ukupne cene na backendu.
- [ ] Implementirati umanjenje zaliha.
- [ ] Implementirati mock card payment service.
- [ ] Implementirati pouzece.
- [ ] Implementirati statusne prelaze.
- [ ] Napisati `OrderServiceTest`.
- [ ] Napisati integracione testove iz `specs.md`.

### Faza 7 - Employee obrada porudzbina

- [ ] Implementirati pregled porudzbina po statusu.
- [ ] Implementirati promenu statusa.
- [ ] Implementirati zabranu nedozvoljenih statusnih prelaza.
- [ ] Implementirati prikaz ponistenih porudzbina.
- [ ] Dodati API testove za employee tok.

### Faza 8 - Obavesti me

- [ ] Implementirati `RestockNotificationRequest`.
- [ ] Implementirati public/client endpoint.
- [ ] Implementirati validaciju email/phone.
- [ ] Implementirati mock notification service.
- [ ] Implementirati employee pregled zahteva.
- [ ] Dodati unit/API testove.

### Faza 9 - Specijalno porucivanje

- [ ] Implementirati `SpecialOrderRequest`.
- [ ] Implementirati public/client kreiranje zahteva.
- [ ] Implementirati employee pregled zahteva.
- [ ] Implementirati employee odgovor/status.
- [ ] Dodati API testove.

### Faza 10 - Frontend auth i layout

- [ ] Kreirati osnovni layout.
- [ ] Implementirati `api` servis.
- [ ] Implementirati `AuthContext`.
- [ ] Implementirati `ProtectedRoute`.
- [ ] Implementirati login stranu.
- [ ] Implementirati register stranu.
- [ ] Implementirati role-based navigaciju.
- [ ] Dodati frontend testove za auth.

### Faza 11 - Frontend katalog i korpa

- [ ] Implementirati `PartList`.
- [ ] Implementirati filtere.
- [ ] Implementirati `PartCard`.
- [ ] Implementirati `PartDetails`.
- [ ] Implementirati `CartContext`.
- [ ] Implementirati `CartPage`.
- [ ] Dodati MSW testove za listu, filtere i korpu.

### Faza 12 - Frontend checkout

- [ ] Implementirati checkout formu.
- [ ] Implementirati izbor placanja karticom/pouzecem.
- [ ] Implementirati potvrdu porudzbine.
- [ ] Implementirati istoriju porudzbina klijenta.
- [ ] Dodati frontend test za slanje porudzbine backendu.

### Faza 13 - Frontend employee/admin

- [ ] Implementirati employee orders page.
- [ ] Implementirati employee parts CRUD page.
- [ ] Implementirati special orders employee page.
- [ ] Implementirati admin employees page.
- [ ] Dodati frontend testove za role i glavne akcije.

### Faza 14 - E2E i regresija

- [ ] Kreirati `e2e/` Playwright projekat.
- [ ] Podesiti Playwright da podize backend i frontend.
- [ ] Dodati e2e helper za registraciju/login.
- [ ] Dodati checkout e2e test.
- [ ] Dodati employee order status e2e test.
- [ ] Dodati root `test:regression` komandu.

### Faza 15 - Zavrsna verifikacija

- [ ] Pokrenuti backend testove.
- [ ] Pokrenuti frontend testove.
- [ ] Pokrenuti frontend build.
- [ ] Pokrenuti e2e testove.
- [ ] Proveriti aplikaciju rucno kroz MAMP MySQL.
- [ ] Azurirati `TEST_PLAN.md` ako se plan promenio.
- [ ] Azurirati `IMPLEMENTATION_PLAN.md` sa zavrsnim statusom.
- [ ] Dodati kratak zavrsni izvestaj.

## 11. Redosled rada u praksi

Radicemo iterativno:

1. Implementirati malu funkcionalnu celinu.
2. Pokrenuti lokalnu proveru.
3. Dodati ili azurirati test.
4. Azurirati ovaj plan.
5. Preci na sledecu celinu.

Prvi konkretan korak posle ovog plana:

```text
Faza 1 - Scaffold projekta
```

Zatim odmah:

```text
Faza 2 - MySQL profili i Flyway migracije
```

To je vazno jer ostatak aplikacije zavisi od stabilnog modela baze.

## 12. Komande koje cemo uvesti

Planirani root `package.json`:

```json
{
  "scripts": {
    "backend": "cd backend && ./mvnw spring-boot:run",
    "frontend": "cd frontend && npm run dev",
    "test:backend": "cd backend && ./mvnw test",
    "test:frontend": "cd frontend && npm run test",
    "build": "cd frontend && npm run build",
    "test:e2e": "cd e2e && npx playwright test",
    "test:regression": "npm run test:backend && npm run test:frontend && npm run build && npm run test:e2e"
  }
}
```

Ove komande cemo dodati kada projekti postoje.

## 13. Definicija zavrsene prve verzije

Prva verzija se smatra zavrsenom kada:

- klijent moze da se registruje i prijavi;
- gost moze da pregleda katalog;
- klijent moze da filtrira artikle;
- klijent moze da doda dostupan artikal u korpu;
- artikal bez zaliha prikazuje "Obavesti me";
- klijent moze da kreira porudzbinu karticom ili pouzecem;
- zaliha se smanjuje nakon porudzbine;
- zaposleni moze da obradi porudzbinu;
- admin moze da doda zaposlenog;
- specijalno porucivanje radi;
- obavezni unit, integracioni i frontend testovi prolaze;
- osnovni e2e tok prolazi;
- aplikacija radi sa MAMP MySQL bazom.

## 14. Dnevnik rada

| Datum | Promena | Status |
| ----- | ------- | ------ |
| 2026-06-25 | Kreiran `TEST_PLAN.md` na osnovu specifikacije | Zavrseno |
| 2026-06-25 | Kreiran `IMPLEMENTATION_PLAN.md` | Zavrseno |
| 2026-06-25 | Dodat `.gitignore` sa `projects/` | Zavrseno |
| 2026-06-25 | Napravljen Spring Boot backend scaffold sa Maven wrapperom | Zavrseno |
| 2026-06-25 | Napravljen React/Vite frontend scaffold i pocetni ekran | Zavrseno |
| 2026-06-25 | Dodati root npm scripts, MAMP MySQL profili, frontend test setup i backend health endpoint | Zavrseno |
| 2026-06-25 | Verifikacija: frontend testovi prolaze, frontend build prolazi, backend compile prolazi sa `-DskipTests` | Zavrseno |
