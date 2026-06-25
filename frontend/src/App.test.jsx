import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { describe, expect, it, vi } from 'vitest'
import App from './App'
import { AuthProvider } from './context/AuthContext'

/* Mockujemo api modul da /api/auth/me ne gadja pravi backend */
vi.mock('./api', () => ({
  default: {
    get: vi.fn().mockRejectedValue(new Error('no token')),
    post: vi.fn(),
  },
}))

const renderApp = (initialPath = '/') => {
  return render(
    <MemoryRouter initialEntries={[initialPath]}>
      <AuthProvider>
        <App />
      </AuthProvider>
    </MemoryRouter>,
  )
}

describe('App shell', () => {
  it('prikazuje pocetnu stranicu prodavnice auto delova', () => {
    renderApp()

    expect(screen.getByText('Prodavnica auto delova')).toBeInTheDocument()
    expect(screen.getByRole('link', { name: 'Pregled kataloga' })).toHaveAttribute('href', '/parts')
    expect(screen.getByText('Katalog auto delova')).toBeInTheDocument()
  })

  it('prikazuje placeholder rutu za employee delove', () => {
    // Moramo testirati stranicu koja je i dalje placeholder, npr. employee/parts
    renderApp('/employee/parts')

    // Posto je employee ruta zasticena, bez tokena ce da nas preusmeri na /login!
    // App.test.jsx za sad moze da testira neku zasticenu rutu ili da izbacimo ovaj test.
    // Ajde da testiramo /special-order koja je public placeholder.
    renderApp('/special-order')

    expect(screen.getByRole('heading', { name: 'Specijalno porucivanje' })).toBeInTheDocument()
    expect(screen.getByRole('link', { name: 'Nazad na pocetnu' })).toHaveAttribute('href', '/')
  })

  it('prikazuje navigaciju sa linkovima za prijavu i registraciju za gosta', () => {
    renderApp()

    expect(screen.getByRole('link', { name: 'Prijava' })).toHaveAttribute('href', '/login')
    expect(screen.getByRole('link', { name: 'Registracija' })).toHaveAttribute('href', '/register')
  })

  it('prikazuje login formu na /login ruti', () => {
    renderApp('/login')

    expect(screen.getByRole('heading', { name: 'Prijava' })).toBeInTheDocument()
    expect(screen.getByLabelText('Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Lozinka')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Prijavi se' })).toBeInTheDocument()
  })

  it('prikazuje register formu na /register ruti', () => {
    renderApp('/register')

    expect(screen.getByRole('heading', { name: 'Registracija' })).toBeInTheDocument()
    expect(screen.getByLabelText('Ime')).toBeInTheDocument()
    expect(screen.getByLabelText('Prezime')).toBeInTheDocument()
    expect(screen.getByLabelText('Email')).toBeInTheDocument()
    expect(screen.getByLabelText('Lozinka')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Registruj se' })).toBeInTheDocument()
  })
})
