package com.autoparts.shop.auth;

import java.util.List;

import com.autoparts.shop.security.JwtService;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.user.UserRole;
import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuthService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;
	private final JwtService jwtService;

	public AuthService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
		this.jwtService = jwtService;
	}

	@Transactional
	public AuthResponse registerClient(RegisterRequest request) {
		AppUser user = createUser(UserRole.CLIENT, request.firstName(), request.lastName(), request.email(), request.phone(), request.password());
		return authResponse(user);
	}

	@Transactional(readOnly = true)
	public AuthResponse login(LoginRequest request) {
		AppUser user = userRepository.findByEmailIgnoreCase(normalizeEmail(request.email()))
			.orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "Invalid credentials"));

		if (!user.isActive() || !passwordEncoder.matches(request.password(), user.getPasswordHash())) {
			throw new ApiException(HttpStatus.UNAUTHORIZED, "Invalid credentials");
		}

		return authResponse(user);
	}

	@Transactional
	public UserResponse createEmployee(CreateEmployeeRequest request) {
		AppUser user = createUser(UserRole.EMPLOYEE, request.firstName(), request.lastName(), request.email(), request.phone(), request.password());
		return UserResponse.from(user);
	}

	@Transactional(readOnly = true)
	public List<UserResponse> listEmployees() {
		return userRepository.findByRoleOrderByCreatedAtDesc(UserRole.EMPLOYEE)
			.stream()
			.map(UserResponse::from)
			.toList();
	}

	private AppUser createUser(UserRole role, String firstName, String lastName, String email, String phone, String password) {
		String normalizedEmail = normalizeEmail(email);
		if (userRepository.existsByEmailIgnoreCase(normalizedEmail)) {
			throw new ApiException(HttpStatus.CONFLICT, "Email already registered");
		}

		AppUser user = new AppUser(
			role,
			firstName.trim(),
			lastName.trim(),
			normalizedEmail,
			normalizeOptional(phone),
			passwordEncoder.encode(password)
		);

		return userRepository.save(user);
	}

	private AuthResponse authResponse(AppUser user) {
		return new AuthResponse(jwtService.generateToken(user), UserResponse.from(user));
	}

	private String normalizeEmail(String email) {
		return email.trim().toLowerCase();
	}

	private String normalizeOptional(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		return value.trim();
	}
}
