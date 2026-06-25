package com.autoparts.shop.notification;

import com.autoparts.shop.security.ShopUserDetails;
import jakarta.validation.Valid;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/notifications/restock")
public class PublicRestockNotificationController {

	private final RestockNotificationService notificationService;

	public PublicRestockNotificationController(RestockNotificationService notificationService) {
		this.notificationService = notificationService;
	}

	@PostMapping
	public RestockNotificationResponse create(
		@AuthenticationPrincipal ShopUserDetails userDetails,
		@Valid @RequestBody CreateRestockNotificationRequest request
	) {
		Long clientId = userDetails == null ? null : userDetails.user().getId();
		return notificationService.create(clientId, request);
	}
}
