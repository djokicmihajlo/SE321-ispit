package com.autoparts.shop.auth;

import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRole;

public record UserResponse(
	Long id,
	String firstName,
	String lastName,
	String email,
	String phone,
	UserRole role,
	boolean active
) {
	public static UserResponse from(AppUser user) {
		return new UserResponse(
			user.getId(),
			user.getFirstName(),
			user.getLastName(),
			user.getEmail(),
			user.getPhone(),
			user.getRole(),
			user.isActive()
		);
	}
}
