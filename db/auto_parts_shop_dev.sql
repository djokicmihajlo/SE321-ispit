-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 25, 2026 at 06:02 PM
-- Server version: 8.0.40
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `auto_parts_shop_dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE `app_users` (
  `id` bigint NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`id`, `role`, `first_name`, `last_name`, `email`, `phone`, `password_hash`, `active`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN', 'Admin', 'User', 'admin@autodelovi.test', '+381600000001', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(2, 'EMPLOYEE', 'Employee', 'User', 'employee@autodelovi.test', '+381600000002', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(3, 'CLIENT', 'Client', 'User', 'client@autodelovi.test', '+381600000003', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(4, 'CLIENT', 'User', 'User', 'user@gmail.com', NULL, '$2a$10$6EYpXEm4QtEgL0ZOyDdXm.cdK3tcYo0HOyH9NL4kKkSmMeD07v8B2', 1, '2026-06-25 17:31:01', '2026-06-25 17:31:01');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 4, '2026-06-25 17:31:01', '2026-06-25 17:31:01');

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint NOT NULL,
  `cart_id` bigint NOT NULL,
  `part_id` bigint NOT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `cart_items`
--

INSERT INTO `cart_items` (`id`, `cart_id`, `part_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 1, '2026-06-25 17:31:14', '2026-06-25 17:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `flyway_schema_history`
--

