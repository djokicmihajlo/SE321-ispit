package com.autoparts.shop.catalog;

import static org.hamcrest.Matchers.greaterThan;
import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;

import com.autoparts.shop.auth.LoginRequest;
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
class PartApiTests {

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
	void listsAllActivePartsIncludingOutOfStockParts() throws Exception {
		mockMvc.perform(get("/api/parts"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()", greaterThan(3)))
			.andExpect(jsonPath("$[*].name", hasItem("Set kvacila")))
			.andExpect(jsonPath("$[?(@.name == 'Set kvacila')].inStock", hasItem(false)));
	}

	@Test
	void filtersPartsByCategoryMakeModelAndSearch() throws Exception {
		mockMvc.perform(get("/api/parts")
				.param("categorySlug", "kocioni-sistem")
				.param("make", "Volkswagen")
				.param("model", "Golf 7")
				.param("search", "plocice"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()").value(1))
			.andExpect(jsonPath("$[0].name").value("Prednje kocione plocice"))
			.andExpect(jsonPath("$[0].category.slug").value("kocioni-sistem"))
			.andExpect(jsonPath("$[0].vehicle.make").value("Volkswagen"))
			.andExpect(jsonPath("$[0].vehicle.model").value("Golf 7"));
	}

	@Test
	void getsPartDetails() throws Exception {
		Long partId = createEmployeePart();

		mockMvc.perform(get("/api/parts/{id}", partId))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.id").value(partId))
			.andExpect(jsonPath("$.sku", notNullValue()))
			.andExpect(jsonPath("$.inStock").value(true));
	}

	@Test
	void allowsEmployeeCrudAndForbidsClientCrud() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		String clientToken = login("client@autodelovi.test");
		PartUpsertRequest createRequest = buildPartRequest(uniqueSku(), "Test alternator", 7, true);

		mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(createRequest)))
			.andExpect(status().isForbidden());

		Long createdId = extractId(mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(createRequest)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.name").value("Test alternator"))
			.andExpect(jsonPath("$.stockQuantity").value(7))
			.andReturn()
			.getResponse()
			.getContentAsString());

		PartUpsertRequest updateRequest = buildPartRequest(createRequest.sku(), "Test alternator updated", 3, true);
		mockMvc.perform(put("/api/employee/parts/{id}", createdId)
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(updateRequest)))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.name").value("Test alternator updated"))
			.andExpect(jsonPath("$.stockQuantity").value(3));

		mockMvc.perform(delete("/api/employee/parts/{id}", createdId)
				.header("Authorization", "Bearer " + employeeToken))
			.andExpect(status().isNoContent());

		mockMvc.perform(get("/api/parts/{id}", createdId))
			.andExpect(status().isNotFound());
	}

	@Test
	void rejectsDuplicateSku() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		PartUpsertRequest first = buildPartRequest(uniqueSku(), "Duplicate SKU first", 2, true);
		PartUpsertRequest second = buildPartRequest(first.sku(), "Duplicate SKU second", 2, true);

		mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(first)))
			.andExpect(status().isOk());

		mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(second)))
			.andExpect(status().isConflict())
			.andExpect(jsonPath("$.message").value("SKU already exists"));
	}

	private Long createEmployeePart() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		String response = mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(buildPartRequest(uniqueSku(), "Detalji test deo", 4, true))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();
		return extractId(response);
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
			"Test deo za API proveru",
			"Bosch",
			new BigDecimal("2500.00"),
			stockQuantity,
			"/images/parts/test.jpg",
			active
		);
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

	private Long extractId(String response) throws Exception {
		JsonNode json = objectMapper.readTree(response);
		return json.get("id").asLong();
	}

	private String uniqueSku() {
		return "TEST-" + System.nanoTime();
	}
}
