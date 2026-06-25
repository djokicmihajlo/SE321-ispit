package com.autoparts.shop.catalog;

public record CategoryResponse(Long id, String name, String slug) {

	static CategoryResponse from(PartCategory category) {
		return new CategoryResponse(category.getId(), category.getName(), category.getSlug());
	}
}
