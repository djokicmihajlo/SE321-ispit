package com.autoparts.shop.notification;

import java.util.List;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.catalog.PartRepository;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class RestockNotificationService {

	private final RestockNotificationRepository notificationRepository;
	private final PartRepository partRepository;
	private final UserRepository userRepository;
	private final NotificationDispatchService dispatchService;

	public RestockNotificationService(RestockNotificationRepository notificationRepository, PartRepository partRepository, UserRepository userRepository, NotificationDispatchService dispatchService) {
		this.notificationRepository = notificationRepository;
		this.partRepository = partRepository;
		this.userRepository = userRepository;
		this.dispatchService = dispatchService;
	}

	@Transactional
	public RestockNotificationResponse create(Long clientId, CreateRestockNotificationRequest request) {
		Part part = partRepository.findByIdAndActiveTrue(request.partId())
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Part not found"));
		if (part.getStockQuantity() > 0) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Part is already in stock");
		}

		AppUser client = clientId == null ? null : userRepository.findById(clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "User not found"));

		String email = normalize(request.email());
		String phone = normalize(request.phone());
		validateContact(request.channel(), email, phone);

		RestockNotificationRequest saved = notificationRepository.save(new RestockNotificationRequest(
			part,
			client,
			request.channel(),
			email,
			phone
		));
		dispatchService.restockRequestCreated(saved);
		return RestockNotificationResponse.from(saved);
	}

	@Transactional(readOnly = true)
	public List<RestockNotificationResponse> findAll(NotificationStatus status) {
		return notificationRepository.findAllWithDetails(status)
			.stream()
			.map(RestockNotificationResponse::from)
			.toList();
	}

	private void validateContact(NotificationChannel channel, String email, String phone) {
		if (channel == NotificationChannel.EMAIL && email == null) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Email is required for email notifications");
		}
		if (channel == NotificationChannel.SMS && phone == null) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Phone is required for SMS notifications");
		}
	}

	private String normalize(String value) {
		if (value == null || value.isBlank()) {
			return null;
		}
		return value.trim();
	}
}
