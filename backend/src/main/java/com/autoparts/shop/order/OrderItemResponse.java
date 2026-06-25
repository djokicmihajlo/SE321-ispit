package com.autoparts.shop.order;

import java.math.BigDecimal;

public record OrderItemResponse(
	Long id,
	Long partId,
	String partName,
	BigDecimal unitPrice,
	int quantity,
	BigDecimal lineTotal
) {
	static OrderItemResponse from(OrderItem item) {
		return new OrderItemResponse(
			item.getId(),
			item.getPart().getId(),
			item.getPartName(),
			item.getUnitPrice(),
			item.getQuantity(),
			item.getLineTotal()
		);
	}
}
