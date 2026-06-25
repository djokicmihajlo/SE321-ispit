package com.autoparts.shop.security;

import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import javax.crypto.SecretKey;

import com.autoparts.shop.user.AppUser;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class JwtService {

	private final SecretKey secretKey;
	private final long expirationMinutes;

	public JwtService(
		@Value("${app.security.jwt.secret}") String secret,
		@Value("${app.security.jwt.expiration-minutes}") long expirationMinutes
	) {
		this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
		this.expirationMinutes = expirationMinutes;
	}

	public String generateToken(AppUser user) {
		Instant now = Instant.now();
		return Jwts.builder()
			.subject(user.getEmail())
			.claim("userId", user.getId())
			.claim("role", user.getRole().name())
			.issuedAt(Date.from(now))
			.expiration(Date.from(now.plus(expirationMinutes, ChronoUnit.MINUTES)))
			.signWith(secretKey)
			.compact();
	}

	public String extractEmail(String token) {
		return claims(token).getSubject();
	}

	public boolean isTokenValid(String token, ShopUserDetails userDetails) {
		return extractEmail(token).equalsIgnoreCase(userDetails.getUsername()) && claims(token).getExpiration().after(new Date());
	}

	private Claims claims(String token) {
		return Jwts.parser()
			.verifyWith(secretKey)
			.build()
			.parseSignedClaims(token)
			.getPayload();
	}
}
