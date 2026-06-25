package com.autoparts.shop.catalog;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface VehicleModelRepository extends JpaRepository<VehicleModel, Long> {

	Optional<VehicleModel> findByIdAndMakeId(Long id, Long makeId);

	Optional<VehicleModel> findFirstByMakeIdOrderByNameAsc(Long makeId);
}
