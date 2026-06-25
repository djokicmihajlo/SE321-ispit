package com.autoparts.shop.order;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "orders")
public class ShopOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "client_id", nullable = false)
	private AppUser client;

	@Column(nullable = false, unique = true, length = 40)
	private String orderNumber;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private OrderStatus status = OrderStatus.CREATED;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private PaymentMethod paymentMethod;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private PaymentStatus paymentStatus;

	@Column(nullable = false, precision = 12, scale = 2)
	private BigDecimal subtotal;

	@Column(nullable = false, precision = 12, scale = 2)
	private BigDecimal total;

	@Column(nullable = false, length = 160)
	private String contactName;

	@Column(nullable = false, length = 160)
	private String contactEmail;

	@Column(nullable = false, length = 40)
	private String contactPhone;

	@Column(nullable = false, length = 255)
	private String shippingAddress;

	@Column(nullable = false, length = 120)
	private String shippingCity;

	@Column(nullable = false, length = 30)
	private String shippingPostalCode;

	@OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<OrderItem> items = new ArrayList<>();

	@OneToOne(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	private Payment payment;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected ShopOrder() {
	}

	public ShopOrder(AppUser client, String orderNumber, PaymentMethod paymentMethod, PaymentStatus paymentStatus, BigDecimal subtotal, String contactName, String contactEmail, String contactPhone, String shippingAddress, String shippingCity, String shippingPostalCode) {
		this.client = client;
		this.orderNumber = orderNumber;
		this.paymentMethod = paymentMethod;
		this.paymentStatus = paymentStatus;
		this.subtotal = subtotal;
		this.total = subtotal;
		this.contactName = contactName;
		this.contactEmail = contactEmail;
		this.contactPhone = contactPhone;
		this.shippingAddress = shippingAddress;
		this.shippingCity = shippingCity;
		this.shippingPostalCode = shippingPostalCode;
	}

	public Long getId() {
		return id;
	}

	public AppUser getClient() {
		return client;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public OrderStatus getStatus() {
		return status;
	}

	public PaymentMethod getPaymentMethod() {
		return paymentMethod;
	}

	public PaymentStatus getPaymentStatus() {
		return paymentStatus;
	}

	public BigDecimal getSubtotal() {
		return subtotal;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public String getContactName() {
		return contactName;
	}

	public String getContactEmail() {
		return contactEmail;
	}

	public String getContactPhone() {
		return contactPhone;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public String getShippingCity() {
		return shippingCity;
	}

	public String getShippingPostalCode() {
		return shippingPostalCode;
	}

	public List<OrderItem> getItems() {
		return items;
	}

	public Payment getPayment() {
		return payment;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void addItem(Part part, String partName, BigDecimal unitPrice, int quantity) {
		items.add(new OrderItem(this, part, partName, unitPrice, quantity));
	}

	public void attachPayment(Payment payment) {
		this.payment = payment;
	}

	public void changeStatus(OrderStatus status) {
		this.status = status;
	}
}
