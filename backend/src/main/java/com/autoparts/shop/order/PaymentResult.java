package com.autoparts.shop.order;

public record PaymentResult(
	PaymentStatus status,
	String transactionReference,
	String failureReason
) {
	public boolean successful() {
		return status == PaymentStatus.PAID || status == PaymentStatus.CASH_ON_DELIVERY;
	}
}
