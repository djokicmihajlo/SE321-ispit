package com.autoparts.shop.order;

import java.math.BigDecimal;

public interface PaymentService {

	PaymentResult process(PaymentMethod method, BigDecimal amount, CardPaymentRequest card);
}
