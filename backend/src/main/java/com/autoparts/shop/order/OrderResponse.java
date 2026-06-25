package com.autoparts.shop.order;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record OrderResponse(
	Long id,
	String orderNumber,
	OrderStatus status,
	PaymentMethod paymentMethod,
	PaymentStatus paymentStatus,
	BigDecimal subtotal,
	BigDecimal total,
	String contactName,
	String contactEmail,
	String contactPhone,
	String shippingAddress,
	String shippingCity,
	String shippingPostalCode,
	List<OrderItemResponse> items,
	PaymentResponse payment,
	LocalDateTime createdAt
) {
	static OrderResponse from(ShopOrder order) {
		return new OrderResponse(
			order.getId(),
			order.getOrderNumber(),
			order.getStatus(),
			order.getPaymentMethod(),
			order.getPaymentStatus(),
			order.getSubtotal(),
			order.getTotal(),
			order.getContactName(),
			order.getContactEmail(),
			order.getContactPhone(),
			order.getShippingAddress(),
			order.getShippingCity(),
			order.getShippingPostalCode(),
			order.getItems().stream().map(OrderItemResponse::from).toList(),
			order.getPayment() == null ? null : PaymentResponse.from(order.getPayment()),
			order.getCreatedAt()
		);
	}
}
