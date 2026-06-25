package com.autoparts.shop.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

@Component
@Profile("test")
public class TestDatabaseSafetyCheck {

	private final String datasourceUrl;

	public TestDatabaseSafetyCheck(@Value("${spring.datasource.url}") String datasourceUrl) {
		this.datasourceUrl = datasourceUrl;
	}

	@PostConstruct
	void verifyTestDatabase() {
		if (!datasourceUrl.contains("auto_parts_shop_test")) {
			throw new IllegalStateException("Refusing to run tests without auto_parts_shop_test database");
		}
	}
}
