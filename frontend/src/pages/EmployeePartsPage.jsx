import { useState, useEffect } from 'react'
import api from '../api'
import './Admin.css'

export default function EmployeePartsPage() {
  const [parts, setParts] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [isAdding, setIsAdding] = useState(false)

  const initialForm = {
    categoryId: 1,
    vehicleMakeId: 1,
    vehicleModelId: 1,
    sku: '',
    name: '',
    description: '',
    manufacturer: '',
    price: 0,
    stockQuantity: 0,
    imageUrl: '/images/parts/placeholder.jpg',
    active: true
  }

  const [form, setForm] = useState(initialForm)

  const fetchParts = async () => {
    try {
      const data = await api.get('/api/parts')
      setParts(data)
    } catch (err) {
      setError('Greska pri ucitavanju artikala.')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchParts()
  }, [])

  const handleChange = (e) => {
    const value = e.target.type === 'checkbox' ? e.target.checked : e.target.value
    setForm({ ...form, [e.target.name]: value })
  }

  const handleAddSubmit = async (e) => {
    e.preventDefault()
    try {
      const payload = {
        ...form,
        categoryId: Number(form.categoryId),
        vehicleMakeId: Number(form.vehicleMakeId),
        vehicleModelId: Number(form.vehicleModelId),
        price: Number(form.price),
        stockQuantity: Number(form.stockQuantity)
      }
      await api.post('/api/employee/parts', payload)
      alert('Artikal uspesno dodat!')
      setForm(initialForm)
      setIsAdding(false)
      fetchParts()
    } catch (err) {
      alert('Greska pri dodavanju artikla.')
    }
  }

  const handleDelete = async (id) => {
    if (window.confirm('Brisanje artikla?')) {
      try {
        await api.delete(`/api/employee/parts/${id}`)
        fetchParts()
      } catch (err) {
        alert('Greska pri brisanju artikla.')
      }
    }
  }

  if (loading) return <main className="app-shell"><div className="loading-container">Ucitavanje...</div></main>

  return (
    <main className="app-shell">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
        <h1>Upravljanje artiklima</h1>
        <button className="primary-action" onClick={() => setIsAdding(!isAdding)}>
          {isAdding ? 'Zatvori formu' : 'Dodaj novi artikal'}
        </button>
      </div>
      
      {error && <div className="error-message">{error}</div>}

      {isAdding && (
        <form onSubmit={handleAddSubmit} className="admin-form" style={{ marginBottom: '32px' }}>
          <h3>Novi artikal</h3>
          <div className="form-grid">
            <div>
              <label>SKU</label>
              <input type="text" name="sku" value={form.sku} onChange={handleChange} required />
            </div>
            <div>
              <label>Naziv</label>
              <input type="text" name="name" value={form.name} onChange={handleChange} required />
            </div>
            <div>
              <label>Proizvodjac</label>
              <input type="text" name="manufacturer" value={form.manufacturer} onChange={handleChange} required />
            </div>
            <div>
              <label>Cena (RSD)</label>
              <input type="number" name="price" value={form.price} onChange={handleChange} required min="1" step="0.01" />
            </div>
            <div>
              <label>Na stanju</label>
              <input type="number" name="stockQuantity" value={form.stockQuantity} onChange={handleChange} required min="0" />
            </div>
            <div>
              <label>Image URL</label>
              <input type="text" name="imageUrl" value={form.imageUrl} onChange={handleChange} required />
            </div>
            <div style={{ gridColumn: '1 / -1' }}>
              <label>Opis</label>
              <textarea name="description" value={form.description} onChange={handleChange} required style={{ width: '100%', padding: '8px', minHeight: '80px' }} />
            </div>
            <div style={{ gridColumn: '1 / -1' }}>
              <label><input type="checkbox" name="active" checked={form.active} onChange={handleChange} /> Aktivan</label>
            </div>
          </div>
          <button type="submit" className="primary-action" style={{ marginTop: '16px' }}>Sacuvaj artikal</button>
        </form>
      )}

      <div className="admin-table-container">
        <table className="admin-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>SKU</th>
              <th>Naziv</th>
              <th>Cena</th>
              <th>Zaliha</th>
              <th>Akcije</th>
            </tr>
          </thead>
          <tbody>
            {parts.map(p => (
              <tr key={p.id}>
                <td>{p.id}</td>
                <td>{p.sku}</td>
                <td>{p.name}</td>
                <td>{p.price.toFixed(2)}</td>
                <td>{p.stockQuantity}</td>
                <td>
                  <button onClick={() => handleDelete(p.id)} style={{ color: 'red', border: 'none', background: 'none', cursor: 'pointer', textDecoration: 'underline' }}>Obrisi</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </main>
  )
}
