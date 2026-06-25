import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MemoryRouter } from 'react-router-dom'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import App from '../App'
import { AuthProvider } from '../context/AuthContext'
import api from '../api'

vi.mock('../api', () => ({
  default: {
    get: vi.fn(),
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

describe('Auth tokovi', () => {
  beforeEach(() => {
    localStorage.clear()
    vi.clearAllMocks()
    api.get.mockRejectedValue(new Error('no token'))
  })

  afterEach(() => {
    localStorage.clear()
  })

  it('uspesan login cuva token i prikazuje korisnicko ime', async () => {
    const user = userEvent.setup()

    api.post.mockResolvedValueOnce({
      token: 'fake-jwt-token',
      user: {
        id: 1,
        firstName: 'Ana',
        lastName: 'Jovanovic',
        email: 'ana@example.com',
        phone: null,
        role: 'CLIENT',
        active: true,
      },
    })

    renderApp('/login')

    await user.type(screen.getByLabelText('Email'), 'ana@example.com')
    await user.type(screen.getByLabelText('Lozinka'), 'Password1!')
    await user.click(screen.getByRole('button', { name: 'Prijavi se' }))

    await waitFor(() => {
      expect(screen.getByText('Ana Jovanovic')).toBeInTheDocument()
    })

    expect(localStorage.getItem('token')).toBe('fake-jwt-token')
    expect(api.post).toHaveBeenCalledWith('/api/auth/login', {
      email: 'ana@example.com',
      password: 'Password1!',
    })
  })

  it('prikazuje gresku kada su kredencijali nevalidni', async () => {
    const user = userEvent.setup()

    api.post.mockRejectedValueOnce(new Error('Invalid credentials'))

    renderApp('/login')

    await user.type(screen.getByLabelText('Email'), 'los@email.com')
    await user.type(screen.getByLabelText('Lozinka'), 'pogresna123')
    await user.click(screen.getByRole('button', { name: 'Prijavi se' }))

    await waitFor(() => {
      expect(screen.getByRole('alert')).toHaveTextContent('Invalid credentials')
    })

    expect(localStorage.getItem('token')).toBeNull()
  })

  it('uspesna registracija cuva token i preusmerava na pocetnu', async () => {
    const user = userEvent.setup()

    api.post.mockResolvedValueOnce({
      token: 'new-jwt-token',
      user: {
        id: 2,
        firstName: 'Marko',
        lastName: 'Petrovic',
        email: 'marko@example.com',
        phone: '+381641112223',
        role: 'CLIENT',
        active: true,
      },
    })

    renderApp('/register')

    await user.type(screen.getByLabelText('Ime'), 'Marko')
    await user.type(screen.getByLabelText('Prezime'), 'Petrovic')
    await user.type(screen.getByLabelText('Email'), 'marko@example.com')
    await user.type(screen.getByLabelText('Telefon (opciono)'), '+381641112223')
    await user.type(screen.getByLabelText('Lozinka'), 'Password1!')
    await user.type(screen.getByLabelText('Potvrdite lozinku'), 'Password1!')
    await user.click(screen.getByRole('button', { name: 'Registruj se' }))

    await waitFor(() => {
      expect(screen.getByText('Marko Petrovic')).toBeInTheDocument()
    })

    expect(localStorage.getItem('token')).toBe('new-jwt-token')
  })

  it('registracija prikazuje gresku za nepodudarajuce lozinke', async () => {
    const user = userEvent.setup()

    renderApp('/register')

    await user.type(screen.getByLabelText('Ime'), 'Test')
    await user.type(screen.getByLabelText('Prezime'), 'User')
    await user.type(screen.getByLabelText('Email'), 'test@example.com')
    await user.type(screen.getByLabelText('Lozinka'), 'Password1!')
    await user.type(screen.getByLabelText('Potvrdite lozinku'), 'DrugiPassword2!')
    await user.click(screen.getByRole('button', { name: 'Registruj se' }))

    await waitFor(() => {
      expect(screen.getByRole('alert')).toHaveTextContent('Lozinke se ne poklapaju')
    })

    expect(api.post).not.toHaveBeenCalled()
  })

  it('odjava uklanja token i prikazuje guest navigaciju', async () => {
    const user = userEvent.setup()

    api.post.mockResolvedValueOnce({
      token: 'temp-token',
      user: {
        id: 1,
        firstName: 'Ana',
        lastName: 'Jovanovic',
        email: 'ana@example.com',
        phone: null,
        role: 'CLIENT',
        active: true,
      },
    })

    renderApp('/login')

    await user.type(screen.getByLabelText('Email'), 'ana@example.com')
    await user.type(screen.getByLabelText('Lozinka'), 'Password1!')
    await user.click(screen.getByRole('button', { name: 'Prijavi se' }))

    await waitFor(() => {
      expect(screen.getByText('Ana Jovanovic')).toBeInTheDocument()
    })

    await user.click(screen.getByRole('button', { name: 'Odjavi se' }))

    await waitFor(() => {
      expect(screen.getByRole('link', { name: 'Prijava' })).toBeInTheDocument()
    })

    expect(localStorage.getItem('token')).toBeNull()
  })

  it('hidracija ucitava korisnika iz sacuvanog tokena', async () => {
    localStorage.setItem('token', 'existing-token')

    api.get.mockResolvedValueOnce({
      id: 3,
      firstName: 'Jovan',
      lastName: 'Nikolic',
      email: 'jovan@example.com',
      phone: null,
      role: 'EMPLOYEE',
      active: true,
    })

    renderApp()

    await waitFor(() => {
      expect(screen.getByText('Jovan Nikolic')).toBeInTheDocument()
    })

    expect(api.get).toHaveBeenCalledWith('/api/auth/me')
  })

  it('employee login prikazuje employee linkove u navigaciji', async () => {
    const user = userEvent.setup()

    api.post.mockResolvedValueOnce({
      token: 'emp-token',
      user: {
        id: 4,
        firstName: 'Zaposleni',
        lastName: 'Test',
        email: 'employee@autodelovi.test',
        phone: null,
        role: 'EMPLOYEE',
        active: true,
      },
    })

    renderApp('/login')

    await user.type(screen.getByLabelText('Email'), 'employee@autodelovi.test')
    await user.type(screen.getByLabelText('Lozinka'), 'Password1!')
    await user.click(screen.getByRole('button', { name: 'Prijavi se' }))

    await waitFor(() => {
      expect(screen.getByText('Zaposleni Test')).toBeInTheDocument()
    })

    expect(screen.getByRole('link', { name: 'Porudzbine' })).toHaveAttribute('href', '/employee/orders')
    expect(screen.getByRole('link', { name: 'Artikli' })).toHaveAttribute('href', '/employee/parts')
  })
})
