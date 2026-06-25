package com.autoparts.shop.catalog;

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
@Table(name = "vehicle_models")
public class VehicleModel {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "make_id", nullable = false)
	private VehicleMake make;

	@Column(nullable = false, length = 120)
	private String name;

	private Integer yearFrom;

	private Integer yearTo;

	protected VehicleModel() {
	}

	public VehicleModel(VehicleMake make, String name, Integer yearFrom, Integer yearTo) {
		this.make = make;
		this.name = name;
		this.yearFrom = yearFrom;
		this.yearTo = yearTo;
	}

	public Long getId() {
		return id;
	}

	public VehicleMake getMake() {
		return make;
	}

	public String getName() {
		return name;
	}

	public Integer getYearFrom() {
		return yearFrom;
	}

	public Integer getYearTo() {
		return yearTo;
	}
}
