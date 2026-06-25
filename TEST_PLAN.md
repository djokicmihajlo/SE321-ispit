# Test plan - Prodavnica auto delova

## 1. Svrha dokumenta

Ovaj dokument je pocetni test plan za veb aplikaciju prodavnice auto delova. Plan nastaje pre implementacije aplikacije i sluzice kao vodic za redosled razvoja, pisanje testova i proveru funkcionalnosti.

Plan je napravljen na osnovu `specs.md` i uzora iz projekata u folderu `projects/`:

- `PATHS-MERN-main`: kompletna regresiona struktura, frontend/backend/e2e testovi, Playwright i CI pristup.
- `ecommerce-node-main`: jednostavan e-commerce primer sa backend, frontend i Playwright testovima.
- `ecommerce-vibe-main`: sirina domena e-commerce aplikacije i postojeci backend test plan.
- `todo-list-master`: najjasniji primer za Spring Boot + React test slojeve, posebno MockMvc, repository testove i MSW na frontendu.

Napomena: specifikacija pretpostavlja PostgreSQL, ali za ovaj projekat koristimo MAMP MySQL i phpMyAdmin. Zato je testno okruzenje prilagodjeno MySQL-u.

## 2. Cilj testiranja

Cilj testiranja je da se proveri da aplikacija prodavnice auto delova ispravno podrzava:

- registraciju i prijavljivanje klijenata;
- prijavljivanje zaposlenih i administratora;
- autorizaciju po ulogama;
- pregled i filtriranje artikala;
- dodavanje artikala u korpu;
- kreiranje i placanje porudzbine;
- narucivanje pouzećem;
- opciju "Obavesti me" za artikle koji nisu na stanju;
- specijalno porucivanje delova koji ne postoje u katalogu;
- obradu porudzbina od strane zaposlenog;
- administraciju zaposlenih i podataka potrebnih za rad sistema.

Testovi treba da obezbede da se osnovni poslovni tokovi mogu menjati bez straha od regresije.

## 3. Obim testiranja

Testiranjem su obuhvaceni sledeci slojevi:

- Spring Boot servisni sloj.
- Spring Boot REST API.
- Spring Security i JWT autorizacija.
- Repozitorijumi i MySQL test baza.
- React komponente.
- Frontend komunikacija sa backendom preko HTTP/JSON.
- Sistemski tokovi kroz frontend, backend i bazu.
- Prihvatljivost glavnih korisnickih scenarija.

## 4. Funkcionalnosti koje ce biti testirane

### Autentifikacija i autorizacija

- Registracija klijenta.
- Login klijenta, zaposlenog i administratora.
- Izdavanje i provera JWT tokena.
- Zastita endpointa po ulogama: `CLIENT`, `EMPLOYEE`, `ADMIN`.
- Zabrana pristupa employee/admin endpointima neautorizovanim korisnicima.

### Artikli i pretraga

- Prikaz svih artikala, ukljucujuci artikle koji nisu na stanju.
- Pretraga po proizvodjacu vozila.
- Pretraga po modelu vozila.
- Pretraga po kategoriji dela.
- Pretraga po tekstu/nazivu dela.
- Prikaz stanja zaliha.
- Employee CRUD nad artiklima.

### Korpa i porucivanje

- Dodavanje dostupnog artikla u korpu.
- Onemoguceno dodavanje artikla koji nije na stanju.
- Promena kolicine u korpi.
- Uklanjanje artikla iz korpe.
- Kreiranje porudzbine iz korpe.
- Izracunavanje ukupne cene na backendu.
- Umanjenje zaliha nakon uspesne porudzbine.
- Spraznjavanje korpe nakon porudzbine.

### Placanje

- Izbor placanja karticom.
- Izbor placanja pouzećem.
- Validacija osnovnih podataka za karticno placanje.
- Mock placanja karticom bez stvarnog payment gateway-a.
- Status porudzbine nakon placanja.

### Obavestenja

- Prikaz opcije "Obavesti me" za artikal koji nije na stanju.
- Slanje zahteva za obavestenje preko emaila ili telefona.
- Validacija emaila i broja telefona.
- Mock eksternog email/SMS servisa.

