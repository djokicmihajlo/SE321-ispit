package com.autoparts.shop.specialorder;

import java.util.List;

import com.autoparts.shop.security.ShopUserDetails;
import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/special-orders")
public class PublicSpecialOrderController {

	private final SpecialOrderService specialOrderService;

	public PublicSpecialOrderController(SpecialOrderService specialOrderService) {
		this.specialOrderService = specialOrderService;
	}

	@PostMapping
	public SpecialOrderResponse create(
		@AuthenticationPrincipal ShopUserDetails userDetails,
		@Valid @RequestBody CreateSpecialOrderRequest request
	) {
		Long clientId = userDetails == null ? null : userDetails.user().getId();
		return specialOrderService.create(clientId, request);
	}

	@GetMapping("/my")
	@PreAuthorize("hasRole('CLIENT')")
	public List<SpecialOrderResponse> mine(@AuthenticationPrincipal ShopUserDetails userDetails) {
		return specialOrderService.findMine(userDetails.user().getId());
	}
}
