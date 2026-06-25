package com.autoparts.shop.specialorder;

import java.time.LocalDate;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record UpdateSpecialOrderRequest(
	@NotNull SpecialOrderStatus status,
	@Size(max = 5000) String employeeResponse,
	LocalDate estimatedArrival,
	@Size(max = 180) String pickupLocation
) {
}
