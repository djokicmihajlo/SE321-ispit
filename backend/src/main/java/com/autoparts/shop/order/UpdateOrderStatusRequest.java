package com.autoparts.shop.order;

import jakarta.validation.constraints.NotNull;

public record UpdateOrderStatusRequest(
	@NotNull OrderStatus status
) {
}
