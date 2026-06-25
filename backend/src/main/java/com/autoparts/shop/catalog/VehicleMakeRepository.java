package com.autoparts.shop.catalog;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleMakeRepository extends JpaRepository<VehicleMake, Long> {

	Optional<VehicleMake> findByNameIgnoreCase(String name);
}
