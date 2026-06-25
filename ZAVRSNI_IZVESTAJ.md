# Završni Izveštaj

## 1. Implementirani sistemi
- **Backend (Spring Boot):** REST API, Spring Security (JWT), MySQL integracija (MAMP).
- **Frontend (React/Vite):** Javni katalog, korisnička korpa, employee i admin dashboard. Context API za upravljanje stanjem.

## 2. Testiranje i pokrivenost
Ukupno je izvršeno **60 testova**:
- **Backend (38 testova):** 
  - 33 integraciona REST testa (`@SpringBootTest` + `MockMvc`).
  - 5 izolovanih unit testova (`Mockito` za `OrderService`).
  - JaCoCo pokrivenost koda iznosi **90.35%**.
- **Frontend (20 testova):** 
  - Komponentni testovi uz MSW simulaciju backend odgovora (uključujući error handlovanje i "Obavesti me" tok).
- **E2E (2 testa):** 
  - Playwright testiranje kompletnog toka (od registracije, preko kupovine, do promene statusa porudžbine).
- Svi testovi se izvršavaju preko objedinjene skripte: `npm run test:regression`.

## 3. Instrukcije za pokretanje
- **Backend:** `cd backend && ./mvnw spring-boot:run` (zahteva MAMP MySQL: `root`/`root`, port `8889`, `auto_parts_shop_dev`).
- **Frontend:** `cd frontend && npm run dev` (dostupno na portu `5173`).
