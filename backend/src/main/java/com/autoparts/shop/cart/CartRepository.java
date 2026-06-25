package com.autoparts.shop.cart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CartRepository extends JpaRepository<Cart, Long> {

	@Query("""
		select distinct c from Cart c
		join fetch c.client
		left join fetch c.items i
		left join fetch i.part p
		left join fetch p.category
		left join fetch p.vehicleMake
		left join fetch p.vehicleModel
		where c.client.id = :clientId
		""")
	Optional<Cart> findByClientIdWithItems(@Param("clientId") Long clientId);
}
