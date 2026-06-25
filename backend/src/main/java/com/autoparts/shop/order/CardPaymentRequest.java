package com.autoparts.shop.order;

import jakarta.validation.constraints.Size;

public record CardPaymentRequest(
	@Size(max = 120) String cardholderName,
	@Size(max = 30) String cardNumber,
	@Size(max = 7) String expiry,
	@Size(max = 4) String cvc
) {
}
