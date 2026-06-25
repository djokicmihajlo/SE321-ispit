package com.autoparts.shop.catalog;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/parts")
public class PublicPartController {

	private final CatalogService catalogService;

	public PublicPartController(CatalogService catalogService) {
		this.catalogService = catalogService;
	}

	@GetMapping
	public List<PartResponse> search(
		@RequestParam(required = false) String search,
		@RequestParam(required = false) String categorySlug,
		@RequestParam(required = false) String make,
		@RequestParam(required = false) String model
	) {
		return catalogService.search(new PartSearchRequest(search, categorySlug, make, model));
	}

	@GetMapping("/{id}")
	public PartResponse getPart(@PathVariable Long id) {
		return catalogService.getPart(id);
	}
}
