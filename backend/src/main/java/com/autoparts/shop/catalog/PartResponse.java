package com.autoparts.shop.catalog;

import java.math.BigDecimal;

public record PartResponse(
	Long id,
	String sku,
	String name,
	String description,
	String manufacturer,
	BigDecimal price,
	int stockQuantity,
	boolean inStock,
	String imageUrl,
	boolean active,
	CategoryResponse category,
	VehicleResponse vehicle
) {
	static PartResponse from(Part part) {
		return new PartResponse(
			part.getId(),
			part.getSku(),
			part.getName(),
			part.getDescription(),
			part.getManufacturer(),
			part.getPrice(),
			part.getStockQuantity(),
			part.getStockQuantity() > 0,
			part.getImageUrl(),
			part.isActive(),
			CategoryResponse.from(part.getCategory()),
			VehicleResponse.from(part.getVehicleMake(), part.getVehicleModel())
		);
	}
}
