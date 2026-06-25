import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react'
import api from '../api'

const AuthContext = createContext(null)

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)

  /* Hidracija - pri ucitavanju pokusaj da ucitas korisnika iz sacuvanog tokena */
  useEffect(() => {
    const token = localStorage.getItem('token')
    if (!token) {
      setLoading(false)
      return
    }

    api.get('/api/auth/me')
      .then((userData) => setUser(userData))
      .catch(() => {
        localStorage.removeItem('token')
      })
      .finally(() => setLoading(false))
  }, [])

  const login = useCallback(async (email, password) => {
    const data = await api.post('/api/auth/login', { email, password })
    localStorage.setItem('token', data.token)
    setUser(data.user)
    return data.user
  }, [])

  const register = useCallback(async (formData) => {
    const data = await api.post('/api/auth/register', formData)
    localStorage.setItem('token', data.token)
    setUser(data.user)
    return data.user
  }, [])

  const logout = useCallback(() => {
    localStorage.removeItem('token')
    setUser(null)
  }, [])

  const value = useMemo(() => ({
    user,
    loading,
    login,
    register,
    logout,
    isAuthenticated: !!user,
    isClient: user?.role === 'CLIENT',
    isEmployee: user?.role === 'EMPLOYEE',
    isAdmin: user?.role === 'ADMIN',
    isStaff: user?.role === 'EMPLOYEE' || user?.role === 'ADMIN',
  }), [user, loading, login, register, logout])

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider')
  }
  return context
}
