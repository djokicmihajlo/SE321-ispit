package com.autoparts.shop.cart;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.catalog.PartRepository;
import com.autoparts.shop.user.AppUser;
import com.autoparts.shop.user.UserRepository;
import com.autoparts.shop.web.ApiException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CartService {

	private final CartRepository cartRepository;
	private final CartItemRepository cartItemRepository;
	private final PartRepository partRepository;
	private final UserRepository userRepository;

	public CartService(
		CartRepository cartRepository,
		CartItemRepository cartItemRepository,
		PartRepository partRepository,
		UserRepository userRepository
	) {
		this.cartRepository = cartRepository;
		this.cartItemRepository = cartItemRepository;
		this.partRepository = partRepository;
		this.userRepository = userRepository;
	}

	@Transactional
	public CartResponse getCart(Long clientId) {
		return CartResponse.from(findOrCreateCart(clientId));
	}

	@Transactional
	public CartResponse addItem(Long clientId, AddCartItemRequest request) {
		Cart cart = findOrCreateCart(clientId);
		Part part = findAvailablePart(request.partId());
		int requestedQuantity = request.quantity();

		cart.findItemByPartId(part.getId()).ifPresentOrElse(
			item -> item.updateQuantity(validQuantity(part, item.getQuantity() + requestedQuantity)),
			() -> cart.addItem(part, validQuantity(part, requestedQuantity))
		);

		cartRepository.flush();
		return CartResponse.from(cart);
	}

	@Transactional
	public CartResponse updateItem(Long clientId, Long itemId, UpdateCartItemRequest request) {
		CartItem item = findClientItem(clientId, itemId);
		item.updateQuantity(validQuantity(item.getPart(), request.quantity()));
		return CartResponse.from(item.getCart());
	}

	@Transactional
	public CartResponse removeItem(Long clientId, Long itemId) {
		CartItem item = findClientItem(clientId, itemId);
		Cart cart = item.getCart();
		cart.removeItem(item);
		return CartResponse.from(cart);
	}

	@Transactional
	public void clearCart(Long clientId) {
		Cart cart = findOrCreateCart(clientId);
		cart.clear();
	}

	private Cart findOrCreateCart(Long clientId) {
		return cartRepository.findByClientIdWithItems(clientId)
			.orElseGet(() -> cartRepository.save(new Cart(findClient(clientId))));
	}

	private AppUser findClient(Long clientId) {
		return userRepository.findById(clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.UNAUTHORIZED, "User not found"));
	}

	private Part findAvailablePart(Long partId) {
		Part part = partRepository.findByIdAndActiveTrue(partId)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Part not found"));
		if (part.getStockQuantity() <= 0) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Part is out of stock");
		}
		return part;
	}

	private CartItem findClientItem(Long clientId, Long itemId) {
		return cartItemRepository.findByIdAndClientId(itemId, clientId)
			.orElseThrow(() -> new ApiException(HttpStatus.NOT_FOUND, "Cart item not found"));
	}

	private int validQuantity(Part part, int quantity) {
		if (quantity > part.getStockQuantity()) {
			throw new ApiException(HttpStatus.BAD_REQUEST, "Requested quantity exceeds stock");
		}
		return quantity;
	}
}
