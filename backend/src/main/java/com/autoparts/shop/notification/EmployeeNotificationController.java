package com.autoparts.shop.notification;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/employee/notifications")
@PreAuthorize("hasAnyRole('EMPLOYEE', 'ADMIN')")
public class EmployeeNotificationController {

	private final RestockNotificationService notificationService;

	public EmployeeNotificationController(RestockNotificationService notificationService) {
		this.notificationService = notificationService;
	}

	@GetMapping
	public List<RestockNotificationResponse> notifications(@RequestParam(required = false) NotificationStatus status) {
		return notificationService.findAll(status);
	}
}