### Specijalno porucivanje

- Forma za deo koji ne postoji u katalogu.
- Unos informacija o automobilu.
- Unos opisa trazenog dela.
- Slanje zahteva prodavnici.
- Pregled zahteva od strane zaposlenog.
- Promena statusa specijalnog zahteva.

### Obrada porudzbina

- Pregled novih/neisporucenih porudzbina.
- Pregled isporucenih porudzbina.
- Pregled ponistenih porudzbina.
- Promena statusa porudzbine:
  - `CREATED`
  - `PROCESSING`
  - `SHIPPED`
  - `DELIVERED`
  - `CANCELLED`
- Zabrana nedozvoljenih prelaza statusa, npr. `DELIVERED -> CREATED`.

### Administracija

- Admin dodaje novog zaposlenog.
- Admin menja podatke zaposlenog.
- Admin blokira ili deaktivira zaposlenog.
- Zaposleni ne moze sam da se registruje.

## 5. Funkcionalnosti koje nisu obuhvacene testiranjem

U prvoj verziji testiranja nisu obuhvaceni:

- Stvarna naplata preko karticnog payment gateway-a.
- Stvarno slanje email i SMS poruka ka eksternim servisima.
- Load/performance testiranje sa velikim brojem korisnika.
- Penetraciono testiranje.
- Testiranje na svim browserima i mobilnim uredjajima.
- Napredna analitika prodaje.
- Racunovodstveni ili fiskalni sistemi.
- Integracija sa stvarnim dobavljacem za specijalno porucivanje.

Umesto stvarnih eksternih integracija koristice se mock objekti, test adapteri ili WireMock.

## 6. Testno okruzenje

### Lokalno razvojno okruzenje

- Frontend: React + Vite.
- Backend: Spring Boot REST API.
- Autentifikacija: Spring Security + JWT.
- Baza: MySQL preko MAMP-a.
- Administracija baze: phpMyAdmin.
- Komunikacija: HTTP/JSON.

### MAMP MySQL parametri

Prema lokalnom MAMP podesavanju:

```text
Host: localhost / 127.0.0.1
Port: 8889
Username: root
Password: root
Socket: /Applications/MAMP/tmp/mysql/mysql.sock
```

Predlog baza:

```text
auto_parts_shop_dev
auto_parts_shop_test
```

Testovi ne smeju da koriste produkcionu ili razvojnu bazu sa rucno unetim podacima. Za automatizovane backend/integracione testove koristi se `auto_parts_shop_test`.

Primer Spring profila za lokalni MySQL:

```properties
spring.datasource.url=jdbc:mysql://localhost:8889/auto_parts_shop_dev?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=validate
spring.flyway.enabled=true
```

Primer test profila:

```properties
spring.datasource.url=jdbc:mysql://localhost:8889/auto_parts_shop_test?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=validate
spring.flyway.enabled=true
```

## 7. Alati i biblioteke

### Backend

- JUnit 5 za unit i integracione testove.
- Mockito za simuliranje repozitorijuma i eksternih zavisnosti.
- Spring Boot Test za podizanje aplikacionog konteksta.
- MockMvc za REST API testove.
- Spring Security Test za proveru autorizacije.
- MySQL Connector/J za povezivanje sa MAMP MySQL bazom.
- Flyway za migracije baze.
- JaCoCo za izvestaj pokrivenosti koda.
- WireMock kao opcioni alat za email/SMS/payment mock.

### Frontend

- Vitest kao test runner.
- React Testing Library za testiranje korisnickog ponasanja.
- `@testing-library/jest-dom` za DOM asercije.
- `@testing-library/user-event` za interakcije.
- MSW za mock HTTP komunikacije sa Spring Boot API-jem.
- Playwright za e2e testove.

### Pomocni alati

- phpMyAdmin za pregled MySQL baze.
- Postman ili Bruno za rucnu proveru REST API-ja.
- GitHub Actions kao opcioni CI dodatak.

## 8. Vrste testiranja

### 8.1 Jedinicno testiranje

