package com.autoparts.shop.catalog;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
@Table(name = "parts")
public class Part {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "category_id", nullable = false)
	private PartCategory category;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "vehicle_make_id")
	private VehicleMake vehicleMake;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "vehicle_model_id")
	private VehicleModel vehicleModel;

	@Column(nullable = false, unique = true, length = 80)
	private String sku;

	@Column(nullable = false, length = 180)
	private String name;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Column(nullable = false, length = 120)
	private String manufacturer;

	@Column(nullable = false, precision = 12, scale = 2)
	private BigDecimal price;

	@Column(nullable = false)
	private int stockQuantity;

	@Column(length = 500)
	private String imageUrl;

	@Column(nullable = false)
	private boolean active = true;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected Part() {
	}

	public Part(PartCategory category, VehicleMake vehicleMake, VehicleModel vehicleModel, String sku, String name, String description, String manufacturer, BigDecimal price, int stockQuantity, String imageUrl) {
		this.category = category;
		this.vehicleMake = vehicleMake;
		this.vehicleModel = vehicleModel;
		this.sku = sku;
		this.name = name;
		this.description = description;
		this.manufacturer = manufacturer;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.imageUrl = imageUrl;
	}

	public Long getId() {
		return id;
	}

	public PartCategory getCategory() {
		return category;
	}

	public VehicleMake getVehicleMake() {
		return vehicleMake;
	}

	public VehicleModel getVehicleModel() {
		return vehicleModel;
	}

	public String getSku() {
		return sku;
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public boolean isActive() {
		return active;
	}

	public void update(PartCategory category, VehicleMake vehicleMake, VehicleModel vehicleModel, String sku, String name, String description, String manufacturer, BigDecimal price, int stockQuantity, String imageUrl, boolean active) {
		this.category = category;
		this.vehicleMake = vehicleMake;
		this.vehicleModel = vehicleModel;
		this.sku = sku;
		this.name = name;
		this.description = description;
		this.manufacturer = manufacturer;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.imageUrl = imageUrl;
		this.active = active;
	}

	public void deactivate() {
		this.active = false;
	}

	public void decreaseStock(int quantity) {
		this.stockQuantity -= quantity;
	}
}
