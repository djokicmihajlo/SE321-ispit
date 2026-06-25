# Plan testiranja: Prodavnica auto delova

## 1. Ciljevi testiranja
Ovaj plan obuhvata strategiju testiranja celokupnog softverskog rešenja za prodavnicu auto delova. Cilj je da se kroz različite nivoe testiranja osigura da sistem pouzdano obavlja sve ključne poslovne procese:
- Registraciju, autentifikaciju i autorizaciju (klijenti, zaposleni, administratori).
- Rad sa katalogom artikala, filtriranje i pretragu.
- Upravljanje korisničkom korpom i proces naplate.
- Mehanizme obaveštavanja ("Obavesti me") kada željeni artikal nije na stanju.
- Proces specijalnog poručivanja auto delova.
- Upravljanje narudžbinama i zalihama od strane zaposlenih radnika.

## 2. Nivoi i obim testiranja

Aplikacija će biti testirana kroz četiri glavna nivoa:

### 2.1. Jedinično testiranje (Unit Testing)
Služi za proveru ključne biznis logike u potpunoj izolaciji, bez konekcije sa pravom bazom podataka ili pokretanja celokupnog okruženja.
- **OrderService:** Najvažniji deo sistema koji je neophodno izolovano testirati korišćenjem **Mockito** framework-a. Svi repozitorijumi i eksterni servisi se simuliraju (mock-uju).  
  *Scenariji koji se moraju proveriti:*
  - Uspešno kreiranje porudžbine i tačno obračunavanje ukupne cene.
  - Pokušaj kreiranja porudžbine sa praznom korpom (očekuje se validaciona greška).
  - Pokušaj kreiranja narudžbine za klijenta koji ne postoji u sistemu.
  - Pokušaj kupovine veće količine artikala nego što je dostupno na zalihama (zalihe se ne smeju menjati u slučaju greške).

### 2.2. Integraciono testiranje
Proverava da li različite komponente sistema pravilno komuniciraju. Pokreće se kompletna Spring aplikacija sa konekcijom ka namenskoj, izolovanoj MySQL testnoj bazi.
- **REST API:** Testiranje svih kontrolera pomoću `MockMvc`.
- Proveravaju se HTTP statusni kodovi, validacije ulaznih podataka, sigurnosni mehanizmi (JWT validacija i provera uloga) i stvarne izmene nad bazom podataka.
- *Ključni tokovi:* Pravilno ažuriranje statusa porudžbine (`CREATED` u `PROCESSING`, `SHIPPED`, itd.), blokiranje prelaza unazad (npr. iz `DELIVERED` u `CREATED`) i provera autorizacije zaposlenih u odnosu na klijente.

### 2.3. Testiranje korisničkog interfejsa (Frontend)
Fokusira se isključivo na web klijent (React aplikaciju). Svi odgovori sa servera moraju biti presretnuti i simulirani (Mock Service Worker - MSW) kako bi se UI testirao nezavisno od stanja bekenda.
- Provera vizuelnog prikaza i rutiranja.
- Simulacija korisničkih interakcija (unos teksta, klikovi, odabir filtera).
- **Dodatni ključni testovi:**
  - *Dugme "Obavesti me":* Proveriti da li se za artikle van zaliha pravilno prikazuje opcija i uspešno šalje simulirani zahtev.
  - *Pad sistema (Error handling):* Testirati prikaz adekvatne poruke i reakciju korisničkog interfejsa kada backend server uopšte nije dostupan (simuliran pad mreže).

### 2.4. End-to-End (E2E) testiranje
Služi za proveru sistema iz ugla stvarnog korisnika. Pokreće se pretraživač u pozadini (Playwright) koji navigira kroz pravu aplikaciju na realnom okruženju.
- *Regresioni tok:* Novi klijent otvara sajt, registruje se, pronalazi artikal, dodaje u korpu, izvršava kupovinu pouzećem, zatim se zaposleni prijavljuje u sistem i obeležava porudžbinu kao isporučenu.

## 3. Tehnički uslovi i alati

Da bi se testiranje uspešno obavilo, neophodni su sledeći tehnički preduslovi:
- **Lokalno testno okruženje:** Namenska test baza u koju aplikacija može slobodno pisati i brisati podatke. Prava produkciona baza se nikada ne koristi u testne svrhe.
- **Backend alati:** JUnit 5, Mockito, Spring Boot Test, MockMvc i JaCoCo za merenje procenata pokrivenosti (Coverage).
- **Frontend alati:** Vitest, React Testing Library i MSW (Mock Service Worker).
- **E2E alati:** Playwright (Chromium).

## 4. Očekivanja i kriterijumi za uspešnost
Aplikacija se smatra adekvatno testiranom kada se ispune sledeći uslovi:
1. Svi napisani unit, integracioni, frontend i E2E testovi uspešno prolaze bez pada.
2. Pokrivenost linija koda (Code coverage) na backendu iznosi preko 80% (optimalno oko 90%).
3. Postoji jedinstvena CLI skripta koja programerima i testerima omogućava pokretanje apsolutno svih provera pritiskom na jedno dugme pre bilo kakve isporuke koda u produkciju.
