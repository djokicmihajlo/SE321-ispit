import { render, screen, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { afterAll, afterEach, beforeAll, describe, expect, it } from 'vitest'
import { setupServer } from 'msw/node'
import { http, HttpResponse } from 'msw'
import PartsPage from '../pages/PartsPage'
import PartDetailsPage from '../pages/PartDetailsPage'
import CartPage from '../pages/CartPage'
import CheckoutPage from '../pages/CheckoutPage'
import { CartProvider } from '../context/CartContext'
import { AuthProvider } from '../context/AuthContext'

const mockParts = [
  {
    id: 1,
    sku: 'TEST-1',
    name: 'Brake Pad A',
    price: 1500,
    stockQuantity: 5,
    inStock: true,
    category: { name: 'Kocioni sistem' }
  },
  {
    id: 2,
    sku: 'TEST-2',
    name: 'Out of stock Filter',
    price: 1200,
    stockQuantity: 0,
    inStock: false,
    category: { name: 'Filteri' }
  }
]

const server = setupServer(
  http.get('*/api/auth/me', () => {
    return HttpResponse.json({
      id: 1,
      firstName: 'Test',
      lastName: 'Client',
      role: 'CLIENT'
    })
  }),
  http.get('*/api/parts', ({ request }) => {
    const url = new URL(request.url)
    const search = url.searchParams.get('search')
    if (search === 'Brake') {
      return HttpResponse.json([mockParts[0]])
    }
    return HttpResponse.json(mockParts)
  }),
  http.get('*/api/parts/:id', ({ params }) => {
    const part = mockParts.find(p => p.id === Number(params.id))
    return part ? HttpResponse.json(part) : new HttpResponse(null, { status: 404 })
  }),
  http.get('*/api/cart', () => {
    return HttpResponse.json({ items: [], total: 0 })
  }),
  http.post('*/api/cart/items', () => {
    return HttpResponse.json({ items: [{ id: 1, partId: 1, quantity: 1 }], total: 1500 })
  }),
  http.post('*/api/orders', () => {
    return HttpResponse.json({ id: 100, status: 'CREATED' })
  })
)

beforeAll(() => server.listen({ onUnhandledRequest: 'error' }))
afterEach(() => {
  server.resetHandlers()
  localStorage.clear()
})
afterAll(() => server.close())

const renderWithContext = (ui, initialPath = '/') => {
  localStorage.setItem('token', 'fake-token')
  return render(
    <MemoryRouter initialEntries={[initialPath]}>
      <AuthProvider>
        <CartProvider>
          {ui}
        </CartProvider>
      </AuthProvider>
    </MemoryRouter>
  )
}

describe('Katalog, korpa i placanje (MSW)', () => {
  it('Prikazuje listu artikala sa servera', async () => {
    renderWithContext(<PartsPage />)
    
    expect(screen.getByText('Ucitavanje...')).toBeInTheDocument()
    
    await waitFor(() => {
      expect(screen.getByText('Brake Pad A')).toBeInTheDocument()
      expect(screen.getByText('Out of stock Filter')).toBeInTheDocument()
    })
  })

  it('Pretraga filtrira artikle', async () => {
    const user = userEvent.setup()
    renderWithContext(<PartsPage />)
    
    await waitFor(() => expect(screen.getByText('Brake Pad A')).toBeInTheDocument())
    
    const searchInput = screen.getByPlaceholderText('Pretraga po nazivu...')
    await user.type(searchInput, 'Brake')
    await user.click(screen.getByRole('button', { name: 'Trazi' }))
    
    await waitFor(() => {
      expect(screen.getByText('Brake Pad A')).toBeInTheDocument()
      expect(screen.queryByText('Out of stock Filter')).not.toBeInTheDocument()
    })
  })

  it('Dodavanje artikla u korpu', async () => {
    const user = userEvent.setup()
    
    // override cart get to return empty then filled
    let cartCallCount = 0
    server.use(
      http.get('*/api/cart', () => {
        cartCallCount++
        if (cartCallCount === 1) return HttpResponse.json({ items: [], total: 0 })
        return HttpResponse.json({ 
          items: [{ id: 1, partId: 1, name: 'Brake Pad A', quantity: 1, subtotal: 1500, unitPrice: 1500, inStock: true, stockQuantity: 5 }], 
          total: 1500 
        })
      })
    )

    renderWithContext(
      <Routes>
        <Route path="/" element={<PartsPage />} />
        <Route path="/cart" element={<CartPage />} />
      </Routes>
    )

    await waitFor(() => expect(screen.getByText('Brake Pad A')).toBeInTheDocument())
    
    // Prvo dugme je od Brake Pad A
    const addBtns = screen.getAllByRole('button', { name: 'Dodaj u korpu' })
    
    // Out of stock mora biti disabled
    const outOfStockCard = screen.getByText('Out of stock Filter').closest('.part-card')
    const outOfStockBtn = outOfStockCard.querySelector('.add-to-cart-btn')
    expect(outOfStockBtn).toBeDisabled()

    // Stub window alert
    window.alert = vi.fn()

    await user.click(addBtns[0])
    
    await waitFor(() => {
      expect(window.alert).toHaveBeenCalledWith('Dodato u korpu!')
    })
  })

  it('Prikazuje Checkout formu i salje POST /api/orders', async () => {
    const user = userEvent.setup()
    
    server.use(
      http.get('*/api/cart', () => {
        return HttpResponse.json({ 
          items: [{ id: 1, partId: 1, name: 'Brake Pad A', quantity: 1, subtotal: 1500, unitPrice: 1500, inStock: true, stockQuantity: 5 }], 
          total: 1500 
        })
      })
    )

    window.alert = vi.fn()

    renderWithContext(
      <Routes>
        <Route path="/checkout" element={<CheckoutPage />} />
        <Route path="/orders" element={<div>Uspesno kreirano</div>} />
      </Routes>,
      '/checkout'
    )

    await waitFor(() => expect(screen.getByText('Placanje i isporuka')).toBeInTheDocument())
    
    await user.type(screen.getByLabelText('Ime i prezime'), 'Test Kupac')
    await user.type(screen.getByLabelText('Telefon'), '123')
    await user.type(screen.getByLabelText('Email'), 'test@test.com')
    await user.type(screen.getByLabelText('Adresa (ulica i broj)'), 'Ulica 1')
    await user.type(screen.getByLabelText('Grad'), 'Grad')
    await user.type(screen.getByLabelText('Postanski broj'), '11000')

    await user.click(screen.getByRole('button', { name: 'Zavrsi porudzbinu' }))
    
    await waitFor(() => {
      expect(screen.getByText('Uspesno kreirano')).toBeInTheDocument()
    })
  })

  it('Prikazuje poruku o gresci kada API nije dostupan', async () => {
    server.use(
      http.get('*/api/parts', () => {
        return HttpResponse.error()
      })
    )
    renderWithContext(<PartsPage />)
    
    await waitFor(() => {
      expect(screen.getByRole('alert')).toHaveTextContent('Greska pri ucitavanju kataloga.')
    })
  })

  it('Prikazuje opciju Obavesti me i uspesno salje zahtev', async () => {
    const user = userEvent.setup()
    server.use(
      http.post('*/api/notifications/restock', () => {
        return HttpResponse.json({ message: 'Success' }, { status: 201 })
      })
    )
    
    renderWithContext(
      <Routes>
        <Route path="/parts/:id" element={<PartDetailsPage />} />
      </Routes>,
      '/parts/2'
    )

    await waitFor(() => expect(screen.getByText('Out of stock Filter')).toBeInTheDocument())
    
    expect(screen.getByText('Obavesti me kada bude na stanju')).toBeInTheDocument()
    
    const emailInput = screen.getByPlaceholderText('vas@email.com')
    await user.type(emailInput, 'test@example.com')
    
    await user.click(screen.getByRole('button', { name: 'Obavesti me' }))
    
    await waitFor(() => {
      expect(screen.getByRole('alert')).toHaveTextContent('Zahtev za obavestenje uspesno poslat.')
    })
  })
})
