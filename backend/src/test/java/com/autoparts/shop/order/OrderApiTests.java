package com.autoparts.shop.order;

import static org.hamcrest.Matchers.empty;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.math.BigDecimal;

import com.autoparts.shop.auth.LoginRequest;
import com.autoparts.shop.auth.RegisterRequest;
import com.autoparts.shop.cart.AddCartItemRequest;
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
class OrderApiTests {

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

	/*
	 * Komponente koje se zajednicki testiraju:
	 * OrderController -> OrderService -> OrderRepository -> testna baza podataka
	 * CartController -> CartService -> CartRepository -> testna baza podataka
	 * PaymentService (mock payment adapter)
	 */
	@Test
	void createsCashOnDeliveryOrderFromCartAndReducesStock() throws Exception {
		String clientToken = registerClient();
		Long partId = createEmployeePart("Order test deo", 5);
		addToCart(clientToken, partId, 2);

		String response = mockMvc.perform(post("/api/orders")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(cashOrderRequest())))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.status").value("CREATED"))
			.andExpect(jsonPath("$.paymentMethod").value("CASH_ON_DELIVERY"))
			.andExpect(jsonPath("$.paymentStatus").value("CASH_ON_DELIVERY"))
			.andExpect(jsonPath("$.total").value(5000.00))
			.andExpect(jsonPath("$.items.length()").value(1))
			.andExpect(jsonPath("$.items[0].quantity").value(2))
			.andReturn()
			.getResponse()
			.getContentAsString();

		Long orderId = objectMapper.readTree(response).get("id").asLong();

		mockMvc.perform(get("/api/parts/{id}", partId))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.stockQuantity").value(3));

		mockMvc.perform(get("/api/cart")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.items", empty()));

		mockMvc.perform(get("/api/orders/my")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[0].id").value(orderId));
	}

	/*
	 * Komponente koje se zajednicki testiraju:
	 * OrderController -> OrderService -> PaymentService -> OrderRepository -> testna baza podataka
	 */
	@Test
	void cardPaymentFailureDoesNotCreateOrderOrReduceStock() throws Exception {
		String clientToken = registerClient();
		Long partId = createEmployeePart("Card fail API deo", 4);
		addToCart(clientToken, partId, 1);

		mockMvc.perform(post("/api/orders")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(cardOrderRequest("4000000000000002"))))
			.andExpect(status().isPaymentRequired())
			.andExpect(jsonPath("$.message").value("Card payment declined"));

		mockMvc.perform(get("/api/parts/{id}", partId))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.stockQuantity").value(4));

		mockMvc.perform(get("/api/orders/my")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", empty()));
	}

	/*
	 * Komponente koje se zajednicki testiraju:
	 * OrderController -> OrderService -> PartRepository (provera zaliha) -> testna baza podataka
	 */
	@Test
	void rejectsOrderWhenCartPartBecomesOutOfStock() throws Exception {
		String clientToken = registerClient();
		String employeeToken = login("employee@autodelovi.test");
		Long partId = createEmployeePart("Out before checkout", 2);
		addToCart(clientToken, partId, 1);

		mockMvc.perform(put("/api/employee/parts/{id}", partId)
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(buildPartRequest("ORDER-UPDATED-" + System.nanoTime(), "Out before checkout", 0, true))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.stockQuantity").value(0));

		mockMvc.perform(post("/api/orders")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(cashOrderRequest())))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Part is out of stock"));

		mockMvc.perform(get("/api/orders/my")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$", empty()));
	}

	/*
	 * Komponente koje se zajednicki testiraju:
	 * SecurityFilterChain -> JwtAuthenticationFilter -> OrderController
	 * Proverava se da Spring Security blokira klijentski JWT na employee endpointu.
	 */
	@Test
	void clientCannotAccessEmployeeOrderStatusEndpoint() throws Exception {
		String clientToken = registerClient();
		Long partId = createEmployeePart("Forbidden status deo", 3);
		addToCart(clientToken, partId, 1);
		Long orderId = createOrder(clientToken);

		mockMvc.perform(patch("/api/employee/orders/{id}/status", orderId)
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new UpdateOrderStatusRequest(OrderStatus.PROCESSING))))
			.andExpect(status().isForbidden());
	}

	/*
	 * Komponente koje se zajednicki testiraju:
	 * OrderController -> OrderService (statusna masina) -> OrderRepository -> testna baza podataka
	 * Proveravaju se dozvoljeni prelazi (CREATED->PROCESSING->SHIPPED->DELIVERED)
	 * i nedozvoljeni prelazi (DELIVERED->CREATED).
	 */
	@Test
	void employeeCanMoveOrderThroughAllowedStatusesAndInvalidTransitionIsRejected() throws Exception {
		String clientToken = registerClient();
		String employeeToken = login("employee@autodelovi.test");
		Long partId = createEmployeePart("Status flow deo", 3);
		addToCart(clientToken, partId, 1);
		Long orderId = createOrder(clientToken);

		patchStatus(employeeToken, orderId, OrderStatus.PROCESSING)
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.status").value("PROCESSING"));

		patchStatus(employeeToken, orderId, OrderStatus.SHIPPED)
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.status").value("SHIPPED"));

		patchStatus(employeeToken, orderId, OrderStatus.DELIVERED)
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.status").value("DELIVERED"));

		patchStatus(employeeToken, orderId, OrderStatus.CREATED)
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Order status transition is not allowed"));
	}

	private org.springframework.test.web.servlet.ResultActions patchStatus(String token, Long orderId, OrderStatus status) throws Exception {
		return mockMvc.perform(patch("/api/employee/orders/{id}/status", orderId)
			.header("Authorization", "Bearer " + token)
			.contentType(MediaType.APPLICATION_JSON)
			.content(objectMapper.writeValueAsString(new UpdateOrderStatusRequest(status))));
	}

	private Long createOrder(String clientToken) throws Exception {
		String response = mockMvc.perform(post("/api/orders")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(cashOrderRequest())))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("id").asLong();
	}

	private void addToCart(String clientToken, Long partId, int quantity) throws Exception {
		mockMvc.perform(post("/api/cart/items")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new AddCartItemRequest(partId, quantity))))
			.andExpect(status().isOk());
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
			"Test deo za order API proveru",
			"Bosch",
			new BigDecimal("2500.00"),
			stockQuantity,
			"/images/parts/order-test.jpg",
			active
		);
	}

	private CreateOrderRequest cashOrderRequest() {
		return new CreateOrderRequest(
			"Test Kupac",
			"kupac@autodelovi.test",
			"+38164123456",
			"Bulevar test 10",
			"Beograd",
			"11000",
			PaymentMethod.CASH_ON_DELIVERY,
			null
		);
	}

	private CreateOrderRequest cardOrderRequest(String cardNumber) {
		return new CreateOrderRequest(
			"Test Kupac",
			"kupac@autodelovi.test",
			"+38164123456",
			"Bulevar test 10",
			"Beograd",
			"11000",
			PaymentMethod.CARD,
			new CardPaymentRequest("Test Kupac", cardNumber, "12/30", "123")
		);
	}

	private String registerClient() throws Exception {
		String email = "order-" + System.nanoTime() + "@autodelovi.test";
		String response = mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Order",
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
		return "ORDER-" + System.nanoTime();
	}
}