CREATE TABLE `flyway_schema_history` (
  `installed_rank` int NOT NULL,
  `version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `script` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` int DEFAULT NULL,
  `installed_by` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int NOT NULL,
  `success` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flyway_schema_history`
--

INSERT INTO `flyway_schema_history` (`installed_rank`, `version`, `description`, `type`, `script`, `checksum`, `installed_by`, `installed_on`, `execution_time`, `success`) VALUES
(1, '1', 'create users', 'SQL', 'V1__create_users.sql', -1394215039, 'root', '2026-06-25 16:46:11', 17, 1),
(2, '2', 'create parts catalog', 'SQL', 'V2__create_parts_catalog.sql', -1531422848, 'root', '2026-06-25 16:46:11', 76, 1),
(3, '3', 'create cart tables', 'SQL', 'V3__create_cart_tables.sql', 203196383, 'root', '2026-06-25 16:46:11', 24, 1),
(4, '4', 'create orders', 'SQL', 'V4__create_orders.sql', -153117449, 'root', '2026-06-25 16:46:11', 57, 1),
(5, '5', 'create notifications', 'SQL', 'V5__create_notifications.sql', -1750630332, 'root', '2026-06-25 16:46:11', 23, 1),
(6, '6', 'create special orders', 'SQL', 'V6__create_special_orders.sql', -31241286, 'root', '2026-06-25 16:46:11', 24, 1),
(7, '7', 'seed initial data', 'SQL', 'V7__seed_initial_data.sql', -1585400605, 'root', '2026-06-25 16:46:11', 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint NOT NULL,
  `client_id` bigint NOT NULL,
  `order_number` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `contact_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_city` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shipping_postal_code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `part_id` bigint NOT NULL,
  `part_name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `quantity` int NOT NULL,
  `line_total` decimal(12,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `parts`
--

CREATE TABLE `parts` (
  `id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `vehicle_make_id` bigint DEFAULT NULL,
  `vehicle_model_id` bigint DEFAULT NULL,
  `sku` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `manufacturer` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  `image_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `parts`
--

INSERT INTO `parts` (`id`, `category_id`, `vehicle_make_id`, `vehicle_model_id`, `sku`, `name`, `description`, `manufacturer`, `price`, `stock_quantity`, `image_url`, `active`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'BRK-GOLF7-FRONT', 'Prednje kocione plocice', 'Set prednjih kocionih plocica za Volkswagen Golf 7.', 'Brembo', 4200.00, 12, '/images/parts/brake-pads.jpg', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(2, 2, 2, 2, 'FLT-ASTRAJ-OIL', 'Filter ulja', 'Filter ulja za Opel Astra J benzinske i dizel motore.', 'Mann Filter', 1200.00, 30, '/images/parts/oil-filter.jpg', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(3, 3, 4, 4, 'BAT-60AH-UNI', 'Akumulator 60Ah', 'Univerzalni akumulator kapaciteta 60Ah.', 'Varta', 8900.00, 5, '/images/parts/battery.jpg', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(4, 4, 3, 3, 'CLU-PUNTO-SET', 'Set kvacila', 'Set kvacila za Fiat Punto. Trenutno nije na stanju.', 'LUK', 14500.00, 0, '/images/parts/clutch-kit.jpg', 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `part_categories`
--

CREATE TABLE `part_categories` (
  `id` bigint NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(140) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `part_categories`
--

INSERT INTO `part_categories` (`id`, `name`, `slug`, `description`, `image_url`, `active`, `created_at`, `updated_at`) VALUES
(1, 'Kocioni sistem', 'kocioni-sistem', 'Delovi za kocioni sistem vozila.', NULL, 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(2, 'Filteri', 'filteri', 'Filteri ulja, vazduha, goriva i kabine.', NULL, 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(3, 'Elektrika', 'elektrika', 'Akumulatori, sijalice i ostali elektricni delovi.', NULL, 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11'),
(4, 'Menjac', 'menjac', 'Delovi menjaca i kvacila.', NULL, 1, '2026-06-25 16:46:11', '2026-06-25 16:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `method` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `transaction_reference` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failure_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `restock_notification_requests`
--

CREATE TABLE `restock_notification_requests` (
  `id` bigint NOT NULL,
  `part_id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `channel` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notified_at` timestamp NULL DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `special_order_requests`
--

CREATE TABLE `special_order_requests` (
  `id` bigint NOT NULL,
  `client_id` bigint DEFAULT NULL,
  `contact_name` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(160) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_make` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_model` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_year` int DEFAULT NULL,
  `vin` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parts_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SUBMITTED',
  `employee_response` text COLLATE utf8mb4_unicode_ci,
  `estimated_arrival` date DEFAULT NULL,
  `pickup_location` varchar(180) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_makes`
--

CREATE TABLE `vehicle_makes` (
  `id` bigint NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_makes`
--

INSERT INTO `vehicle_makes` (`id`, `name`, `created_at`) VALUES
(1, 'Volkswagen', '2026-06-25 16:46:11'),
(2, 'Opel', '2026-06-25 16:46:11'),
(3, 'Fiat', '2026-06-25 16:46:11'),
(4, 'Univerzalno', '2026-06-25 16:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_models`
--

CREATE TABLE `vehicle_models` (
  `id` bigint NOT NULL,
  `make_id` bigint NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_from` int DEFAULT NULL,
  `year_to` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vehicle_models`
--

INSERT INTO `vehicle_models` (`id`, `make_id`, `name`, `year_from`, `year_to`, `created_at`) VALUES
(1, 1, 'Golf 7', 2012, 2020, '2026-06-25 16:46:11'),
(2, 2, 'Astra J', 2009, 2015, '2026-06-25 16:46:11'),
(3, 3, 'Punto', 1999, 2018, '2026-06-25 16:46:11'),
(4, 4, 'Univerzalni deo', NULL, NULL, '2026-06-25 16:46:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_users`
--
ALTER TABLE `app_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_app_users_email` (`email`),
  ADD KEY `idx_app_users_role` (`role`),
  ADD KEY `idx_app_users_active` (`active`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_carts_client` (`client_id`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_cart_items_cart_part` (`cart_id`,`part_id`),
  ADD KEY `idx_cart_items_part` (`part_id`);

--
-- Indexes for table `flyway_schema_history`
--
ALTER TABLE `flyway_schema_history`
  ADD PRIMARY KEY (`installed_rank`),
  ADD KEY `flyway_schema_history_s_idx` (`success`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_orders_order_number` (`order_number`),
  ADD KEY `idx_orders_client` (`client_id`),
  ADD KEY `idx_orders_status` (`status`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_items_order` (`order_id`),
  ADD KEY `idx_order_items_part` (`part_id`);

--
-- Indexes for table `parts`
--
ALTER TABLE `parts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_parts_sku` (`sku`),
  ADD KEY `idx_parts_category` (`category_id`),
  ADD KEY `idx_parts_vehicle_make` (`vehicle_make_id`),
  ADD KEY `idx_parts_vehicle_model` (`vehicle_model_id`),
  ADD KEY `idx_parts_name` (`name`),
  ADD KEY `idx_parts_stock` (`stock_quantity`);

--
-- Indexes for table `part_categories`
--
ALTER TABLE `part_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_part_categories_name` (`name`),
  ADD UNIQUE KEY `uk_part_categories_slug` (`slug`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payments_order` (`order_id`);

--
-- Indexes for table `restock_notification_requests`
--
ALTER TABLE `restock_notification_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_restock_notifications_client` (`client_id`),
  ADD KEY `idx_restock_notifications_part` (`part_id`),
  ADD KEY `idx_restock_notifications_status` (`status`);

--
-- Indexes for table `special_order_requests`
--
ALTER TABLE `special_order_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_special_orders_client` (`client_id`),
  ADD KEY `idx_special_orders_status` (`status`);

--
-- Indexes for table `vehicle_makes`
--
ALTER TABLE `vehicle_makes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_vehicle_makes_name` (`name`);

--
-- Indexes for table `vehicle_models`
--
ALTER TABLE `vehicle_models`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_vehicle_models_make_name` (`make_id`,`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `parts`
--
ALTER TABLE `parts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `part_categories`
--
ALTER TABLE `part_categories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `restock_notification_requests`
--
ALTER TABLE `restock_notification_requests`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `special_order_requests`
--
ALTER TABLE `special_order_requests`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicle_makes`
--
ALTER TABLE `vehicle_makes`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vehicle_models`
--
ALTER TABLE `vehicle_models`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `fk_carts_client` FOREIGN KEY (`client_id`) REFERENCES `app_users` (`id`);

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `fk_cart_items_cart` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_cart_items_part` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_client` FOREIGN KEY (`client_id`) REFERENCES `app_users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_items_part` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`);

--
-- Constraints for table `parts`
--
ALTER TABLE `parts`
  ADD CONSTRAINT `fk_parts_category` FOREIGN KEY (`category_id`) REFERENCES `part_categories` (`id`),
  ADD CONSTRAINT `fk_parts_vehicle_make` FOREIGN KEY (`vehicle_make_id`) REFERENCES `vehicle_makes` (`id`),
  ADD CONSTRAINT `fk_parts_vehicle_model` FOREIGN KEY (`vehicle_model_id`) REFERENCES `vehicle_models` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `restock_notification_requests`
--
ALTER TABLE `restock_notification_requests`
  ADD CONSTRAINT `fk_restock_notifications_client` FOREIGN KEY (`client_id`) REFERENCES `app_users` (`id`),
  ADD CONSTRAINT `fk_restock_notifications_part` FOREIGN KEY (`part_id`) REFERENCES `parts` (`id`);

--
-- Constraints for table `special_order_requests`
--
ALTER TABLE `special_order_requests`
  ADD CONSTRAINT `fk_special_orders_client` FOREIGN KEY (`client_id`) REFERENCES `app_users` (`id`);

--
-- Constraints for table `vehicle_models`
--
ALTER TABLE `vehicle_models`
  ADD CONSTRAINT `fk_vehicle_models_make` FOREIGN KEY (`make_id`) REFERENCES `vehicle_makes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
