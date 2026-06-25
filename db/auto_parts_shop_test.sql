-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 25, 2026 at 06:03 PM
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
-- Database: `auto_parts_shop_test`
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
(1, 'ADMIN', 'Admin', 'User', 'admin@autodelovi.test', '+381600000001', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(2, 'EMPLOYEE', 'Employee', 'User', 'employee@autodelovi.test', '+381600000002', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(3, 'CLIENT', 'Client', 'User', 'client@autodelovi.test', '+381600000003', '$2a$10$9HvN28mpBVhkhkJyv8.Ux.1lTNUjvEtFHKkcwLnLYaR2umH6o7nPG', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(4, 'CLIENT', 'Test', 'Client', 'register-356313744047416@example.test', '+381641110001', '$2a$10$.juVCJcBwxDEuv2gnJDqROoYhRJfcMd1MCKHONXlSfmHshsLDA3Tu', 1, '2026-06-25 16:18:21', '2026-06-25 16:18:21'),
(5, 'CLIENT', 'Test', 'Client', 'duplicate-356314513475875@example.test', NULL, '$2a$10$yuzf8iToO8Iy8cQYr.4uiOfLmWUNSqj4DtCowjz1Y5XlwHiB0y1jy', 1, '2026-06-25 16:18:21', '2026-06-25 16:18:21'),
(6, 'EMPLOYEE', 'New', 'Employee', 'employee-356314762182250@example.test', '+381641110002', '$2a$10$v54abfVrcC8U9b3UZkBC1Oodt2t0dGOgjO9WOm9.RN0IkLWoji1ZG', 1, '2026-06-25 16:18:22', '2026-06-25 16:18:22'),
(7, 'CLIENT', 'Test', 'Client', 'register-356327457419666@example.test', '+381641110001', '$2a$10$HaiorzkryKUvDSKdYHefteQKhk1rZZXW1f10ZPnFgRlXxyIgftGPO', 1, '2026-06-25 16:18:35', '2026-06-25 16:18:35'),
(8, 'CLIENT', 'Test', 'Client', 'duplicate-356328171499583@example.test', NULL, '$2a$10$VZrk0GO8GpcN3Iw76O9.oOGNgQrNFXST4aNo/TcmdGep0XCI8b0/q', 1, '2026-06-25 16:18:35', '2026-06-25 16:18:35'),
(9, 'EMPLOYEE', 'New', 'Employee', 'employee-356328416568750@example.test', '+381641110002', '$2a$10$Z2bj9H5bRM0Nj6d2BrHkCOv00AivCbdT4rqi/7GG72XAeaqefmmC2', 1, '2026-06-25 16:18:35', '2026-06-25 16:18:35'),
(10, 'CLIENT', 'Test', 'Client', 'register-356553817356333@example.test', '+381641110001', '$2a$10$xas9rSBbjx8yX.5k.IERK.IiSXWxANwi5X3ePxFk.ey4E230/fK1y', 1, '2026-06-25 16:22:21', '2026-06-25 16:22:21'),
(11, 'CLIENT', 'Test', 'Client', 'duplicate-356554295156833@example.test', NULL, '$2a$10$j3KUwYr1e4l4.aQxEq7mIezApz8k8FEfQI/ALRTq48351oTQYviG.', 1, '2026-06-25 16:22:21', '2026-06-25 16:22:21'),
(12, 'EMPLOYEE', 'New', 'Employee', 'employee-356554539712708@example.test', '+381641110002', '$2a$10$4xn9uMVK6pueBQmEZ4SsRuJJPKQtNfdASAwF.fajHrcjCh9TKgClW', 1, '2026-06-25 16:22:22', '2026-06-25 16:22:22'),
(13, 'CLIENT', 'Test', 'Client', 'register-356617417030750@example.test', '+381641110001', '$2a$10$OeNsGocyi6bRKVUmB2xDvu3TEdTAEVlT/QI588VtTU16cidVVNjte', 1, '2026-06-25 16:23:25', '2026-06-25 16:23:25'),
(14, 'CLIENT', 'Test', 'Client', 'duplicate-356617913489166@example.test', NULL, '$2a$10$e3kimUB1/QbEKBBcVp1zSeAWD2beLr0GroIDc2UUkIc8FR1NiKHh6', 1, '2026-06-25 16:23:25', '2026-06-25 16:23:25'),
(15, 'EMPLOYEE', 'New', 'Employee', 'employee-356618183648166@example.test', '+381641110002', '$2a$10$K0nSJKEcEU5/7WyY67qrA.J0TGtfPXPCwdmq6ejS.o3dbgDUOMfbK', 1, '2026-06-25 16:23:25', '2026-06-25 16:23:25'),
(16, 'CLIENT', 'Test', 'Client', 'register-356637318127791@example.test', '+381641110001', '$2a$10$AESFiskGGUMpSiCmL/C0me0Sg0hdUgGkgJYPhwOSgjNgSrMTRZ9D6', 1, '2026-06-25 16:23:44', '2026-06-25 16:23:44'),
(17, 'CLIENT', 'Test', 'Client', 'duplicate-356637803780750@example.test', NULL, '$2a$10$fQ4gu691qit5/FLSmawzaOzlQv64IArlmbauM1id/klT8vUd/yQWu', 1, '2026-06-25 16:23:45', '2026-06-25 16:23:45'),
(18, 'EMPLOYEE', 'New', 'Employee', 'employee-356638055186041@example.test', '+381641110002', '$2a$10$mz4xDEXNvXzd3oChY6MGuu9bTdVcZCHjwc7COctNzcdUOq2Lh5uQO', 1, '2026-06-25 16:23:45', '2026-06-25 16:23:45'),
(19, 'CLIENT', 'Test', 'Client', 'register-356850036146708@example.test', '+381641110001', '$2a$10$17q1gLTTbsu8m1YRXSo24OYjz4TFBbdQrkOfFexJUTLUNbx6mLdnu', 1, '2026-06-25 16:27:17', '2026-06-25 16:27:17'),
(20, 'CLIENT', 'Test', 'Client', 'duplicate-356850515909541@example.test', NULL, '$2a$10$z5POWse4EBTurJgrLkSQg.nn0a88I//501oBJj2370WJ7LIz.nS5C', 1, '2026-06-25 16:27:17', '2026-06-25 16:27:17'),
(21, 'EMPLOYEE', 'New', 'Employee', 'employee-356850765554041@example.test', '+381641110002', '$2a$10$yqbZuW.p9Ei8FrYkeZIwHeDhCI3SgAXtyKRY4WRQznuv6gyBOifVm', 1, '2026-06-25 16:27:18', '2026-06-25 16:27:18'),
(22, 'CLIENT', 'Cart', 'Client', 'cart-356852005906166@autodelovi.test', '+38164111222', '$2a$10$x.Z2YheOwkhJ47huHfTDluE5hpbXRhspqUaHyvtaNK/2jQoyezag6', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(23, 'CLIENT', 'Cart', 'Client', 'cart-356852358628750@autodelovi.test', '+38164111222', '$2a$10$/70Sm0pmZi4rRJD5irFqN.hXvOFlMkME0z9S5baHyMFEKKHbAt5BK', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(24, 'CLIENT', 'Cart', 'Client', 'cart-356875762819458@autodelovi.test', '+38164111222', '$2a$10$r/Kz7JSV4Vqa9aM1xuANIe64pVPDKKBab1ww6GdMUDn9LZpbwzND6', 1, '2026-06-25 16:27:43', '2026-06-25 16:27:43'),
(25, 'CLIENT', 'Cart', 'Client', 'cart-356876628083125@autodelovi.test', '+38164111222', '$2a$10$WxLR.wgGV10jFbgOWuZGdumd06A15VkO1A2Yujs8iL1oYfSSLcTWK', 1, '2026-06-25 16:27:44', '2026-06-25 16:27:44'),
(26, 'CLIENT', 'Test', 'Client', 'register-356887501479708@example.test', '+381641110001', '$2a$10$X/UQeoCR62r6g3zTZjmvzO9hF3.RwLMxXzRN/DWXpJn9ZDaMEx2AS', 1, '2026-06-25 16:27:55', '2026-06-25 16:27:55'),
(27, 'CLIENT', 'Test', 'Client', 'duplicate-356888140888375@example.test', NULL, '$2a$10$p2yUvUg0stDEk2uDBi9h2.jTpcl0DnxX1G.SvXZBd7YIqYnRR0yEW', 1, '2026-06-25 16:27:55', '2026-06-25 16:27:55'),
(28, 'EMPLOYEE', 'New', 'Employee', 'employee-356888438190250@example.test', '+381641110002', '$2a$10$Cb5N7Qyi7fWy4OvqStkPG.VVYnMfFK4TQsZUQu47SDkaYj8Jsfc.6', 1, '2026-06-25 16:27:55', '2026-06-25 16:27:55'),
(29, 'CLIENT', 'Cart', 'Client', 'cart-356889743958916@autodelovi.test', '+38164111222', '$2a$10$lVFyEzqPe.g5VXv5rgPbb.MO7QuuYx6o3GzbeZNV0D80PA5ZPUk1W', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(30, 'CLIENT', 'Cart', 'Client', 'cart-356890198532000@autodelovi.test', '+38164111222', '$2a$10$CjjNKzhe2lyZYkZRUbiq/O1wqceHAWSiS2FhH1t6UeOQOVEizfW3y', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(31, 'CLIENT', 'Test', 'Client', 'register-356903459825541@example.test', '+381641110001', '$2a$10$oNTc7fUWvyS/FhsFQ.7ZtOsauChv3FOw/d1aAKX/AiIW.4uv8OzJa', 1, '2026-06-25 16:28:11', '2026-06-25 16:28:11'),
(32, 'CLIENT', 'Test', 'Client', 'duplicate-356903985718916@example.test', NULL, '$2a$10$sIi.r2k0YWNdJG32kec5veFZSOTqC/nfmY3rTOh3AzbV1tZ6W93wS', 1, '2026-06-25 16:28:11', '2026-06-25 16:28:11'),
(33, 'EMPLOYEE', 'New', 'Employee', 'employee-356904233270125@example.test', '+381641110002', '$2a$10$ANs19N5Da4vhZpGiDuhKWOyJ3s5dys71sosSQh8BvMqWuki9zRZNi', 1, '2026-06-25 16:28:11', '2026-06-25 16:28:11'),
(34, 'CLIENT', 'Cart', 'Client', 'cart-356905681138375@autodelovi.test', '+38164111222', '$2a$10$cIVvt7y3S2WNiZIIRd2FBeB8crhXm9M1dqx2vq1XRO3v41Y4gBToa', 1, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(35, 'CLIENT', 'Cart', 'Client', 'cart-356906232022000@autodelovi.test', '+38164111222', '$2a$10$v0MIhLAa.QLkPGQsCCeZQOZ9MY9.LaiBiSSGOpz15hysmzpnWmdSa', 1, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(36, 'CLIENT', 'Order', 'Client', 'order-357230195578750@autodelovi.test', '+38164111222', '$2a$10$df71wDP8/b0pggDNz/x29.qYs0pWuUoffR9J5P7rw4G3JUpWZoDdu', 1, '2026-06-25 16:33:37', '2026-06-25 16:33:37'),
(37, 'CLIENT', 'Order', 'Client', 'order-357230989813500@autodelovi.test', '+38164111222', '$2a$10$7O9WoSkig5S83jvfhah0zuiRmncEMZVDIJPFObuIHOac6nvDiUV8G', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(38, 'CLIENT', 'Order', 'Client', 'order-357231237665250@autodelovi.test', '+38164111222', '$2a$10$oPbhc.XVgiPzqZWlhC4I0Orw3qC0bAbnMVfVeGwbH31O4D0Mc2eQW', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(39, 'CLIENT', 'Order', 'Client', 'order-357231479509250@autodelovi.test', '+38164111222', '$2a$10$TaU19mGh11zXtzoI7XIuZuSWabPoeHMn/IasXT80KeHfHTPIGaS8K', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(40, 'CLIENT', 'Order', 'Client', 'order-357231745135958@autodelovi.test', '+38164111222', '$2a$10$ffpUgr3Ordv0zS5aAOtf5O0jRaV7DSNe825WGLo19brIkKDuofRIq', 1, '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(41, 'CLIENT', 'Order', 'Client', 'order-357243887288958@autodelovi.test', '+38164111222', '$2a$10$V6WjtX6Wr4i5LV.Aw04JC.nAbdyAoJU4Smqq/HewLcvMhkFsJPgrC', 1, '2026-06-25 16:33:51', '2026-06-25 16:33:51'),
(42, 'CLIENT', 'Order', 'Client', 'order-357244777573458@autodelovi.test', '+38164111222', '$2a$10$c0/zBsMlbT/j3K4QMT/O5eGphfCpmaz42ow0eaylfZKEFSvzsnG9W', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(43, 'CLIENT', 'Order', 'Client', 'order-357245014299916@autodelovi.test', '+38164111222', '$2a$10$ZZzjXgAAQ/Mzc5vz9DSOkuznawPENrOiEsWxhJ1RatY4H9uX4bSzK', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(44, 'CLIENT', 'Order', 'Client', 'order-357245249111125@autodelovi.test', '+38164111222', '$2a$10$IlYZ.Q31Qm5nCjYo1tS1BOAx6V7ificIozm1kv4kirOVxPTw.dZXm', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(45, 'CLIENT', 'Order', 'Client', 'order-357245532667583@autodelovi.test', '+38164111222', '$2a$10$1NBBaoi4DkTUIEYNIm.nwuDVRutGjo0AbO4DmJ4YrsMkvtVzmKT1S', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(46, 'CLIENT', 'Test', 'Client', 'register-357245888909166@example.test', '+381641110001', '$2a$10$163XBS1DwLDJHzhDS1YohOP/P9xUjQlhnwIdSPZIFDNQHJIODPicG', 1, '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(47, 'CLIENT', 'Test', 'Client', 'duplicate-357246048663625@example.test', NULL, '$2a$10$Jyu3ISHNWs01i1WPC1/tJueZSKVaRz.K9N1MSlA8mnUwl0bVIKz72', 1, '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(48, 'EMPLOYEE', 'New', 'Employee', 'employee-357246285671833@example.test', '+381641110002', '$2a$10$6x/cclx2ZAMJI4sMMGOLEeLelTunhLwyiU2lJ1MwGptDOojMm1teC', 1, '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(49, 'CLIENT', 'Cart', 'Client', 'cart-357247392590250@autodelovi.test', '+38164111222', '$2a$10$hqjW/WCEKq/SFN.FM6XdZu7InYnkvUhRuxr62dfrZEiZAKqJi.i.G', 1, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(50, 'CLIENT', 'Cart', 'Client', 'cart-357247782993916@autodelovi.test', '+38164111222', '$2a$10$.IHxwxf5wByWN3hveEr3yu/GHxfHZMVtSSHGLNJVi3Gn7xUDnfrxm', 1, '2026-06-25 16:33:55', '2026-06-25 16:33:55'),
(51, 'CLIENT', 'Order', 'Client', 'order-357264567760833@autodelovi.test', '+38164111222', '$2a$10$slA6S9aB7JCPVARJcknJOeoSsL5zjKRhpdVSSSQkK0bk9h8uK53J2', 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(52, 'CLIENT', 'Order', 'Client', 'order-357265365654916@autodelovi.test', '+38164111222', '$2a$10$vH4pm5Xa4M/b9p3mGIl9ReM4CeLk8wpabFlYF14L61X738ufo/pn6', 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(53, 'CLIENT', 'Order', 'Client', 'order-357265607742625@autodelovi.test', '+38164111222', '$2a$10$1xtVqiRuwu9BerhQoGQCy.IQP5mmFKwEGJmJpYl.IzJN45jialGkC', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(54, 'CLIENT', 'Order', 'Client', 'order-357265848520500@autodelovi.test', '+38164111222', '$2a$10$kmyvZG1SWAY7DZgx4P8kI.XyfuF4cFs.H0YLPjN/cQlbwPy0CKIQO', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(55, 'CLIENT', 'Order', 'Client', 'order-357266121580916@autodelovi.test', '+38164111222', '$2a$10$MbI0kwcezBClFOma87kbuOOm5eqx0NrzQrvWccBSbIB8iWKpARjwq', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(56, 'CLIENT', 'Test', 'Client', 'register-357266470461208@example.test', '+381641110001', '$2a$10$70nkcYe7Y5JLV2Pwl9/vCu6Th8anpQw1AnYJEpvNGOyelHGTJOMRq', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(57, 'CLIENT', 'Test', 'Client', 'duplicate-357266629589125@example.test', NULL, '$2a$10$b/N90pRosidWFSUG7qlp1OXe/gERywtYjiiv1UTHDM6uDh/h7oij.', 1, '2026-06-25 16:34:14', '2026-06-25 16:34:14'),
(58, 'EMPLOYEE', 'New', 'Employee', 'employee-357266862500708@example.test', '+381641110002', '$2a$10$qLKQEbfG95HbNL5nEqb0vuSuUTJTExFETeDmLJvspvSLFKy6nKhZ.', 1, '2026-06-25 16:34:14', '2026-06-25 16:34:14'),
(59, 'CLIENT', 'Cart', 'Client', 'cart-357267965630791@autodelovi.test', '+38164111222', '$2a$10$.oCC33o6FZvdhZjeqGQbZOuNEUj/1XprsYqcURPt.FfGcGm0uEpYC', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(60, 'CLIENT', 'Cart', 'Client', 'cart-357268348288583@autodelovi.test', '+38164111222', '$2a$10$KsHrnq7Zv0nT3daQfVcZMODChqQfyjW1V0wjc/B2xqj6MNJ9CSMj6', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(61, 'CLIENT', 'Notify', 'Client', 'notify-357507717575875@autodelovi.test', '+38164111222', '$2a$10$SVXtcyIIifdNqHQ20y.jEuMhylFFLGZqDE1Nkf201Uc65LkO9w10C', 1, '2026-06-25 16:38:15', '2026-06-25 16:38:15'),
(62, 'CLIENT', 'Notify', 'Client', 'notify-357508019488375@autodelovi.test', '+38164111222', '$2a$10$/n5V957rN///i1OKkvlCuOjVed0JMXKpVu4vHvWSH9HxfJ8ZEOWmC', 1, '2026-06-25 16:38:15', '2026-06-25 16:38:15'),
(63, 'CLIENT', 'Order', 'Client', 'order-357519436678000@autodelovi.test', '+38164111222', '$2a$10$PTZZo3IOlJOvnEfcXAqvdOL4W7Km574ncUTnNB/F/GqnY.zsYWKOy', 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(64, 'CLIENT', 'Order', 'Client', 'order-357520246815208@autodelovi.test', '+38164111222', '$2a$10$eZQFO.gbncirOabkvaHqs.cihzJdYtqtCvbQeZs4VPaOw0AikEwRW', 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(65, 'CLIENT', 'Order', 'Client', 'order-357520482973583@autodelovi.test', '+38164111222', '$2a$10$/28iDim9Oc3L4G7VXOzmKOAVMi6LyQRiRGjGPRiFkLBSPI4rm0gSW', 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(66, 'CLIENT', 'Order', 'Client', 'order-357520735988958@autodelovi.test', '+38164111222', '$2a$10$apmyVBj0l81Fm7bgwOy8YORq2CCP7PYLwRB.6yTcQsL4pQbOMkIwO', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(67, 'CLIENT', 'Order', 'Client', 'order-357520982881250@autodelovi.test', '+38164111222', '$2a$10$Dz6bvDmjPKIXN1sT3f.35OQjPNm9DQ2NmrRyOK7w8PRuMAl1xepV2', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(68, 'CLIENT', 'Test', 'Client', 'register-357521332713500@example.test', '+381641110001', '$2a$10$bD.FlHlKBlIAehXfLoXDp.ydanij1Ex4THEdqkiijdNId26igXB5u', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(69, 'CLIENT', 'Test', 'Client', 'duplicate-357521491526291@example.test', NULL, '$2a$10$Tb23kxYIhRqrbCweqo3SyeuUChRKhT3uqaYPfAl1o4hY4wewhSHge', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(70, 'EMPLOYEE', 'New', 'Employee', 'employee-357521724480708@example.test', '+381641110002', '$2a$10$cl6yckc7AwS.BDNlSIWEu.FnUMCX/JQbpWSaTIWI2XYUcmuKMHjHW', 1, '2026-06-25 16:38:29', '2026-06-25 16:38:29'),
(71, 'CLIENT', 'Notify', 'Client', 'notify-357522680113958@autodelovi.test', '+38164111222', '$2a$10$HbM4u/O7SO6xdMdxi7lLfu40LceWvvQsy.Oy7h78WahiSReYG9xeq', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(72, 'CLIENT', 'Notify', 'Client', 'notify-357522944341500@autodelovi.test', '+38164111222', '$2a$10$laxZHaOEdVPID6sLFCXM9OkOtPkcpasy.6pz2jujV.LgzKEKXdD6W', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(73, 'CLIENT', 'Cart', 'Client', 'cart-357523676877625@autodelovi.test', '+38164111222', '$2a$10$oHTSqEynR0nFW0NF3Sfp0OmL/AJHXiFLzn9BAYik9/qiNHa.kYpC6', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(74, 'CLIENT', 'Cart', 'Client', 'cart-357524087296833@autodelovi.test', '+38164111222', '$2a$10$RzDDvY6AGk3e9.zrteq0feeTDoOQh8JZe4WbVDOdaUtcqPRX9VSGW', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(75, 'CLIENT', 'Order', 'Client', 'order-357536246491166@autodelovi.test', '+38164111222', '$2a$10$D4RTjE8bRs/oZnNZwlVv6ezzCnBVa3kBBmLGdpaCfEeTwbRe8wEHW', 1, '2026-06-25 16:38:43', '2026-06-25 16:38:43'),
(76, 'CLIENT', 'Order', 'Client', 'order-357537012968500@autodelovi.test', '+38164111222', '$2a$10$QRSE7vjKcI6WBTOdIMaL7eVZ4JlGrUkRwBv.mdRRbz80uI83EuQ4.', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(77, 'CLIENT', 'Order', 'Client', 'order-357537260315833@autodelovi.test', '+38164111222', '$2a$10$S5lar3lx/13Y0bMC38s.pOu8nGHsHUFbE7J.WLJUrL4rBJzqFpY92', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(78, 'CLIENT', 'Order', 'Client', 'order-357537489816208@autodelovi.test', '+38164111222', '$2a$10$VP3g1yHEO55wiH1oP9TLRepByxnEejyhewzLi.LHon98RAlqZ9/GW', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(79, 'CLIENT', 'Order', 'Client', 'order-357537736792375@autodelovi.test', '+38164111222', '$2a$10$wpp4RSIN6WuSkt/NOxrXeuSumcYkOryS7zBUIVArbAO3etGGu3lai', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(80, 'CLIENT', 'Test', 'Client', 'register-357538079329416@example.test', '+381641110001', '$2a$10$oCHbXYXp.RWwA3nO6.EJ5ePnhS8O7T2/rJqYEK7/zUxy3A9iMpK9C', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(81, 'CLIENT', 'Test', 'Client', 'duplicate-357538237402125@example.test', NULL, '$2a$10$2ggctlzIAl0qD9jBRprQkehyZ4pyiPQVUMeVt6EREmZeWwijqYv2i', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(82, 'EMPLOYEE', 'New', 'Employee', 'employee-357538466117833@example.test', '+381641110002', '$2a$10$5IwOiIW/7m9Qo18IICd69.r/qeI0Lf88C5sKFrVRgZeJkePMn4oqi', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(83, 'CLIENT', 'Notify', 'Client', 'notify-357539369065083@autodelovi.test', '+38164111222', '$2a$10$m7XucrfWFrA.xNPNozh2N.AM4femwCL6ssWkxDecACHu8bgmrHB4S', 1, '2026-06-25 16:38:46', '2026-06-25 16:38:46'),
(84, 'CLIENT', 'Notify', 'Client', 'notify-357539622612458@autodelovi.test', '+38164111222', '$2a$10$pxyF.OpY82ai0hUaOTsV7u0KNzemsHmZatRN2b6xeTn9YkI.H0hAi', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(85, 'CLIENT', 'Cart', 'Client', 'cart-357540362577875@autodelovi.test', '+38164111222', '$2a$10$NKnngtam1gHnZpRE81KAQ.9wGdD09DY/CkZlWRSQJvqP9zLpf2VP.', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(86, 'CLIENT', 'Cart', 'Client', 'cart-357540745878500@autodelovi.test', '+38164111222', '$2a$10$5F7IBLptgP1E.6tvpeIEc.ceGd6R3YzhnKOZAm8AH34c8bUseXUmK', 1, '2026-06-25 16:38:48', '2026-06-25 16:38:48'),
(87, 'CLIENT', 'Special', 'Client', 'special-357736316205375@autodelovi.test', '+38164111222', '$2a$10$hwPpy2Fe.GgeOPRTQ74fEum8T0bqOvsVeLRrTfjJN2VrI4jZFzZee', 1, '2026-06-25 16:42:03', '2026-06-25 16:42:03'),
(88, 'CLIENT', 'Special', 'Client', 'special-357736447110041@autodelovi.test', '+38164111222', '$2a$10$acAGkn309fdpBbNk9EHkr.hUtp4hqyZ/pa8DaF6bZQ9gbHJzhJ5Y.', 1, '2026-06-25 16:42:03', '2026-06-25 16:42:03'),
(89, 'CLIENT', 'Order', 'Client', 'order-357748190054125@autodelovi.test', '+38164111222', '$2a$10$GErx0XCKgVPdrbgI3WhOpu1vk.YskETnKw47IhXZ64SqoG.Vyg87q', 1, '2026-06-25 16:42:15', '2026-06-25 16:42:15'),
(90, 'CLIENT', 'Order', 'Client', 'order-357748984496416@autodelovi.test', '+38164111222', '$2a$10$9NUIoLjbmKughKx/IsYr5e0XSxu.JFsr1FMrzt5dyHSt6M0T67SZO', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(91, 'CLIENT', 'Order', 'Client', 'order-357749227886208@autodelovi.test', '+38164111222', '$2a$10$o.oanXFyByaT49FEW64A5eItTUAzDxH8JAselzUjRy6pLUky2U9Re', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(92, 'CLIENT', 'Order', 'Client', 'order-357749459697291@autodelovi.test', '+38164111222', '$2a$10$B89PfnWayfTIpiGre62tDeprNG6FZRQP02gjN2d1RtiTxbRgZbPxG', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(93, 'CLIENT', 'Order', 'Client', 'order-357750022931833@autodelovi.test', '+38164111222', '$2a$10$bzGepqlZ7IdnKBBahcJ6V.C/2UrYJCf1FVHRHLflc55zHBZSPcvge', 1, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(94, 'CLIENT', 'Test', 'Client', 'register-357750445004208@example.test', '+381641110001', '$2a$10$Edzbdnn.vE0DFQI5MqNtEO0s.hlnNHCnGHLRK4eIyHxaBByWk2JmO', 1, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(95, 'CLIENT', 'Test', 'Client', 'duplicate-357750606647500@example.test', NULL, '$2a$10$83uMcbl1FXFt1WcNKdZ/xOhwNqomklSx0IQ0XUwjoOPqQqNEZUumy', 1, '2026-06-25 16:42:18', '2026-06-25 16:42:18'),
(96, 'EMPLOYEE', 'New', 'Employee', 'employee-357750842302541@example.test', '+381641110002', '$2a$10$0kpQPO7aTSafpE0df4DTBeub6CTzru.4SYM.oHqINuuxku3bNzaYe', 1, '2026-06-25 16:42:18', '2026-06-25 16:42:18'),
(97, 'CLIENT', 'Notify', 'Client', 'notify-357751832507333@autodelovi.test', '+38164111222', '$2a$10$3gsLB14r/hey1G9c19wtgeV6Q6z32zExv9l6FTV4Gbgc8dtMKOKQ.', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(98, 'CLIENT', 'Notify', 'Client', 'notify-357752138873416@autodelovi.test', '+38164111222', '$2a$10$AwbDR.fPAKk8M2dcR8Q8deaKAhvINmEfCl4fGpkLrZ0uQH0s5ds9u', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(99, 'CLIENT', 'Special', 'Client', 'special-357753032412000@autodelovi.test', '+38164111222', '$2a$10$S/1ppPKAE/CdIVmVVM9yFuk2Ts/tsxp/oms4DGJ2PV4Jaexi7WeuW', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(100, 'CLIENT', 'Special', 'Client', 'special-357753141162416@autodelovi.test', '+38164111222', '$2a$10$uZI4rIzfB5Q/7BcjJ3udV.w4KbAg8qemIK3Nfmr9gipaym3bLWwwa', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(101, 'CLIENT', 'Cart', 'Client', 'cart-357753347578458@autodelovi.test', '+38164111222', '$2a$10$yoRw8J3PfktEYIuECTdc9ORPzsbyc1t/FChWKXm1EK3Dnw6rD21.G', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(102, 'CLIENT', 'Cart', 'Client', 'cart-357753706660458@autodelovi.test', '+38164111222', '$2a$10$VRxr0CuTAk1vk/sSpFGcye4GBOkxiXBP3C.cpu/6eka5bnpEYPPR6', 1, '2026-06-25 16:42:21', '2026-06-25 16:42:21'),
(103, 'CLIENT', 'Order', 'Client', 'order-357810471963125@autodelovi.test', '+38164111222', '$2a$10$k7tGCGE66cZuJSJHeoAw1OO8udcUozrG9Q3BSYdbQCKJAmdkLxZU2', 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(104, 'CLIENT', 'Order', 'Client', 'order-357811272605875@autodelovi.test', '+38164111222', '$2a$10$QDBZlT7FBYP0/t5GFi/5Ce6YhiRrQSYiMjqnCSgx/BEl71WEUlvRa', 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(105, 'CLIENT', 'Order', 'Client', 'order-357811517470250@autodelovi.test', '+38164111222', '$2a$10$P4rAae.hD30efD6v89KqVuZxdZbe2Ny3/z0gP1bEU38PoQiubAaXi', 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(106, 'CLIENT', 'Order', 'Client', 'order-357811752722083@autodelovi.test', '+38164111222', '$2a$10$G8dLe4/Kl5cVP9gjsYxLt.B.yS5gDNkMiKx8x25JIipkJ1dwZ0022', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(107, 'CLIENT', 'Order', 'Client', 'order-357812017911416@autodelovi.test', '+38164111222', '$2a$10$ZRibSmTQUvdCnj01dYhwAu9GTKAQgWeojQ5t2vpSGsA/PCo9F5zdO', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(108, 'CLIENT', 'Test', 'Client', 'register-357812381133875@example.test', '+381641110001', '$2a$10$5r/j9HMJ3BkAR0gzRG4V6.lQVflDtfwSYhCY6Gg86tXHvn8gT4ALi', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(109, 'CLIENT', 'Test', 'Client', 'duplicate-357812539472541@example.test', NULL, '$2a$10$rv4ehxQDmK7Rv99St6P6e.HmZoW7XSWSemyvzu4ueKffkHcctyJSS', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(110, 'EMPLOYEE', 'New', 'Employee', 'employee-357812775222833@example.test', '+381641110002', '$2a$10$NX81DqRSQySr374xxtGYbOmEkx7j43F9TZ0U1EqJaDvwZSlI8aSpu', 1, '2026-06-25 16:43:20', '2026-06-25 16:43:20'),
(111, 'CLIENT', 'Notify', 'Client', 'notify-357813744941250@autodelovi.test', '+38164111222', '$2a$10$pRfEvlHtcJDMRFbR6vukxuFL/7YLpOdMvP4LgWBeFCFU55brMVpSW', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(112, 'CLIENT', 'Notify', 'Client', 'notify-357814015519833@autodelovi.test', '+38164111222', '$2a$10$SrfWwU5NkWClKK.hgELwmuOEDbgAtBgUqoukULQoabj7c8thX8FjO', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(113, 'CLIENT', 'Special', 'Client', 'special-357814869126708@autodelovi.test', '+38164111222', '$2a$10$PJdxe6cRD.5ichmVXGL7m.F8vUkogQ10CS4.IZDh0.d3WjlnqyRhO', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(114, 'CLIENT', 'Special', 'Client', 'special-357814975218791@autodelovi.test', '+38164111222', '$2a$10$vepEX.LmEKTX/POqPYMfpeL1IrDiu3OFaxT7lLU24TT7oP4Raooze', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(115, 'CLIENT', 'Cart', 'Client', 'cart-357815193647083@autodelovi.test', '+38164111222', '$2a$10$cPUBEyzQjnmoGgnTwYwBmuR8mmmcqKtec.SqhFOxKOG0MgGxNUiOi', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(116, 'CLIENT', 'Cart', 'Client', 'cart-357815556643750@autodelovi.test', '+38164111222', '$2a$10$6ECTQAoHB3TucmAK6IgbQOXHZNNcgL.mnjQcJJXB0Dv3rUqrn4AOW', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(117, 'CLIENT', 'Order', 'Client', 'order-358465844406708@autodelovi.test', '+38164111222', '$2a$10$FbvV5KoVfxbVNOicElDZm.LoHGs8dGxN9tc0nXt3mGnZ138od3qvy', 1, '2026-06-25 16:54:13', '2026-06-25 16:54:13'),
(118, 'CLIENT', 'Order', 'Client', 'order-358466617079166@autodelovi.test', '+38164111222', '$2a$10$j2q0RRn52aIlj5rpxqVFG.i7nTAYvoknqEDggJ.21hM8wpCWGZh6G', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(119, 'CLIENT', 'Order', 'Client', 'order-358466850287291@autodelovi.test', '+38164111222', '$2a$10$rWVP86NsXhm0FrHsZFRCIOPz0UaDbEn6yCCqje/uYxJwXb6BbQsWm', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(120, 'CLIENT', 'Order', 'Client', 'order-358467081893916@autodelovi.test', '+38164111222', '$2a$10$10jznNqYcvHjt7DLOkDp1OF5vS705BB6pPDu0ZO1Jg7JudfZmGDfO', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(121, 'CLIENT', 'Order', 'Client', 'order-358467338944958@autodelovi.test', '+38164111222', '$2a$10$sG52lvgpcERwtiV882GZbu09wC0LtTErS9xQZT/FFdlIRoqwxIDUK', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(122, 'CLIENT', 'Test', 'Client', 'register-358467695008208@example.test', '+381641110001', '$2a$10$RrKHVnowtr8STmWjf/GhxeOdOo0CsN.LMdd0KuFRMx4s1mmU5AQci', 1, '2026-06-25 16:54:15', '2026-06-25 16:54:15'),
(123, 'CLIENT', 'Test', 'Client', 'duplicate-358467852162791@example.test', NULL, '$2a$10$iWbqb5qaGlBzPjrxhwzq/.cyNhlSzKtCp1xvQ.5MyFPM9Bqv9N4c2', 1, '2026-06-25 16:54:15', '2026-06-25 16:54:15'),
(124, 'EMPLOYEE', 'New', 'Employee', 'employee-358468082678041@example.test', '+381641110002', '$2a$10$Nm.su4xV4cLwBU.fLSS4JecN88ff51cXO9/MLPy9lsLQvXVUSCIuy', 1, '2026-06-25 16:54:15', '2026-06-25 16:54:15'),
(125, 'CLIENT', 'Notify', 'Client', 'notify-358469021334625@autodelovi.test', '+38164111222', '$2a$10$6fMEtXhG//hkRq2Xqu0icO9uwYcuW1iOyAds3.VgmKB8kB1o9xNkK', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(126, 'CLIENT', 'Notify', 'Client', 'notify-358469283568916@autodelovi.test', '+38164111222', '$2a$10$UoxcC/YfCbQ/3wjs6cY2lO4M.KCTUGbOvhdoYv0iAv061R2i9wU8m', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(127, 'CLIENT', 'Special', 'Client', 'special-358470162815208@autodelovi.test', '+38164111222', '$2a$10$sFEnEXfyzMkcbxzLRo90IeDcFEsoqWdO7jQwShOMo5OD6LHkqha12', 1, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(128, 'CLIENT', 'Special', 'Client', 'special-358470266475583@autodelovi.test', '+38164111222', '$2a$10$rDYybgO.3yIF3zKlqu5e3eAFHwsfi4FiFkRE5Sd1fBs5XCk7.zyiK', 1, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(129, 'CLIENT', 'Cart', 'Client', 'cart-358470472524541@autodelovi.test', '+38164111222', '$2a$10$pWmE8z6USFZNJJKKDXevtO0XljuGrjlhBYVcn5NbEPvDw43MOwTWW', 1, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(130, 'CLIENT', 'Cart', 'Client', 'cart-358470852646625@autodelovi.test', '+38164111222', '$2a$10$7H4cQuKxX5fNCW7sHJsil.aWPrZU6I07b91kfYH5qLDEc.C6iOsay', 1, '2026-06-25 16:54:18', '2026-06-25 16:54:18'),
(131, 'CLIENT', 'Order', 'Client', 'order-358812633840000@autodelovi.test', '+38164111222', '$2a$10$G589zkgltq30inH9Gc4yXewCQDX2a5zJ/gkrC99kR69TP28e/oJ1S', 1, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(132, 'CLIENT', 'Order', 'Client', 'order-358813414374625@autodelovi.test', '+38164111222', '$2a$10$UrQ.VY0J.XKxdI6Fcwknw..fX.O6ffR62vzgUJruCvxNs2FLTCleq', 1, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(133, 'CLIENT', 'Order', 'Client', 'order-358813660792125@autodelovi.test', '+38164111222', '$2a$10$5t/zOnkNUgSU53pVJq7IU.42KQETb4ltamSd6EdF.SftB8jl4uKW2', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(134, 'CLIENT', 'Order', 'Client', 'order-358813883351666@autodelovi.test', '+38164111222', '$2a$10$l1Lehbb.a7fCBw1/Ymu5g.wTAYT4geixfk/2B3QRfmcAEpO7/ydui', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(135, 'CLIENT', 'Order', 'Client', 'order-358814141055625@autodelovi.test', '+38164111222', '$2a$10$yxEI8YmawTpP1ZMpC0z5V.SRr81dK1lV72/z57xHbJYhfdt3FCn.q', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(136, 'CLIENT', 'Test', 'Client', 'register-358814486349041@example.test', '+381641110001', '$2a$10$k7b2ePvqzor1fRyRxFVSfeZwUjA8M3XGal.ttf5wQbHjA8tw5WyY.', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(137, 'CLIENT', 'Test', 'Client', 'duplicate-358814647200583@example.test', NULL, '$2a$10$iTu5CEl/bVjj2naJIHMek.DhUlwgcadgqa/Oc82tHKQgeOU61ZTCa', 1, '2026-06-25 17:00:02', '2026-06-25 17:00:02'),
(138, 'EMPLOYEE', 'New', 'Employee', 'employee-358814884289958@example.test', '+381641110002', '$2a$10$1S.DaVTeEq.RjvHxpX989ePxICO/JcxHGqn5JWemmBrWere0RqXda', 1, '2026-06-25 17:00:02', '2026-06-25 17:00:02'),
(139, 'CLIENT', 'Notify', 'Client', 'notify-358815885835750@autodelovi.test', '+38164111222', '$2a$10$ErlgTTdubeneJuP0UG7DrO6JARdE9LkHL.qqaX6Unndwgg8SwT84m', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(140, 'CLIENT', 'Notify', 'Client', 'notify-358816143921416@autodelovi.test', '+38164111222', '$2a$10$XaRAtF3KUVA0j59juYds1.0u2K9VNiuPrxgtL7ZVFdLAomjo.O/Xa', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(141, 'CLIENT', 'Special', 'Client', 'special-358816968801375@autodelovi.test', '+38164111222', '$2a$10$ijTREwKg7iQPDMEfXGxNNeXZJXG6O6e.GRA8cf4sBlumQxh8Bd2Gq', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(142, 'CLIENT', 'Special', 'Client', 'special-358817075577916@autodelovi.test', '+38164111222', '$2a$10$K7Cvltyd/G/keOtX5zBEuOKbn3Yr7rukFXgxD69nXM0.WUDkv3NkO', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(143, 'CLIENT', 'Cart', 'Client', 'cart-358817290364916@autodelovi.test', '+38164111222', '$2a$10$6PW50GMBlD.choTFASpsoOzL2yw42BSInLsnLDVA5MIRcseBAgLKW', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(144, 'CLIENT', 'Cart', 'Client', 'cart-358817708250125@autodelovi.test', '+38164111222', '$2a$10$YOZmtcxSJtXSBaqCgfssgeCRSYvp4ETdWFiTbudaSTxk8PXBbcG0.', 1, '2026-06-25 17:00:05', '2026-06-25 17:00:05'),
(145, 'CLIENT', 'Order', 'Client', 'order-359036103041833@autodelovi.test', '+38164111222', '$2a$10$kNnNUph7mpuNSSPUeeGQNefe6Zz1HmTwwI51PeuVw3zMXIWulMoxe', 1, '2026-06-25 17:03:43', '2026-06-25 17:03:43'),
(146, 'CLIENT', 'Order', 'Client', 'order-359036887537375@autodelovi.test', '+38164111222', '$2a$10$.7/WfXbuUdovJFCk4mZ3GeuPq9Nc/HlHWe.je883ENG.N9kJ4ICsC', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(147, 'CLIENT', 'Order', 'Client', 'order-359037157453916@autodelovi.test', '+38164111222', '$2a$10$AYhCdQRcYqZx.OAmJvAt0uroIOhP9IMLsx4eE3GH7MSvRH0SWINQ2', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(148, 'CLIENT', 'Order', 'Client', 'order-359037380469041@autodelovi.test', '+38164111222', '$2a$10$3X.yTrfQQyuRxxM2HiCm.edKfH.uEg5x7tKRsRHJbCrHoYJdcO3I6', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(149, 'CLIENT', 'Order', 'Client', 'order-359037636426583@autodelovi.test', '+38164111222', '$2a$10$R6hTZVxWcohg7nScRBUkE.08TmlQTIE1w8qfSQeNRRBiI/hndP/Vy', 1, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(150, 'CLIENT', 'Test', 'Client', 'register-359038022046875@example.test', '+381641110001', '$2a$10$g6FoAfNHSsQWj4A6KBXcyeVrQmx7O3DU31qNKgm.UDg1n92jHc0u6', 1, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(151, 'CLIENT', 'Test', 'Client', 'duplicate-359038179969041@example.test', NULL, '$2a$10$1tY8E1vF2NctvdgWyxxHA.vVqFYEr8j6dEG0AlJtLwaGdte9/eG5m', 1, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(152, 'EMPLOYEE', 'New', 'Employee', 'employee-359038408927625@example.test', '+381641110002', '$2a$10$XjrQyzaVgp66r1WecU4iGezXzQ/ROocAY97hYYrW1C7PoehPrI0jK', 1, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(153, 'CLIENT', 'Notify', 'Client', 'notify-359039371012416@autodelovi.test', '+38164111222', '$2a$10$RQRCiCxUkthdNtEpuW.pFugHsnp/4jn2cKV/EM0.4wTV5gO0oK20a', 1, '2026-06-25 17:03:46', '2026-06-25 17:03:46'),
(154, 'CLIENT', 'Notify', 'Client', 'notify-359039637066833@autodelovi.test', '+38164111222', '$2a$10$aVZ.PXfK6krIK3QdBgDuPusdZ8vnuXe51ZkP/emas/anc6jAapVou', 1, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(155, 'CLIENT', 'Special', 'Client', 'special-359040559897250@autodelovi.test', '+38164111222', '$2a$10$0llHiCf57qi6tg.na5tAI.vnxQ14Qrt0Hg4FUTO67.Bq/Ra0AY7B6', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(156, 'CLIENT', 'Special', 'Client', 'special-359040663813291@autodelovi.test', '+38164111222', '$2a$10$Cxiy/mvhhueWDWQ.cJhF5.Gb55vzFkP9DqutVIWj/2jjT932YV.IS', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(157, 'CLIENT', 'Cart', 'Client', 'cart-359040883316916@autodelovi.test', '+38164111222', '$2a$10$HXNfYpYXj2dH7LDVS64UD.HxmekMqnx1pUOKfqH0YNdzLabnTyI/W', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(158, 'CLIENT', 'Cart', 'Client', 'cart-359041230577833@autodelovi.test', '+38164111222', '$2a$10$KiSVF.BZTisqs6b9o0.lju4.miKU2Lx3oX9Oiv2XcKqnQ7i/RrcR.', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(159, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407185608@autodelovi.test', '+38165123456', '$2a$10$0XYsHNICs7SXx8Qw0Lq4POWJ7zC3ejkzH2lD8GlNsFNywxVPA6lQG', 1, '2026-06-25 17:06:25', '2026-06-25 17:06:25'),
(160, 'CLIENT', 'Test', 'Kupac', 'kupac1782407186291@test.com', NULL, '$2a$10$gjm9b6yWkSjWCZVA.yIMH.y2hlflFvZum9HWFbCeH4l0Z1bP.UMaK', 1, '2026-06-25 17:06:26', '2026-06-25 17:06:26'),
(161, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407211417@autodelovi.test', '+38165123456', '$2a$10$.KM7WynxBhDkixmgQ1cC/Oulr5.7eO3XGIApfu/G.Bq/dXjtJN07O', 1, '2026-06-25 17:06:51', '2026-06-25 17:06:51'),
(162, 'CLIENT', 'Test', 'Kupac', 'kupac1782407212109@test.com', NULL, '$2a$10$R3Pb7zs/gk0l.OODJ/ZR..aaqZDVuWrhPOhtIKAcFdNXA1HTy6wCm', 1, '2026-06-25 17:06:52', '2026-06-25 17:06:52'),
(163, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407228401@autodelovi.test', '+38165123456', '$2a$10$z2s3k5gfF29qa7Y4yuVoLu5pihAm4ywi.cTNIN3JmoxkryvM8F9Qa', 1, '2026-06-25 17:07:08', '2026-06-25 17:07:08'),
(164, 'CLIENT', 'Test', 'Kupac', 'kupac1782407229111@test.com', NULL, '$2a$10$pbnh9EMIbpn4yHl3tOVpv.lU7p1j82wa9E3y2d3fKhNNaJd8.m9xC', 1, '2026-06-25 17:07:09', '2026-06-25 17:07:09'),
(165, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407257801@autodelovi.test', '+38165123456', '$2a$10$MtgsXcxysv4338hjglEaQ.5o8ZgqHE0.QH1Uc0F36Kqc5bot1YGZO', 1, '2026-06-25 17:07:38', '2026-06-25 17:07:38'),
(166, 'CLIENT', 'Test', 'Kupac', 'kupac1782407258562@test.com', NULL, '$2a$10$..arf6e2O96rYlz8DzsGGuOA19wZ2hJDUG0IDVQ1mk7Qh./vJjH8y', 1, '2026-06-25 17:07:38', '2026-06-25 17:07:38'),
(167, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407321023@autodelovi.test', '+38165123456', '$2a$10$Otio0yqNnsNeof42Dc5tDeu79s7XIfVH63dSoX5FfC61iWVPxaFpS', 1, '2026-06-25 17:08:41', '2026-06-25 17:08:41'),
(168, 'CLIENT', 'Test', 'Kupac', 'kupac1782407321709@test.com', NULL, '$2a$10$or5HdRfQ.JOgyZk4heH0aeL7MP0.yOgQ5GwoGm.D5kKtqToKQSDhu', 1, '2026-06-25 17:08:41', '2026-06-25 17:08:41'),
(169, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407375535@autodelovi.test', '+38165123456', '$2a$10$6QXTkV6tsrENtLzB8SnepuhMbZtV/xXPFrMBkWGpDn0KFHEd9QOmu', 1, '2026-06-25 17:09:35', '2026-06-25 17:09:35'),
(170, 'CLIENT', 'Test', 'Kupac', 'kupac1782407376206@test.com', NULL, '$2a$10$fOs0nv6Ddfc.4EEXJ89WEOyzMvme5ebGe6/wFf4rMSwIC.OMuk3YS', 1, '2026-06-25 17:09:36', '2026-06-25 17:09:36'),
(171, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407408002@autodelovi.test', '+38165123456', '$2a$10$yJAWk/1.hgOuDPPF/dib0uTYVSBnr2FjaL3T2iiKbwiK9r6fDV.xy', 1, '2026-06-25 17:10:08', '2026-06-25 17:10:08'),
(172, 'CLIENT', 'Test', 'Kupac', 'kupac1782407408691@test.com', NULL, '$2a$10$h6XmOGCjaG1tc0rBDAvove.vJF54Sk6Crw3SG1hbxW5QQL7hjYjq2', 1, '2026-06-25 17:10:08', '2026-06-25 17:10:08'),
(173, 'CLIENT', 'Order', 'Client', 'order-359434305910625@autodelovi.test', '+38164111222', '$2a$10$jW467o8b7tS5r69Ip/v3..yBA/ZIOFa7XdLkRCGnjXOQhOzgqTzHC', 1, '2026-06-25 17:10:21', '2026-06-25 17:10:21'),
(174, 'CLIENT', 'Order', 'Client', 'order-359435059155750@autodelovi.test', '+38164111222', '$2a$10$PdMDLR.66NShcj.N58XYyeFstC/Vue.ec391o4FtZoLXrd3nxY2YO', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(175, 'CLIENT', 'Order', 'Client', 'order-359435293834083@autodelovi.test', '+38164111222', '$2a$10$3wtzBi3MH0ZVwAyY4sUe8eKAq1A5xHTzKNj1w/vB4WjjwkkyU/Bo2', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(176, 'CLIENT', 'Order', 'Client', 'order-359435519784083@autodelovi.test', '+38164111222', '$2a$10$tWw7AVmBgg4cCEgvsUdCNu7UaRsiiSSF1I8Y6Rdb1xu1lHJqO4VQG', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(177, 'CLIENT', 'Order', 'Client', 'order-359435775096500@autodelovi.test', '+38164111222', '$2a$10$/.wdh76W4CgHYQXsPaCKyeWgqkKaBWL6mlLLPMAzrHgHNy7NHhgay', 1, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(178, 'CLIENT', 'Test', 'Client', 'register-359436125369416@example.test', '+381641110001', '$2a$10$w.nYkLeQZ57mkAvy1/ubqe3ZNEVF9VWe0uJwaIKz.HYkbKImEuz2O', 1, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(179, 'CLIENT', 'Test', 'Client', 'duplicate-359436280556458@example.test', NULL, '$2a$10$UaHpig4erGgH5JQdQ2faVOCef3L7DLTWkBUB7BREMjQ4hevzrDvku', 1, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(180, 'EMPLOYEE', 'New', 'Employee', 'employee-359436512004041@example.test', '+381641110002', '$2a$10$tcPW/4lm3tbJRM3x9FtdoOgdT9GqMds5o8xyZUQ1G68nyHDsMMOW.', 1, '2026-06-25 17:10:24', '2026-06-25 17:10:24'),
(181, 'CLIENT', 'Notify', 'Client', 'notify-359437429355666@autodelovi.test', '+38164111222', '$2a$10$QE2BdeIChkGuCmDSE2nPkOpfu0EXtl07TVrnjnQruW5hED.osknt6', 1, '2026-06-25 17:10:24', '2026-06-25 17:10:24'),
(182, 'CLIENT', 'Notify', 'Client', 'notify-359437686779500@autodelovi.test', '+38164111222', '$2a$10$lkdNtpkkvi6cz7GY0j2DAu8zY/ZGyR6nO6C1cnq.Qg.N1NRBFqL0C', 1, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(183, 'CLIENT', 'Special', 'Client', 'special-359438530395833@autodelovi.test', '+38164111222', '$2a$10$KhMyx/q4DzKa1J/rFKdTHufG5RSc6BZthcx6KfqCd2zWaF0zC4SkC', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(184, 'CLIENT', 'Special', 'Client', 'special-359438632407708@autodelovi.test', '+38164111222', '$2a$10$bIKjvarOL9dVeGA8PyfNWOt///HDEvgfJ8KaPtEj/EMvudYpEDy9u', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(185, 'CLIENT', 'Cart', 'Client', 'cart-359438839469541@autodelovi.test', '+38164111222', '$2a$10$8s7aOx7AkodiBLmBYxFTk.9eMf07hreG1ZOk5w91T5urTehUWRtYC', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(186, 'CLIENT', 'Cart', 'Client', 'cart-359439261228291@autodelovi.test', '+38164111222', '$2a$10$pBA231ja06TCSDcNSHa.vu/7/7Ab1Afg.3Je//r4rJwFY5rIFdnPS', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(187, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407436979@autodelovi.test', '+38165123456', '$2a$10$g3kaXe6KYO431jvqG5E/MeNQXsP5O3jm823rOnhcTxnoNAn.2UKCC', 1, '2026-06-25 17:10:37', '2026-06-25 17:10:37'),
(188, 'CLIENT', 'Test', 'Kupac', 'kupac1782407437748@test.com', NULL, '$2a$10$Xc0NlChldlIWlIglwmDWjODCVmq78Lj94nINYGgBHzhK15WCwPw9W', 1, '2026-06-25 17:10:38', '2026-06-25 17:10:38'),
(189, 'CLIENT', 'Order', 'Client', 'order-359685450513083@autodelovi.test', '+38164111222', '$2a$10$fVs9Lz68ctBePrTHXB/.0.E5nbv4jfAmR7BfNxPgmi8MgO/..aySe', 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(190, 'CLIENT', 'Order', 'Client', 'order-359686270408375@autodelovi.test', '+38164111222', '$2a$10$nFbmqzE3tR3h94HCgxWZGeuN4O9VWSK8PnKWeulZjeQmysusbjY16', 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(191, 'CLIENT', 'Order', 'Client', 'order-359686513277958@autodelovi.test', '+38164111222', '$2a$10$XqrWtSESYrrxgFO36jW1g.ud2MLbVW0UMvDpNDBFmN9rXXBUI4h5K', 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(192, 'CLIENT', 'Order', 'Client', 'order-359686757151125@autodelovi.test', '+38164111222', '$2a$10$z0mQaw2DpMrObRQ10AZz3.2/S/74Xb7Y7vx8PQjFq218yMaka36ty', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(193, 'CLIENT', 'Order', 'Client', 'order-359687019667083@autodelovi.test', '+38164111222', '$2a$10$jXW.ScK98RhNtWBj0ChqU.FoVoV/7en5jPrjVvoygVjxabT569QJq', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(194, 'CLIENT', 'Test', 'Client', 'register-359687385416791@example.test', '+381641110001', '$2a$10$0wqh.XuW37.9UxgQP5ns2uDzQBEgdb6HdlG.VDGNwKSsv/Wy/3h2W', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(195, 'CLIENT', 'Test', 'Client', 'duplicate-359687545209125@example.test', NULL, '$2a$10$bBY6WJC1Wgu24eAcZdsBjOhJqbZp6dnXAcAXfJDQ/hoFPatKUWoWu', 1, '2026-06-25 17:14:35', '2026-06-25 17:14:35'),
(196, 'EMPLOYEE', 'New', 'Employee', 'employee-359687777347416@example.test', '+381641110002', '$2a$10$5P6bce7jZw3tYSErdFQD0eVy8Iqk4ZRYVuAciov0c9JYqr46dll8e', 1, '2026-06-25 17:14:35', '2026-06-25 17:14:35'),
(197, 'CLIENT', 'Notify', 'Client', 'notify-359688776552833@autodelovi.test', '+38164111222', '$2a$10$wBA7Cy/36hCY6rSjNjIsx.l/soAmzgOAgCBLzfFaemPGuCjvStKZu', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(198, 'CLIENT', 'Notify', 'Client', 'notify-359689045414625@autodelovi.test', '+38164111222', '$2a$10$0/A9TCiWNW905m4o5ctH8en9VOqjKjpA3M4NfFoNPnfvAjqyL./b.', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(199, 'CLIENT', 'Special', 'Client', 'special-359689889191166@autodelovi.test', '+38164111222', '$2a$10$gfT9CCYGuvjB2BB7xUSmx.DJ1iU9OYcMxbby6dm3LGjWswsZwoxAm', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(200, 'CLIENT', 'Special', 'Client', 'special-359690001596000@autodelovi.test', '+38164111222', '$2a$10$H2OYfwEOpatIhPSiWIlWBeJ16egPTcgvZnZr2a2xFspWU/udtVy8u', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(201, 'CLIENT', 'Cart', 'Client', 'cart-359690230814500@autodelovi.test', '+38164111222', '$2a$10$uuVTjOQBz/17uOs4BRjpQ..WP1fALJh3YrCZALR3zapH.QKbUJmlq', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(202, 'CLIENT', 'Cart', 'Client', 'cart-359690643186458@autodelovi.test', '+38164111222', '$2a$10$3dCvKGU3fBl20uosVmZQUeVOThR4/pfU3/YDtsAHNLTT7m9rqtVh6', 1, '2026-06-25 17:14:38', '2026-06-25 17:14:38'),
(203, 'CLIENT', 'Novi', 'Klijent', 'noviklijent1782407705431@autodelovi.test', '+38165123456', '$2a$10$Mk95NpfFtR3vtCH2vrliDefjpT9rhevNz5ul78GVDgxIBZrQpKa5G', 1, '2026-06-25 17:15:05', '2026-06-25 17:15:05'),
(204, 'CLIENT', 'Test', 'Kupac', 'kupac1782407706156@test.com', NULL, '$2a$10$bUfV8crXAKpAFPfOF0b/Au7agSnzqlwe1XOBJaScnmQ5wvrAKb.ty', 1, '2026-06-25 17:15:06', '2026-06-25 17:15:06'),
(205, 'CLIENT', 'Order', 'Client', 'order-360200245997916@autodelovi.test', '+38164111222', '$2a$10$gEZSB85sDPsB2wUKsE1laO18jjPHH8.cPhlfs/2Xj/B05Bslugx5m', 1, '2026-06-25 17:23:07', '2026-06-25 17:23:07'),
(206, 'CLIENT', 'Order', 'Client', 'order-360201064478416@autodelovi.test', '+38164111222', '$2a$10$Gpq/PJgVEaQvPnUd59RoAOhimUyOG7gK4nMMDMmCQM39Wm5fEj7LO', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(207, 'CLIENT', 'Order', 'Client', 'order-360201306169750@autodelovi.test', '+38164111222', '$2a$10$xRKd8lMyUVSGWclI9lpNle.fivqwZmeyYJNhAgd64xHfY4GMvyKla', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(208, 'CLIENT', 'Order', 'Client', 'order-360201554609666@autodelovi.test', '+38164111222', '$2a$10$nmrkb7yj/.436VGkvhgkJ.rzn6a0v5UCXKa6m7bjT82ESHexCjx4a', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(209, 'CLIENT', 'Order', 'Client', 'order-360201816474541@autodelovi.test', '+38164111222', '$2a$10$xgTZ.QIv5Lgmtw.pn3sjl.6xOpjf8SjUv1SRh0zJKKMf/aLKZt/Km', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(210, 'CLIENT', 'Test', 'Client', 'register-360202177369791@example.test', '+381641110001', '$2a$10$SlpkpCEr5nqfqQE7FnQOOesEvjWBLCQLfgwtbiFk54uMNMCQAysAG', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(211, 'CLIENT', 'Test', 'Client', 'duplicate-360202335044833@example.test', NULL, '$2a$10$xB7P4q/QjvZOBrtDPOpwXe1.31lXObAe6SwrUQtM6lJF5HiXajW2e', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(212, 'EMPLOYEE', 'New', 'Employee', 'employee-360202564748250@example.test', '+381641110002', '$2a$10$9uj4bGtLRvt5rbClFQX4F.qnZdemtLsLgD8P5UUu0GaWGmqAxeIIW', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(213, 'CLIENT', 'Notify', 'Client', 'notify-360203619907541@autodelovi.test', '+38164111222', '$2a$10$eTzgp.h1fNNxWJ4UA/ECee3wfPmzhBKL9JllLQH9HrQ6pgQJcU1im', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(214, 'CLIENT', 'Notify', 'Client', 'notify-360203883076500@autodelovi.test', '+38164111222', '$2a$10$bq7t/hXbzUgsA1/jsvsiJeGelzqHytYyTehXPqzgQKO2elg.8vtVq', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(215, 'CLIENT', 'Special', 'Client', 'special-360204787308333@autodelovi.test', '+38164111222', '$2a$10$aWQC5OGN1.CDEqKZx3IhGeyjyOUhBQ7a.no0MVo8aiGZwdj8MpjHy', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(216, 'CLIENT', 'Special', 'Client', 'special-360204899458916@autodelovi.test', '+38164111222', '$2a$10$PhCieAQD9GTx5LdxjTXKMuuXjEoZII/DPVXxRA29C7BdJfdqVdqX2', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(217, 'CLIENT', 'Cart', 'Client', 'cart-360205127590916@autodelovi.test', '+38164111222', '$2a$10$ixwuRXb5OKkPCgAACJf48eBtJ5WtWQpDARRD2IhiqngNTHY.Zp2c6', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(218, 'CLIENT', 'Cart', 'Client', 'cart-360205499271458@autodelovi.test', '+38164111222', '$2a$10$nMHXc3WibgHqM2gHBsIYM..xl91xMnjvezLYzu2UueHP4eR29EnRu', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(219, 'CLIENT', 'Order', 'Client', 'order-360227905005041@autodelovi.test', '+38164111222', '$2a$10$pWa.J54eANecDecTT/01FOA8Q65ki164/feC9rcAg9uL.UPBC3ZsW', 1, '2026-06-25 17:23:35', '2026-06-25 17:23:35'),
(220, 'CLIENT', 'Order', 'Client', 'order-360228679423833@autodelovi.test', '+38164111222', '$2a$10$7QbWbqbxfuP5rDHwZgQrEuDllAkK9ggSkTVzY7tD2tMiXe62BuMFy', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(221, 'CLIENT', 'Order', 'Client', 'order-360228918787416@autodelovi.test', '+38164111222', '$2a$10$swPQdQIjxIT9ylQz7YqTFucQzgNkRF6bXUBoc66WA4VQNn2jfMIGm', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(222, 'CLIENT', 'Order', 'Client', 'order-360229153759833@autodelovi.test', '+38164111222', '$2a$10$JmWYQ.hWZ1nSozQZwz0XmewJi3wMAMqkgyFvwUYoqlPnB4yxwLsgC', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(223, 'CLIENT', 'Order', 'Client', 'order-360229409328958@autodelovi.test', '+38164111222', '$2a$10$tXcpyTDtTzYCZ7AumlyQz.Rdg/JLk9vYVNApXFFAWvu1xqDuiwKBe', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(224, 'CLIENT', 'Test', 'Client', 'register-360229764073166@example.test', '+381641110001', '$2a$10$J3Cz.Ug5mH0yIQDNOnPF9OsQ29ai65D.Cm9w6c/l5ECLgd1MkvI0W', 1, '2026-06-25 17:23:37', '2026-06-25 17:23:37'),
(225, 'CLIENT', 'Test', 'Client', 'duplicate-360229922852083@example.test', NULL, '$2a$10$CbqyNrfBDtdXZSjVFxmitO5lHc/HcqVdsrLLxy1zoUQAQD13IQ9eW', 1, '2026-06-25 17:23:37', '2026-06-25 17:23:37'),
(226, 'EMPLOYEE', 'New', 'Employee', 'employee-360230153457833@example.test', '+381641110002', '$2a$10$w5wwfu8PwUoDT5glNUKl/eWxjYALe4QWjo2XJzSZldkzAnIwO5Wt6', 1, '2026-06-25 17:23:37', '2026-06-25 17:23:37'),
(227, 'CLIENT', 'Notify', 'Client', 'notify-360231153433041@autodelovi.test', '+38164111222', '$2a$10$b9CJ7mB.jBX2VqPd7YT30.pR1Kd9xsJ1sd5XyTI82EitRhxbsrvxa', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(228, 'CLIENT', 'Notify', 'Client', 'notify-360231413593125@autodelovi.test', '+38164111222', '$2a$10$tuUo.PkRsp3YFstWYcFPpuy9zKfoJtMPaW1KojzujSNQsEO9XLjXi', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(229, 'CLIENT', 'Special', 'Client', 'special-360232324504208@autodelovi.test', '+38164111222', '$2a$10$m8lNkGNgEPLcZkd2ZQp6suPrDpNzZsJ5hFzOGVRYurWeblfxR/8lG', 1, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(230, 'CLIENT', 'Special', 'Client', 'special-360232434645958@autodelovi.test', '+38164111222', '$2a$10$RuHvstgK7bdovqb2Gm8f7ePXh0uV2cGebDdur9t7w6iMV1tXlYsPa', 1, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(231, 'CLIENT', 'Cart', 'Client', 'cart-360232645314833@autodelovi.test', '+38164111222', '$2a$10$25B8Hr9Ta5rMWoLu3sM/OeiPhAYjSsc.hD3XDUEiBHZypDkZoeAia', 1, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(232, 'CLIENT', 'Cart', 'Client', 'cart-360233012650250@autodelovi.test', '+38164111222', '$2a$10$3vEm2mQ/Dgjji2FTzAcqEe.7WmzE7RIWEDQtapZNaOeoEfMGWu4T.', 1, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(233, 'CLIENT', 'Order', 'Client', 'order-362064383982458@autodelovi.test', '+38164111222', '$2a$10$UYVj4Ldw9CBgMQ8Rg20UJe.IlvzfBZ/ptvR.n0zAlJOfo3QBbF53W', 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(234, 'CLIENT', 'Order', 'Client', 'order-362065237164875@autodelovi.test', '+38164111222', '$2a$10$b621xwrWkQzso.bXNtrZCuxGrvIl/N0rqtH/Aye3HD23z9DShLfJ.', 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(235, 'CLIENT', 'Order', 'Client', 'order-362065484030583@autodelovi.test', '+38164111222', '$2a$10$vxqw/nGFc8GeI2596OGhxuIoGfZfgmAFUx3doJ1SdT/GuoTcadGtO', 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(236, 'CLIENT', 'Order', 'Client', 'order-362065726128833@autodelovi.test', '+38164111222', '$2a$10$K27trK3xmhR.285HTDSVKu7Ioc.qPTELxYPqXXCMXf6xDJs9vgf3W', 1, '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(237, 'CLIENT', 'Order', 'Client', 'order-362065998183583@autodelovi.test', '+38164111222', '$2a$10$TkMEvQkj0Bl32PjGbsFk.OMEve6NrwnJdfyW6nBen5ubCnYeWkeg.', 1, '2026-06-25 17:54:13', '2026-06-25 17:54:13');

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
(1, 22, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(4, 24, '2026-06-25 16:27:43', '2026-06-25 16:27:43'),
(7, 29, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(10, 34, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(13, 36, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(14, 37, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(15, 38, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(16, 39, '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(17, 40, '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(18, 41, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(19, 42, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(20, 43, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(21, 44, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(22, 45, '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(23, 49, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(26, 51, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(27, 52, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(28, 53, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(29, 54, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(30, 55, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(31, 59, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(34, 63, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(35, 64, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(36, 65, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(37, 66, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(38, 67, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(39, 73, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(42, 75, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(43, 76, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(44, 77, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(45, 78, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(46, 79, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(47, 85, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(50, 89, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(51, 90, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(52, 91, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(53, 92, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(54, 93, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(55, 101, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(58, 103, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(59, 104, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(60, 105, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(61, 106, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(62, 107, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(63, 115, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(66, 117, '2026-06-25 16:54:13', '2026-06-25 16:54:13'),
(67, 118, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(68, 119, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(69, 120, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(70, 121, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(71, 129, '2026-06-25 16:54:18', '2026-06-25 16:54:18'),
(74, 131, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(75, 132, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(76, 133, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(77, 134, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(78, 135, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(79, 143, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(82, 145, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(83, 146, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(84, 147, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(85, 148, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(86, 149, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(87, 157, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(90, 159, '2026-06-25 17:06:26', '2026-06-25 17:06:26'),
(91, 160, '2026-06-25 17:06:26', '2026-06-25 17:06:26'),
(92, 161, '2026-06-25 17:06:51', '2026-06-25 17:06:51'),
(93, 162, '2026-06-25 17:06:52', '2026-06-25 17:06:52'),
(94, 163, '2026-06-25 17:07:08', '2026-06-25 17:07:08'),
(95, 164, '2026-06-25 17:07:09', '2026-06-25 17:07:09'),
(96, 165, '2026-06-25 17:07:38', '2026-06-25 17:07:38'),
(97, 166, '2026-06-25 17:07:38', '2026-06-25 17:07:38'),
(98, 167, '2026-06-25 17:08:41', '2026-06-25 17:08:41'),
(99, 168, '2026-06-25 17:08:41', '2026-06-25 17:08:41'),
(100, 169, '2026-06-25 17:09:35', '2026-06-25 17:09:35'),
(101, 170, '2026-06-25 17:09:36', '2026-06-25 17:09:36'),
(102, 171, '2026-06-25 17:10:08', '2026-06-25 17:10:08'),
(103, 172, '2026-06-25 17:10:08', '2026-06-25 17:10:08'),
(104, 173, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(105, 174, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(106, 175, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(107, 176, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(108, 177, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(109, 185, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(112, 187, '2026-06-25 17:10:37', '2026-06-25 17:10:37'),
(113, 188, '2026-06-25 17:10:38', '2026-06-25 17:10:38'),
(114, 189, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(115, 190, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(116, 191, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(117, 192, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(118, 193, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(119, 201, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(122, 203, '2026-06-25 17:15:05', '2026-06-25 17:15:05'),
(123, 204, '2026-06-25 17:15:06', '2026-06-25 17:15:06'),
(124, 205, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(125, 206, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(126, 207, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(127, 208, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(128, 209, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(129, 217, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(132, 219, '2026-06-25 17:23:35', '2026-06-25 17:23:35'),
(133, 220, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(134, 221, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(135, 222, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(136, 223, '2026-06-25 17:23:37', '2026-06-25 17:23:37'),
(137, 231, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(140, 233, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(141, 234, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(142, 235, '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(143, 236, '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(144, 237, '2026-06-25 17:54:13', '2026-06-25 17:54:13');

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
(1, 1, 17, 3, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(8, 13, 35, 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(9, 14, 36, 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(13, 18, 40, 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(14, 19, 41, 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(20, 26, 51, 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(21, 27, 52, 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(27, 34, 67, 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(28, 35, 68, 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(34, 42, 83, 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(35, 43, 84, 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(41, 50, 99, 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(42, 51, 100, 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(48, 58, 115, 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(49, 59, 116, 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(55, 66, 131, 1, '2026-06-25 16:54:13', '2026-06-25 16:54:13'),
(56, 67, 132, 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(62, 74, 147, 1, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(63, 75, 148, 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(69, 82, 163, 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(70, 83, 164, 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(76, 93, 2, 1, '2026-06-25 17:06:52', '2026-06-25 17:06:52'),
(82, 104, 179, 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(83, 105, 180, 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(90, 114, 195, 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(91, 115, 196, 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(98, 124, 211, 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(99, 125, 212, 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(105, 132, 227, 1, '2026-06-25 17:23:35', '2026-06-25 17:23:35'),
(106, 133, 228, 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(112, 140, 243, 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(113, 141, 244, 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12');

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
(1, '1', 'create users', 'SQL', 'V1__create_users.sql', -1394215039, 'root', '2026-06-25 16:12:38', 25, 1),
(2, '2', 'create parts catalog', 'SQL', 'V2__create_parts_catalog.sql', -1531422848, 'root', '2026-06-25 16:12:38', 50, 1),
(3, '3', 'create cart tables', 'SQL', 'V3__create_cart_tables.sql', 203196383, 'root', '2026-06-25 16:12:38', 23, 1),
(4, '4', 'create orders', 'SQL', 'V4__create_orders.sql', -153117449, 'root', '2026-06-25 16:12:38', 54, 1),
(5, '5', 'create notifications', 'SQL', 'V5__create_notifications.sql', -1750630332, 'root', '2026-06-25 16:12:38', 24, 1),
(6, '6', 'create special orders', 'SQL', 'V6__create_special_orders.sql', -31241286, 'root', '2026-06-25 16:12:38', 27, 1),
(7, '7', 'seed initial data', 'SQL', 'V7__seed_initial_data.sql', -1585400605, 'root', '2026-06-25 16:12:39', 13, 1);

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

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `client_id`, `order_number`, `status`, `payment_method`, `payment_status`, `subtotal`, `total`, `contact_name`, `contact_email`, `contact_phone`, `shipping_address`, `shipping_city`, `shipping_postal_code`, `created_at`, `updated_at`) VALUES
(1, 38, 'ORD-1782405218816-6625', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(2, 39, 'ORD-1782405219057-9500', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(3, 40, 'ORD-1782405219392-7083', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(4, 43, 'ORD-1782405232585-4833', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(5, 44, 'ORD-1782405232846-4708', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(6, 45, 'ORD-1782405233179-6500', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(7, 53, 'ORD-1782405253186-2375', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(8, 54, 'ORD-1782405253430-5583', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(9, 55, 'ORD-1782405253764-4625', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(10, 65, 'ORD-1782405508055-8250', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(11, 66, 'ORD-1782405508302-8750', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(12, 67, 'ORD-1782405508622-6083', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(13, 77, 'ORD-1782405524831-7416', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(14, 78, 'ORD-1782405525054-6625', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(15, 79, 'ORD-1782405525372-1916', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(16, 91, 'ORD-1782405736797-5333', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(17, 92, 'ORD-1782405737305-1833', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(18, 93, 'ORD-1782405737731-1250', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(19, 105, 'ORD-1782405799093-2875', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(20, 106, 'ORD-1782405799327-4208', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(21, 107, 'ORD-1782405799666-3375', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(22, 119, 'ORD-1782406454449-8000', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(23, 120, 'ORD-1782406454679-5583', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(24, 121, 'ORD-1782406455011-2750', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 16:54:15', '2026-06-25 16:54:15'),
(25, 133, 'ORD-1782406801258-6291', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(26, 134, 'ORD-1782406801483-2166', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(27, 135, 'ORD-1782406801809-7791', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(28, 147, 'ORD-1782407024756-7000', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(29, 148, 'ORD-1782407024987-3000', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(30, 149, 'ORD-1782407025344-7125', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(31, 164, 'ORD-1782407229894-2166', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407229111@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:07:09', '2026-06-25 17:07:09'),
(32, 166, 'ORD-1782407259342-1791', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407258562@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:07:39', '2026-06-25 17:07:39'),
(33, 168, 'ORD-1782407322492-9625', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407321709@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:08:42', '2026-06-25 17:08:42'),
(34, 170, 'ORD-1782407377007-83', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407376206@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:09:37', '2026-06-25 17:09:37'),
(35, 172, 'ORD-1782407409472-666', 'PROCESSING', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407408691@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:10:09', '2026-06-25 17:10:09'),
(36, 175, 'ORD-1782407422901-6000', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(37, 176, 'ORD-1782407423127-8250', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(38, 177, 'ORD-1782407423450-6333', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(39, 188, 'ORD-1782407438556-4958', 'PROCESSING', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407437748@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:10:38', '2026-06-25 17:10:38'),
(40, 191, 'ORD-1782407674134-4458', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(41, 192, 'ORD-1782407674374-3875', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(42, 193, 'ORD-1782407674706-3416', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(43, 204, 'ORD-1782407707013-4125', 'PROCESSING', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, 1200.00, 'Test Kupac', 'kupac1782407706156@test.com', '123456', 'Glavna 1', 'Beograd', '11000', '2026-06-25 17:15:07', '2026-06-25 17:15:07'),
(44, 207, 'ORD-1782408188857-4625', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(45, 208, 'ORD-1782408189097-6708', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(46, 209, 'ORD-1782408189430-6708', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(47, 221, 'ORD-1782408216460-500', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(48, 222, 'ORD-1782408216690-1291', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(49, 223, 'ORD-1782408217020-3375', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:23:37', '2026-06-25 17:23:37'),
(50, 235, 'ORD-1782410053093-8583', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(51, 236, 'ORD-1782410053335-9375', 'CREATED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, 5000.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(52, 237, 'ORD-1782410053680-2750', 'DELIVERED', 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, 2500.00, 'Test Kupac', 'kupac@autodelovi.test', '+38164123456', 'Bulevar test 10', 'Beograd', '11000', '2026-06-25 17:54:13', '2026-06-25 17:54:13');

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

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `part_id`, `part_name`, `unit_price`, `quantity`, `line_total`) VALUES
(1, 1, 37, 'Forbidden status deo', 2500.00, 1, 2500.00),
(2, 2, 38, 'Order test deo', 2500.00, 2, 5000.00),
(3, 3, 39, 'Status flow deo', 2500.00, 1, 2500.00),
(4, 4, 42, 'Forbidden status deo', 2500.00, 1, 2500.00),
(5, 5, 43, 'Order test deo', 2500.00, 2, 5000.00),
(6, 6, 44, 'Status flow deo', 2500.00, 1, 2500.00),
(7, 7, 53, 'Forbidden status deo', 2500.00, 1, 2500.00),
(8, 8, 54, 'Order test deo', 2500.00, 2, 5000.00),
(9, 9, 55, 'Status flow deo', 2500.00, 1, 2500.00),
(10, 10, 69, 'Forbidden status deo', 2500.00, 1, 2500.00),
(11, 11, 70, 'Order test deo', 2500.00, 2, 5000.00),
(12, 12, 71, 'Status flow deo', 2500.00, 1, 2500.00),
(13, 13, 85, 'Forbidden status deo', 2500.00, 1, 2500.00),
(14, 14, 86, 'Order test deo', 2500.00, 2, 5000.00),
(15, 15, 87, 'Status flow deo', 2500.00, 1, 2500.00),
(16, 16, 101, 'Forbidden status deo', 2500.00, 1, 2500.00),
(17, 17, 102, 'Order test deo', 2500.00, 2, 5000.00),
(18, 18, 103, 'Status flow deo', 2500.00, 1, 2500.00),
(19, 19, 117, 'Forbidden status deo', 2500.00, 1, 2500.00),
(20, 20, 118, 'Order test deo', 2500.00, 2, 5000.00),
(21, 21, 119, 'Status flow deo', 2500.00, 1, 2500.00),
(22, 22, 133, 'Forbidden status deo', 2500.00, 1, 2500.00),
(23, 23, 134, 'Order test deo', 2500.00, 2, 5000.00),
(24, 24, 135, 'Status flow deo', 2500.00, 1, 2500.00),
(25, 25, 149, 'Forbidden status deo', 2500.00, 1, 2500.00),
(26, 26, 150, 'Order test deo', 2500.00, 2, 5000.00),
(27, 27, 151, 'Status flow deo', 2500.00, 1, 2500.00),
(28, 28, 165, 'Forbidden status deo', 2500.00, 1, 2500.00),
(29, 29, 166, 'Order test deo', 2500.00, 2, 5000.00),
(30, 30, 167, 'Status flow deo', 2500.00, 1, 2500.00),
(31, 31, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(32, 32, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(33, 33, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(34, 34, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(35, 35, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(36, 36, 181, 'Forbidden status deo', 2500.00, 1, 2500.00),
(37, 37, 182, 'Order test deo', 2500.00, 2, 5000.00),
(38, 38, 183, 'Status flow deo', 2500.00, 1, 2500.00),
(39, 39, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(40, 40, 197, 'Forbidden status deo', 2500.00, 1, 2500.00),
(41, 41, 198, 'Order test deo', 2500.00, 2, 5000.00),
(42, 42, 199, 'Status flow deo', 2500.00, 1, 2500.00),
(43, 43, 2, 'Filter ulja', 1200.00, 1, 1200.00),
(44, 44, 213, 'Forbidden status deo', 2500.00, 1, 2500.00),
(45, 45, 214, 'Order test deo', 2500.00, 2, 5000.00),
(46, 46, 215, 'Status flow deo', 2500.00, 1, 2500.00),
(47, 47, 229, 'Forbidden status deo', 2500.00, 1, 2500.00),
(48, 48, 230, 'Order test deo', 2500.00, 2, 5000.00),
(49, 49, 231, 'Status flow deo', 2500.00, 1, 2500.00),
(50, 50, 245, 'Forbidden status deo', 2500.00, 1, 2500.00),
(51, 51, 246, 'Order test deo', 2500.00, 2, 5000.00),
(52, 52, 247, 'Status flow deo', 2500.00, 1, 2500.00);

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
(1, 1, 1, 1, 'BRK-GOLF7-FRONT', 'Prednje kocione plocice', 'Set prednjih kocionih plocica za Volkswagen Golf 7.', 'Brembo', 4200.00, 12, '/images/parts/brake-pads.jpg', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(2, 2, 2, 2, 'FLT-ASTRAJ-OIL', 'Filter ulja', 'Filter ulja za Opel Astra J benzinske i dizel motore.', 'Mann Filter', 1200.00, 23, '/images/parts/oil-filter.jpg', 1, '2026-06-25 16:12:39', '2026-06-25 17:15:07'),
(3, 3, 4, 4, 'BAT-60AH-UNI', 'Akumulator 60Ah', 'Univerzalni akumulator kapaciteta 60Ah.', 'Varta', 8900.00, 5, '/images/parts/battery.jpg', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(4, 4, 3, 3, 'CLU-PUNTO-SET', 'Set kvacila', 'Set kvacila za Fiat Punto. Trenutno nije na stanju.', 'LUK', 14500.00, 0, '/images/parts/clutch-kit.jpg', 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(5, 3, 4, 4, 'TEST-356555379890083', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:22:22', '2026-06-25 16:22:22'),
(6, 3, 4, 4, 'TEST-356555577954041', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:22:22', '2026-06-25 16:22:22'),
(7, 3, 4, 4, 'TEST-356555717039833', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:22:23', '2026-06-25 16:22:23'),
(8, 3, 4, 4, 'TEST-356619024244833', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:23:26', '2026-06-25 16:23:26'),
(9, 3, 4, 4, 'TEST-356619218940500', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:23:26', '2026-06-25 16:23:26'),
(10, 3, 4, 4, 'TEST-356619355768708', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:23:26', '2026-06-25 16:23:26'),
(11, 3, 4, 4, 'TEST-356638882905208', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:23:46', '2026-06-25 16:23:46'),
(12, 3, 4, 4, 'TEST-356639072894375', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:23:46', '2026-06-25 16:23:46'),
(13, 3, 4, 4, 'TEST-356639211577916', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:23:46', '2026-06-25 16:23:46'),
(14, 3, 4, 4, 'TEST-356851611468666', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(15, 3, 4, 4, 'TEST-356851805590625', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(16, 3, 4, 4, 'TEST-356851949293375', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(17, 3, 4, 4, 'CART-356852156048208', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(18, 3, 4, 4, 'CART-356852506098208', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(19, 3, 4, 4, 'CART-356852604692708', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:19', '2026-06-25 16:27:19'),
(20, 3, 4, 4, 'CART-356876187718083', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:43', '2026-06-25 16:27:43'),
(21, 3, 4, 4, 'CART-356876780192458', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:44', '2026-06-25 16:27:44'),
(22, 3, 4, 4, 'CART-356876879261875', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:44', '2026-06-25 16:27:44'),
(23, 3, 4, 4, 'TEST-356889354282083', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:27:56', '2026-06-25 16:27:56'),
(24, 3, 4, 4, 'TEST-356889548750125', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:27:56', '2026-06-25 16:27:56'),
(25, 3, 4, 4, 'TEST-356889690784416', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(26, 3, 4, 4, 'CART-356889898958958', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(27, 3, 4, 4, 'CART-356890412914666', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(28, 3, 4, 4, 'CART-356890520770458', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:27:57', '2026-06-25 16:27:57'),
(29, 3, 4, 4, 'TEST-356905236159750', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:28:12', '2026-06-25 16:28:12'),
(30, 3, 4, 4, 'TEST-356905458911166', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:28:12', '2026-06-25 16:28:12'),
(31, 3, 4, 4, 'TEST-356905618220916', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:28:12', '2026-06-25 16:28:12'),
(32, 3, 4, 4, 'CART-356905859932666', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(33, 3, 4, 4, 'CART-356906380723583', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(34, 3, 4, 4, 'CART-356906479464875', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:28:13', '2026-06-25 16:28:13'),
(35, 3, 4, 4, 'ORDER-UPDATED-357230880903333', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(36, 3, 4, 4, 'ORDER-357231139192041', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(37, 3, 4, 4, 'ORDER-357231388321291', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:38', '2026-06-25 16:33:38'),
(38, 3, 4, 4, 'ORDER-357231632208250', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(39, 3, 4, 4, 'ORDER-357231969505583', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:39', '2026-06-25 16:33:39'),
(40, 3, 4, 4, 'ORDER-UPDATED-357244660316250', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:51', '2026-06-25 16:33:52'),
(41, 3, 4, 4, 'ORDER-357244929385083', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(42, 3, 4, 4, 'ORDER-357245163842041', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(43, 3, 4, 4, 'ORDER-357245398920208', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:52', '2026-06-25 16:33:52'),
(44, 3, 4, 4, 'ORDER-357245760797125', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:33:53', '2026-06-25 16:33:53'),
(45, 3, 4, 4, 'TEST-357247061699958', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(46, 3, 4, 4, 'TEST-357247212738833', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(47, 3, 4, 4, 'TEST-357247345791666', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(48, 3, 4, 4, 'CART-357247544394625', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:33:54', '2026-06-25 16:33:54'),
(49, 3, 4, 4, 'CART-357247931514791', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:33:55', '2026-06-25 16:33:55'),
(50, 3, 4, 4, 'CART-357248028043416', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:33:55', '2026-06-25 16:33:55'),
(51, 3, 4, 4, 'ORDER-UPDATED-357265257845916', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(52, 3, 4, 4, 'ORDER-357265515424416', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:34:12', '2026-06-25 16:34:12'),
(53, 3, 4, 4, 'ORDER-357265759350583', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(54, 3, 4, 4, 'ORDER-357266000568375', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(55, 3, 4, 4, 'ORDER-357266344662208', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:34:13', '2026-06-25 16:34:13'),
(56, 3, 4, 4, 'TEST-357267630185666', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(57, 3, 4, 4, 'TEST-357267770335083', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(58, 3, 4, 4, 'TEST-357267919664375', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(59, 3, 4, 4, 'CART-357268118086041', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(60, 3, 4, 4, 'CART-357268497506375', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(61, 3, 4, 4, 'CART-357268602913041', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:34:15', '2026-06-25 16:34:15'),
(62, 3, 4, 4, 'NOTIFY-357507270704958', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:14', '2026-06-25 16:38:14'),
(63, 3, 4, 4, 'NOTIFY-357507560913833', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:14', '2026-06-25 16:38:14'),
(64, 3, 4, 4, 'NOTIFY-357507671395458', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:15', '2026-06-25 16:38:15'),
(65, 3, 4, 4, 'NOTIFY-357507903939625', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:15', '2026-06-25 16:38:15'),
(66, 3, 4, 4, 'NOTIFY-357508166446166', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:15', '2026-06-25 16:38:15'),
(67, 3, 4, 4, 'ORDER-UPDATED-357520140052791', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(68, 3, 4, 4, 'ORDER-357520395757083', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:27', '2026-06-25 16:38:27'),
(69, 3, 4, 4, 'ORDER-357520631782958', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(70, 3, 4, 4, 'ORDER-357520883882375', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(71, 3, 4, 4, 'ORDER-357521203566583', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:28', '2026-06-25 16:38:28'),
(72, 3, 4, 4, 'NOTIFY-357522417123875', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:29', '2026-06-25 16:38:29'),
(73, 3, 4, 4, 'NOTIFY-357522529410000', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:29', '2026-06-25 16:38:29'),
(74, 3, 4, 4, 'NOTIFY-357522636478958', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(75, 3, 4, 4, 'NOTIFY-357522829076166', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(76, 3, 4, 4, 'NOTIFY-357523091095666', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(77, 3, 4, 4, 'TEST-357523327572500', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(78, 3, 4, 4, 'TEST-357523488321875', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:38:30', '2026-06-25 16:38:30'),
(79, 3, 4, 4, 'TEST-357523626093125', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(80, 3, 4, 4, 'CART-357523836505666', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(81, 3, 4, 4, 'CART-357524234858583', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(82, 3, 4, 4, 'CART-357524329455041', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:31', '2026-06-25 16:38:31'),
(83, 3, 4, 4, 'ORDER-UPDATED-357536913199666', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(84, 3, 4, 4, 'ORDER-357537162541666', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(85, 3, 4, 4, 'ORDER-357537409401666', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:44', '2026-06-25 16:38:44'),
(86, 3, 4, 4, 'ORDER-357537636026541', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(87, 3, 4, 4, 'ORDER-357537956973041', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:38:45', '2026-06-25 16:38:45'),
(88, 3, 4, 4, 'NOTIFY-357539127516000', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:46', '2026-06-25 16:38:46'),
(89, 3, 4, 4, 'NOTIFY-357539234879541', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:46', '2026-06-25 16:38:46'),
(90, 3, 4, 4, 'NOTIFY-357539336119541', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:46', '2026-06-25 16:38:46'),
(91, 3, 4, 4, 'NOTIFY-357539514927208', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:46', '2026-06-25 16:38:46'),
(92, 3, 4, 4, 'NOTIFY-357539768611166', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(93, 3, 4, 4, 'TEST-357539992529833', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(94, 3, 4, 4, 'TEST-357540160667958', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(95, 3, 4, 4, 'TEST-357540308386333', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(96, 3, 4, 4, 'CART-357540510518208', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:47', '2026-06-25 16:38:47'),
(97, 3, 4, 4, 'CART-357540892593666', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:48', '2026-06-25 16:38:48'),
(98, 3, 4, 4, 'CART-357540983765583', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:38:48', '2026-06-25 16:38:48'),
(99, 3, 4, 4, 'ORDER-UPDATED-357748872589208', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(100, 3, 4, 4, 'ORDER-357749136873708', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(101, 3, 4, 4, 'ORDER-357749379169833', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:42:16', '2026-06-25 16:42:16'),
(102, 3, 4, 4, 'ORDER-357749762082041', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(103, 3, 4, 4, 'ORDER-357750310790583', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:42:17', '2026-06-25 16:42:17'),
(104, 3, 4, 4, 'NOTIFY-357751571342916', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:42:18', '2026-06-25 16:42:18'),
(105, 3, 4, 4, 'NOTIFY-357751685289875', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(106, 3, 4, 4, 'NOTIFY-357751794841791', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(107, 3, 4, 4, 'NOTIFY-357751982056166', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(108, 3, 4, 4, 'NOTIFY-357752328658916', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(109, 3, 4, 4, 'TEST-357752562873583', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:42:19', '2026-06-25 16:42:19'),
(110, 3, 4, 4, 'TEST-357752715356333', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(111, 3, 4, 4, 'TEST-357752862558208', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(112, 3, 4, 4, 'CART-357753494266708', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(113, 3, 4, 4, 'CART-357753854986500', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:42:21', '2026-06-25 16:42:21'),
(114, 3, 4, 4, 'CART-357753949431958', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:42:21', '2026-06-25 16:42:21'),
(115, 3, 4, 4, 'ORDER-UPDATED-357811162569250', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(116, 3, 4, 4, 'ORDER-357811423817750', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:43:18', '2026-06-25 16:43:18'),
(117, 3, 4, 4, 'ORDER-357811667312583', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(118, 3, 4, 4, 'ORDER-357811901665625', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(119, 3, 4, 4, 'ORDER-357812242635750', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:43:19', '2026-06-25 16:43:19'),
(120, 3, 4, 4, 'NOTIFY-357813485251000', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:43:20', '2026-06-25 16:43:20'),
(121, 3, 4, 4, 'NOTIFY-357813599669500', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:43:20', '2026-06-25 16:43:20'),
(122, 3, 4, 4, 'NOTIFY-357813706066250', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(123, 3, 4, 4, 'NOTIFY-357813893429791', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(124, 3, 4, 4, 'NOTIFY-357814163533458', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(125, 3, 4, 4, 'TEST-357814396479791', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(126, 3, 4, 4, 'TEST-357814550195208', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:43:21', '2026-06-25 16:43:21'),
(127, 3, 4, 4, 'TEST-357814703299541', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(128, 3, 4, 4, 'CART-357815345646916', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(129, 3, 4, 4, 'CART-357815704754500', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:43:23', '2026-06-25 16:43:23'),
(130, 3, 4, 4, 'CART-357815800353125', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:43:23', '2026-06-25 16:43:23'),
(131, 3, 4, 4, 'ORDER-UPDATED-358466512519708', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 16:54:13', '2026-06-25 16:54:13'),
(132, 3, 4, 4, 'ORDER-358466765277583', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(133, 3, 4, 4, 'ORDER-358466998262250', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(134, 3, 4, 4, 'ORDER-358467231649083', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:14'),
(135, 3, 4, 4, 'ORDER-358467559527958', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 16:54:14', '2026-06-25 16:54:15'),
(136, 3, 4, 4, 'NOTIFY-358468766225291', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(137, 3, 4, 4, 'NOTIFY-358468876753708', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(138, 3, 4, 4, 'NOTIFY-358468984293166', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(139, 3, 4, 4, 'NOTIFY-358469170011708', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(140, 3, 4, 4, 'NOTIFY-358469452627250', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 16:54:16', '2026-06-25 16:54:16'),
(141, 3, 4, 4, 'TEST-358469682528833', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(142, 3, 4, 4, 'TEST-358469842559333', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(143, 3, 4, 4, 'TEST-358469999249833', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(144, 3, 4, 4, 'CART-358470621275958', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:54:18', '2026-06-25 16:54:18'),
(145, 3, 4, 4, 'CART-358470997889500', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:54:18', '2026-06-25 16:54:18'),
(146, 3, 4, 4, 'CART-358471096100916', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 16:54:18', '2026-06-25 16:54:18'),
(147, 3, 4, 4, 'ORDER-UPDATED-358813310132000', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(148, 3, 4, 4, 'ORDER-358813564174583', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:00:00', '2026-06-25 17:00:00'),
(149, 3, 4, 4, 'ORDER-358813808551666', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(150, 3, 4, 4, 'ORDER-358814030801875', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(151, 3, 4, 4, 'ORDER-358814360339541', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:00:01', '2026-06-25 17:00:01'),
(152, 3, 4, 4, 'NOTIFY-358815623081583', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(153, 3, 4, 4, 'NOTIFY-358815740031875', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(154, 3, 4, 4, 'NOTIFY-358815846871666', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(155, 3, 4, 4, 'NOTIFY-358816033169833', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(156, 3, 4, 4, 'NOTIFY-358816290738416', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(157, 3, 4, 4, 'TEST-358816526234000', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:00:03', '2026-06-25 17:00:03'),
(158, 3, 4, 4, 'TEST-358816664865291', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(159, 3, 4, 4, 'TEST-358816813704583', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(160, 3, 4, 4, 'CART-358817470753958', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(161, 3, 4, 4, 'CART-358817857725291', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:00:05', '2026-06-25 17:00:05'),
(162, 3, 4, 4, 'CART-358817957309166', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:00:05', '2026-06-25 17:00:05'),
(163, 3, 4, 4, 'ORDER-UPDATED-359036778537125', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(164, 3, 4, 4, 'ORDER-359037038594375', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(165, 3, 4, 4, 'ORDER-359037303497666', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(166, 3, 4, 4, 'ORDER-359037529201625', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:03:44', '2026-06-25 17:03:44'),
(167, 3, 4, 4, 'ORDER-359037886314375', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:03:45', '2026-06-25 17:03:45'),
(168, 3, 4, 4, 'NOTIFY-359039117788750', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:03:46', '2026-06-25 17:03:46'),
(169, 3, 4, 4, 'NOTIFY-359039230188791', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:03:46', '2026-06-25 17:03:46'),
(170, 3, 4, 4, 'NOTIFY-359039334754000', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:03:46', '2026-06-25 17:03:46'),
(171, 3, 4, 4, 'NOTIFY-359039518864250', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:03:46', '2026-06-25 17:03:46'),
(172, 3, 4, 4, 'NOTIFY-359039865161833', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(173, 3, 4, 4, 'TEST-359040099355333', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(174, 3, 4, 4, 'TEST-359040255161916', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(175, 3, 4, 4, 'TEST-359040408860750', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(176, 3, 4, 4, 'CART-359041031716708', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(177, 3, 4, 4, 'CART-359041376705250', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(178, 3, 4, 4, 'CART-359041469275833', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(179, 3, 4, 4, 'ORDER-UPDATED-359434951945916', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(180, 3, 4, 4, 'ORDER-359435208550375', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(181, 3, 4, 4, 'ORDER-359435442759208', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:10:22', '2026-06-25 17:10:22'),
(182, 3, 4, 4, 'ORDER-359435669196750', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(183, 3, 4, 4, 'ORDER-359435995716625', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:10:23', '2026-06-25 17:10:23'),
(184, 3, 4, 4, 'NOTIFY-359437178592125', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:10:24', '2026-06-25 17:10:24'),
(185, 3, 4, 4, 'NOTIFY-359437290575000', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:10:24', '2026-06-25 17:10:24'),
(186, 3, 4, 4, 'NOTIFY-359437393326500', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:10:24', '2026-06-25 17:10:24'),
(187, 3, 4, 4, 'NOTIFY-359437576824708', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(188, 3, 4, 4, 'NOTIFY-359437836332916', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(189, 3, 4, 4, 'TEST-359438066011041', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(190, 3, 4, 4, 'TEST-359438222004333', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(191, 3, 4, 4, 'TEST-359438383489208', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(192, 3, 4, 4, 'CART-359439021315500', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(193, 3, 4, 4, 'CART-359439407892041', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(194, 3, 4, 4, 'CART-359439502392416', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(195, 3, 4, 4, 'ORDER-UPDATED-359686157920541', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(196, 3, 4, 4, 'ORDER-359686420535416', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:14:33', '2026-06-25 17:14:33'),
(197, 3, 4, 4, 'ORDER-359686665772583', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(198, 3, 4, 4, 'ORDER-359686910693833', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(199, 3, 4, 4, 'ORDER-359687241622916', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:14:34', '2026-06-25 17:14:34'),
(200, 3, 4, 4, 'NOTIFY-359688508248750', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:14:35', '2026-06-25 17:14:35'),
(201, 3, 4, 4, 'NOTIFY-359688621202750', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(202, 3, 4, 4, 'NOTIFY-359688738866833', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(203, 3, 4, 4, 'NOTIFY-359688924914791', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(204, 3, 4, 4, 'NOTIFY-359689193530041', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(205, 3, 4, 4, 'TEST-359689435765250', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:14:36', '2026-06-25 17:14:36'),
(206, 3, 4, 4, 'TEST-359689581903750', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(207, 3, 4, 4, 'TEST-359689736486416', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(208, 3, 4, 4, 'CART-359690387151125', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(209, 3, 4, 4, 'CART-359690794379291', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:14:38', '2026-06-25 17:14:38'),
(210, 3, 4, 4, 'CART-359690896792125', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:14:38', '2026-06-25 17:14:38'),
(211, 3, 4, 4, 'ORDER-UPDATED-360200948705666', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(212, 3, 4, 4, 'ORDER-360201214120333', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(213, 3, 4, 4, 'ORDER-360201457785250', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:08', '2026-06-25 17:23:08'),
(214, 3, 4, 4, 'ORDER-360201704859500', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(215, 3, 4, 4, 'ORDER-360202039610416', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:09', '2026-06-25 17:23:09'),
(216, 3, 4, 4, 'NOTIFY-360203356810333', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:10', '2026-06-25 17:23:10'),
(217, 3, 4, 4, 'NOTIFY-360203473375208', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:10', '2026-06-25 17:23:10'),
(218, 3, 4, 4, 'NOTIFY-360203581625333', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:10', '2026-06-25 17:23:10'),
(219, 3, 4, 4, 'NOTIFY-360203766856416', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(220, 3, 4, 4, 'NOTIFY-360204030205375', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(221, 3, 4, 4, 'TEST-360204264307666', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(222, 3, 4, 4, 'TEST-360204434378250', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(223, 3, 4, 4, 'TEST-360204610980750', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:23:11', '2026-06-25 17:23:11'),
(224, 3, 4, 4, 'CART-360205280936500', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(225, 3, 4, 4, 'CART-360205646571541', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(226, 3, 4, 4, 'CART-360205742279625', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:13', '2026-06-25 17:23:13'),
(227, 3, 4, 4, 'ORDER-UPDATED-360228575263500', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:35', '2026-06-25 17:23:35'),
(228, 3, 4, 4, 'ORDER-360228830644250', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(229, 3, 4, 4, 'ORDER-360229066550750', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(230, 3, 4, 4, 'ORDER-360229300417375', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:36'),
(231, 3, 4, 4, 'ORDER-360229630425416', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:23:36', '2026-06-25 17:23:37'),
(232, 3, 4, 4, 'NOTIFY-360230895899125', 'Notify in stock deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 4, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(233, 3, 4, 4, 'NOTIFY-360231010690458', 'Notify validation deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(234, 3, 4, 4, 'NOTIFY-360231118027375', 'Notify public deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(235, 3, 4, 4, 'NOTIFY-360231302200208', 'Notify client deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(236, 3, 4, 4, 'NOTIFY-360231565946625', 'Notify list deo', 'Test deo za notification API proveru', 'Bosch', 2500.00, 0, '/images/parts/notification-test.jpg', 1, '2026-06-25 17:23:38', '2026-06-25 17:23:38'),
(237, 3, 4, 4, 'TEST-360231822278416', 'Test alternator updated', 'Test deo za API proveru', 'Bosch', 2500.00, 3, '/images/parts/test.jpg', 0, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(238, 3, 4, 4, 'TEST-360231986281875', 'Detalji test deo', 'Test deo za API proveru', 'Bosch', 2500.00, 4, '/images/parts/test.jpg', 1, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(239, 3, 4, 4, 'TEST-360232158484416', 'Duplicate SKU first', 'Test deo za API proveru', 'Bosch', 2500.00, 2, '/images/parts/test.jpg', 1, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(240, 3, 4, 4, 'CART-360232792933333', 'Korpa test deo', 'Test deo za proveru korpe', 'Bosch', 2500.00, 5, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(241, 3, 4, 4, 'CART-360233160756083', 'Nema na stanju', 'Test deo za proveru korpe', 'Bosch', 2500.00, 0, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(242, 3, 4, 4, 'CART-360233255673333', 'Mala zaliha', 'Test deo za proveru korpe', 'Bosch', 2500.00, 2, '/images/parts/cart-test.jpg', 1, '2026-06-25 17:23:40', '2026-06-25 17:23:40'),
(243, 3, 4, 4, 'ORDER-UPDATED-362065123148125', 'Out before checkout', 'Test deo za order API proveru', 'Bosch', 2500.00, 0, '/images/parts/order-test.jpg', 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(244, 3, 4, 4, 'ORDER-362065389605916', 'Card fail API deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 4, '/images/parts/order-test.jpg', 1, '2026-06-25 17:54:12', '2026-06-25 17:54:12'),
(245, 3, 4, 4, 'ORDER-362065635787500', 'Forbidden status deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(246, 3, 4, 4, 'ORDER-362065876205958', 'Order test deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 3, '/images/parts/order-test.jpg', 1, '2026-06-25 17:54:13', '2026-06-25 17:54:13'),
(247, 3, 4, 4, 'ORDER-362066227130583', 'Status flow deo', 'Test deo za order API proveru', 'Bosch', 2500.00, 2, '/images/parts/order-test.jpg', 1, '2026-06-25 17:54:13', '2026-06-25 17:54:13');

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
(1, 'Kocioni sistem', 'kocioni-sistem', 'Delovi za kocioni sistem vozila.', NULL, 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(2, 'Filteri', 'filteri', 'Filteri ulja, vazduha, goriva i kabine.', NULL, 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(3, 'Elektrika', 'elektrika', 'Akumulatori, sijalice i ostali elektricni delovi.', NULL, 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39'),
(4, 'Menjac', 'menjac', 'Delovi menjaca i kvacila.', NULL, 1, '2026-06-25 16:12:39', '2026-06-25 16:12:39');

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

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `method`, `status`, `amount`, `transaction_reference`, `failure_reason`, `created_at`) VALUES
(1, 1, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:33:38'),
(2, 2, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:33:39'),
(3, 3, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:33:39'),
(4, 4, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:33:52'),
(5, 5, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:33:52'),
(6, 6, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:33:53'),
(7, 7, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:34:13'),
(8, 8, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:34:13'),
(9, 9, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:34:13'),
(10, 10, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:38:28'),
(11, 11, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:38:28'),
(12, 12, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:38:28'),
(13, 13, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:38:44'),
(14, 14, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:38:45'),
(15, 15, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:38:45'),
(16, 16, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:42:16'),
(17, 17, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:42:17'),
(18, 18, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:42:17'),
(19, 19, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:43:19'),
(20, 20, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:43:19'),
(21, 21, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:43:19'),
(22, 22, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:54:14'),
(23, 23, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 16:54:14'),
(24, 24, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 16:54:15'),
(25, 25, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:00:01'),
(26, 26, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:00:01'),
(27, 27, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:00:01'),
(28, 28, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:03:44'),
(29, 29, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:03:44'),
(30, 30, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:03:45'),
(31, 31, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:07:09'),
(32, 32, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:07:39'),
(33, 33, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:08:42'),
(34, 34, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:09:37'),
(35, 35, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:10:09'),
(36, 36, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:10:22'),
(37, 37, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:10:23'),
(38, 38, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:10:23'),
(39, 39, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:10:38'),
(40, 40, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:14:34'),
(41, 41, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:14:34'),
(42, 42, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:14:34'),
(43, 43, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 1200.00, NULL, NULL, '2026-06-25 17:15:07'),
(44, 44, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:23:08'),
(45, 45, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:23:09'),
(46, 46, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:23:09'),
(47, 47, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:23:36'),
(48, 48, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:23:36'),
(49, 49, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:23:37'),
(50, 50, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:54:13'),
(51, 51, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 5000.00, NULL, NULL, '2026-06-25 17:54:13'),
(52, 52, 'CASH_ON_DELIVERY', 'CASH_ON_DELIVERY', 2500.00, NULL, NULL, '2026-06-25 17:54:13');

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

--
-- Dumping data for table `restock_notification_requests`
--

INSERT INTO `restock_notification_requests` (`id`, `part_id`, `client_id`, `channel`, `email`, `phone`, `status`, `created_at`, `notified_at`) VALUES
(1, 64, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:38:15', NULL),
(2, 65, 61, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:38:15', NULL),
(3, 66, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:38:15', NULL),
(4, 74, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:38:30', NULL),
(5, 75, 71, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:38:30', NULL),
(6, 76, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:38:30', NULL),
(7, 90, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:38:46', NULL),
(8, 91, 83, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:38:46', NULL),
(9, 92, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:38:47', NULL),
(10, 106, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:42:19', NULL),
(11, 107, 97, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:42:19', NULL),
(12, 108, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:42:19', NULL),
(13, 122, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:43:21', NULL),
(14, 123, 111, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:43:21', NULL),
(15, 124, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:43:21', NULL),
(16, 138, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 16:54:16', NULL),
(17, 139, 125, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 16:54:16', NULL),
(18, 140, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 16:54:16', NULL),
(19, 154, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:00:03', NULL),
(20, 155, 139, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:00:03', NULL),
(21, 156, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:00:03', NULL),
(22, 170, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:03:46', NULL),
(23, 171, 153, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:03:46', NULL),
(24, 172, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:03:47', NULL),
(25, 186, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:10:24', NULL),
(26, 187, 181, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:10:25', NULL),
(27, 188, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:10:25', NULL),
(28, 202, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:14:36', NULL),
(29, 203, 197, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:14:36', NULL),
(30, 204, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:14:36', NULL),
(31, 218, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:23:10', NULL),
(32, 219, 213, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:23:11', NULL),
(33, 220, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:23:11', NULL),
(34, 234, NULL, 'EMAIL', 'ana@example.com', NULL, 'PENDING', '2026-06-25 17:23:38', NULL),
(35, 235, 227, 'SMS', NULL, '+38164111222', 'PENDING', '2026-06-25 17:23:38', NULL),
(36, 236, NULL, 'EMAIL', 'list@example.com', NULL, 'PENDING', '2026-06-25 17:23:38', NULL);

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

--
-- Dumping data for table `special_order_requests`
--

INSERT INTO `special_order_requests` (`id`, `client_id`, `contact_name`, `contact_email`, `contact_phone`, `vehicle_make`, `vehicle_model`, `vehicle_year`, `vin`, `parts_description`, `status`, `employee_response`, `estimated_arrival`, `pickup_location`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:03', '2026-06-25 16:42:03'),
(2, 87, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:03', '2026-06-25 16:42:03'),
(3, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 16:42:03', '2026-06-25 16:42:04'),
(4, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:04', '2026-06-25 16:42:04'),
(5, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(6, 99, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(7, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(8, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:42:20', '2026-06-25 16:42:20'),
(9, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(10, 113, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(11, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(12, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:43:22', '2026-06-25 16:43:22'),
(13, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(14, 127, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(15, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(16, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 16:54:17', '2026-06-25 16:54:17'),
(17, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(18, 141, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(19, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(20, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:00:04', '2026-06-25 17:00:04'),
(21, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:03:47', '2026-06-25 17:03:47'),
(22, 155, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(23, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(24, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:03:48', '2026-06-25 17:03:48'),
(25, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:10:25', '2026-06-25 17:10:25'),
(26, 183, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(27, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(28, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:10:26', '2026-06-25 17:10:26'),
(29, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(30, 199, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(31, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(32, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:14:37', '2026-06-25 17:14:37'),
(33, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(34, 215, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(35, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(36, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:12', '2026-06-25 17:23:12'),
(37, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Invalid available zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(38, 229, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Client zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(39, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Employee list zahtev', 'AVAILABLE', 'Dobavljac moze da isporuci deo.', '2026-07-15', 'Radnja Beograd', '2026-06-25 17:23:39', '2026-06-25 17:23:39'),
(40, NULL, 'Special Kupac', 'special@example.com', '+38164123456', 'Toyota', 'Corolla', 2014, 'JTDBR32E720000001', 'Public zahtev', 'SUBMITTED', NULL, NULL, NULL, '2026-06-25 17:23:39', '2026-06-25 17:23:39');

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
(1, 'Volkswagen', '2026-06-25 16:12:39'),
(2, 'Opel', '2026-06-25 16:12:39'),
(3, 'Fiat', '2026-06-25 16:12:39'),
(4, 'Univerzalno', '2026-06-25 16:12:39');

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
(1, 1, 'Golf 7', 2012, 2020, '2026-06-25 16:12:39'),
(2, 2, 'Astra J', 2009, 2015, '2026-06-25 16:12:39'),
(3, 3, 'Punto', 1999, 2018, '2026-06-25 16:12:39'),
(4, 4, 'Univerzalni deo', NULL, NULL, '2026-06-25 16:12:39');

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
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

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
