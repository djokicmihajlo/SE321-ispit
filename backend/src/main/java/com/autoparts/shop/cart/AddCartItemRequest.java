package com.autoparts.shop.cart;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record AddCartItemRequest(
	@NotNull Long partId,
	@Min(1) int quantity
) {
}
