package com.autoparts.shop.notification;

import java.time.LocalDateTime;

import com.autoparts.shop.catalog.Part;
import com.autoparts.shop.user.AppUser;
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
import jakarta.persistence.Table;

@Entity
@Table(name = "restock_notification_requests")
public class RestockNotificationRequest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "part_id", nullable = false)
	private Part part;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "client_id")
	private AppUser client;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 20)
	private NotificationChannel channel;

	@Column(length = 160)
	private String email;

	@Column(length = 40)
	private String phone;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 30)
	private NotificationStatus status = NotificationStatus.PENDING;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(insertable = false)
	private LocalDateTime notifiedAt;

	protected RestockNotificationRequest() {
	}

	public RestockNotificationRequest(Part part, AppUser client, NotificationChannel channel, String email, String phone) {
		this.part = part;
		this.client = client;
		this.channel = channel;
		this.email = email;
		this.phone = phone;
	}

	public Long getId() {
		return id;
	}

	public Part getPart() {
		return part;
	}

	public AppUser getClient() {
		return client;
	}

	public NotificationChannel getChannel() {
		return channel;
	}

	public String getEmail() {
		return email;
	}

	public String getPhone() {
		return phone;
	}

	public NotificationStatus getStatus() {
		return status;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public LocalDateTime getNotifiedAt() {
		return notifiedAt;
	}
}
