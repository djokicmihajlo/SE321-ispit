package com.autoparts.shop.order;

import java.math.BigDecimal;

public record PaymentResponse(
	PaymentMethod method,
	PaymentStatus status,
	BigDecimal amount,
	String transactionReference,
	String failureReason
) {
	static PaymentResponse from(Payment payment) {
		return new PaymentResponse(
			payment.getMethod(),
			payment.getStatus(),
			payment.getAmount(),
			payment.getTransactionReference(),
			payment.getFailureReason()
		);
	}
}
