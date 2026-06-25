package com.autoparts.shop.specialorder;

import java.time.LocalDate;
import java.time.LocalDateTime;

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
@Table(name = "special_order_requests")
public class SpecialOrderRequest {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "client_id")
	private AppUser client;

	@Column(nullable = false, length = 160)
	private String contactName;

	@Column(nullable = false, length = 160)
	private String contactEmail;

	@Column(nullable = false, length = 40)
	private String contactPhone;

	@Column(nullable = false, length = 120)
	private String vehicleMake;

	@Column(nullable = false, length = 120)
	private String vehicleModel;

	private Integer vehicleYear;

	@Column(length = 40)
	private String vin;

	@Column(nullable = false, columnDefinition = "TEXT")
	private String partsDescription;

	@Enumerated(EnumType.STRING)
	@Column(nullable = false, length = 40)
	private SpecialOrderStatus status = SpecialOrderStatus.SUBMITTED;

	@Column(columnDefinition = "TEXT")
	private String employeeResponse;

	private LocalDate estimatedArrival;

	@Column(length = 180)
	private String pickupLocation;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected SpecialOrderRequest() {
	}

	public SpecialOrderRequest(AppUser client, String contactName, String contactEmail, String contactPhone, String vehicleMake, String vehicleModel, Integer vehicleYear, String vin, String partsDescription) {
		this.client = client;
		this.contactName = contactName;
		this.contactEmail = contactEmail;
		this.contactPhone = contactPhone;
		this.vehicleMake = vehicleMake;
		this.vehicleModel = vehicleModel;
		this.vehicleYear = vehicleYear;
		this.vin = vin;
		this.partsDescription = partsDescription;
	}

	public Long getId() {
		return id;
	}

	public AppUser getClient() {
		return client;
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

	public String getVehicleMake() {
		return vehicleMake;
	}

	public String getVehicleModel() {
		return vehicleModel;
	}

	public Integer getVehicleYear() {
		return vehicleYear;
	}

	public String getVin() {
		return vin;
	}

	public String getPartsDescription() {
		return partsDescription;
	}

	public SpecialOrderStatus getStatus() {
		return status;
	}

	public String getEmployeeResponse() {
		return employeeResponse;
	}

	public LocalDate getEstimatedArrival() {
		return estimatedArrival;
	}

	public String getPickupLocation() {
		return pickupLocation;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void respond(SpecialOrderStatus status, String employeeResponse, LocalDate estimatedArrival, String pickupLocation) {
		this.status = status;
		this.employeeResponse = employeeResponse;
		this.estimatedArrival = estimatedArrival;
		this.pickupLocation = pickupLocation;
	}
}
