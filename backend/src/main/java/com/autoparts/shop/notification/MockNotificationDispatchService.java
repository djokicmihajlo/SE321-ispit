package com.autoparts.shop.notification;

import org.springframework.stereotype.Service;

@Service
public class MockNotificationDispatchService implements NotificationDispatchService {

	@Override
	public void restockRequestCreated(RestockNotificationRequest request) {
		// External email/SMS integrations are intentionally mocked for the first version.
	}
}
