import { useState, useEffect } from 'react'
import { Link, useSearchParams } from 'react-router-dom'
import api from '../api'
import './Catalog.css'
import { useCart } from '../context/CartContext'

export default function PartsPage() {
  const [parts, setParts] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [searchParams, setSearchParams] = useSearchParams()

  const searchTerm = searchParams.get('search') || ''
  const categorySlug = searchParams.get('categorySlug') || ''
  const make = searchParams.get('make') || ''
  const model = searchParams.get('model') || ''

  useEffect(() => {
    const fetchParts = async () => {
      setLoading(true)
      setError('')
      try {
        const params = new URLSearchParams()
        if (searchTerm) params.append('search', searchTerm)
        if (categorySlug) params.append('categorySlug', categorySlug)
        if (make) params.append('make', make)
        if (model) params.append('model', model)

        const data = await api.get(`/api/parts?${params.toString()}`)
        setParts(data)
      } catch (err) {
        setError('Greska pri ucitavanju kataloga.')
      } finally {
        setLoading(false)
      }
    }
    fetchParts()
  }, [searchTerm, categorySlug, make, model])

  const handleFilterChange = (e) => {
    const { name, value } = e.target
    const newParams = new URLSearchParams(searchParams)
    if (value) {
      newParams.set(name, value)
    } else {
      newParams.delete(name)
    }
    setSearchParams(newParams)
  }

  const handleSearch = (e) => {
    e.preventDefault()
    // Forma automatski okida promenu kroz URLSearchParams ako koristimo onSubmit,
    // ali za React pristup obicno se direktno azurira state u inputu i salje na form submit.
    const formData = new FormData(e.target)
    const newParams = new URLSearchParams(searchParams)
    const s = formData.get('search')
    if (s) {
      newParams.set('search', s)
    } else {
      newParams.delete('search')
    }
    setSearchParams(newParams)
  }

  return (
    <main className="app-shell">
      <div className="catalog-header">
        <h1>Katalog artikala</h1>
        <form className="search-bar" onSubmit={handleSearch} role="search">
          <input 
            type="search" 
            name="search" 
            defaultValue={searchTerm} 
            placeholder="Pretraga po nazivu..." 
            aria-label="Pretraga artikala"
          />
          <button type="submit" className="primary-action">Trazi</button>
        </form>
      </div>

      <div className="catalog-layout">
        <aside className="catalog-filters" aria-label="Filteri">
          <h2>Filteri</h2>
          <div className="filter-group">
            <label htmlFor="categorySlug">Kategorija</label>
            <select id="categorySlug" name="categorySlug" value={categorySlug} onChange={handleFilterChange}>
              <option value="">Sve kategorije</option>
              <option value="kocioni-sistem">Kocioni sistem</option>
              <option value="filteri">Filteri</option>
              <option value="elektrika">Elektrika</option>
              <option value="menjac">Menjac</option>
            </select>
          </div>
          <div className="filter-group">
            <label htmlFor="make">Proizvodjac</label>
            <select id="make" name="make" value={make} onChange={handleFilterChange}>
              <option value="">Svi proizvodjaci</option>
              <option value="Volkswagen">Volkswagen</option>
              <option value="Opel">Opel</option>
              <option value="Fiat">Fiat</option>
            </select>
          </div>
          <div className="filter-group">
            <label htmlFor="model">Model</label>
            <select id="model" name="model" value={model} onChange={handleFilterChange}>
              <option value="">Svi modeli</option>
              <option value="Golf 7">Golf 7</option>
              <option value="Astra J">Astra J</option>
              <option value="Punto">Punto</option>
            </select>
          </div>
        </aside>

        <section className="catalog-content" aria-label="Lista artikala">
          {error && <div className="error-message" role="alert">{error}</div>}
          
          {loading ? (
            <div className="loading-container" aria-label="Ucitavanje">Ucitavanje...</div>
          ) : parts.length === 0 ? (
            <p className="empty-message">Nema artikala koji odgovaraju pretrazi.</p>
          ) : (
            <div className="parts-grid">
              {parts.map(part => (
                <PartCard key={part.id} part={part} />
              ))}
            </div>
          )}
        </section>
      </div>
    </main>
  )
}

function PartCard({ part }) {
  const { addItem } = useCart()
  const [adding, setAdding] = useState(false)

  const handleAdd = async () => {
    if (!part.inStock) return
    setAdding(true)
    try {
      await addItem(part, 1)
      alert('Dodato u korpu!')
    } catch (err) {
      alert('Greska pri dodavanju u korpu.')
    } finally {
      setAdding(false)
    }
  }

  return (
    <article className="part-card">
      <Link to={`/parts/${part.id}`} className="part-image-link">
        <div className="part-image-placeholder">
          {part.imageUrl ? <img src={part.imageUrl} alt={part.name} /> : <span>Nema slike</span>}
        </div>
      </Link>
      <div className="part-info">
        <h3 className="part-name"><Link to={`/parts/${part.id}`}>{part.name}</Link></h3>
        <p className="part-sku">SKU: {part.sku}</p>
        <p className="part-price">{part.price.toFixed(2)} RSD</p>
        
        <div className="part-stock">
          {part.inStock ? (
            <span className="stock-in">Na stanju ({part.stockQuantity})</span>
          ) : (
            <span className="stock-out">Nema na stanju</span>
          )}
        </div>

        <div className="part-actions">
          <button 
            onClick={handleAdd} 
            disabled={!part.inStock || adding} 
            className="primary-action add-to-cart-btn"
          >
            {adding ? 'Dodavanje...' : 'Dodaj u korpu'}
          </button>
        </div>
      </div>
    </article>
  )
}
