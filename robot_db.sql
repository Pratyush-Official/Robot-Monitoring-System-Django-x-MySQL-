-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2026 at 04:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `robot_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `actuators`
--

CREATE TABLE `actuators` (
  `actuator_id` int(11) NOT NULL,
  `actuation_type` varchar(100) DEFAULT NULL,
  `power_consumption` decimal(10,2) DEFAULT NULL,
  `placement` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actuators`
--

INSERT INTO `actuators` (`actuator_id`, `actuation_type`, `power_consumption`, `placement`) VALUES
(1, 'Viet_Motor_1', 25.00, 'Drive Base'),
(2, 'Viet_Motor_2', 25.00, 'Drive Base'),
(3, 'Viet_Motor_3', 25.00, 'Drive Base'),
(4, 'Viet_Motor_4', 25.00, 'Drive Base'),
(5, 'Viet_Motor_5', 25.00, 'Drive Base'),
(6, 'Viet_Motor_6', 25.00, 'Drive Base'),
(7, 'Viet_Motor_7', 25.00, 'Drive Base'),
(8, 'Viet_Motor_8', 25.00, 'Drive Base'),
(9, 'Servo_20kg', 10.00, 'Gripper Arm'),
(10, 'Servo_25kg', 12.00, 'Gripper Arm'),
(11, 'Servo_35kg', 15.00, 'Lifting Mechanism'),
(12, 'Servo_Standard', 5.00, 'Sensor Mount'),
(13, 'Piston_1', 50.00, 'Front Mechanism'),
(14, 'Piston_2', 50.00, 'Side Mechanism'),
(15, 'Damiyo_Motor_1', 30.00, 'Arm Joint'),
(16, 'Damiyo_Motor_2', 30.00, 'Arm Joint'),
(17, 'AK-60_1', 60.00, 'Rotary Joint'),
(18, 'AK-60_2', 60.00, 'Rotary Joint'),
(19, 'Brake_System', 15.00, 'Base'),
(20, 'LED_Status_Light', 2.00, 'Top Panel'),
(21, 'Buzzer_Alert', 1.50, 'Side Panel');

-- --------------------------------------------------------

--
-- Table structure for table `control`
--

