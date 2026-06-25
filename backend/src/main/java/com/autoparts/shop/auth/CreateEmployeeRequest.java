package com.autoparts.shop.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public record CreateEmployeeRequest(
	@NotBlank(message = "First name is required")
	@Size(max = 80, message = "First name is too long")
	String firstName,

	@NotBlank(message = "Last name is required")
	@Size(max = 80, message = "Last name is too long")
	String lastName,

	@NotBlank(message = "Email is required")
	@Email(message = "Email must be valid")
	@Size(max = 160, message = "Email is too long")
	String email,

	@Size(max = 40, message = "Phone is too long")
	String phone,

	@NotBlank(message = "Password is required")
	@Size(min = 8, max = 80, message = "Password must be between 8 and 80 characters")
	@Pattern(regexp = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).+$", message = "Password must contain uppercase, lowercase and digit")
	String password
) {
}
