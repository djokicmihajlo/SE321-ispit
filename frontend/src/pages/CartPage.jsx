import { Link } from 'react-router-dom'
import { useCart } from '../context/CartContext'
import './Cart.css'

export default function CartPage() {
  const { cart, loading, updateItem, removeItem, clearCart } = useCart()

  if (loading) {
    return <main className="app-shell"><div className="loading-container">Ucitavanje korpe...</div></main>
  }

  const handleQuantityChange = async (itemId, newQuantity) => {
    if (newQuantity < 1) return
    await updateItem(itemId, newQuantity)
  }

  const handleRemove = async (itemId) => {
    if (window.confirm('Da li ste sigurni da zelite da uklonite ovaj artikal?')) {
      await removeItem(itemId)
    }
  }

  const handleClear = async () => {
    if (window.confirm('Da li ste sigurni da zelite da ispraznite korpu?')) {
      await clearCart()
    }
  }

  if (!cart.items || cart.items.length === 0) {
    return (
      <main className="app-shell">
        <div className="cart-empty">
          <h1>Vasa korpa je prazna</h1>
          <p>Trenutno nemate artikala u korpi.</p>
          <Link to="/parts" className="primary-action">Pregled kataloga</Link>
        </div>
      </main>
    )
  }

  return (
    <main className="app-shell">
      <div className="cart-header">
        <h1>Korpa</h1>
        <button onClick={handleClear} className="secondary-action">Isprazni korpu</button>
      </div>

      <div className="cart-layout">
        <div className="cart-items">
          {cart.items.map(item => (
            <div key={item.id} className="cart-item">
              <div className="cart-item-image">
                {item.imageUrl ? <img src={item.imageUrl} alt={item.name} /> : <span>Bez slike</span>}
              </div>
              <div className="cart-item-info">
                <h3><Link to={`/parts/${item.partId}`}>{item.name}</Link></h3>
                <p className="cart-item-sku">SKU: {item.sku}</p>
                <p className="cart-item-price">Cena: {item.unitPrice.toFixed(2)} RSD</p>
                
                <div className="cart-item-controls">
                  <div className="quantity-controls">
                    <button onClick={() => handleQuantityChange(item.id, item.quantity - 1)} disabled={item.quantity <= 1}>-</button>
                    <span>{item.quantity}</span>
                    <button onClick={() => handleQuantityChange(item.id, item.quantity + 1)} disabled={item.quantity >= item.stockQuantity}>+</button>
                  </div>
                  <button onClick={() => handleRemove(item.id)} className="remove-item-btn">Ukloni</button>
                </div>
                {!item.inStock && <p className="cart-item-error">Ovaj artikal vise nije na stanju.</p>}
                {item.quantity > item.stockQuantity && <p className="cart-item-error">Nema dovoljno kolicine na stanju (dostupno: {item.stockQuantity}).</p>}
              </div>
              <div className="cart-item-subtotal">
                <p>{item.subtotal.toFixed(2)} RSD</p>
              </div>
            </div>
          ))}
        </div>

        <div className="cart-summary">
          <h2>Ukupno</h2>
          <div className="summary-row total-row">
            <span>Za placanje:</span>
            <span>{cart.total.toFixed(2)} RSD</span>
          </div>
          <div className="summary-actions">
            <Link to="/checkout" className="primary-action checkout-btn">Nastavi na placanje</Link>
          </div>
        </div>
      </div>
    </main>
  )
}
