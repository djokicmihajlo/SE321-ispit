# Auto Parts Shop

Full-stack veb aplikacija za prodavnicu auto delova, razvijena kao projekat za predmet **SE321 - Obezbeđenje kvaliteta, testiranje i evolucija softvera**.

## 🛠 Tehnologije

- **Backend:** Java 17, Spring Boot, Spring Security (JWT), Spring Data JPA, Flyway
- **Frontend:** React, Vite, React Router, Context API
- **Baza podataka:** MySQL (prilagođeno za MAMP okruženje)
- **Testiranje:** 
  - Backend: JUnit 5, Mockito, MockMvc, JaCoCo
  - Frontend: Vitest, React Testing Library, MSW
  - E2E: Playwright

## ✨ Funkcionalnosti

- **Klijenti:** Pregled kataloga, pretraga i filtriranje, upravljanje korpom, kreiranje porudžbina (kartica/pouzeće), opcija "Obavesti me" za artikle van stanja, slanje upita za specijalno poručivanje.
- **Zaposleni:** Pregled i obrada porudžbina (promena statusa), upravljanje specijalnim porudžbinama, upravljanje katalogom artikala.
- **Administratori:** Dodavanje i upravljanje nalozima zaposlenih.

## 🚀 Pokretanje projekta

### 1. Baza podataka (MAMP)

Projekat je konfigurisan za rad sa lokalnim MAMP MySQL serverom:
- **Port:** 8889
- **Username:** `root`
- **Password:** `root`

U bazi napravite dve šeme (možete koristiti priložene SQL skripte iz `db/` foldera):
- `auto_parts_shop_dev` (za razvoj)
- `auto_parts_shop_test` (za automatske testove)

Flyway migracije će automatski kreirati tabele i ubaciti početne podatke pri prvom pokretanju (admin kredencijali: `admin@autodelovi.test` / `Password1!`).

### 2. Pokretanje

Iz korenskog foldera možete koristiti npm skripte:

**Pokretanje backenda:**
```bash
npm run backend
```
*(Alternativno: `cd backend && ./mvnw spring-boot:run -Dspring-boot.run.profiles=local-mysql`)*

**Pokretanje frontenda:**
```bash
npm run frontend
```
*(Aplikacija će biti dostupna na http://localhost:5173)*

## 🧪 Testiranje

Projekat sadrži sveobuhvatan paket testova sa visokom pokrivenošću.

**Backend testovi (Unit & Integracioni):**
```bash
npm run test:backend
```

**Frontend testovi (Komponente & MSW):**
```bash
npm run test:frontend
```

**E2E Testovi (Playwright):**
```bash
npm run test:e2e
```

**Svi testovi odjednom (Regression):**
```bash
npm run test:regression
```

*Za detaljnije informacije o planu testiranja i rezultatima, pogledajte `docs/TEST_PLAN.md` i `docs/TEST_RESULTS.md`.*
