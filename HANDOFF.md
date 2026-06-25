# AI Handoff - Auto Parts Shop

## Project Summary

This is a full-stack web application for an auto parts shop based on `specs.md`.

The application supports:

- guests/clients browsing and filtering auto parts;
- client registration/login, cart, checkout, order history, restock notifications, and special part requests;
- employees managing parts, orders, restock requests, and special orders;
- admins creating/listing employees.

Tech stack:

- Backend: Java 17, Spring Boot 4.1, Spring Web MVC, Spring Data JPA, Spring Security, JWT, Flyway, Maven.
- Database: MAMP MySQL/phpMyAdmin, not PostgreSQL. Local port is `8889`, user/password `root/root`.
- Frontend: React 19, Vite 8, React Router 7, Vitest, React Testing Library, MSW dependency installed.
- Tests: JUnit 5, Mockito, Spring Boot Test, MockMvc, JaCoCo, Vitest.

Architecture:

- Domain-based backend packages under `backend/src/main/java/com/autoparts/shop/`.
- REST JSON API under `/api/**`.
- Stateless JWT auth with role checks: `CLIENT`, `EMPLOYEE`, `ADMIN`.
- Flyway owns schema and seed data in `backend/src/main/resources/db/migration/`.
- Frontend currently has only an app shell and placeholder routes.

Important folders:

- `backend/src/main/java/com/autoparts/shop/auth` - auth, register/login, admin employee create/list.
- `backend/src/main/java/com/autoparts/shop/catalog` - parts, categories, vehicle make/model, employee CRUD.
- `backend/src/main/java/com/autoparts/shop/cart` - authenticated client cart.
- `backend/src/main/java/com/autoparts/shop/order` - checkout, mock payment, order status flow.
- `backend/src/main/java/com/autoparts/shop/notification` - "Obavesti me" restock requests.
- `backend/src/main/java/com/autoparts/shop/specialorder` - special part requests.
- `backend/src/test/java/com/autoparts/shop` - backend unit/API tests.
- `frontend/src` - current React app shell.
- `projects/` - reference projects only, intentionally ignored by git.

## Current State

Completed:

- `TEST_PLAN.md` and `IMPLEMENTATION_PLAN.md` exist and are the source of truth for planned phases.
- `.gitignore` includes `projects/`.
- Backend scaffold, frontend scaffold, root npm scripts, README.
- MAMP MySQL profiles and Flyway migrations `V1` through `V7`.
- Seed users:
  - `admin@autodelovi.test` / `Password1!`
  - `employee@autodelovi.test` / `Password1!`
  - `client@autodelovi.test` / `Password1!`
- Backend auth/JWT/roles.
- Public catalog and employee part CRUD.
- Backend client cart.
- Backend orders, mock card payment, cash on delivery, stock reduction, status transitions.
- Backend employee order processing.
- Backend restock notification request flow.
- Backend special order request flow.
- Backend tests: 33 passing.
- Frontend tests: 2 passing.
- Frontend production build passes.

Partially completed:

- Frontend is only a polished starting shell with routes `/`, `/parts`, and `/special-order`.
- Admin employee management supports create/list only. The implementation plan mentions update/deactivate, but no `PATCH /api/admin/employees/{id}` exists yet.
- E2E is planned but not created.

Unfinished:

- Frontend auth/layout.
- Frontend catalog, filters, details, cart.
- Frontend checkout and order history.
- Frontend employee/admin pages.
- Playwright e2e setup.
- Final manual MAMP/phpMyAdmin verification.

Last known good verification:

```bash
npm run test:regression
```

Result: 33 backend tests, 2 frontend tests, frontend build all passed.

## Current Task

The active implementation task was: continue from `IMPLEMENTATION_PLAN.md`.

The last completed phase was:

- Faza 9 - Specijalno porucivanje.

Files involved in the last completed backend phase:

- `backend/src/main/java/com/autoparts/shop/specialorder/*`
- `backend/src/main/java/com/autoparts/shop/config/SecurityConfig.java`
- `backend/src/test/java/com/autoparts/shop/specialorder/SpecialOrderApiTests.java`
- `IMPLEMENTATION_PLAN.md`

The next planned task is:

- Faza 10 - Frontend auth i layout.

Remaining implementation steps for the next task:

1. Replace placeholder frontend with a real app layout.
2. Add frontend API service for the Spring API.
3. Add `AuthContext` with token persistence and `/api/auth/me` hydration.
4. Add `ProtectedRoute` and role-aware route guards.
5. Add login page.
6. Add register page.
7. Add role-based navigation for guest/client/employee/admin.
8. Add frontend tests for login/register/auth state.
9. Update `IMPLEMENTATION_PLAN.md` as each step is completed.
10. Run `npm run test:regression`.

