package com.autoparts.shop.order;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "payments")
public class Payment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@OneToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "order_id", nullable = false)
	private ShopOrder order;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private PaymentMethod method;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private PaymentStatus status;

	@Column(nullable = false, precision = 12, scale = 2)
	private BigDecimal amount;

	@Column(length = 120)
	private String transactionReference;

	@Column(length = 255)
	private String failureReason;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	protected Payment() {
	}

	public Payment(ShopOrder order, PaymentMethod method, PaymentStatus status, BigDecimal amount, String transactionReference, String failureReason) {
		this.order = order;
		this.method = method;
		this.status = status;
		this.amount = amount;
		this.transactionReference = transactionReference;
		this.failureReason = failureReason;
	}

	public Long getId() {
		return id;
	}

	public PaymentMethod getMethod() {
		return method;
	}

	public PaymentStatus getStatus() {
		return status;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public String getTransactionReference() {
		return transactionReference;
	}

	public String getFailureReason() {
		return failureReason;
	}
}