Jedinicni testovi proveravaju izolovanu poslovnu logiku bez prave baze i bez podizanja celog Spring konteksta.

Glavni fokus:

- `OrderService`.
- `CartService`.
- `InventoryService`.
- `NotificationService`.
- `SpecialOrderService`.
- validacija statusnih prelaza porudzbine.

Prva obavezna jedinica za testiranje:

```java
Order createOrder(Long clientId, CreateOrderRequest request);
```

Testovi za `OrderService`:

| ID | Test | Arrange | Act | Assert |
| -- | ---- | ------- | --- | ------ |
| UT-ORD-01 | Uspesno kreiranje porudzbine | Postoji klijent, korpa ima dostupne artikle | `createOrder` | Porudzbina je sacuvana, status `CREATED`, zalihe umanjene |
| UT-ORD-02 | Prazna korpa | Postoji klijent, request nema stavke | `createOrder` | Baca se validaciona greska, order se ne cuva |
| UT-ORD-03 | Klijent ne postoji | `clientRepository.findById` vraca empty | `createOrder` | Baca se greska `Client not found` |
| UT-ORD-04 | Nedovoljna kolicina | Artikal ima manju kolicinu od trazene | `createOrder` | Baca se greska, zaliha se ne menja |
| UT-ORD-05 | Tacan total | Vise stavki sa razlicitim cenama | `createOrder` | Ukupna cena je tacna |
| UT-ORD-06 | Pouzece | Request ima payment method `CASH_ON_DELIVERY` | `createOrder` | Payment status odgovara pouzeću |
| UT-ORD-07 | Kartica | Request ima payment method `CARD` i validne podatke | `createOrder` | Payment adapter je pozvan, order kreiran |
| UT-ORD-08 | Payment fail | Payment adapter vraca neuspeh | `createOrder` | Order se ne kreira ili dobija status neuspesnog placanja, zaliha se ne menja |

U unit testovima se mockuju:

- `ClientRepository`;
- `PartRepository`;
- `OrderRepository`;
- `PaymentService`;
- `NotificationService`;
- `CartRepository`, ako korpa postoji kao trajni entitet.

Prava baza se ne koristi u unit testovima zato sto se proverava samo jedna jedinica poslovne logike. Baza bi uvela sporost, nestabilnost i greske koje ne pripadaju testiranoj jedinici.

### 8.2 Integraciono testiranje

Integracioni testovi proveravaju vise komponenti zajedno:

```text
Controller -> Service -> Repository -> MySQL test baza
```

Koristi se:

- `@SpringBootTest`;
- `@AutoConfigureMockMvc`;
- `@ActiveProfiles("test")`;
- `MockMvc`;
- test baza `auto_parts_shop_test`.

Preporuceno ciscenje podataka:

- pre svakog testa obrisati tabele redosledom koji postuje strane kljuceve;
- ili koristiti SQL skripte `@Sql`;
- ili napraviti `DatabaseCleaner` helper.

Obavezni integracioni testovi:

| ID | Naziv | Provera |
| -- | ----- | ------- |
| IT-ORD-01 | Uspesno kreiranje porudzbine | HTTP status, JSON odgovor, status ordera, total, umanjena zaliha |
| IT-ORD-02 | Artikal nije na stanju | HTTP greska, order nije kreiran, zaliha nije promenjena |
| IT-AUTH-01 | Neautorizovan pristup employee endpointu | Klijent dobija `403 Forbidden` za promenu statusa |
| IT-ORD-03 | Dozvoljeni statusni prelazi | `CREATED -> PROCESSING -> SHIPPED -> DELIVERED` |
| IT-ORD-04 | Nedozvoljen statusni prelaz | `DELIVERED -> CREATED` vraca gresku |
| IT-AUTH-02 | Registracija i login | Korisnik dobija JWT i moze da pozove protected endpoint |
| IT-CART-01 | Dodavanje u korpu | Dostupan artikal se dodaje u korpu |
| IT-NOTIFY-01 | Obavesti me | Out-of-stock artikal kreira notification request |

### 8.3 Testiranje REST API-ja

API testovi proveravaju ugovor izmedju frontenda i backenda.

