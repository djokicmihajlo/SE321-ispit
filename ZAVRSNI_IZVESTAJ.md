# Završni Izveštaj: Prodavnica Auto Delova

Projekat izrade i automatizovanog testiranja prodavnice auto delova je uspešno i u celosti kompletiran prema specifikaciji `specs.md` i planu implementacije.

## Šta je postignuto:
1. **Backend (Spring Boot)**: 
   - Kompletno dizajniran REST API, entiteti, migracije baze i servisi sa robusnim `Order` i `Inventory` sistemom.
   - Povezan sa MAMP MySQL lokalnom bazom uz postojanje posebnih profila `dev` i `test`.
   - Pokriven sa 33 integraciona REST testa (Spring Boot Test + MockMvc) koji prolaze za manje od nekoliko sekundi.

2. **Frontend (React + Vite)**:
   - Kompletna web aplikacija sa tri glavna aspekta poslovanja (Klijentski izlog, Employee portal i Admin portal).
   - Upravljanje stanjem sa Context API-jem (Auth i Cart).
   - Mock Service Worker (MSW) upotrebljen za 18 naprednih testova koji obezbeđuju integraciju React komponenti pre stvarnog slanja mrežnog zahteva.
   - Uspešno integrisan production `vite build`.

3. **E2E i Regresija (Playwright)**:
   - Podignut i iskonfigurisan Playwright unutar `e2e` foldera sa mogućnošću automatskog orkestriranja webServer komandi (kako bi sam podigao test okruženje pre početka E2E testiranja).
   - Implementirana "End-To-End" simulacija celog toka kupovine: novi kupac -> pretraga kataloga -> dodavanje u korpu -> porudžbina pouzećem -> preuzimanje i izmena statusa od strane ulogovanog zaposlenog radnika.
   - Skripta `npm run test:regression` je jedinstven izvor istine: izvršava apsolutno sve nivoe na klik - od backend jedinica, do frontend komponenti, optimizovanog build-a i Chromium Playwright end-to-end simulacije.

## Pokretanje projekta za korisnika:
Za manuelno testiranje projekta, pokrenuti u terminalu `cd frontend && npm run dev` kao i `cd backend && ./mvnw spring-boot:run` i pristupiti aplikaciji putem brauzera na portu 5173.

Projekat se pokazao kao stabilan i otporan na greške u poslovanju!
