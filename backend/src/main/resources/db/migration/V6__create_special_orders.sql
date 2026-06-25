CREATE TABLE special_order_requests (
    id BIGINT NOT NULL AUTO_INCREMENT,
    client_id BIGINT,
    contact_name VARCHAR(160) NOT NULL,
    contact_email VARCHAR(160) NOT NULL,
    contact_phone VARCHAR(40) NOT NULL,
    vehicle_make VARCHAR(120) NOT NULL,
    vehicle_model VARCHAR(120) NOT NULL,
    vehicle_year INT,
    vin VARCHAR(40),
    parts_description TEXT NOT NULL,
    status VARCHAR(40) NOT NULL DEFAULT 'SUBMITTED',
    employee_response TEXT,
    estimated_arrival DATE,
    pickup_location VARCHAR(180),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_special_orders_client FOREIGN KEY (client_id) REFERENCES app_users (id),
    CONSTRAINT chk_special_orders_status CHECK (status IN ('SUBMITTED', 'CHECKING_SUPPLIER', 'AVAILABLE', 'UNAVAILABLE', 'CLOSED'))
);

CREATE INDEX idx_special_orders_client ON special_order_requests (client_id);
CREATE INDEX idx_special_orders_status ON special_order_requests (status);