Kategorije endpointa:

- Auth:
  - `POST /api/auth/register`
  - `POST /api/auth/login`
- Artikli:
  - `GET /api/parts`
  - `GET /api/parts/{id}`
  - `POST /api/employee/parts`
  - `PUT /api/employee/parts/{id}`
  - `DELETE /api/employee/parts/{id}`
- Korpa:
  - `GET /api/cart`
  - `POST /api/cart/items`
  - `PATCH /api/cart/items/{id}`
  - `DELETE /api/cart/items/{id}`
- Porudzbine:
  - `POST /api/orders`
  - `GET /api/orders/my`
  - `GET /api/employee/orders`
  - `PATCH /api/employee/orders/{id}/status`
- Obavestenja:
  - `POST /api/notifications/restock`
- Specijalne porudzbine:
  - `POST /api/special-orders`
  - `GET /api/employee/special-orders`
  - `PATCH /api/employee/special-orders/{id}/status`

Proveravati:

- HTTP status kod;
- JSON strukturu;
- validacione poruke;
- autorizaciju;
- promene u bazi;
- da greska ne ostavlja delimicno promenjeno stanje.

### 8.4 Testiranje React komponenti

Frontend testovi proveravaju ponasanje koje korisnik vidi i izvrsava.

Ne testirati:

- interno stanje komponente;
- privatne funkcije;
- CSS klase kao primarni izvor istine, osim kada nema bolje alternative.

Testirati:

- tekst, role, labele i dostupne akcije;
- loading, empty i error stanja;
- interakcije korisnika;
- HTTP tokove preko MSW-a.

Obavezni frontend testovi:

| ID | Komponenta/tok | Provera |
| -- | -------------- | ------- |
| FE-PARTS-01 | Lista artikala | Prikaz svih artikala nakon uspesnog ucitavanja |
| FE-PARTS-02 | Filteri | Filter po proizvodjacu/modelu/kategoriji salje GET zahtev i prikazuje rezultate |
| FE-CART-01 | Dodavanje u korpu | Dostupan artikal se dodaje u korpu |
| FE-CART-02 | Nema zaliha | Dugme "Dodaj u korpu" je disabled |
| FE-NOTIFY-01 | Obavesti me | Out-of-stock artikal prikazuje opciju "Obavesti me" |
| FE-API-01 | API greska | Prikazuje se poruka kada backend nije dostupan |
| FE-ORDER-01 | Slanje porudzbine | React salje POST zahtev i prikazuje potvrdu |
| FE-AUTH-01 | Login | Uspesan login cuva token i vodi korisnika na odgovarajucu stranu |

### 8.5 Sistemsko testiranje

Sistemski testovi proveravaju kompletnu aplikaciju u lokalnom okruzenju:

```text
React frontend -> Spring Boot API -> MySQL MAMP baza
```

Glavni sistemski tokovi:

- registracija klijenta;
- login;
- filtriranje artikala;
- dodavanje u korpu;
- placanje pouzećem;
- karticno placanje kroz mock payment servis;
- pregled istorije porudzbina;
- employee promena statusa;
- out-of-stock notification;
- specijalno porucivanje.

### 8.6 Testiranje prihvatljivosti

Prihvatljivost se proverava kroz scenarije iz perspektive korisnika.

Primeri:

- Klijent moze kao gost da pregleda artikle.
- Klijent mora da se registruje ili prijavi pre finalnog kreiranja porudzbine, osim ako odlucimo da guest checkout bude eksplicitno podrzan.
- Klijent jasno vidi koji artikli nisu na stanju.
- Zaposleni vidi samo radne funkcije i ne vidi admin deo.
- Admin moze da doda zaposlenog.
- Sistem nikad ne dozvoljava negativnu zalihu.

## 9. Tabela slucajeva koriscenja za testiranje

