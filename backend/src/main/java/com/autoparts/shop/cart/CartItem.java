package com.autoparts.shop.cart;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import com.autoparts.shop.catalog.Part;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "cart_items")
public class CartItem {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "cart_id", nullable = false)
	private Cart cart;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "part_id", nullable = false)
	private Part part;

	@Column(nullable = false)
	private int quantity;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected CartItem() {
	}

	CartItem(Cart cart, Part part, int quantity) {
		this.cart = cart;
		this.part = part;
		this.quantity = quantity;
	}

	public Long getId() {
		return id;
	}

	public Cart getCart() {
		return cart;
	}

	public Part getPart() {
		return part;
	}

	public int getQuantity() {
		return quantity;
	}

	public BigDecimal subtotal() {
		return part.getPrice().multiply(BigDecimal.valueOf(quantity));
	}

	public void updateQuantity(int quantity) {
		this.quantity = quantity;
	}

	void detach() {
		this.cart = null;
	}
}
