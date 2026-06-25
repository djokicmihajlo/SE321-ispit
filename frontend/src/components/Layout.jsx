import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../context/AuthContext'
import './Layout.css'

export default function Layout({ children }) {
  const { user, isAuthenticated, isStaff, isAdmin, logout } = useAuth()
  const navigate = useNavigate()

  const handleLogout = () => {
    logout()
    navigate('/')
  }

  return (
    <div className="layout">
      <header className="site-header">
        <nav className="site-nav" aria-label="Glavna navigacija">
          <Link to="/" className="site-logo">AutoDelovi</Link>

          <div className="nav-links">
            <Link to="/parts">Katalog</Link>
            <Link to="/special-order">Specijalna porudzbina</Link>

            {isAuthenticated && !isStaff && (
              <>
                <Link to="/cart">Korpa</Link>
                <Link to="/orders">Moje porudzbine</Link>
              </>
            )}

            {isStaff && (
              <>
                <Link to="/employee/orders">Porudzbine</Link>
                <Link to="/employee/parts">Artikli</Link>
                <Link to="/employee/special-orders">Spec. zahtevi</Link>
              </>
            )}

            {isAdmin && (
              <Link to="/admin/employees">Zaposleni</Link>
            )}
          </div>

          <div className="nav-auth">
            {isAuthenticated ? (
              <>
                <span className="nav-user" aria-label="Ulogovan korisnik">
                  {user.firstName} {user.lastName}
                  <span className="nav-role">{user.role}</span>
                </span>
                <button onClick={handleLogout} className="nav-btn logout-btn">
                  Odjavi se
                </button>
              </>
            ) : (
              <>
                <Link to="/login" className="nav-btn login-btn">Prijava</Link>
                <Link to="/register" className="nav-btn register-btn">Registracija</Link>
              </>
            )}
          </div>
        </nav>
      </header>

      <div className="site-content">
        {children}
      </div>

      <footer className="site-footer">
        <p>&copy; 2026 AutoDelovi. Prodavnica auto delova.</p>
      </footer>
    </div>
  )
}