| Slucaj koriscenja | Funkcija koja se testira | Inicijalno stanje sistema | Ulazi | Ocekivani izlaz |
| ----------------- | ------------------------ | ------------------------- | ----- | --------------- |
| Registracija klijenta | Kreiranje korisnickog naloga | Email ne postoji u bazi | Ime, prezime, email, lozinka, telefon | Kreiran klijent, vracen JWT ili potvrda registracije |
| Prijavljivanje korisnika | Login i JWT | Korisnik postoji i aktivan je | Email, lozinka | Vracen JWT i podaci o ulozi |
| Pregled kao gost | Javni katalog | Artikli postoje u bazi | Bez tokena | Prikazana lista artikala |
| Pretraga po filteru | Filtriranje artikala | Postoje artikli razlicitih kategorija/modela | Proizvodjac, model, kategorija | Prikazani samo artikli koji odgovaraju filteru |
| Dodavanje u korpu | Korpa | Artikal je na stanju | ID artikla, kolicina | Artikal dodat u korpu |
| Pokusaj dodavanja artikla bez zaliha | Validacija zaliha | Artikal ima `stock = 0` | ID artikla, kolicina | Dodavanje odbijeno, prikazana opcija "Obavesti me" |
| Placanje pouzećem | Kreiranje porudzbine | Korpa ima dostupne artikle | Adresa, payment method `CASH_ON_DELIVERY` | Porudzbina kreirana, status `CREATED` |
| Placanje karticom | Kreiranje porudzbine i payment mock | Korpa ima dostupne artikle | Podaci kartice, adresa | Payment mock uspesan, porudzbina kreirana |
| Obavesti me | Restock notification | Artikal nije na stanju | Email ili telefon | Kreiran zahtev za obavestenje |
| Specijalno porucivanje | Special order forma | Deo ne postoji u katalogu | Podaci auta, opis dela, kontakt | Kreiran zahtev prodavnici |
| Pregled porudzbina zaposlenog | Employee order dashboard | Postoje porudzbine u razlicitim statusima | Employee JWT, status filter | Prikazane odgovarajuce porudzbine |
| Promena statusa porudzbine | Employee obrada | Porudzbina je `CREATED` | Novi status `PROCESSING` | Status promenjen |
| Admin dodaje zaposlenog | Admin user management | Admin je ulogovan | Podaci zaposlenog | Kreiran nalog zaposlenog |

## 10. Test scenariji

| ID | Funkcionalnost | Preduslovi | Koraci testiranja | Testni podaci | Ocekivani rezultat | Prioritet |
| -- | -------------- | ---------- | ----------------- | ------------- | ------------------ | --------- |
| TS-01 | Registracija klijenta | Email nije zauzet | Otvoriti registraciju, uneti podatke, poslati formu | `ana@example.com`, `Password1!`, telefon | Klijent je registrovan i moze da se prijavi | Visok |
| TS-02 | Prijavljivanje korisnika | Postoji klijent, zaposleni i admin | Uneti validne kredencijale za svaku ulogu | 3 korisnika sa razlicitim ulogama | Svaki korisnik dobija JWT i vidi dozvoljeni deo aplikacije | Visok |
| TS-03 | Pretraga artikala po filterima | U bazi postoje disk plocice, filteri, ulje i akumulatori | Izabrati proizvodjaca, model i kategoriju | `Volkswagen`, `Golf 7`, `Kocioni sistem` | Prikazani samo odgovarajuci artikli | Visok |
| TS-04 | Dodavanje artikla u korpu | Artikal je na stanju | Kliknuti "Dodaj u korpu", proveriti korpu | Artikal `Brake Pad A`, kolicina 1 | Korpa sadrzi artikal, total je azuriran | Visok |
| TS-05 | Placanje karticom | Korpa ima dostupne artikle | Izabrati karticu, uneti mock podatke, potvrditi | `4111111111111111`, validan datum, CVV | Porudzbina kreirana, zaliha smanjena, prikazana potvrda | Visok |
| TS-06 | Placanje pouzećem | Korpa ima dostupne artikle | Izabrati pouzece, uneti adresu, potvrditi | Adresa isporuke | Porudzbina kreirana sa payment method `CASH_ON_DELIVERY` | Visok |
| TS-07 | Obavesti me | Artikal nije na stanju | Kliknuti "Obavesti me", izabrati email/telefon, poslati | `ana@example.com` ili `+38164111222` | Kreiran zahtev za obavestenje, korisnik dobija potvrdu | Srednji |
| TS-08 | Specijalno porucivanje dela | Deo ne postoji u katalogu | Otvoriti formu, uneti podatke vozila i dela, poslati | Marka, model, godiste, VIN opciono, opis dela | Kreiran specijalni zahtev i vidljiv zaposlenom | Srednji |
| TS-09 | Obrada porudzbine od strane zaposlenog | Postoji porudzbina `CREATED`, zaposleni je ulogovan | Otvoriti employee dashboard, promeniti status | `CREATED -> PROCESSING -> SHIPPED` | Statusi su promenjeni i sacuvani | Visok |
| TS-10 | Neautorizovan employee endpoint | Klijent je ulogovan | Klijent pokusava `PATCH /api/employee/orders/{id}/status` | Client JWT | Backend vraca `403 Forbidden` | Visok |
| TS-11 | Employee CRUD artikala | Zaposleni je ulogovan | Dodati, izmeniti i obrisati artikal | Naziv, cena, kolicina, kategorija | Promene su vidljive u katalogu | Srednji |
| TS-12 | Nedozvoljen statusni prelaz | Porudzbina je `DELIVERED` | Pokusati promenu na `CREATED` | Employee JWT | Backend odbija zahtev, status ostaje `DELIVERED` | Visok |

