package com.autoparts.shop.auth;

import static org.hamcrest.Matchers.hasItem;
import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.autoparts.shop.user.UserRepository;
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
class AuthApiTests {

	private static final String PASSWORD = "Password1!";

	@Autowired
	private MockMvc mockMvc;

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Autowired
	private UserRepository userRepository;

	@Test
	void registersClientAndReturnsJwtToken() throws Exception {
		String email = uniqueEmail("register");

		mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Test",
					"Client",
					email,
					"+381641110001",
					PASSWORD
				))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.token", notNullValue()))
			.andExpect(jsonPath("$.user.email").value(email))
			.andExpect(jsonPath("$.user.role").value("CLIENT"));
	}

	@Test
	void rejectsDuplicateRegistrationEmail() throws Exception {
		String email = uniqueEmail("duplicate");
		registerClient(email);

		mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest(
					"Other",
					"Client",
					email,
					null,
					PASSWORD
				))))
			.andExpect(status().isConflict())
			.andExpect(jsonPath("$.message").value("Email already registered"));
	}

	@Test
	void logsInAndLoadsCurrentUserProfile() throws Exception {
		String token = login("client@autodelovi.test", PASSWORD);

		mockMvc.perform(get("/api/auth/me")
				.header("Authorization", "Bearer " + token))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.email").value("client@autodelovi.test"))
			.andExpect(jsonPath("$.role").value("CLIENT"));
	}

	@Test
	void allowsAdminToCreateEmployeeAndForbidsClient() throws Exception {
		String adminToken = login("admin@autodelovi.test", PASSWORD);
		String clientToken = login("client@autodelovi.test", PASSWORD);
		String employeeEmail = uniqueEmail("employee");

		mockMvc.perform(post("/api/admin/employees")
				.header("Authorization", "Bearer " + clientToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateEmployeeRequest(
					"Blocked",
					"Employee",
					uniqueEmail("blocked"),
					null,
					PASSWORD
				))))
			.andExpect(status().isForbidden());

		mockMvc.perform(post("/api/admin/employees")
				.header("Authorization", "Bearer " + adminToken)
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new CreateEmployeeRequest(
					"New",
					"Employee",
					employeeEmail,
					"+381641110002",
					PASSWORD
				))))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$.email").value(employeeEmail))
			.andExpect(jsonPath("$.role").value("EMPLOYEE"));

		mockMvc.perform(get("/api/admin/employees")
				.header("Authorization", "Bearer " + adminToken))
			.andExpect(status().isOk())
			.andExpect(jsonPath("$[*].email", hasItem(employeeEmail)));
	}

	@Test
	void rejectsInvalidLoginCredentials() throws Exception {
		mockMvc.perform(post("/api/auth/login")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new LoginRequest("client@autodelovi.test", "WrongPassword1!"))))
			.andExpect(status().isUnauthorized())
			.andExpect(jsonPath("$.message").value("Invalid credentials"));
	}

	private void registerClient(String email) throws Exception {
		mockMvc.perform(post("/api/auth/register")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new RegisterRequest("Test", "Client", email, null, PASSWORD))))
			.andExpect(status().isOk());
	}

	private String login(String email, String password) throws Exception {
		String response = mockMvc.perform(post("/api/auth/login")
				.contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(new LoginRequest(email, password))))
			.andExpect(status().isOk())
			.andReturn()
			.getResponse()
			.getContentAsString();

		JsonNode json = objectMapper.readTree(response);
		return json.get("token").asText();
	}

	private String uniqueEmail(String prefix) {
		String email;
		do {
			email = "%s-%d@example.test".formatted(prefix, System.nanoTime());
		} while (userRepository.existsByEmailIgnoreCase(email));
		return email;
	}
}
