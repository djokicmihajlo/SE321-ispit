package com.autoparts.shop.cart;

import com.autoparts.shop.security.ShopUserDetails;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/cart")
@PreAuthorize("hasRole('CLIENT')")
public class CartController {

	private final CartService cartService;

	public CartController(CartService cartService) {
		this.cartService = cartService;
	}

	@GetMapping
	public CartResponse getCart(@AuthenticationPrincipal ShopUserDetails userDetails) {
		return cartService.getCart(userDetails.user().getId());
	}

	@PostMapping("/items")
	public CartResponse addItem(@AuthenticationPrincipal ShopUserDetails userDetails, @Valid @RequestBody AddCartItemRequest request) {
		return cartService.addItem(userDetails.user().getId(), request);
	}

	@PatchMapping("/items/{itemId}")
	public CartResponse updateItem(
		@AuthenticationPrincipal ShopUserDetails userDetails,
		@PathVariable Long itemId,
		@Valid @RequestBody UpdateCartItemRequest request
	) {
		return cartService.updateItem(userDetails.user().getId(), itemId, request);
	}

	@DeleteMapping("/items/{itemId}")
	public CartResponse removeItem(@AuthenticationPrincipal ShopUserDetails userDetails, @PathVariable Long itemId) {
		return cartService.removeItem(userDetails.user().getId(), itemId);
	}

	@DeleteMapping
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void clearCart(@AuthenticationPrincipal ShopUserDetails userDetails) {
		cartService.clearCart(userDetails.user().getId());
	}
}