## 11. Predlozeni test podaci

### Korisnici

| Uloga | Email | Lozinka | Napomena |
| ----- | ----- | ------- | -------- |
| Admin | `admin@autodelovi.test` | `Password1!` | Seed korisnik |
| Zaposleni | `employee@autodelovi.test` | `Password1!` | Dodaje ga admin |
| Klijent | `client@autodelovi.test` | `Password1!` | Registrovan kroz test |
| Gost | nema | nema | Samo javni katalog |

### Artikli

| Naziv | Kategorija | Vozilo | Cena | Stanje |
| ----- | ---------- | ------ | ---- | ------ |
| Prednje kocione plocice | Kocioni sistem | VW Golf 7 | 4200 | 12 |
| Filter ulja | Filteri | Opel Astra J | 1200 | 30 |
| Akumulator 60Ah | Elektrika | Univerzalno | 8900 | 5 |
| Set kvacila | Menjac | Fiat Punto | 14500 | 0 |

### Porudzbine

| Status | Opis |
| ------ | ---- |
| `CREATED` | Porudzbina tek kreirana |
| `PROCESSING` | Zaposleni obradjuje |
| `SHIPPED` | Poslata/isporuka u toku |
| `DELIVERED` | Uspesno isporucena |
| `CANCELLED` | Ponistena/neuspesna isporuka |

## 12. Kriterijumi za pocetak testiranja

Testiranje moze da pocne kada:

- postoji dogovorena struktura projekta;
- backend ima osnovne entitete, repozitorijume i servise;
- frontend ima osnovni Vite/React setup;
- MySQL MAMP server je pokrenut;
- postoje baze `auto_parts_shop_dev` i `auto_parts_shop_test`;
- postoje migracije ili SQL skripte za pocetnu semu;
- postoji seed za admina, zaposlenog, klijenta i nekoliko artikala;
- definisani su osnovni endpointi i response formati.

## 13. Kriterijumi za zavrsetak testiranja

Testiranje se smatra zavrsenim za prvu verziju kada:

- svi obavezni unit testovi prolaze;
- svi integracioni REST API testovi prolaze;
- svi frontend testovi prolaze;
- osnovni e2e tok prolazi;
- nema otvorenih kriticnih ili visokih gresaka;
- test baza se moze resetovati i ponovo seedovati;
- aplikacija se moze pokrenuti lokalno sa MAMP MySQL bazom;
- dokumentovani su poznati rizici i ogranicenja.

## 14. Evidentiranje gresaka

Svaka greska treba da bude evidentirana sa sledecim poljima:

