import { Link, Route, Routes } from 'react-router-dom'
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
    <Routes>
      <Route path="/" element={<HomePage />} />
      <Route path="/parts" element={<PlaceholderPage title="Katalog artikala" />} />
      <Route path="/special-order" element={<PlaceholderPage title="Specijalno porucivanje" />} />
    </Routes>
  )
}

export default App
