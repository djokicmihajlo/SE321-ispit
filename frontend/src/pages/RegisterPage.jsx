import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import './AuthPages.css'

export default function RegisterPage() {
  const { register } = useAuth()
  const navigate = useNavigate()

  const [form, setForm] = useState({
    firstName: '',
    lastName: '',
    email: '',
    phone: '',
    password: '',
    confirmPassword: '',
  })
  const [error, setError] = useState('')
  const [submitting, setSubmitting] = useState(false)

  const updateField = (field) => (e) =>
    setForm((prev) => ({ ...prev, [field]: e.target.value }))

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')

    if (form.password !== form.confirmPassword) {
      setError('Lozinke se ne poklapaju')
      return
    }

    setSubmitting(true)

    try {
      await register({
        firstName: form.firstName,
        lastName: form.lastName,
        email: form.email,
        phone: form.phone || undefined,
        password: form.password,
      })
      navigate('/')
    } catch (err) {
      setError(err.message || 'Greska pri registraciji')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <main className="auth-page">
      <form className="auth-form" onSubmit={handleSubmit} aria-label="Forma za registraciju">
        <h1>Registracija</h1>
        <p className="auth-subtitle">Napravite nalog za porucivanje auto delova.</p>

        {error && <div className="auth-error" role="alert">{error}</div>}

        <div className="auth-row">
          <div className="auth-field">
            <label htmlFor="reg-firstName">Ime</label>
            <input
              id="reg-firstName"
              type="text"
              value={form.firstName}
              onChange={updateField('firstName')}
              required
              placeholder="Ime"
            />
          </div>
          <div className="auth-field">
            <label htmlFor="reg-lastName">Prezime</label>
            <input
              id="reg-lastName"
              type="text"
              value={form.lastName}
              onChange={updateField('lastName')}
              required
              placeholder="Prezime"
            />
          </div>
        </div>

        <label htmlFor="reg-email">Email</label>
        <input
          id="reg-email"
          type="email"
          value={form.email}
          onChange={updateField('email')}
          required
          autoComplete="email"
          placeholder="vas@email.com"
        />

        <label htmlFor="reg-phone">Telefon (opciono)</label>
        <input
          id="reg-phone"
          type="tel"
          value={form.phone}
          onChange={updateField('phone')}
          autoComplete="tel"
          placeholder="+381..."
        />

        <label htmlFor="reg-password">Lozinka</label>
        <input
          id="reg-password"
          type="password"
          value={form.password}
          onChange={updateField('password')}
          required
          autoComplete="new-password"
          placeholder="Najmanje 8 karaktera"
          minLength={8}
        />

        <label htmlFor="reg-confirmPassword">Potvrdite lozinku</label>
        <input
          id="reg-confirmPassword"
          type="password"
          value={form.confirmPassword}
          onChange={updateField('confirmPassword')}
          required
          autoComplete="new-password"
          placeholder="Ponovite lozinku"
          minLength={8}
        />

        <button type="submit" className="auth-submit" disabled={submitting}>
          {submitting ? 'Kreiranje naloga...' : 'Registruj se'}
        </button>

        <p className="auth-footer">
          Vec imate nalog? <Link to="/login">Prijavite se</Link>
        </p>
      </form>
    </main>
  )
}