| Polje | Opis |
| ----- | ---- |
| ID | Jedinstvena oznaka, npr. `BUG-001` |
| Naslov | Kratak opis problema |
| Okruzenje | Frontend/backend/browser/baza |
| Koraci | Tacni koraci za reprodukciju |
| Ocekivano | Sta je trebalo da se desi |
| Stvarno | Sta se zaista desilo |
| Ozbiljnost | Critical, High, Medium, Low |
| Prioritet | P1, P2, P3 |
| Dokaz | Screenshot, log, response body |
| Status | Open, In Progress, Fixed, Retest, Closed |

Primer:

```text
BUG-001
Naslov: Klijent moze da promeni status porudzbine preko employee endpointa
Ozbiljnost: Critical
Ocekivano: 403 Forbidden
Stvarno: 200 OK
```

## 15. Glavni rizici

| Rizik | Uticaj | Mitigacija |
| ----- | ------ | ---------- |
| Testovi greskom koriste dev bazu | Gubitak ili menjanje rucnih podataka | Posebna `auto_parts_shop_test` baza i zastita u test setupu |
| MAMP port nije standardni 3306 | Backend se ne konektuje | Uvek koristiti port `8889` u lokalnim profilima |
| Eksterni email/SMS/payment servisi nisu dostupni | Flaky testovi | Koristiti mock adaptere ili WireMock |
| JWT i role konfiguracija budu pogresne | Sigurnosni propusti | Pokriti `401` i `403` testovima |
| Nedovoljno izolovani integracioni testovi | Testovi zavise jedan od drugog | Ciscenje baze pre svakog testa |
| Frontend testovi zavise od CSS klasa | Krhki testovi | Koristiti role, label i tekst |
| Statusi porudzbine nisu jasno modelovani | Nedozvoljeni prelazi prolaze | Poseban unit test za state machine logiku |
| Karticno placanje se previse realisticki implementira | Gubitak vremena i rizik | Za skolsku verziju koristiti mock payment |

## 16. Redosled rada

Predlozeni redosled razvoja i testiranja:

1. Kreirati bazni projekat: Spring Boot backend, React/Vite frontend.
2. Podesiti MySQL konekciju na MAMP i napraviti `dev` i `test` profile.
3. Dodati migracije za korisnike, uloge, artikle, korpu, porudzbine, obavestenja i specijalne porudzbine.
4. Implementirati auth i role model.
5. Implementirati katalog artikala i filtere.
6. Implementirati korpu.
7. Implementirati `OrderService`.
8. Napisati unit testove za `OrderService`.
9. Implementirati REST tok porudzbine.
10. Napisati integracione API testove.
11. Implementirati React liste, filtere, korpu i checkout.
12. Napisati frontend testove uz MSW.
13. Implementirati employee dashboard.
14. Napisati testove za promenu statusa porudzbine.
15. Dodati opciju "Obavesti me".
16. Dodati specijalno porucivanje.
17. Dodati Playwright e2e smoke/regression test.
18. Dodati coverage i eventualno GitHub Actions.

## 17. Minimalni regression paket

Pre zavrsetka svake faze pokretati:

```bash
# Backend unit + integration
./mvnw test

# Frontend unit/component
npm run test

# Frontend build
npm run build

# E2E, kada bude uveden
npm run test:e2e
```

Kasnije napraviti root skriptu po uzoru na `projects/PATHS-MERN-main/package.json`, npr:

```json
{
  "scripts": {
    "test:backend": "cd backend && ./mvnw test",
    "test:frontend": "cd frontend && npm run test",
    "build": "cd frontend && npm run build",
    "test:e2e": "cd e2e && npx playwright test",
    "test:regression": "npm run test:backend && npm run test:frontend && npm run build && npm run test:e2e"
  }
}
```

## 18. Dodatni poeni

Najbolji kandidati za dodatne poene:

1. JaCoCo coverage za Spring Boot.
2. Playwright e2e test za glavni checkout tok.
3. WireMock za email/SMS ili payment mock.
4. GitHub Actions za automatsko pokretanje testova.

Testcontainers je koristan, ali posto projekat lokalno cilja MAMP MySQL, prvo cemo stabilizovati lokalni MySQL test profil. Testcontainers mozemo dodati kasnije ako bude potreban izolovan CI-friendly database setup.

