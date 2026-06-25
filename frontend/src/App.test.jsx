import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { describe, expect, it } from 'vitest'
import App from './App'

const renderApp = (initialPath = '/') => {
  window.history.pushState({}, '', initialPath)

  return render(
    <MemoryRouter initialEntries={[initialPath]}>
      <App />
    </MemoryRouter>,
  )
}

describe('App shell', () => {
  it('renders the auto parts shop landing view', () => {
    renderApp()

    expect(screen.getByText('Prodavnica auto delova')).toBeInTheDocument()
    expect(screen.getByRole('link', { name: 'Pregled kataloga' })).toHaveAttribute('href', '/parts')
    expect(screen.getByText('Katalog auto delova')).toBeInTheDocument()
  })

  it('renders a placeholder route for the catalog', () => {
    renderApp('/parts')

    expect(screen.getByRole('heading', { name: 'Katalog artikala' })).toBeInTheDocument()
    expect(screen.getByRole('link', { name: 'Nazad na pocetnu' })).toHaveAttribute('href', '/')
  })
})
