package com.autoparts.shop.catalog;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PartRepository extends JpaRepository<Part, Long> {

	boolean existsBySkuIgnoreCase(String sku);

	Optional<Part> findByIdAndActiveTrue(Long id);

	@Query("""
		select p from Part p
		join fetch p.category c
		left join fetch p.vehicleMake make
		left join fetch p.vehicleModel model
		where p.active = true
		  and (:categorySlug is null or c.slug = :categorySlug)
		  and (:make is null or lower(make.name) = lower(:make))
		  and (:model is null or lower(model.name) = lower(:model))
		  and (:search is null or lower(p.name) like lower(concat('%', :search, '%'))
		    or lower(p.description) like lower(concat('%', :search, '%'))
		    or lower(p.manufacturer) like lower(concat('%', :search, '%'))
		    or lower(p.sku) like lower(concat('%', :search, '%')))
		order by p.name asc
		""")
	List<Part> search(
		@Param("search") String search,
		@Param("categorySlug") String categorySlug,
		@Param("make") String make,
		@Param("model") String model
	);
}
