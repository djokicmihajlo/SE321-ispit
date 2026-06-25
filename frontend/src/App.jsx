import { Link, Route, Routes } from 'react-router-dom'
import Layout from './components/Layout'
import ProtectedRoute from './components/ProtectedRoute'
import LoginPage from './pages/LoginPage'
import RegisterPage from './pages/RegisterPage'
import PartsPage from './pages/PartsPage'
import PartDetailsPage from './pages/PartDetailsPage'
import CartPage from './pages/CartPage'
import CheckoutPage from './pages/CheckoutPage'
import OrdersPage from './pages/OrdersPage'
import EmployeeOrdersPage from './pages/EmployeeOrdersPage'
import EmployeePartsPage from './pages/EmployeePartsPage'
import EmployeeSpecialOrdersPage from './pages/EmployeeSpecialOrdersPage'
import AdminEmployeesPage from './pages/AdminEmployeesPage'
import './App.css'

const featureCards = [
  {
    title: 'Katalog auto delova',
    text: 'Pretraga po proizvodjacu, modelu vozila i kategoriji dela.',
  },
  {
    title: 'Korpa i placanje',
    text: 'Porucivanje dostupnih artikala karticom ili pouzecem.',
  },
  {
    title: 'Obavestenja',
    text: 'Zahtev za email ili SMS kada artikal ponovo bude na stanju.',
  },
  {
    title: 'Specijalno porucivanje',
    text: 'Forma za delove koji trenutno ne postoje u katalogu.',
  },
]

function HomePage() {
  return (
    <main className="app-shell">
      <section className="hero-panel">
        <div>
          <p className="eyebrow">Prodavnica auto delova</p>
          <h1>Pronadji deo, proveri stanje i poruci bez cekanja.</h1>
          <p className="hero-copy">
            Klijenti mogu da pretrazuju katalog kao gosti, naprave nalog za
            porucivanje i prate porudzbine, dok zaposleni obradjuju narudzbine i
            upravljaju artiklima.
          </p>
        </div>
        <div className="hero-actions" aria-label="Glavne akcije">
          <Link to="/parts" className="primary-action">Pregled kataloga</Link>
          <Link to="/special-order" className="secondary-action">Specijalna porudzbina</Link>
        </div>
      </section>

      <section className="feature-grid" aria-label="Planirane funkcionalnosti">
        {featureCards.map((card) => (
          <article className="feature-card" key={card.title}>
            <h2>{card.title}</h2>
            <p>{card.text}</p>
          </article>
        ))}
      </section>
    </main>
  )
}

function PlaceholderPage({ title }) {
  return (
    <main className="app-shell">
      <section className="placeholder-panel">
        <p className="eyebrow">U pripremi</p>
        <h1>{title}</h1>
        <p>Ova funkcionalnost ce biti implementirana u narednim fazama plana.</p>
        <Link to="/" className="secondary-action">Nazad na pocetnu</Link>
      </section>
    </main>
  )
}

function App() {
  return (
    <Layout>
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/login" element={<LoginPage />} />
        <Route path="/register" element={<RegisterPage />} />
        <Route path="/parts" element={<PartsPage />} />
        <Route path="/parts/:id" element={<PartDetailsPage />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/special-order" element={<PlaceholderPage title="Specijalno porucivanje" />} />

        {/* Zasticene klijentske rute */}
        <Route path="/checkout" element={
          <ProtectedRoute roles={['CLIENT']}>
            <CheckoutPage />
          </ProtectedRoute>
        } />
        <Route path="/orders" element={
          <ProtectedRoute roles={['CLIENT']}>
            <OrdersPage />
          </ProtectedRoute>
        } />

        {/* Zasticene employee rute */}
        <Route path="/employee/orders" element={
          <ProtectedRoute roles={['EMPLOYEE', 'ADMIN']}>
            <EmployeeOrdersPage />
          </ProtectedRoute>
        } />
        <Route path="/employee/parts" element={
          <ProtectedRoute roles={['EMPLOYEE', 'ADMIN']}>
            <EmployeePartsPage />
          </ProtectedRoute>
        } />
        <Route path="/employee/special-orders" element={
          <ProtectedRoute roles={['EMPLOYEE', 'ADMIN']}>
            <EmployeeSpecialOrdersPage />
          </ProtectedRoute>
        } />

        {/* Zasticena admin ruta */}
        <Route path="/admin/employees" element={
          <ProtectedRoute roles={['ADMIN']}>
            <AdminEmployeesPage />
          </ProtectedRoute>
        } />
      </Routes>
    </Layout>
  )
}

export default App
