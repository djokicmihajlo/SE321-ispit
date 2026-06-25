import { useState, useEffect } from 'react'
import { useParams, Link } from 'react-router-dom'
import api from '../api'
import { useCart } from '../context/CartContext'
import './Catalog.css'

export default function PartDetailsPage() {
  const { id } = useParams()
  const { addItem } = useCart()
  const [part, setPart] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [adding, setAdding] = useState(false)
  
  // Za "Obavesti me"
  const [notifyEmail, setNotifyEmail] = useState('')
  const [notifySuccess, setNotifySuccess] = useState('')

  useEffect(() => {
    const fetchPart = async () => {
      try {
        const data = await api.get(`/api/parts/${id}`)
        setPart(data)
      } catch (err) {
        setError('Artikal nije pronadjen.')
      } finally {
        setLoading(false)
      }
    }
    fetchPart()
  }, [id])

  const handleAdd = async () => {
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

  const handleNotify = async (e) => {
    e.preventDefault()
    try {
      await api.post('/api/notifications/restock', {
        partId: part.id,
        email: notifyEmail,
        channel: 'EMAIL'
      })
      setNotifySuccess('Zahtev za obavestenje uspesno poslat.')
      setNotifyEmail('')
    } catch (err) {
      alert(err.message || 'Greska pri slanju zahteva.')
    }
  }

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje...</div></main>
  if (error) return <main className="app-shell"><div className="error-message" role="alert">{error}</div></main>
  if (!part) return null

  return (
    <main className="app-shell">
      <div className="part-details">
        <div className="part-details-image">
          {part.imageUrl ? <img src={part.imageUrl} alt={part.name} /> : <div className="part-image-placeholder">Nema slike</div>}
        </div>
        
        <div className="part-details-info">
          <h1>{part.name}</h1>
          <p className="part-sku">SKU: {part.sku} | Proizvodjac: {part.manufacturer}</p>
          <p className="part-price">{part.price.toFixed(2)} RSD</p>
          
          <div className="part-description">
            <p>{part.description}</p>
          </div>

          <div className="part-compatibility">
            <h3>Kompatibilnost</h3>
            <p>Kategorija: {part.category?.name}</p>
            {part.vehicle && (
              <p>Vozilo: {part.vehicle.makeName} {part.vehicle.modelName}</p>
            )}
          </div>

          <div className="part-stock-status">
            {part.inStock ? (
              <span className="stock-in">Na stanju ({part.stockQuantity} komada)</span>
            ) : (
              <span className="stock-out">Nema na stanju</span>
            )}
          </div>

          {part.inStock ? (
            <button 
              onClick={handleAdd} 
              disabled={adding} 
              className="primary-action add-to-cart-btn"
            >
              {adding ? 'Dodavanje...' : 'Dodaj u korpu'}
            </button>
          ) : (
            <div className="notify-section">
              <h3>Obavesti me kada bude na stanju</h3>
              {notifySuccess ? (
                <div className="success-message" role="alert">{notifySuccess}</div>
              ) : (
                <form onSubmit={handleNotify} className="notify-form">
                  <input 
                    type="email" 
                    placeholder="vas@email.com" 
                    value={notifyEmail} 
                    onChange={(e) => setNotifyEmail(e.target.value)} 
                    required 
                  />
                  <button type="submit" className="secondary-action">Obavesti me</button>
                </form>
              )}
            </div>
          )}
        </div>
      </div>
    </main>
  )
}
