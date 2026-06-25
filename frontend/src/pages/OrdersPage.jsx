import { useState, useEffect } from 'react'
import api from '../api'

export default function OrdersPage() {
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const data = await api.get('/api/orders/my')
        setOrders(data)
      } catch (err) {
        setError('Greska pri ucitavanju istorije porudzbina.')
      } finally {
        setLoading(false)
      }
    }
    fetchOrders()
  }, [])

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje istorije porudzbina...</div></main>

  return (
    <main className="app-shell">
      <h1>Moje porudzbine</h1>
      
      {error && <div className="error-message">{error}</div>}
      
      {orders.length === 0 ? (
        <p className="empty-message">Nemate prethodnih porudzbina.</p>
      ) : (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
          {orders.map(order => (
            <div key={order.id} style={{ background: '#fff', border: '1px solid #d8dee4', borderRadius: '8px', padding: '20px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '16px', paddingBottom: '16px', borderBottom: '1px solid #eef1f4' }}>
                <div>
                  <h3 style={{ margin: '0 0 8px 0' }}>Porudzbina #{order.orderNumber}</h3>
                  <p style={{ margin: 0, color: '#5b6b75', fontSize: '0.9rem' }}>Datum: {new Date(order.createdAt).toLocaleString('sr-RS')}</p>
                </div>
                <div style={{ textAlign: 'right' }}>
                  <span style={{ display: 'inline-block', padding: '4px 8px', background: '#eef1f4', borderRadius: '4px', fontSize: '0.85rem', fontWeight: 'bold' }}>{order.status}</span>
                  <p style={{ margin: '8px 0 0 0', fontWeight: 'bold', fontSize: '1.1rem' }}>{order.total.toFixed(2)} RSD</p>
                </div>
              </div>
              
              <div>
                <h4 style={{ margin: '0 0 12px 0', fontSize: '0.95rem' }}>Stavke porudzbine:</h4>
                <ul style={{ margin: 0, paddingLeft: '20px', color: '#51616b' }}>
                  {order.items.map(item => (
                    <li key={item.id} style={{ marginBottom: '6px' }}>
                      {item.partName} x {item.quantity} - {item.subtotal.toFixed(2)} RSD
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          ))}
        </div>
      )}
    </main>
  )
}