## Important Design Decisions

- Use MAMP MySQL instead of PostgreSQL because the user explicitly requested MAMP/phpMyAdmin.
- Use two local databases:
  - `auto_parts_shop_dev` for app development.
  - `auto_parts_shop_test` for tests.
- `TestDatabaseSafetyCheck` refuses to run the `test` profile unless the datasource URL contains `auto_parts_shop_test`.
- Keep schema changes in Flyway migrations. Do not use Hibernate schema generation beyond `ddl-auto=validate`.
- Keep backend organized by domain package, not by technical layer.
- Use Java records for request/response DTOs.
- Use `ApiException` plus `GlobalExceptionHandler` for consistent JSON API errors.
- Use method-level `@PreAuthorize` where endpoint role checks are specific.
- Backend cart is stored server-side for logged-in clients. Guest cart is planned for the frontend only.
- Payment is a mock adapter:
  - card `4000000000000002` fails;
  - normal card succeeds;
  - cash on delivery is supported.
- Email/SMS notification dispatch is mocked through an adapter.
- Special orders can be created publicly or by an authenticated client; only clients can list their own via `/api/special-orders/my`.
- Regression command intentionally excludes e2e for now because `e2e/` is not implemented.

## Coding Style

Backend style:

- Small domain services with transactional methods.
- Controllers are thin and delegate to services.
- DTOs are Java records with Jakarta Validation annotations.
- Entities encapsulate state changes with methods such as `update`, `deactivate`, `decreaseStock`, `changeStatus`, `respond`.
- Error messages are short, user-facing English strings.
- Tests use descriptive method names, MockMvc, JSONPath, and helper methods inside each test class.
- Unit tests use Mockito and Arrange/Act/Assert style.
- API tests create unique emails/SKUs with `System.nanoTime()` to avoid collisions in the shared MySQL test DB.

Frontend style:

- Plain React components, React Router routes, CSS modules via normal `.css` imports.
- Current CSS is restrained, utilitarian, responsive, and uses 6-8px radii.
- Text is mostly Serbian/Latin without diacritics in code-facing copy, with some existing mixed wording from specs.
- Tests should assert visible behavior with React Testing Library, not implementation details.

## Things NOT to Change

- Do not remove `projects/` from `.gitignore`.
- Do not switch the database target back to PostgreSQL unless the user explicitly asks.
- Do not let tests run against `auto_parts_shop_dev`.
- Do not replace Flyway migrations with Hibernate auto-DDL.
- Do not remove the seeded credentials without updating tests and docs.
- Do not remove the mock payment/notification approach; real external services are out of scope.
- Do not flatten the backend into generic controller/service/repository folders; keep domain packages.
- Do not bypass role checks in `SecurityConfig` or method-level `@PreAuthorize`.
- Do not make frontend tests depend on CSS class names when visible roles/text can be used.

## Known Issues

- Frontend is not functionally implemented beyond initial shell and placeholders.
- No e2e tests or `e2e/` project yet.
- Admin employee update/deactivation is planned in docs but not implemented.
- There are no public endpoints for listing categories or vehicle makes/models separately; current catalog filtering uses known query params against `/api/parts`.
- Integration tests use a persistent local MySQL test database and mostly avoid conflicts with unique data. There is no centralized database cleaner yet.
- `README.md` is minimal and does not document every endpoint.
- API error messages are in English while the UI/spec text is Serbian.
- Some generated build/test artifacts may exist locally under ignored folders.
- No CI configuration yet.

## Recommended Next Steps

1. Implement Faza 10: frontend auth and base layout.
2. Add frontend API client with `Authorization: Bearer <token>` support and clear handling for 401/403/API errors.
3. Add `AuthContext`, login/register pages, protected routes, and role-aware navigation.
4. Add Vitest/RTL tests for auth flows using mocked API responses.
5. Update `IMPLEMENTATION_PLAN.md` after the auth phase and run `npm run test:regression`.
6. Implement Faza 11: frontend catalog, filters, part cards/details, and cart context.
7. Add MSW-based frontend tests for catalog loading, filters, cart actions, out-of-stock state, and "Obavesti me".
8. Implement checkout/order history, then employee/admin screens.
9. Create Playwright e2e only after the main frontend flows exist.
10. Expand README with setup, seed users, and common commands.
