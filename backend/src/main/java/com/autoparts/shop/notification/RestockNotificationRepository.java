package com.autoparts.shop.notification;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface RestockNotificationRepository extends JpaRepository<RestockNotificationRequest, Long> {

	@Query("""
		select r from RestockNotificationRequest r
		join fetch r.part p
		left join fetch r.client
		where (:status is null or r.status = :status)
		order by r.createdAt desc
		""")
	List<RestockNotificationRequest> findAllWithDetails(@Param("status") NotificationStatus status);
}
