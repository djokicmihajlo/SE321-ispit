package com.autoparts.shop.notification;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CreateRestockNotificationRequest(
	@NotNull Long partId,
	@NotNull NotificationChannel channel,
	@Email @Size(max = 160) String email,
	@Size(max = 40) String phone
) {
}
