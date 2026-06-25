package com.autoparts.shop.specialorder;

import java.util.List;

import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SpecialOrderService {

	private final SpecialOrderRepository specialOrderRepository;
	private final UserRepository userRepository;

	public SpecialOrderService(SpecialOrderRepository specialOrderRepository, UserRepository userRepository) {
		this.specialOrderRepository = specialOrderRepository;
		this.userRepository = userRepository;
	}

	@Transactional
	public SpecialOrderResponse create(Long clientId, CreateSpecialOrderRequest request) {
		AppUser client = clientId == null ? null : userRepository.findById(clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "User not found"));

		SpecialOrderRequest saved = specialOrderRepository.save(new SpecialOrderRequest(
			client,
			request.contactName().trim(),
			request.contactEmail().trim(),
			request.contactPhone().trim(),
			request.vehicleMake().trim(),
			request.vehicleModel().trim(),
			request.vehicleYear(),
			normalize(request.vin()),
			request.partsDescription().trim()
		));

		return SpecialOrderResponse.from(saved);
	}

	@Transactional(readOnly = true)
	public List<SpecialOrderResponse> findMine(Long clientId) {
		return specialOrderRepository.findByClientIdWithDetails(clientId)
			.stream()
			.map(SpecialOrderResponse::from)
			.toList();
	}

	@Transactional(readOnly = true)
	public List<SpecialOrderResponse> findEmployeeOrders(SpecialOrderStatus status) {
		return specialOrderRepository.findAllWithDetails(status)
			.stream()
			.map(SpecialOrderResponse::from)
			.toList();
	}

	@Transactional
	public SpecialOrderResponse update(Long id, UpdateSpecialOrderRequest request) {
		SpecialOrderRequest specialOrder = specialOrderRepository.findByIdWithDetails(id)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Special order request not found"));

		validateEmployeeResponse(request);
		specialOrder.respond(
			request.status(),
			normalize(request.employeeResponse()),
			request.estimatedArrival(),
			normalize(request.pickupLocation())
		);

		return SpecialOrderResponse.from(specialOrder);
	}

	private void validateEmployeeResponse(UpdateSpecialOrderRequest request) {
		if (request.status() == SpecialOrderStatus.AVAILABLE) {
			if (request.estimatedArrival() == null) {
				throw new ApiException(HttpStatus.BAD_REQUEST, "Estimated arrival is required when part is available");
			}
			if (normalize(request.pickupLocation()) == null) {
				throw new ApiException(HttpStatus.BAD_REQUEST, "Pickup location is required when part is available");
			}
		}
		if ((request.status() == SpecialOrderStatus.AVAILABLE || request.status() == SpecialOrderStatus.UNAVAILABLE)
			&& normalize(request.employeeResponse()) == null) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Employee response is required for supplier answer");
		}
	}

	private String normalize(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		return value.trim();
	}
}
