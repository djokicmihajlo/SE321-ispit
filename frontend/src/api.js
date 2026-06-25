const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:8080'

/**
 * Centralni API klijent za komunikaciju sa Spring Boot backendom.
 * Automatski dodaje JWT token iz localStorage-a.
 */
async function request(method, path, body) {
  const token = localStorage.getItem('token')
  const headers = {}

  if (token) {
    headers['Authorization'] = `Bearer ${token}`
  }
  if (body !== undefined) {
    headers['Content-Type'] = 'application/json'
  }

  const response = await fetch(`${API_BASE}${path}`, {
    method,
    headers,
    body: body !== undefined ? JSON.stringify(body) : undefined,
  })

  if (response.status === 204) {
    return null
  }

  const data = await response.json().catch(() => null)

  if (!response.ok) {
    const error = new Error(data?.message || data?.error || `Greska ${response.status}`)
    error.status = response.status
    error.data = data
    throw error
  }

  return data
}

const api = {
  get: (path) => request('GET', path),
  post: (path, body) => request('POST', path, body),
  put: (path, body) => request('PUT', path, body),
  patch: (path, body) => request('PATCH', path, body),
  delete: (path) => request('DELETE', path),
}

export default api
