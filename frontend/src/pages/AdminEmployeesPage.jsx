import { useState, useEffect } from 'react'
import api from '../api'
import './Admin.css'

export default function AdminEmployeesPage() {
  const [employees, setEmployees] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [isAdding, setIsAdding] = useState(false)

  const initialForm = {
    firstName: '',
    lastName: '',
    email: '',
    password: ''
  }

  const [form, setForm] = useState(initialForm)

  const fetchEmployees = async () => {
    try {
      const data = await api.get('/api/admin/employees')
      setEmployees(data)
    } catch (err) {
      setError('Greska pri ucitavanju zaposlenih.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchEmployees()
  }, [])

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value })
  }

  const handleAddSubmit = async (e) => {
    e.preventDefault()
    try {
      await api.post('/api/admin/employees', form)
      alert('Zaposleni uspesno kreiran!')
      setForm(initialForm)
      setIsAdding(false)
      fetchEmployees()
    } catch (err) {
      alert('Greska pri kreiranju zaposlenog.')
    }
  }

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje...</div></main>

  return (
    <main className="app-shell">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <h1>Zaposleni (Admin)</h1>
        <button className="primary-action" onClick={() => setIsAdding(!isAdding)}>
          {isAdding ? 'Zatvori formu' : 'Dodaj novog zaposlenog'}
        </button>
      </div>
      
      {error && <div className="error-message">{error}</div>}

      {isAdding && (
        <form onSubmit={handleAddSubmit} className="admin-form" style={{ marginBottom: '32px' }}>
          <h3>Novi zaposleni</h3>
          <div className="form-grid">
            <div>
              <label htmlFor="firstName">Ime</label>
              <input id="firstName" type="text" name="firstName" value={form.firstName} onChange={handleChange} required />
            </div>
            <div>
              <label htmlFor="lastName">Prezime</label>
              <input id="lastName" type="text" name="lastName" value={form.lastName} onChange={handleChange} required />
            </div>
            <div>
              <label htmlFor="email">Email</label>
              <input id="email" type="email" name="email" value={form.email} onChange={handleChange} required />
            </div>
            <div>
              <label htmlFor="password">Lozinka</label>
              <input id="password" type="password" name="password" value={form.password} onChange={handleChange} required minLength="8" />
            </div>
          </div>
          <button type="submit" className="primary-action" style={{ marginTop: '16px' }}>Kreiraj nalog</button>
        </form>
      )}

      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Ime i Prezime</th>
              <th>Email</th>
              <th>Uloga</th>
            </tr>
          </thead>
          <tbody>
            {employees.map(e => (
              <tr key={e.id}>
                <td>{e.id}</td>
                <td>{e.firstName} {e.lastName}</td>
                <td>{e.email}</td>
                <td>{e.role}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </main>
  )
}
