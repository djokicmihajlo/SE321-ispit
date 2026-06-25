package com.autoparts.shop.notification;

import java.time.LocalDateTime;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;

public record RestockNotificationResponse(
	Long id,
	Long partId,
	String partName,
	Long clientId,
	NotificationChannel channel,
	String email,
	String phone,
	NotificationStatus status,
	LocalDateTime createdAt,
	LocalDateTime notifiedAt
) {
	static RestockNotificationResponse from(RestockNotificationRequest request) {
		Part part = request.getPart();
		AppUser client = request.getClient();
		return new RestockNotificationResponse(
			request.getId(),
			part.getId(),
			part.getName(),
			client == null ? null : client.getId(),
			request.getChannel(),
			request.getEmail(),
			request.getPhone(),
			request.getStatus(),
			request.getCreatedAt(),
			request.getNotifiedAt()
		);
	}
}
