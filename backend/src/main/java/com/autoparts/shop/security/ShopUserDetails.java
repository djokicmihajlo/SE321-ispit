package com.autoparts.shop.security;

import java.util.Collection;
import java.util.List;

import com.autoparts.shop.user.AppUser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class ShopUserDetails implements UserDetails {

	private final AppUser user;

	public ShopUserDetails(AppUser user) {
		this.user = user;
	}

	public AppUser user() {
		return user;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return List.of(new SimpleGrantedAuthority("ROLE_" + user.getRole().name()));
	}

	@Override
	public String getPassword() {
		return user.getPasswordHash();
	}

	@Override
	public String getUsername() {
		return user.getEmail();
	}

	@Override
	public boolean isEnabled() {
		return user.isActive();
	}
}
