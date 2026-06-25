package com.autoparts.shop.order;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import com.autoparts.shop.cart.Cart;
import com.autoparts.shop.cart.CartItem;
import com.autoparts.shop.cart.CartRepository;
import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.user.UserRole;
import com.autoparts.shop.web.ApiException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpStatus;
import org.springframework.test.util.ReflectionTestUtils;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.never;

/*
 * Odgovori na pitanja iz specifikacije:
 *
 * 1. Koji deo sistema predstavlja jedinicu koja se testira?
 * Jedinica koja se testira je metoda `createOrder` unutar klase `OrderService`. Ovo je centralna biznis logika
 * za kreiranje porudzbine koja orkestrira podatke iz korpe, racuna cene, poziva payment servis i azurira zalihe.
 *
 * 2. Koje zavisnosti su simulirane?
 * Simulirani (mock-ovani) su `UserRepository`, `CartRepository`, `PaymentService` i `OrderRepository`.
 * Umesto da ove komponente zaista idu u bazu ili ka eksternim sistemima, Mockito omogucava da definisemo
 * njihovo ponasanje u memoriji samo za potrebe testa.
 *
 * 3. Zbog cega se u datim testovima ne koristi prava baza podataka?
 * Ne koristi se prava baza podataka zato sto zelimo da izolujemo iskljucivo logiku unutar `OrderService` klase.
 * Konekcija sa bazom bi testove usporila, ucinila ih podloznim problemima sa mrezom ili stanjem podataka (flaky tests),
 * i pretvorila bi ih u integracione testove umesto u jedinicne (unit) testove.
 */
@ExtendWith(MockitoExtension.class)
class OrderServiceUnitTests {

	@Mock
	private OrderRepository orderRepository;

	@Mock
	private CartRepository cartRepository;

	@Mock
	private UserRepository userRepository;

	@Mock
	private PaymentService paymentService;

	@InjectMocks
	private OrderService orderService;

	private AppUser client;
	private CreateOrderRequest request;

	@BeforeEach
	void setUp() {
		client = new AppUser(UserRole.CLIENT, "Client", "Test", "client@test.com", "+381", "pass");
		ReflectionTestUtils.setField(client, "id", 1L);

		request = new CreateOrderRequest(
			"Test Kupac",
			"kupac@autodelovi.test",
			"+38164123456",
			"Adresa 1",
			"Beograd",
			"11000",
			PaymentMethod.CASH_ON_DELIVERY,
			null
		);
	}

	@Test
	void createsOrderSuccessfully() {
		// Arrange
		Part part = createPart("Test Deo", new BigDecimal("1000.00"), 5);
		Cart cart = new Cart(client);
		cart.addItem(part, 2);

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));
		when(paymentService.process(any(), any(), any())).thenReturn(new PaymentResult(PaymentStatus.CASH_ON_DELIVERY, null, null));
		when(orderRepository.save(any(ShopOrder.class))).thenAnswer(invocation -> {
			ShopOrder order = invocation.getArgument(0);
			ReflectionTestUtils.setField(order, "id", 100L);
			return order;
		});

		// Act
		OrderResponse response = orderService.createOrder(1L, request);

		// Assert
		assertThat(response.id()).isEqualTo(100L);
		assertThat(response.status()).isEqualTo(OrderStatus.CREATED);
		assertThat(response.total()).isEqualTo(new BigDecimal("2000.00"));
		assertThat(part.getStockQuantity()).isEqualTo(3); // 5 - 2 = 3
		assertThat(cart.getItems()).isEmpty(); // Cart should be cleared
		verify(orderRepository).save(any(ShopOrder.class));
	}

	@Test
	void throwsExceptionWhenCartIsEmpty() {
		// Arrange
		Cart emptyCart = new Cart(client);
		
		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(emptyCart));

		// Act & Assert
		assertThatThrownBy(() -> orderService.createOrder(1L, request))
			.isInstanceOf(ApiException.class)
			.hasMessageContaining("Cart is empty")
			.extracting("status")
			.isEqualTo(HttpStatus.BAD_REQUEST);

		verify(orderRepository, never()).save(any());
	}

	@Test
	void throwsExceptionWhenClientDoesNotExist() {
		// Arrange
		when(userRepository.findById(1L)).thenReturn(Optional.empty());

		// Act & Assert
		assertThatThrownBy(() -> orderService.createOrder(1L, request))
			.isInstanceOf(ApiException.class)
			.hasMessageContaining("User not found")
			.extracting("status")
			.isEqualTo(HttpStatus.UNAUTHORIZED);

		verify(cartRepository, never()).findByClientIdWithItems(any());
	}

	@Test
	void throwsExceptionWhenPartQuantityExceedsStock() {
		// Arrange
		Part part = createPart("Test Deo", new BigDecimal("1000.00"), 1); // Only 1 in stock
		Cart cart = new Cart(client);
		cart.addItem(part, 2); // Requesting 2

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));

		// Act & Assert
		assertThatThrownBy(() -> orderService.createOrder(1L, request))
			.isInstanceOf(ApiException.class)
			.hasMessageContaining("Requested quantity exceeds stock")
			.extracting("status")
			.isEqualTo(HttpStatus.BAD_REQUEST);

		verify(paymentService, never()).process(any(), any(), any());
		verify(orderRepository, never()).save(any());
	}

	@Test
	void calculatesCorrectTotalForMultipleItems() {
		// Arrange
		Part part1 = createPart("Deo 1", new BigDecimal("1000.00"), 5);
		Part part2 = createPart("Deo 2", new BigDecimal("500.00"), 5);
		Cart cart = new Cart(client);
		cart.addItem(part1, 2); // 2 * 1000 = 2000
		cart.addItem(part2, 3); // 3 * 500 = 1500
		                        // Total should be 3500

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));
		when(paymentService.process(any(), any(), any())).thenReturn(new PaymentResult(PaymentStatus.CASH_ON_DELIVERY, null, null));
		when(orderRepository.save(any(ShopOrder.class))).thenAnswer(invocation -> {
			ShopOrder order = invocation.getArgument(0);
			ReflectionTestUtils.setField(order, "id", 101L);
			return order;
		});

		// Act
		OrderResponse response = orderService.createOrder(1L, request);

		// Assert
		assertThat(response.total()).isEqualTo(new BigDecimal("3500.00"));
		verify(orderRepository).save(any(ShopOrder.class));
	}

	private Part createPart(String name, BigDecimal price, int stock) {
		Part part = new Part(null, null, null, "SKU", name, "Desc", "Brand", price, stock, "img");
		ReflectionTestUtils.setField(part, "id", (long) name.hashCode());
		ReflectionTestUtils.setField(part, "active", true);
		return part;
	}
}
