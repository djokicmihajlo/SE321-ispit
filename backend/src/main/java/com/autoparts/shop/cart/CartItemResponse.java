package com.autoparts.shop.cart;

import java.math.BigDecimal;

import com.autoparts.shop.catalog.Part;

public record CartItemResponse(
	Long id,
	Long partId,
	String sku,
	String name,
	BigDecimal unitPrice,
	int quantity,
	BigDecimal subtotal,
	int stockQuantity,
	boolean inStock,
	String imageUrl
) {
	static CartItemResponse from(CartItem item) {
		Part part = item.getPart();
		return new CartItemResponse(
			item.getId(),
			part.getId(),
			part.getSku(),
			part.getName(),
			part.getPrice(),
			item.getQuantity(),
			item.subtotal(),
			part.getStockQuantity(),
			part.getStockQuantity() > 0,
			part.getImageUrl()
		);
	}
}
