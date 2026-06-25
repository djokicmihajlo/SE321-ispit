package com.autoparts.shop.order;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.util.Optional;

import com.autoparts.shop.cart.Cart;
import com.autoparts.shop.cart.CartRepository;
import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.user.UserRole;
import com.autoparts.shop.web.ApiException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

	@Mock
	private OrderRepository orderRepository;

	@Mock
	private CartRepository cartRepository;

	@Mock
	private UserRepository userRepository;

	@Mock
	private PaymentService paymentService;

	private OrderService orderService;
	private AppUser client;

	@BeforeEach
	void setUp() {
		orderService = new OrderService(orderRepository, cartRepository, userRepository, paymentService);
		client = new AppUser(UserRole.CLIENT, "Test", "Client", "unit-client@autodelovi.test", "+38164111111", "hash");
	}

	@Test
	void createsCashOnDeliveryOrderAndReducesStock() {
		Part part = part("Unit deo", new BigDecimal("1500.00"), 5);
		Cart cart = new Cart(client);
		cart.addItem(part, 2);

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));
		when(paymentService.process(PaymentMethod.CASH_ON_DELIVERY, new BigDecimal("3000.00"), null))
			.thenReturn(new PaymentResult(PaymentStatus.CASH_ON_DELIVERY, null, null));
		when(orderRepository.save(any(ShopOrder.class))).thenAnswer(invocation -> invocation.getArgument(0));

		OrderResponse response = orderService.createOrder(1L, cashRequest());

		assertThat(response.status()).isEqualTo(OrderStatus.CREATED);
		assertThat(response.paymentStatus()).isEqualTo(PaymentStatus.CASH_ON_DELIVERY);
		assertThat(response.total()).isEqualByComparingTo("3000.00");
		assertThat(response.items()).hasSize(1);
		assertThat(part.getStockQuantity()).isEqualTo(3);
		assertThat(cart.getItems()).isEmpty();
	}

	@Test
	void rejectsEmptyCart() {
		Cart cart = new Cart(client);

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));

		assertThatThrownBy(() -> orderService.createOrder(1L, cashRequest()))
			.isInstanceOf(ApiException.class)
			.hasMessage("Cart is empty");

		verify(orderRepository, never()).save(any());
	}

	@Test
	void paymentFailureDoesNotCreateOrderOrReduceStock() {
		Part part = part("Card fail deo", new BigDecimal("1000.00"), 2);
		Cart cart = new Cart(client);
		cart.addItem(part, 1);
		CreateOrderRequest request = new CreateOrderRequest(
			"Test Client",
			"client@autodelovi.test",
			"+38164111111",
			"Test adresa 1",
			"Beograd",
			"11000",
			PaymentMethod.CARD,
			new CardPaymentRequest("Test Client", "4000000000000002", "12/30", "123")
		);

		when(userRepository.findById(1L)).thenReturn(Optional.of(client));
		when(cartRepository.findByClientIdWithItems(1L)).thenReturn(Optional.of(cart));
		when(paymentService.process(PaymentMethod.CARD, new BigDecimal("1000.00"), request.card()))
			.thenReturn(new PaymentResult(PaymentStatus.FAILED, null, "Card payment declined"));

		assertThatThrownBy(() -> orderService.createOrder(1L, request))
			.isInstanceOf(ApiException.class)
			.hasMessage("Card payment declined");

		assertThat(part.getStockQuantity()).isEqualTo(2);
		assertThat(cart.getItems()).hasSize(1);
		verify(orderRepository, never()).save(any());
	}

	@Test
	void rejectsInvalidStatusTransition() {
		ShopOrder order = new ShopOrder(client, "ORD-UNIT", PaymentMethod.CASH_ON_DELIVERY, PaymentStatus.CASH_ON_DELIVERY, new BigDecimal("1000.00"), "Test Client", "client@autodelovi.test", "+38164111111", "Test adresa 1", "Beograd", "11000");
		order.changeStatus(OrderStatus.DELIVERED);
		when(orderRepository.findByIdWithDetails(5L)).thenReturn(Optional.of(order));

		assertThatThrownBy(() -> orderService.updateStatus(5L, OrderStatus.CREATED))
			.isInstanceOf(ApiException.class)
			.hasMessage("Order status transition is not allowed");
	}

	private CreateOrderRequest cashRequest() {
		return new CreateOrderRequest(
			"Test Client",
			"client@autodelovi.test",
			"+38164111111",
			"Test adresa 1",
			"Beograd",
			"11000",
			PaymentMethod.CASH_ON_DELIVERY,
			null
		);
	}

	private Part part(String name, BigDecimal price, int stockQuantity) {
		return new Part(null, null, null, "UNIT-" + name, name, "Opis", "Bosch", price, stockQuantity, null);
	}
}
