package com.autoparts.shop.catalog;

import java.math.BigDecimal;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record PartUpsertRequest(
	@NotNull(message = "Category is required")
	Long categoryId,

	Long vehicleMakeId,

	Long vehicleModelId,

	@NotBlank(message = "SKU is required")
	@Size(max = 80, message = "SKU is too long")
	String sku,

	@NotBlank(message = "Name is required")
	@Size(max = 180, message = "Name is too long")
	String name,

	String description,

	@NotBlank(message = "Manufacturer is required")
	@Size(max = 120, message = "Manufacturer is too long")
	String manufacturer,

	@NotNull(message = "Price is required")
	@DecimalMin(value = "0.00", message = "Price must not be negative")
	BigDecimal price,

	@Min(value = 0, message = "Stock quantity must not be negative")
	int stockQuantity,

	@Size(max = 500, message = "Image URL is too long")
	String imageUrl,

	boolean active
) {
}
