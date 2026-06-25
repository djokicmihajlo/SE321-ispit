package com.autoparts.shop.specialorder;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record CreateSpecialOrderRequest(
	@NotBlank @Size(max = 160) String contactName,
	@NotBlank @Email @Size(max = 160) String contactEmail,
	@NotBlank @Size(max = 40) String contactPhone,
	@NotBlank @Size(max = 120) String vehicleMake,
	@NotBlank @Size(max = 120) String vehicleModel,
	@Min(1950) @Max(2100) Integer vehicleYear,
	@Size(max = 40) String vin,
	@NotBlank @Size(max = 5000) String partsDescription
) {
}
