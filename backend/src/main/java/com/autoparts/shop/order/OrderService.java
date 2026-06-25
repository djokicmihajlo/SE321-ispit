package com.autoparts.shop.order;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.autoparts.shop.cart.Cart;
import com.autoparts.shop.cart.CartItem;
import com.autoparts.shop.cart.CartRepository;
import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {

	private static final Map<OrderStatus, Set<OrderStatus>> ALLOWED_TRANSITIONS = Map.of(
		OrderStatus.CREATED, Set.of(OrderStatus.PROCESSING, OrderStatus.CANCELLED),
		OrderStatus.PROCESSING, Set.of(OrderStatus.SHIPPED, OrderStatus.CANCELLED),
		OrderStatus.SHIPPED, Set.of(OrderStatus.DELIVERED),
		OrderStatus.DELIVERED, Set.of(),
		OrderStatus.CANCELLED, Set.of()
	);

	private final OrderRepository orderRepository;
	private final CartRepository cartRepository;
	private final UserRepository userRepository;
	private final PaymentService paymentService;

	public OrderService(OrderRepository orderRepository, CartRepository cartRepository, UserRepository userRepository, PaymentService paymentService) {
		this.orderRepository = orderRepository;
		this.cartRepository = cartRepository;
		this.userRepository = userRepository;
		this.paymentService = paymentService;
	}

	@Transactional
	public OrderResponse createOrder(Long clientId, CreateOrderRequest request) {
		AppUser client = findClient(clientId);
		Cart cart = cartRepository.findByClientIdWithItems(clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.BAD_REQUEST, "Cart is empty"));

		if (cart.getItems().isEmpty()) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Cart is empty");
		}

		BigDecimal subtotal = calculateSubtotal(cart.getItems());
		PaymentResult paymentResult = paymentService.process(request.paymentMethod(), subtotal, request.card());
		if (!paymentResult.successful()) {
			throw new ApiException(HttpStatus.PAYMENT_REQUIRED, paymentResult.failureReason());
		}

		ShopOrder order = new ShopOrder(
			client,
			nextOrderNumber(),
			request.paymentMethod(),
			paymentResult.status(),
			subtotal,
			request.contactName().trim(),
			request.contactEmail().trim(),
			request.contactPhone().trim(),
			request.shippingAddress().trim(),
			request.shippingCity().trim(),
			request.shippingPostalCode().trim()
		);

		for (CartItem cartItem : cart.getItems()) {
			Part part = cartItem.getPart();
			validateAvailability(part, cartItem.getQuantity());
			order.addItem(part, part.getName(), part.getPrice(), cartItem.getQuantity());
			part.decreaseStock(cartItem.getQuantity());
		}

		order.attachPayment(new Payment(
			order,
			request.paymentMethod(),
			paymentResult.status(),
			subtotal,
			paymentResult.transactionReference(),
			paymentResult.failureReason()
		));

		ShopOrder savedOrder = orderRepository.save(order);
		cart.clear();

		return OrderResponse.from(savedOrder);
	}

	@Transactional(readOnly = true)
	public List<OrderResponse> findMyOrders(Long clientId) {
		return orderRepository.findByClientIdWithDetails(clientId)
			.stream()
			.map(OrderResponse::from)
			.toList();
	}

	@Transactional(readOnly = true)
	public OrderResponse findOrder(Long requesterId, boolean employeeView, Long orderId) {
		ShopOrder order = findOrderWithDetails(orderId);
		if (!employeeView && !order.getClient().getId().equals(requesterId)) {
			throw new ApiException(HttpStatus.FORBIDDEN, "Access denied");
		}
		return OrderResponse.from(order);
	}

	@Transactional(readOnly = true)
	public List<OrderResponse> findEmployeeOrders(OrderStatus status) {
		return orderRepository.findAllWithDetails(status)
			.stream()
			.map(OrderResponse::from)
			.toList();
	}

	@Transactional
	public OrderResponse updateStatus(Long orderId, OrderStatus newStatus) {
		ShopOrder order = findOrderWithDetails(orderId);
		if (!ALLOWED_TRANSITIONS.getOrDefault(order.getStatus(), Set.of()).contains(newStatus)) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Order status transition is not allowed");
		}
		order.changeStatus(newStatus);
		return OrderResponse.from(order);
	}

	private AppUser findClient(Long clientId) {
		return userRepository.findById(clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "User not found"));
	}

	private ShopOrder findOrderWithDetails(Long orderId) {
		return orderRepository.findByIdWithDetails(orderId)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Order not found"));
	}

	private BigDecimal calculateSubtotal(List<CartItem> items) {
		return items.stream()
			.peek(item -> validateAvailability(item.getPart(), item.getQuantity()))
			.map(CartItem::subtotal)
			.reduce(BigDecimal.ZERO, BigDecimal::add);
	}

	private void validateAvailability(Part part, int quantity) {
		if (!part.isActive()) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Part is not available");
		}
		if (part.getStockQuantity() <= 0) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Part is out of stock");
		}
		if (quantity > part.getStockQuantity()) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Requested quantity exceeds stock");
		}
	}

	private String nextOrderNumber() {
		return "ORD-" + System.currentTimeMillis() + "-" + Math.abs((int) (System.nanoTime() % 10000));
	}
}
