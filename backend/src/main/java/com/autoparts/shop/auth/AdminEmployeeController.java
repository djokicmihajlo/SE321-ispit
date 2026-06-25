package com.autoparts.shop.auth;

import java.util.List;

import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/employees")
@PreAuthorize("hasRole('ADMIN')")
public class AdminEmployeeController {

	private final AuthService authService;

	public AdminEmployeeController(AuthService authService) {
		this.authService = authService;
	}

	@GetMapping
	public List<UserResponse> listEmployees() {
		return authService.listEmployees();
	}

	@PostMapping
	public UserResponse createEmployee(@Valid @RequestBody CreateEmployeeRequest request) {
		return authService.createEmployee(request);
	}
}
