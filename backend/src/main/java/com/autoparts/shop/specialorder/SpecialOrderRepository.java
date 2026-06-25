package com.autoparts.shop.specialorder;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SpecialOrderRepository extends JpaRepository<SpecialOrderRequest, Long> {

	@Query("""
		select s from SpecialOrderRequest s
		left join fetch s.client
		where s.client.id = :clientId
		order by s.createdAt desc
		""")
	List<SpecialOrderRequest> findByClientIdWithDetails(@Param("clientId") Long clientId);

	@Query("""
		select s from SpecialOrderRequest s
		left join fetch s.client
		where s.id = :id
		""")
	Optional<SpecialOrderRequest> findByIdWithDetails(@Param("id") Long id);

	@Query("""
		select s from SpecialOrderRequest s
		left join fetch s.client
		where (:status is null or s.status = :status)
		order by s.createdAt desc
		""")
	List<SpecialOrderRequest> findAllWithDetails(@Param("status") SpecialOrderStatus status);
}
