package com.autoparts.shop.order;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CreateOrderRequest(
	@NotBlank @Size(max = 160) String contactName,
	@NotBlank @Email @Size(max = 160) String contactEmail,
	@NotBlank @Size(max = 40) String contactPhone,
	@NotBlank @Size(max = 255) String shippingAddress,
	@NotBlank @Size(max = 120) String shippingCity,
	@NotBlank @Size(max = 30) String shippingPostalCode,
	@NotNull PaymentMethod paymentMethod,
	@Valid CardPaymentRequest card
) {
}
