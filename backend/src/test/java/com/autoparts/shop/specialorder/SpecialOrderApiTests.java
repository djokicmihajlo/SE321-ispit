package com.autoparts.shop.specialorder;

import static org.hamcrest.Matchers.greaterThanOrEqualTo;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.patch;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Map;

import com.autoparts.shop.auth.LoginRequest;
import com.autoparts.shop.auth.RegisterRequest;
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
class SpecialOrderApiTests {

	private static final String PASSWORD = "Password1!";

	@Autowired
	private MockMvc mockMvc;

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Test
	void publicUserCanCreateSpecialOrderRequest() throws Exception {
		mockMvc.perform(post("/api/special-orders")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(createRequest("Public zahtev"))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.id").isNumber())
			.andExpect(jsonPath("$.clientId").doesNotExist())
			.andExpect(jsonPath("$.contactEmail").value("special@example.com"))
			.andExpect(jsonPath("$.vehicleMake").value("Toyota"))
			.andExpect(jsonPath("$.status").value("SUBMITTED"));
	}

	@Test
	void authenticatedClientCanCreateAndListOwnSpecialOrders() throws Exception {
		JsonNode auth = registerClient();
		String clientToken = auth.get("token").asText();
		Long clientId = auth.get("user").get("id").asLong();

		String response = mockMvc.perform(post("/api/special-orders")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(createRequest("Client zahtev"))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.clientId").value(clientId))
			.andReturn()
			.getResponse()
			.getContentAsString();

		Long createdId = objectMapper.readTree(response).get("id").asLong();

		mockMvc.perform(get("/api/special-orders/my")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[0].id").value(createdId))
			.andExpect(jsonPath("$[0].partsDescription").value("Client zahtev"));
	}

	@Test
	void employeeCanListAndAnswerSpecialOrderRequest() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		Long requestId = createPublicSpecialOrder("Employee list zahtev");

		mockMvc.perform(get("/api/employee/special-orders")
				.header("Authorization", "Bearer " + employeeToken)
				.param("status", "SUBMITTED"))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.length()", greaterThanOrEqualTo(1)));

		mockMvc.perform(patch("/api/employee/special-orders/{id}/status", requestId)
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(Map.of(
					"status", "AVAILABLE",
					"employeeResponse", "Dobavljac moze da isporuci deo.",
					"estimatedArrival", "2026-07-15",
					"pickupLocation", "Radnja Beograd"
				))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.status").value("AVAILABLE"))
			.andExpect(jsonPath("$.employeeResponse").value("Dobavljac moze da isporuci deo."))
			.andExpect(jsonPath("$.estimatedArrival").value("2026-07-15"))
			.andExpect(jsonPath("$.pickupLocation").value("Radnja Beograd"));
	}

	@Test
	void clientCannotAccessEmployeeSpecialOrderEndpoint() throws Exception {
		JsonNode auth = registerClient();
		String clientToken = auth.get("token").asText();

		mockMvc.perform(get("/api/employee/special-orders")
				.header("Authorization", "Bearer " + clientToken))
			.andExpect(status().isForbidden());
	}

	@Test
	void rejectsAvailableStatusWithoutArrivalAndPickupLocation() throws Exception {
		String employeeToken = login("employee@autodelovi.test");
		Long requestId = createPublicSpecialOrder("Invalid available zahtev");

		mockMvc.perform(patch("/api/employee/special-orders/{id}/status", requestId)
				.header("Authorization", "Bearer " + employeeToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(Map.of(
					"status", "AVAILABLE",
					"employeeResponse", "Dobavljac ima deo."
				))))
			.andExpect(status().isBadRequest())
			.andExpect(jsonPath("$.message").value("Estimated arrival is required when part is available"));
	}

	private Long createPublicSpecialOrder(String partsDescription) throws Exception {
		String response = mockMvc.perform(post("/api/special-orders")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(createRequest(partsDescription))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		return objectMapper.readTree(response).get("id").asLong();
	}

	private CreateSpecialOrderRequest createRequest(String partsDescription) {
		return new CreateSpecialOrderRequest(
			"Special Kupac",
			"special@example.com",
			"+38164123456",
			"Toyota",
			"Corolla",
			2014,
			"JTDBR32E720000001",
			partsDescription
		);
	}

	private JsonNode registerClient() throws Exception {
		String email = "special-" + System.nanoTime() + "@autodelovi.test";
		String response = mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Special",
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
}
