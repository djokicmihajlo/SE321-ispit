package com.autoparts.shop.order;

import java.math.BigDecimal;

import org.springframework.stereotype.Service;

@Service
public class MockPaymentService implements PaymentService {

	private static final String FAIL_CARD = "4000000000000002";

	@Override
	public PaymentResult process(PaymentMethod method, BigDecimal amount, CardPaymentRequest card) {
		if (method == PaymentMethod.CASH_ON_DELIVERY) {
			return new PaymentResult(PaymentStatus.CASH_ON_DELIVERY, null, null);
		}

		if (card == null || isBlank(card.cardNumber()) || isBlank(card.cardholderName()) || isBlank(card.expiry()) || isBlank(card.cvc())) {
			return new PaymentResult(PaymentStatus.FAILED, null, "Card details are required");
		}

		String normalizedCardNumber = card.cardNumber().replace(" ", "");
		if (FAIL_CARD.equals(normalizedCardNumber)) {
			return new PaymentResult(PaymentStatus.FAILED, null, "Card payment declined");
		}

		return new PaymentResult(PaymentStatus.PAID, "MOCK-" + System.nanoTime(), null);
	}

	private boolean isBlank(String value) {
		return value == null || value.isBlank();
	}
}
