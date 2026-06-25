package com.autoparts.shop.specialorder;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.autoparts.shop.user.AppUser;

public record SpecialOrderResponse(
	Long id,
	Long clientId,
	String contactName,
	String contactEmail,
	String contactPhone,
	String vehicleMake,
	String vehicleModel,
	Integer vehicleYear,
	String vin,
	String partsDescription,
	SpecialOrderStatus status,
	String employeeResponse,
	LocalDate estimatedArrival,
	String pickupLocation,
	LocalDateTime createdAt,
	LocalDateTime updatedAt
) {
	static SpecialOrderResponse from(SpecialOrderRequest request) {
		AppUser client = request.getClient();
		return new SpecialOrderResponse(
			request.getId(),
			client == null ? null : client.getId(),
			request.getContactName(),
			request.getContactEmail(),
			request.getContactPhone(),
			request.getVehicleMake(),
			request.getVehicleModel(),
			request.getVehicleYear(),
			request.getVin(),
			request.getPartsDescription(),
			request.getStatus(),
			request.getEmployeeResponse(),
			request.getEstimatedArrival(),
			request.getPickupLocation(),
			request.getCreatedAt(),
			request.getUpdatedAt()
		);
	}
}
