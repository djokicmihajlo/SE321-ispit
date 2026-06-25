import { Navigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'

/**
 * Stiti rutu od neautorizovanog pristupa.
 *
 * @param {Object} props
 * @param {React.ReactNode} props.children - Sadrzaj rute
 * @param {string[]} [props.roles] - Dozvoljene uloge (npr. ['EMPLOYEE', 'ADMIN'])
 */
export default function ProtectedRoute({ children, roles }) {
  const { user, loading, isAuthenticated } = useAuth()

  if (loading) {
    return <div className="loading-container" aria-label="Ucitavanje">Ucitavanje...</div>
  }

  if (!isAuthenticated) {
    return <Navigate to="/login" replace />
  }

  if (roles && roles.length > 0 && !roles.includes(user.role)) {
    return <Navigate to="/" replace />
  }

  return children
}
