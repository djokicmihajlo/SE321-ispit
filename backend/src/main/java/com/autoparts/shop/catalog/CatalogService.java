package com.autoparts.shop.catalog;

import java.util.List;

import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CatalogService {

	private final PartRepository partRepository;
	private final PartCategoryRepository categoryRepository;
	private final VehicleMakeRepository makeRepository;
	private final VehicleModelRepository modelRepository;

	public CatalogService(
		PartRepository partRepository,
		PartCategoryRepository categoryRepository,
		VehicleMakeRepository makeRepository,
		VehicleModelRepository modelRepository
	) {
		this.partRepository = partRepository;
		this.categoryRepository = categoryRepository;
		this.makeRepository = makeRepository;
		this.modelRepository = modelRepository;
	}

	@Transactional(readOnly = true)
	public List<PartResponse> search(PartSearchRequest request) {
		return partRepository.search(
				normalize(request.search()),
				normalize(request.categorySlug()),
				normalize(request.make()),
				normalize(request.model()))
			.stream()
			.map(PartResponse::from)
			.toList();
	}

	@Transactional(readOnly = true)
	public PartResponse getPart(Long id) {
		return PartResponse.from(findActivePart(id));
	}

	@Transactional
	public PartResponse createPart(PartUpsertRequest request) {
		String sku = request.sku().trim();
		if (partRepository.existsBySkuIgnoreCase(sku)) {
			throw new ApiException(HttpStatus.CONFLICT, "SKU already exists");
		}

		Part part = new Part(
			findCategory(request.categoryId()),
			findMake(request.vehicleMakeId()),
			findModel(request.vehicleModelId(), request.vehicleMakeId()),
			sku,
			request.name().trim(),
			normalizeOptional(request.description()),
			request.manufacturer().trim(),
			request.price(),
			request.stockQuantity(),
			normalizeOptional(request.imageUrl())
		);

		return PartResponse.from(partRepository.save(part));
	}

	@Transactional
	public PartResponse updatePart(Long id, PartUpsertRequest request) {
		Part part = partRepository.findById(id)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Part not found"));

		part.update(
			findCategory(request.categoryId()),
			findMake(request.vehicleMakeId()),
			findModel(request.vehicleModelId(), request.vehicleMakeId()),
			request.sku().trim(),
			request.name().trim(),
			normalizeOptional(request.description()),
			request.manufacturer().trim(),
			request.price(),
			request.stockQuantity(),
			normalizeOptional(request.imageUrl()),
			request.active()
		);

		return PartResponse.from(part);
	}

	@Transactional
	public void deletePart(Long id) {
		Part part = partRepository.findById(id)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Part not found"));
		part.deactivate();
	}

	private Part findActivePart(Long id) {
		return partRepository.findByIdAndActiveTrue(id)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Part not found"));
	}

	private PartCategory findCategory(Long id) {
		return categoryRepository.findById(id)
			.orElseThrow(() -> new ApiException(HttpStatus.BAD_REQUEST, "Category not found"));
	}

	private VehicleMake findMake(Long id) {
		if (id == null) {
			return null;
		}
		return makeRepository.findById(id)
			.orElseThrow(() -> new ApiException(HttpStatus.BAD_REQUEST, "Vehicle make not found"));
	}

	private VehicleModel findModel(Long modelId, Long makeId) {
		if (modelId == null) {
			return null;
		}
		if (makeId == null) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Vehicle make is required for model");
		}
		return modelRepository.findByIdAndMakeId(modelId, makeId)
			.orElseThrow(() -> new ApiException(HttpStatus.BAD_REQUEST, "Vehicle model not found for make"));
	}

	private String normalize(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		return value.trim();
	}

	private String normalizeOptional(String value) {
		return normalize(value);
	}
}
