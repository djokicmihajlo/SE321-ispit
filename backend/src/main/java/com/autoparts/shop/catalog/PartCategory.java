package com.autoparts.shop.catalog;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "part_categories")
public class PartCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, unique = true, length = 120)
	private String name;

	@Column(nullable = false, unique = true, length = 140)
	private String slug;

	@Column(columnDefinition = "TEXT")
	private String description;

	@Column(length = 500)
	private String imageUrl;

	@Column(nullable = false)
	private boolean active = true;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime createdAt;

	@Column(nullable = false, insertable = false, updatable = false)
	private LocalDateTime updatedAt;

	protected PartCategory() {
	}

	public PartCategory(String name, String slug, String description) {
		this.name = name;
		this.slug = slug;
		this.description = description;
	}

	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getSlug() {
		return slug;
	}

	public String getDescription() {
		return description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public boolean isActive() {
		return active;
	}
}
