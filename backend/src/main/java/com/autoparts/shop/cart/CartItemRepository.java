package com.autoparts.shop.cart;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {

	@Query("""
		select i from CartItem i
		join fetch i.cart c
		join fetch i.part p
		left join fetch p.category
		left join fetch p.vehicleMake
		left join fetch p.vehicleModel
		where i.id = :itemId and c.client.id = :clientId
		""")
	Optional<CartItem> findByIdAndClientId(@Param("itemId") Long itemId, @Param("clientId") Long clientId);
}
