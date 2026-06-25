import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../api'
import { useCart } from '../context/CartContext'
import './Cart.css'

export default function CheckoutPage() {
  const { cart, fetchCart } = useCart()
  const navigate = useNavigate()
  
  const [form, setForm] = useState({
    contactName: '',
    contactEmail: '',
    contactPhone: '',
    shippingAddress: '',
    shippingCity: '',
    shippingPostalCode: '',
    paymentMethod: 'CASH_ON_DELIVERY',
    cardHolder: '',
    cardNumber: '',
    expirationDate: '',
    cvv: ''
  })
  
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState('')

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value })
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    
    if (cart.items.length === 0) {
      setError('Korpa je prazna.')
      return
    }

    setSubmitting(true)

    try {
      const payload = {
        contactName: form.contactName,
        contactEmail: form.contactEmail,
        contactPhone: form.contactPhone,
        shippingAddress: form.shippingAddress,
        shippingCity: form.shippingCity,
        shippingPostalCode: form.shippingPostalCode,
        paymentMethod: form.paymentMethod,
        card: form.paymentMethod === 'CARD' ? {
          cardHolder: form.cardHolder,
          cardNumber: form.cardNumber,
          expirationDate: form.expirationDate,
          cvv: form.cvv
        } : null
      }

      await api.post('/api/orders', payload)
      await fetchCart() // Osvjezi korpu, trebalo bi da bude prazna
      alert('Porudzbina uspesno kreirana!')
      navigate('/orders')
    } catch (err) {
      setError(err.message || 'Greska pri kreiranju porudzbine.')
    } finally {
      setSubmitting(false)
    }
  }

  if (!cart.items || cart.items.length === 0) {
    return (
      <main className="app-shell">
        <div className="error-message">Vasa korpa je prazna. Dodajte artikle pre placanja.</div>
      </main>
    )
  }

  return (
    <main className="app-shell">
      <h1>Placanje i isporuka</h1>
      
      <div className="cart-layout">
        <div className="cart-items" style={{ background: '#fff', padding: '24px', border: '1px solid #d8dee4', borderRadius: '8px' }}>
          {error && <div className="error-message" role="alert">{error}</div>}
          
          <form onSubmit={handleSubmit} className="auth-form" style={{ maxWidth: '100%', border: 'none', padding: 0 }}>
            <h3>Podaci za kontakt</h3>
            <div className="auth-row">
              <div className="auth-field">
                <label htmlFor="contactName">Ime i prezime</label>
                <input id="contactName" type="text" name="contactName" value={form.contactName} onChange={handleChange} required />
              </div>
              <div className="auth-field">
                <label htmlFor="contactPhone">Telefon</label>
                <input id="contactPhone" type="text" name="contactPhone" value={form.contactPhone} onChange={handleChange} required />
              </div>
            </div>
            <label htmlFor="contactEmail">Email</label>
            <input id="contactEmail" type="email" name="contactEmail" value={form.contactEmail} onChange={handleChange} required />

            <h3 style={{ marginTop: '24px' }}>Adresa za isporuku</h3>
            <label htmlFor="shippingAddress">Adresa (ulica i broj)</label>
            <input id="shippingAddress" type="text" name="shippingAddress" value={form.shippingAddress} onChange={handleChange} required />
            <div className="auth-row">
              <div className="auth-field">
                <label htmlFor="shippingCity">Grad</label>
                <input id="shippingCity" type="text" name="shippingCity" value={form.shippingCity} onChange={handleChange} required />
              </div>
              <div className="auth-field">
                <label htmlFor="shippingPostalCode">Postanski broj</label>
                <input id="shippingPostalCode" type="text" name="shippingPostalCode" value={form.shippingPostalCode} onChange={handleChange} required />
              </div>
            </div>

            <h3 style={{ marginTop: '24px' }}>Nacin placanja</h3>
            <div style={{ marginBottom: '16px' }}>
              <label style={{ display: 'inline-block', marginRight: '16px', fontWeight: 'normal' }}>
                <input type="radio" name="paymentMethod" value="CASH_ON_DELIVERY" checked={form.paymentMethod === 'CASH_ON_DELIVERY'} onChange={handleChange} /> Pouzecem
              </label>
              <label style={{ display: 'inline-block', fontWeight: 'normal' }}>
                <input type="radio" name="paymentMethod" value="CARD" checked={form.paymentMethod === 'CARD'} onChange={handleChange} /> Karticom
              </label>
            </div>

            {form.paymentMethod === 'CARD' && (
              <div style={{ padding: '16px', background: '#f8fafc', borderRadius: '8px', border: '1px solid #d8dee4', marginBottom: '16px' }}>
                <label>Ime na kartici</label>
                <input type="text" name="cardHolder" value={form.cardHolder} onChange={handleChange} required={form.paymentMethod === 'CARD'} />
                
                <label>Broj kartice</label>
                <input type="text" name="cardNumber" value={form.cardNumber} onChange={handleChange} required={form.paymentMethod === 'CARD'} placeholder="XXXX XXXX XXXX XXXX" />
                
                <div className="auth-row">
                  <div className="auth-field">
                    <label>Datum isteka</label>
                    <input type="text" name="expirationDate" value={form.expirationDate} onChange={handleChange} required={form.paymentMethod === 'CARD'} placeholder="MM/YY" />
                  </div>
                  <div className="auth-field">
                    <label>CVV</label>
                    <input type="text" name="cvv" value={form.cvv} onChange={handleChange} required={form.paymentMethod === 'CARD'} />
                  </div>
                </div>
              </div>
            )}

            <button type="submit" className="primary-action auth-submit" disabled={submitting}>
              {submitting ? 'Kreiranje porudzbine...' : 'Zavrsi porudzbinu'}
            </button>
          </form>
        </div>
        
        <div className="cart-summary">
          <h2>Rezime porudzbine</h2>
          <p>Ukupno stavki: {cart.items.length}</p>
          <div className="summary-row total-row">
            <span>Za placanje:</span>
            <span>{cart.total.toFixed(2)} RSD</span>
          </div>
        </div>
      </div>
    </main>
  )
}
