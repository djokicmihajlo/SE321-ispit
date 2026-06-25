import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { afterAll, afterEach, beforeAll, describe, expect, it } from 'vitest'
import { setupServer } from 'msw/node'
import { http, HttpResponse } from 'msw'
import EmployeeOrdersPage from '../pages/EmployeeOrdersPage'
import AdminEmployeesPage from '../pages/AdminEmployeesPage'
import { AuthProvider } from '../context/AuthContext'
import { CartProvider } from '../context/CartContext'

const mockOrders = [
  {
    id: 1,
    orderNumber: 'ORD-TEST-1',
    clientName: 'Test Klijent',
    contactEmail: 'klijent@test.com',
    createdAt: new Date().toISOString(),
    total: 5000,
    status: 'CREATED'
  }
]

const mockEmployees = [
  { id: 1, firstName: 'Radnik', lastName: 'Zaposleni', email: 'radnik@test.com', role: 'EMPLOYEE' }
]

const server = setupServer(
  http.get('*/api/auth/me', () => {
    return HttpResponse.json({
      id: 2,
      firstName: 'Admin',
      lastName: 'User',
      role: 'ADMIN'
    })
  }),
  http.get('*/api/employee/orders', () => {
    return HttpResponse.json(mockOrders)
  }),
  http.patch('*/api/employee/orders/:id/status', async ({ request }) => {
    const data = await request.json()
    return HttpResponse.json({ id: 1, status: data.status })
  }),
  http.get('*/api/admin/employees', () => {
    return HttpResponse.json(mockEmployees)
  }),
  http.post('*/api/admin/employees', async ({ request }) => {
    const data = await request.json()
    return HttpResponse.json({ id: 2, ...data, role: 'EMPLOYEE' })
  }),
  http.get('*/api/cart', () => {
    return HttpResponse.json({ items: [], total: 0 })
  })
)

beforeAll(() => server.listen({ onUnhandledRequest: 'error' }))
afterEach(() => {
  server.resetHandlers()
  localStorage.clear()
  vi.clearAllMocks()
})
afterAll(() => server.close())

const renderWithContext = (ui, initialPath = '/') => {
  localStorage.setItem('token', 'fake-token')
  return render(
    <MemoryRouter initialEntries={[initialPath]}>
      <AuthProvider>
        <CartProvider>
          <Routes>
            <Route path="/*" element={ui} />
          </Routes>
        </CartProvider>
      </AuthProvider>
    </MemoryRouter>
  )
}

describe('Zaposleni i Admin (MSW)', () => {
  it('Prikazuje listu porudzbina za zaposlenog i menja status', async () => {
    window.alert = vi.fn()
    const user = userEvent.setup()

    renderWithContext(<EmployeeOrdersPage />)

    await waitFor(() => expect(screen.getByText('ORD-TEST-1')).toBeInTheDocument())
    
    const select = screen.getByRole('combobox')
    expect(select).toHaveValue('CREATED')

    await user.selectOptions(select, 'SHIPPED')

    await waitFor(() => {
      expect(window.alert).toHaveBeenCalledWith('Status uspesno azuriran.')
    })
  })

  it('Prikazuje zaposlene za admina i kreira novog zaposlenog', async () => {
    window.alert = vi.fn()
    const user = userEvent.setup()

    renderWithContext(<AdminEmployeesPage />)

    await waitFor(() => expect(screen.getByText('radnik@test.com')).toBeInTheDocument())

    await user.click(screen.getByRole('button', { name: 'Dodaj novog zaposlenog' }))

    await user.type(screen.getByLabelText('Ime'), 'Novi')
    await user.type(screen.getByLabelText('Prezime'), 'Zaposleni')
    await user.type(screen.getByLabelText('Email'), 'novi@test.com')
    await user.type(screen.getByLabelText('Lozinka'), 'Lozinka123!')

    // Intercept kreiranje da sledeci GET vrati oba
    server.use(
      http.get('*/api/admin/employees', () => {
        return HttpResponse.json([
          ...mockEmployees,
          { id: 2, firstName: 'Novi', lastName: 'Zaposleni', email: 'novi@test.com', role: 'EMPLOYEE' }
        ])
      })
    )

    await user.click(screen.getByRole('button', { name: 'Kreiraj nalog' }))

    await waitFor(() => {
      expect(window.alert).toHaveBeenCalledWith('Zaposleni uspesno kreiran!')
      expect(screen.getByText('novi@test.com')).toBeInTheDocument()
    })
  })
})
