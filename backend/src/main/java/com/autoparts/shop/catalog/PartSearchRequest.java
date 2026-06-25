package com.autoparts.shop.catalog;

public record PartSearchRequest(String search, String categorySlug, String make, String model) {
}
