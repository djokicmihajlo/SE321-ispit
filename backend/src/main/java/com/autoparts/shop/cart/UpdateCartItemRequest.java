package com.autoparts.shop.cart;

import jakarta.validation.constraints.Min;

public record UpdateCartItemRequest(
	@Min(1) int quantity
) {
}
