# Auto Parts Shop

Full-stack aplikacija za prodavnicu auto delova, razvijena kao projekat za predmet SE321 (Obezbedjenje kvaliteta, testiranje i evolucija softvera).

## Tehnologije

- Backend: Java 17, Spring Boot, Spring Security, Spring Data JPA, Flyway
- Frontend: React, Vite, React Router
- Baza podataka: MySQL (za MAMP okruzenje)
- Testiranje: 
  - Backend: JUnit 5, Mockito, MockMvc, JaCoCo
  - Frontend: Vitest, React Testing Library, MSW
  - E2E: Playwright

## Osnovne funkcionalnosti

- Klijentski deo: Pregled i filtriranje kataloga, korpa, checkout (kartica/pouzece), "Obavesti me" opcija, specijalno porucivanje.
- Radni deo (zaposleni): Obrada porudzbina i promena statusa, upravljanje specijalnim zahtevima, azuriranje kataloga artikala.
- Administracija: Upravljanje nalozima zaposlenih.

## Pokretanje projekta

### 1. Baza podataka (MAMP)

Konfiguracija za lokalni MAMP MySQL server:
- Port: 8889
- Username: root
- Password: root

Potrebno je napraviti dve baze:
- auto_parts_shop_dev (za razvoj)
- auto_parts_shop_test (za testove)

Flyway migracije automatski kreiraju tabele i seed podatke pri prvom pokretanju backenda.
Pocetni nalog za admina: admin@autodelovi.test / Password1!

### 2. Pokretanje aplikacije

Iz glavnog foldera koriste se sledece npm skripte:

Pokretanje backenda:
```bash
npm run backend
```
(Ili rucno: cd backend && ./mvnw spring-boot:run -Dspring-boot.run.profiles=local-mysql)

Pokretanje frontenda:
```bash
npm run frontend
```

## Testiranje

Svi testovi se mogu pokrenuti preko predefinisanih npm skripti.

Backend testovi (Unit i Integracioni):
```bash
npm run test:backend
```

Frontend testovi:
```bash
npm run test:frontend
```

E2E Testovi (Playwright):
```bash
npm run test:e2e
```

Pokretanje cele testne suite:
```bash
npm run test:regression
```

Detaljnija dokumentacija o testiranju nalazi se u docs/TEST_PLAN.md i docs/TEST_RESULTS.md fajlovima.
