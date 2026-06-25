package com.autoparts.shop.cart;

import static org.hamcrest.Matchers.empty;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
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
class CartApiTests {

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
	void clientCanAddUpdateRemoveAndClearCartItems() throws Exception {
		String clientToken = registerClient();
		Long partId = createEmployeePart("Korpa test deo", 5);

		mockMvc.perform(get("/api/cart")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items", empty()))
			.andExpect(jsonPath("$.total").value(0));

		JsonNode afterAdd = performCartMutation("/api/cart/items", clientToken, new AddCartItemRequest(partId, 2));
		Long itemId = afterAdd.get("items").get(0).get("id").asLong();

		mockMvc.perform(post("/api/cart/items")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new AddCartItemRequest(partId, 1))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items.length()").value(1))
			.andExpect(jsonPath("$.items[0].quantity").value(3))
			.andExpect(jsonPath("$.items[0].subtotal").value(7500.00))
			.andExpect(jsonPath("$.total").value(7500.00));

		mockMvc.perform(patch("/api/cart/items/{itemId}", itemId)
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new UpdateCartItemRequest(4))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items[0].quantity").value(4))
			.andExpect(jsonPath("$.total").value(10000.00));

		mockMvc.perform(delete("/api/cart/items/{itemId}", itemId)
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items", empty()))
			.andExpect(jsonPath("$.total").value(0));

		performCartMutation("/api/cart/items", clientToken, new AddCartItemRequest(partId, 1));

		mockMvc.perform(delete("/api/cart")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isNoContent());

		mockMvc.perform(get("/api/cart")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items", empty()));
	}

	@Test
	void rejectsOutOfStockAndOverStockItems() throws Exception {
		String clientToken = registerClient();
		Long outOfStockPartId = createEmployeePart("Nema na stanju", 0);
		Long lowStockPartId = createEmployeePart("Mala zaliha", 2);

		mockMvc.perform(post("/api/cart/items")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new AddCartItemRequest(outOfStockPartId, 1))))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Part is out of stock"));

		mockMvc.perform(post("/api/cart/items")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new AddCartItemRequest(lowStockPartId, 3))))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Requested quantity exceeds stock"));
	}

	@Test
	void cartEndpointsAreOnlyForClients() throws Exception {
		String employeeToken = login("employee@autodelovi.test");

		mockMvc.perform(get("/api/cart")
				.header("Authorization", "Bearer " + employeeToken))
			.andExpect(status().isForbidden());
	}

	private JsonNode performCartMutation(String url, String token, Object body) throws Exception {
		String response = mockMvc.perform(post(url)
				.header("Authorization", "Bearer " + token)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(body)))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response);
	}

	private Long createEmployeePart(String name, int stockQuantity) throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		String response = mockMvc.perform(post("/api/employee/parts")
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(buildPartRequest(uniqueSku(), name, stockQuantity))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("id").asLong();
	}

	private PartUpsertRequest buildPartRequest(String sku, String name, int stockQuantity) {
		PartCategory category = categoryRepository.findBySlug("elektrika").orElseThrow();
		VehicleMake make = makeRepository.findByNameIgnoreCase("Univerzalno").orElseThrow();
		VehicleModel model = modelRepository.findFirstByMakeIdOrderByNameAsc(make.getId()).orElseThrow();

		return new PartUpsertRequest(
			category.getId(),
			make.getId(),
			model.getId(),
			sku,
			name,
			"Test deo za proveru korpe",
			"Bosch",
			new BigDecimal("2500.00"),
			stockQuantity,
			"/images/parts/cart-test.jpg",
			true
		);
	}

	private String registerClient() throws Exception {
		String email = "cart-" + System.nanoTime() + "@autodelovi.test";
		String response = mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Cart",
					"Client",
					email,
					"+38164111222",
					PASSWORD
				))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("token").asText();
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
		return "CART-" + System.nanoTime();
	}
}
