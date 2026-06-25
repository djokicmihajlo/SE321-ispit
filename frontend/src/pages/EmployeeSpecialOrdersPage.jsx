import { useState, useEffect } from 'react'
import api from '../api'
import './Admin.css'

export default function EmployeeSpecialOrdersPage() {
  const [orders, setOrders] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  const fetchOrders = async () => {
    try {
      const data = await api.get('/api/employee/special-orders')
      setOrders(data)
    } catch (err) {
      setError('Greska pri ucitavanju specijalnih porudzbina.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchOrders()
  }, [])

  const handleStatusChange = async (id, newStatus) => {
    // Da bi bilo jednostavno, employee message cemo hardkodovati
    const message = prompt('Unesite poruku za klijenta (opciono):', '')
    try {
      await api.patch(`/api/employee/special-orders/${id}/status`, { 
        status: newStatus,
        employeeMessage: message || 'Status je azuriran'
      })
      alert('Status uspesno azuriran.')
      fetchOrders()
    } catch (err) {
      alert('Greska pri azuriranju statusa.')
    }
  }

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje specijalnih porudzbina...</div></main>

  return (
    <main className="app-shell">
      <h1>Specijalne porudzbine (Zaposleni)</h1>
      {error && <div className="error-message">{error}</div>}

      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>Datum</th>
              <th>Klijent</th>
              <th>Artikal</th>
              <th>Opis</th>
              <th>Status</th>
              <th>Akcije</th>
            </tr>
          </thead>
          <tbody>
            {orders.map(o => (
              <tr key={o.id}>
                <td>{new Date(o.createdAt).toLocaleString('sr-RS')}</td>
                <td>{o.clientName}</td>
                <td>{o.partName}</td>
                <td>{o.description}</td>
                <td>{o.status}</td>
                <td>
                  <select 
                    value={o.status} 
                    onChange={(e) => handleStatusChange(o.id, e.target.value)}
                  >
                    <option value="PENDING">PENDING</option>
                    <option value="REVIEWING">REVIEWING</option>
                    <option value="APPROVED">APPROVED</option>
                    <option value="REJECTED">REJECTED</option>
                    <option value="ORDERED">ORDERED</option>
                    <option value="ARRIVED">ARRIVED</option>
                    <option value="DELIVERED">DELIVERED</option>
                  </select>
                </td>
              </tr>
            ))}
            {orders.length === 0 && (
              <tr><td colSpan="6">Nema specijalnih porudzbina.</td></tr>
            )}
          </tbody>
        </table>
      </div>
    </main>
  )
}
