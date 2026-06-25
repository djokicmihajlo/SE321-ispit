package com.autoparts.shop.specialorder;

import java.util.List;

import jakarta.validation.Valid;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/employee/special-orders")
@PreAuthorize("hasAnyRole('EMPLOYEE', 'ADMIN')")
public class EmployeeSpecialOrderController {

	private final SpecialOrderService specialOrderService;

	public EmployeeSpecialOrderController(SpecialOrderService specialOrderService) {
		this.specialOrderService = specialOrderService;
	}

	@GetMapping
	public List<SpecialOrderResponse> orders(@RequestParam(required = false) SpecialOrderStatus status) {
		return specialOrderService.findEmployeeOrders(status);
	}

	@PatchMapping("/{id}/status")
	public SpecialOrderResponse update(@PathVariable Long id, @Valid @RequestBody UpdateSpecialOrderRequest request) {
		return specialOrderService.update(id, request);
	}
}
