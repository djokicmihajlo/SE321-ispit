CREATE TABLE restock_notification_requests (
    id BIGINT NOT NULL AUTO_INCREMENT,
    part_id BIGINT NOT NULL,
    client_id BIGINT,
    channel VARCHAR(20) NOT NULL,
    email VARCHAR(160),
    phone VARCHAR(40),
    status VARCHAR(30) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notified_at TIMESTAMP NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_restock_notifications_part FOREIGN KEY (part_id) REFERENCES parts (id),
    CONSTRAINT fk_restock_notifications_client FOREIGN KEY (client_id) REFERENCES app_users (id),
    CONSTRAINT chk_restock_notifications_channel CHECK (channel IN ('EMAIL', 'SMS')),
    CONSTRAINT chk_restock_notifications_status CHECK (status IN ('PENDING', 'SENT', 'CANCELLED'))
);

CREATE INDEX idx_restock_notifications_part ON restock_notification_requests (part_id);
CREATE INDEX idx_restock_notifications_status ON restock_notification_requests (status);
