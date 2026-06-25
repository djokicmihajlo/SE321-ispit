import { useState, useEffect } from 'react'
import api from '../api'
import './Admin.css'

export default function EmployeeOrdersPage() {
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  const fetchOrders = async () => {
    try {
      const data = await api.get('/api/employee/orders')
      setOrders(data)
    } catch (err) {
      setError('Greska pri ucitavanju porudzbina.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchOrders()
  }, [])

  const handleStatusChange = async (id, newStatus) => {
    try {
      await api.patch(`/api/employee/orders/${id}/status`, { status: newStatus })
      alert('Status uspesno azuriran.')
      fetchOrders()
    } catch (err) {
      alert('Greska pri azuriranju statusa.')
    }
  }

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje porudzbina...</div></main>

  return (
    <main className="app-shell">
      <h1>Sve porudzbine (Zaposleni)</h1>
      {error && <div className="error-message">{error}</div>}

      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Broj Porudzbine</th>
              <th>Klijent</th>
              <th>Datum</th>
              <th>Ukupno</th>
              <th>Status</th>
              <th>Akcije</th>
            </tr>
          </thead>
          <tbody>
            {orders.map(o => (
              <tr key={o.id}>
                <td>{o.orderNumber}</td>
                <td>{o.clientName} ({o.contactEmail})</td>
                <td>{new Date(o.createdAt).toLocaleString('sr-RS')}</td>
                <td>{o.total.toFixed(2)} RSD</td>
                <td>{o.status}</td>
                <td>
                  <select 
                    value={o.status} 
                    onChange={(e) => handleStatusChange(o.id, e.target.value)}
                  >
                    <option value="CREATED">CREATED</option>
                    <option value="PROCESSING">PROCESSING</option>
                    <option value="SHIPPED">SHIPPED</option>
                    <option value="DELIVERED">DELIVERED</option>
                    <option value="CANCELLED">CANCELLED</option>
                  </select>
                </td>
              </tr>
            ))}
            {orders.length === 0 && (
              <tr><td colSpan="6">Nema porudzbina.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </main>
  )
}
