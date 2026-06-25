package com.autoparts.shop.order;

import java.util.List;

import com.autoparts.shop.security.ShopUserDetails;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/orders")
public class ClientOrderController {

	private final OrderService orderService;

	public ClientOrderController(OrderService orderService) {
		this.orderService = orderService;
	}

	@PostMapping
	@PreAuthorize("hasRole('CLIENT')")
	public OrderResponse createOrder(@AuthenticationPrincipal ShopUserDetails userDetails, @Valid @RequestBody CreateOrderRequest request) {
		return orderService.createOrder(userDetails.user().getId(), request);
	}

	@GetMapping("/my")
	@PreAuthorize("hasRole('CLIENT')")
	public List<OrderResponse> myOrders(@AuthenticationPrincipal ShopUserDetails userDetails) {
		return orderService.findMyOrders(userDetails.user().getId());
	}

	@GetMapping("/{id}")
	@PreAuthorize("hasAnyRole('CLIENT', 'EMPLOYEE', 'ADMIN')")
	public OrderResponse getOrder(@AuthenticationPrincipal ShopUserDetails userDetails, @PathVariable Long id) {
		boolean employeeView = userDetails.getAuthorities().stream()
			.anyMatch(authority -> authority.getAuthority().equals("ROLE_EMPLOYEE") || authority.getAuthority().equals("ROLE_ADMIN"));
		return orderService.findOrder(userDetails.user().getId(), employeeView, id);
	}
}
