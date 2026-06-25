import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import './AuthPages.css'

export default function LoginPage() {
  const { login } = useAuth()
  const navigate = useNavigate()

  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [submitting, setSubmitting] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSubmitting(true)

    try {
      const user = await login(email, password)
      if (user.role === 'EMPLOYEE' || user.role === 'ADMIN') {
        navigate('/employee/orders')
      } else {
        navigate('/')
      }
    } catch (err) {
      setError(err.message || 'Greska pri prijavi')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <main className="auth-page">
      <form className="auth-form" onSubmit={handleSubmit} aria-label="Forma za prijavu">
        <h1>Prijava</h1>
        <p className="auth-subtitle">Unesite kredencijale da biste pristupili nalogu.</p>

        {error && <div className="auth-error" role="alert">{error}</div>}

        <label htmlFor="login-email">Email</label>
        <input
          id="login-email"
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          autoComplete="email"
          placeholder="vas@email.com"
        />

        <label htmlFor="login-password">Lozinka</label>
        <input
          id="login-password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          autoComplete="current-password"
          placeholder="Unesite lozinku"
        />

        <button type="submit" className="auth-submit" disabled={submitting}>
          {submitting ? 'Prijavljivanje...' : 'Prijavi se'}
        </button>

        <p className="auth-footer">
          Nemate nalog? <Link to="/register">Registrujte se</Link>
        </p>
      </form>
    </main>
  )
}
