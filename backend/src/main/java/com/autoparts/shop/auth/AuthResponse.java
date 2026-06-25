package com.autoparts.shop.auth;

public record AuthResponse(String token, UserResponse user) {
}
