import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import api from '../api'
import { useAuth } from './AuthContext'

const CartContext = createContext(null)

export function CartProvider({ children }) {
  const { isAuthenticated, isClient } = useAuth()
  const [cart, setCart] = useState({ items: [], total: 0 })
  const [loading, setLoading] = useState(true)

  const fetchCart = useCallback(async () => {
    if (isAuthenticated && isClient) {
      try {
        const data = await api.get('/api/cart')
        setCart({ items: data.items || [], total: data.total || 0 })
      } catch (err) {
        console.error('Failed to fetch client cart', err)
      } finally {
        setLoading(false)
      }
    } else {
      // Guest cart
      const guestCart = JSON.parse(localStorage.getItem('guest_cart') || '{"items":[],"total":0}')
      setCart(guestCart)
      setLoading(false)
    }
  }, [isAuthenticated, isClient])

  useEffect(() => {
    setLoading(true)
    fetchCart()
  }, [fetchCart])

  // Save guest cart to localStorage
  useEffect(() => {
    if (!isAuthenticated || !isClient) {
      localStorage.setItem('guest_cart', JSON.stringify(cart))
    }
  }, [cart, isAuthenticated, isClient])

  const calculateGuestTotal = (items) => {
    return items.reduce((sum, item) => sum + (item.unitPrice * item.quantity), 0)
  }

  const addItem = async (part, quantity) => {
    if (isAuthenticated && isClient) {
      await api.post('/api/cart/items', { partId: part.id, quantity })
      await fetchCart()
    } else {
      setCart((prev) => {
        const existing = prev.items.find(i => i.partId === part.id)
        let newItems
        if (existing) {
          newItems = prev.items.map(i => i.partId === part.id ? { ...i, quantity: i.quantity + quantity, subtotal: i.unitPrice * (i.quantity + quantity) } : i)
        } else {
          newItems = [...prev.items, {
            id: part.id, // For guest, itemId is partId
            partId: part.id,
            sku: part.sku,
            name: part.name,
            unitPrice: part.price,
            quantity,
            subtotal: part.price * quantity,
            stockQuantity: part.stockQuantity,
            inStock: part.inStock,
            imageUrl: part.imageUrl
          }]
        }
        return { items: newItems, total: calculateGuestTotal(newItems) }
      })
    }
  }

  const updateItem = async (itemId, quantity) => {
    if (isAuthenticated && isClient) {
      await api.patch(`/api/cart/items/${itemId}`, { quantity })
      await fetchCart()
    } else {
      setCart((prev) => {
        const newItems = prev.items.map(i => i.id === itemId ? { ...i, quantity, subtotal: i.unitPrice * quantity } : i)
        return { items: newItems, total: calculateGuestTotal(newItems) }
      })
    }
  }

  const removeItem = async (itemId) => {
    if (isAuthenticated && isClient) {
      await api.delete(`/api/cart/items/${itemId}`)
      await fetchCart()
    } else {
      setCart((prev) => {
        const newItems = prev.items.filter(i => i.id !== itemId)
        return { items: newItems, total: calculateGuestTotal(newItems) }
      })
    }
  }

  const clearCart = async () => {
    if (isAuthenticated && isClient) {
      await api.delete('/api/cart')
      await fetchCart()
    } else {
      setCart({ items: [], total: 0 })
    }
  }

  const value = useMemo(() => ({
    cart,
    loading,
    addItem,
    updateItem,
    removeItem,
    clearCart,
    fetchCart
  }), [cart, loading, addItem, updateItem, removeItem, clearCart, fetchCart])

  return (
    <CartContext.Provider value={value}>
      {children}
    </CartContext.Provider>
  )
}

export function useCart() {
  const context = useContext(CartContext)
  if (!context) {
    throw new Error('useCart must be used within CartProvider')
  }
  return context
}
