package com.autoparts.shop.web;

import java.time.Instant;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

	@ExceptionHandler(ApiException.class)
	public ResponseEntity<Map<String, Object>> handleApiException(ApiException exception) {
		return error(exception.status(), exception.getMessage(), null);
	}

	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<Map<String, Object>> handleValidation(MethodArgumentNotValidException exception) {
		List<Map<String, String>> details = exception.getBindingResult()
			.getFieldErrors()
			.stream()
			.map(this::fieldError)
			.toList();

		return error(HttpStatus.BAD_REQUEST, "Validation failed", details);
	}

	@ExceptionHandler(AccessDeniedException.class)
	public ResponseEntity<Map<String, Object>> handleAccessDenied(AccessDeniedException exception) {
		return error(HttpStatus.FORBIDDEN, "Access denied", null);
	}

	private ResponseEntity<Map<String, Object>> error(HttpStatus status, String message, Object details) {
		return ResponseEntity.status(status).body(Map.of(
			"timestamp", Instant.now().toString(),
			"status", status.value(),
			"message", message,
			"details", details == null ? List.of() : details
		));
	}

	private Map<String, String> fieldError(FieldError error) {
		return Map.of(
			"field", error.getField(),
			"message", error.getDefaultMessage() == null ? "Invalid value" : error.getDefaultMessage()
		);
	}
}
