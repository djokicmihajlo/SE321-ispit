package com.autoparts.shop.cart;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "carts")
public class Cart {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "client_id", nullable = false)
	private AppUser client;

	@OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<CartItem> items = new ArrayList<>();

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected Cart() {
	}

	public Cart(AppUser client) {
		this.client = client;
	}

	public Long getId() {
		return id;
	}

	public AppUser getClient() {
		return client;
	}

	public List<CartItem> getItems() {
		return items;
	}

	public Optional<CartItem> findItemByPartId(Long partId) {
		return items.stream()
			.filter(item -> item.getPart().getId().equals(partId))
			.findFirst();
	}

	public void addItem(Part part, int quantity) {
		CartItem item = new CartItem(this, part, quantity);
		items.add(item);
	}

	public void removeItem(CartItem item) {
		items.remove(item);
		item.detach();
	}

	public void clear() {
		items.forEach(CartItem::detach);
		items.clear();
	}
}