CREATE TABLE `control` (
  `control_id` int(11) NOT NULL,
  `reading_id` int(11) DEFAULT NULL,
  `actuator_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `control`
--

INSERT INTO `control` (`control_id`, `reading_id`, `actuator_id`) VALUES
(1, 2, 19),
(2, 5, 1),
(3, 5, 2),
(4, 9, 1),
(5, 9, 2),
(6, 13, 21),
(7, 18, 1),
(8, 18, 2),
(9, 19, 3),
(10, 19, 4),
(11, 17, 19),
(12, 23, 9),
(13, 23, 10),
(14, 28, 1),
(15, 28, 2),
(16, 29, 3),
(17, 29, 4),
(18, 27, 21),
(19, 33, 11),
(20, 36, 17),
(21, 36, 18),
(22, 37, 15),
(23, 37, 16),
(24, 41, 12),
(25, 35, 21),
(26, 46, 17),
(27, 46, 18),
(28, 47, 15),
(29, 47, 16),
(30, 44, 19),
(31, 45, 21);

-- --------------------------------------------------------

--
-- Table structure for table `robot`
--

CREATE TABLE `robot` (
  `robot_id` int(11) NOT NULL,
  `robot_name` varchar(100) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `robot`
--

INSERT INTO `robot` (`robot_id`, `robot_name`, `location`, `status`) VALUES
(1, '2022_Manual_Robot', 'Lab / Workshop', 'retired'),
(2, '2023_Autonomous_Robot', 'Lab / Workshop', 'retired'),
(3, '2024_Autonomous_Robot', 'Competition Arena', 'retired'),
(4, '2025_Robot_1', 'Lab / Workshop', 'retired'),
(5, '2025_Robot_2', 'Competition Arena', 'retired'),
(6, '2026_Autonomous_Robot', 'Lab / Competition Arena', 'in development'),
(7, '2026_Manual_Robot', 'Lab / Competition Arena', 'in development');

-- --------------------------------------------------------

--
-- Table structure for table `sensors`
--

CREATE TABLE `sensors` (
  `sensor_id` int(11) NOT NULL,
  `robot_id` int(11) DEFAULT NULL,
  `sensor_type` varchar(100) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `max_value` decimal(10,2) DEFAULT NULL,
  `min_value` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensors`
--

INSERT INTO `sensors` (`sensor_id`, `robot_id`, `sensor_type`, `unit`, `max_value`, `min_value`) VALUES
(1, 1, 'Motor_Current', 'Amperes', 5.00, 0.10),
(2, 2, 'Infrared_Proximity', 'cm', 50.00, 1.00),
(3, 2, 'Motor_Current', 'Amperes', 5.00, 0.10),
(4, 3, 'Infrared_Proximity', 'cm', 50.00, 1.00),
(5, 3, 'Ultrasonic_Distance', 'cm', 200.00, 2.00),
(6, 3, 'Battery_Voltage', 'Volts', 12.60, 9.00),
(7, 4, 'Infrared_Proximity', 'cm', 50.00, 1.00),
(8, 4, 'Ultrasonic_Distance', 'cm', 200.00, 2.00),
(9, 4, 'Battery_Voltage', 'Volts', 12.60, 9.00),
(10, 4, 'Motor_Current', 'Amperes', 5.00, 0.10),
(11, 4, 'SICK_Sensor_1', 'cm', 200.00, 0.50),
(12, 4, 'SICK_Sensor_2', 'cm', 200.00, 0.50),
(13, 4, 'SICK_Sensor_3', 'cm', 200.00, 0.50),
(14, 4, 'SICK_Sensor_4', 'cm', 200.00, 0.50),
(15, 4, 'Proximity_Sensor_1', 'cm', 50.00, 1.00),
(16, 4, 'IMU_1', 'degrees/s', 2000.00, -2000.00),
(17, 4, 'Deadwheel_1', 'mm', 10000.00, 0.00),
(18, 4, 'Deadwheel_2', 'mm', 10000.00, 0.00),
(19, 5, 'Line_Sensor', 'Digital', 1.00, 0.00),
(20, 5, 'Battery_Voltage', 'Volts', 12.60, 9.00),
(21, 5, 'SICK_Sensor_5', 'cm', 200.00, 0.50),
(22, 5, 'SICK_Sensor_6', 'cm', 200.00, 0.50),
(23, 5, 'SICK_Sensor_7', 'cm', 200.00, 0.50),
(24, 5, 'SICK_Sensor_8', 'cm', 200.00, 0.50),
(25, 5, 'Proximity_Sensor_2', 'cm', 50.00, 1.00),
(26, 5, 'IMU_2', 'degrees/s', 2000.00, -2000.00),
(27, 6, 'Ultrasonic_Distance', 'cm', 300.00, 2.00),
(28, 6, 'Battery_Voltage', 'Volts', 12.60, 9.00),
(29, 6, 'SICK_Sensor_1', 'cm', 200.00, 0.50),
(30, 6, 'SICK_Sensor_2', 'cm', 200.00, 0.50),
(31, 6, 'SICK_Sensor_3', 'cm', 200.00, 0.50),
(32, 6, 'SICK_Sensor_4', 'cm', 200.00, 0.50),
(33, 6, 'Proximity_Sensor_1', 'cm', 50.00, 1.00),
(34, 6, 'IMU_1', 'degrees/s', 2000.00, -2000.00),
(35, 6, 'Deadwheel_1', 'mm', 10000.00, 0.00),
(36, 6, 'Deadwheel_2', 'mm', 10000.00, 0.00),
(37, 7, 'Motor_Current', 'Amperes', 5.00, 0.10),
(38, 7, 'Battery_Voltage', 'Volts', 12.60, 9.00),
(39, 7, 'SICK_Sensor_5', 'cm', 200.00, 0.50),
(40, 7, 'SICK_Sensor_6', 'cm', 200.00, 0.50),
(41, 7, 'SICK_Sensor_7', 'cm', 200.00, 0.50),
(42, 7, 'SICK_Sensor_8', 'cm', 200.00, 0.50),
(43, 7, 'Proximity_Sensor_3', 'cm', 50.00, 1.00),
(44, 7, 'IMU_2', 'degrees/s', 2000.00, -2000.00),
(45, 7, 'Deadwheel_1', 'mm', 10000.00, 0.00),
(46, 7, 'Deadwheel_2', 'mm', 10000.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_readings`
--

CREATE TABLE `sensor_readings` (
  `reading_id` int(11) NOT NULL,
  `sensor_id` int(11) DEFAULT NULL,
  `reading_time` datetime DEFAULT current_timestamp(),
  `value` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sensor_readings`
--

INSERT INTO `sensor_readings` (`reading_id`, `sensor_id`, `reading_time`, `value`) VALUES
(1, 1, '2022-11-10 09:00:00', 3.2000),
(2, 1, '2022-11-10 09:05:00', 4.8000),
(3, 1, '2022-11-10 09:10:00', 2.1000),
(4, 2, '2023-11-15 10:00:00', 25.0000),
(5, 2, '2023-11-15 10:05:00', 8.3000),
(6, 3, '2023-11-15 10:00:00', 4.1000),
(7, 3, '2023-11-15 10:05:00', 3.9000),
(8, 4, '2024-11-20 09:00:00', 18.5000),
(9, 4, '2024-11-20 09:05:00', 5.2000),
(10, 5, '2024-11-20 09:00:00', 120.0000),
(11, 5, '2024-11-20 09:05:00', 85.0000),
(12, 6, '2024-11-20 09:00:00', 11.8000),
(13, 6, '2024-11-20 09:05:00', 10.9000),
(14, 7, '2025-03-01 08:00:00', 10.2000),
(15, 8, '2025-03-01 08:00:00', 95.0000),
(16, 9, '2025-03-01 08:00:00', 12.1000),
(17, 10, '2025-03-01 08:00:00', 4.5000),
(18, 11, '2025-03-01 08:05:00', 45.0000),
(19, 12, '2025-03-01 08:05:00', 38.0000),
(20, 13, '2025-03-01 08:05:00', 22.0000),
(21, 14, '2025-03-01 08:05:00', 30.0000),
(22, 15, '2025-03-01 08:05:00', 12.0000),
(23, 16, '2025-03-01 08:10:00', 150.0000),
(24, 17, '2025-03-01 08:10:00', 4200.0000),
(25, 18, '2025-03-01 08:10:00', 3800.0000),
(26, 19, '2025-03-05 14:00:00', 1.0000),
(27, 20, '2025-03-05 14:00:00', 10.9000),
(28, 21, '2025-03-05 14:05:00', 55.0000),
(29, 22, '2025-03-05 14:05:00', 48.0000),
(30, 23, '2025-03-05 14:05:00', 60.0000),
(31, 24, '2025-03-05 14:05:00', 52.0000),
(32, 25, '2025-03-05 14:05:00', 30.0000),
(33, 26, '2025-03-05 14:10:00', 500.0000),
(34, 27, '2026-01-10 09:00:00', 55.0000),
(35, 28, '2026-01-10 09:00:00', 12.4000),
(36, 29, '2026-01-10 09:05:00', 90.0000),
(37, 30, '2026-01-10 09:05:00', 85.0000),
(38, 31, '2026-01-10 09:05:00', 78.0000),
(39, 32, '2026-01-10 09:05:00', 92.0000),
(40, 33, '2026-01-10 09:05:00', 18.0000),
(41, 34, '2026-01-10 09:10:00', 200.0000),
(42, 35, '2026-01-10 09:10:00', 5100.0000),
(43, 36, '2026-01-10 09:10:00', 4900.0000),
(44, 37, '2026-01-12 09:00:00', 3.5000),
(45, 38, '2026-01-12 09:00:00', 12.2000),
(46, 39, '2026-01-12 09:05:00', 70.0000),
(47, 40, '2026-01-12 09:05:00', 65.0000),
(48, 41, '2026-01-12 09:05:00', 80.0000),
(49, 42, '2026-01-12 09:05:00', 75.0000),
(50, 43, '2026-01-12 09:05:00', 22.0000),
(51, 44, '2026-01-12 09:10:00', 300.0000),
(52, 45, '2026-01-12 09:10:00', 5500.0000),
(53, 46, '2026-01-12 09:10:00', 5200.0000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actuators`
--
ALTER TABLE `actuators`
  ADD PRIMARY KEY (`actuator_id`);

--
-- Indexes for table `control`
--
ALTER TABLE `control`
  ADD PRIMARY KEY (`control_id`),
  ADD KEY `reading_id` (`reading_id`),
  ADD KEY `actuator_id` (`actuator_id`);

--
-- Indexes for table `robot`
--
ALTER TABLE `robot`
  ADD PRIMARY KEY (`robot_id`);

--
-- Indexes for table `sensors`
--
ALTER TABLE `sensors`
  ADD PRIMARY KEY (`sensor_id`),
  ADD KEY `robot_id` (`robot_id`);

--
-- Indexes for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  ADD PRIMARY KEY (`reading_id`),
  ADD KEY `sensor_id` (`sensor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actuators`
--
ALTER TABLE `actuators`
  MODIFY `actuator_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `control`
--
ALTER TABLE `control`
  MODIFY `control_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `robot`
--
ALTER TABLE `robot`
  MODIFY `robot_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sensors`
--
ALTER TABLE `sensors`
  MODIFY `sensor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  MODIFY `reading_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `control`
--
ALTER TABLE `control`
  ADD CONSTRAINT `control_ibfk_1` FOREIGN KEY (`reading_id`) REFERENCES `sensor_readings` (`reading_id`),
  ADD CONSTRAINT `control_ibfk_2` FOREIGN KEY (`actuator_id`) REFERENCES `actuators` (`actuator_id`);

--
-- Constraints for table `sensors`
--
ALTER TABLE `sensors`
  ADD CONSTRAINT `sensors_ibfk_1` FOREIGN KEY (`robot_id`) REFERENCES `robot` (`robot_id`);

--
-- Constraints for table `sensor_readings`
--
ALTER TABLE `sensor_readings`
  ADD CONSTRAINT `sensor_readings_ibfk_1` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`sensor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
