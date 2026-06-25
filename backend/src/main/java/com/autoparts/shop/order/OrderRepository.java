package com.autoparts.shop.order;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface OrderRepository extends JpaRepository<ShopOrder, Long> {

	@Query("""
		select distinct o from ShopOrder o
		join fetch o.client
		left join fetch o.items i
		left join fetch i.part
		left join fetch o.payment
		where o.client.id = :clientId
		order by o.createdAt desc
		""")
	List<ShopOrder> findByClientIdWithDetails(@Param("clientId") Long clientId);

	@Query("""
		select distinct o from ShopOrder o
		join fetch o.client
		left join fetch o.items i
		left join fetch i.part
		left join fetch o.payment
		where o.id = :id
		""")
	Optional<ShopOrder> findByIdWithDetails(@Param("id") Long id);

	@Query("""
		select distinct o from ShopOrder o
		join fetch o.client
		left join fetch o.items i
		left join fetch i.part
		left join fetch o.payment
		where (:status is null or o.status = :status)
		order by o.createdAt desc
		""")
	List<ShopOrder> findAllWithDetails(@Param("status") OrderStatus status);
}
