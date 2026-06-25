CREATE TABLE part_categories (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    slug VARCHAR(140) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT uk_part_categories_name UNIQUE (name),
    CONSTRAINT uk_part_categories_slug UNIQUE (slug)
);

CREATE TABLE vehicle_makes (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT uk_vehicle_makes_name UNIQUE (name)
);

CREATE TABLE vehicle_models (
    id BIGINT NOT NULL AUTO_INCREMENT,
    make_id BIGINT NOT NULL,
    name VARCHAR(120) NOT NULL,
    year_from INT,
    year_to INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_vehicle_models_make FOREIGN KEY (make_id) REFERENCES vehicle_makes (id),
    CONSTRAINT uk_vehicle_models_make_name UNIQUE (make_id, name)
);

CREATE TABLE parts (
    id BIGINT NOT NULL AUTO_INCREMENT,
    category_id BIGINT NOT NULL,
    vehicle_make_id BIGINT,
    vehicle_model_id BIGINT,
    sku VARCHAR(80) NOT NULL,
    name VARCHAR(180) NOT NULL,
    description TEXT,
    manufacturer VARCHAR(120) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    image_url VARCHAR(500),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT uk_parts_sku UNIQUE (sku),
    CONSTRAINT fk_parts_category FOREIGN KEY (category_id) REFERENCES part_categories (id),
    CONSTRAINT fk_parts_vehicle_make FOREIGN KEY (vehicle_make_id) REFERENCES vehicle_makes (id),
    CONSTRAINT fk_parts_vehicle_model FOREIGN KEY (vehicle_model_id) REFERENCES vehicle_models (id),
    CONSTRAINT chk_parts_price CHECK (price >= 0),
    CONSTRAINT chk_parts_stock CHECK (stock_quantity >= 0)
);

CREATE INDEX idx_parts_category ON parts (category_id);
CREATE INDEX idx_parts_vehicle_make ON parts (vehicle_make_id);
CREATE INDEX idx_parts_vehicle_model ON parts (vehicle_model_id);
CREATE INDEX idx_parts_name ON parts (name);
CREATE INDEX idx_parts_stock ON parts (stock_quantity);
