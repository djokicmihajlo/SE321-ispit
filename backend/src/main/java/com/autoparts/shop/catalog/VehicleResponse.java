package com.autoparts.shop.catalog;

public record VehicleResponse(Long makeId, String make, Long modelId, String model) {

	static VehicleResponse from(VehicleMake make, VehicleModel model) {
		return new VehicleResponse(
			make == null ? null : make.getId(),
			make == null ? null : make.getName(),
			model == null ? null : model.getId(),
			model == null ? null : model.getName()
		);
	}
}
