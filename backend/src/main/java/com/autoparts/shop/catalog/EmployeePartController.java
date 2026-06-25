package com.autoparts.shop.catalog;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/employee/parts")
@PreAuthorize("hasAnyRole('EMPLOYEE', 'ADMIN')")
public class EmployeePartController {

	private final CatalogService catalogService;

	public EmployeePartController(CatalogService catalogService) {
		this.catalogService = catalogService;
	}

	@PostMapping
	public PartResponse createPart(@Valid @RequestBody PartUpsertRequest request) {
		return catalogService.createPart(request);
	}

	@PutMapping("/{id}")
	public PartResponse updatePart(@PathVariable Long id, @Valid @RequestBody PartUpsertRequest request) {
		return catalogService.updatePart(id, request);
	}

	@DeleteMapping("/{id}")
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void deletePart(@PathVariable Long id) {
		catalogService.deletePart(id);
	}
}
