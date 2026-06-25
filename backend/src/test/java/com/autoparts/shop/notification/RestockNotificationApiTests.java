package com.autoparts.shop.notification;

import static org.hamcrest.Matchers.greaterThanOrEqualTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;

import com.autoparts.shop.auth.LoginRequest;
import com.autoparts.shop.auth.RegisterRequest;
import com.autoparts.shop.catalog.PartCategory;
import com.autoparts.shop.catalog.PartCategoryRepository;
import com.autoparts.shop.catalog.PartUpsertRequest;
import com.autoparts.shop.catalog.VehicleMake;
import com.autoparts.shop.catalog.VehicleMakeRepository;
import com.autoparts.shop.catalog.VehicleModel;
import com.autoparts.shop.catalog.VehicleModelRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class RestockNotificationApiTests {

	private static final String PASSWORD = "Password1!";

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private PartCategoryRepository categoryRepository;

	@Autowired
	private VehicleMakeRepository makeRepository;

	@Autowired
	private VehicleModelRepository modelRepository;

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Test
	void publicUserCanCreateEmailRestockNotificationForOutOfStockPart() throws Exception {
		Long partId = createEmployeePart("Notify public deo", 0);

		mockMvc.perform(post("/api/notifications/restock")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateRestockNotificationRequest(
					partId,
					NotificationChannel.EMAIL,
					"ana@example.com",
					null
				))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.id", notNullValue()))
			.andExpect(jsonPath("$.partId").value(partId))
			.andExpect(jsonPath("$.clientId").doesNotExist())
			.andExpect(jsonPath("$.channel").value("EMAIL"))
			.andExpect(jsonPath("$.email").value("ana@example.com"))
			.andExpect(jsonPath("$.status").value("PENDING"));
	}

	@Test
	void authenticatedClientCanCreateSmsRestockNotification() throws Exception {
		JsonNode auth = registerClient();
		String clientToken = auth.get("token").asText();
		Long clientId = auth.get("user").get("id").asLong();
		Long partId = createEmployeePart("Notify client deo", 0);

		mockMvc.perform(post("/api/notifications/restock")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateRestockNotificationRequest(
					partId,
					NotificationChannel.SMS,
					null,
					"+38164111222"
				))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.partId").value(partId))
			.andExpect(jsonPath("$.clientId").value(clientId))
			.andExpect(jsonPath("$.channel").value("SMS"))
			.andExpect(jsonPath("$.phone").value("+38164111222"));
	}

	@Test
	void rejectsMissingContactForSelectedChannel() throws Exception {
		Long partId = createEmployeePart("Notify validation deo", 0);

		mockMvc.perform(post("/api/notifications/restock")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateRestockNotificationRequest(
					partId,
					NotificationChannel.SMS,
					null,
					null
				))))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Phone is required for SMS notifications"));
	}

	@Test
	void rejectsNotificationForPartThatIsAlreadyInStock() throws Exception {
		Long partId = createEmployeePart("Notify in stock deo", 4);

		mockMvc.perform(post("/api/notifications/restock")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateRestockNotificationRequest(
					partId,
					NotificationChannel.EMAIL,
					"ana@example.com",
					null
				))))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Part is already in stock"));
	}

	@Test
	void employeeCanListNotificationsAndClientCannot() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		JsonNode auth = registerClient();
		String clientToken = auth.get("token").asText();
		Long partId = createEmployeePart("Notify list deo", 0);

		mockMvc.perform(post("/api/notifications/restock")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateRestockNotificationRequest(
					partId,
					NotificationChannel.EMAIL,
					"list@example.com",
					null
				))))
			.andExpect(status().isOk());

		mockMvc.perform(get("/api/employee/notifications")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isForbidden());

		mockMvc.perform(get("/api/employee/notifications")
				.header("Authorization", "Bearer " + employeeToken)
				.param("status", "PENDING"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()", greaterThanOrEqualTo(1)))
			.andExpect(jsonPath("$[0].status").value("PENDING"));
	}

	private Long createEmployeePart(String name, int stockQuantity) throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		String response = mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(buildPartRequest(uniqueSku(), name, stockQuantity, true))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("id").asLong();
	}

	private PartUpsertRequest buildPartRequest(String sku, String name, int stockQuantity, boolean active) {
		PartCategory category = categoryRepository.findBySlug("elektrika").orElseThrow();
		VehicleMake make = makeRepository.findByNameIgnoreCase("Univerzalno").orElseThrow();
		VehicleModel model = modelRepository.findFirstByMakeIdOrderByNameAsc(make.getId()).orElseThrow();

		return new PartUpsertRequest(
			category.getId(),
			make.getId(),
			model.getId(),
			sku,
			name,
			"Test deo za notification API proveru",
			"Bosch",
			new BigDecimal("2500.00"),
			stockQuantity,
			"/images/parts/notification-test.jpg",
			active
		);
	}

	private JsonNode registerClient() throws Exception {
		String email = "notify-" + System.nanoTime() + "@autodelovi.test";
		String response = mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Notify",
					"Client",
					email,
					"+38164111222",
					PASSWORD
				))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response);
	}

	private String login(String email) throws Exception {
		String response = mockMvc.perform(post("/api/auth/login")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new LoginRequest(email, PASSWORD))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("token").asText();
	}

	private String uniqueSku() {
		return "NOTIFY-" + System.nanoTime();
	}
}
