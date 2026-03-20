-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.15.0.7171
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para inventario_hotel
CREATE DATABASE IF NOT EXISTS `inventario_hotel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `inventario_hotel`;

-- Volcando estructura para tabla inventario_hotel.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `documento` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.cliente: ~0 rows (aproximadamente)

-- Volcando estructura para tabla inventario_hotel.habitacion
CREATE TABLE IF NOT EXISTS `habitacion` (
  `id_habitacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_hotel` int(11) DEFAULT NULL,
  `numero_habitacion` varchar(50) DEFAULT NULL,
  `piso` int(11) DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `estado` enum('disponible','ocupada','en_mantenimiento') DEFAULT 'disponible',
  `id_tipo` int(10) DEFAULT NULL,
  PRIMARY KEY (`id_habitacion`),
  KEY `id_tipo` (`id_tipo`),
  KEY `id_hotel` (`id_hotel`),
  CONSTRAINT `id_hotel` FOREIGN KEY (`id_hotel`) REFERENCES `hotel` (`id_hotel`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_habitacion` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.habitacion: ~0 rows (aproximadamente)

-- Volcando estructura para tabla inventario_hotel.hotel
CREATE TABLE IF NOT EXISTS `hotel` (
  `nombre_hotel` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `cuidad` varchar(50) DEFAULT NULL,
  `categoria` enum('1','2','3','4','5') DEFAULT NULL,
  `id_hotel` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_hotel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.hotel: ~0 rows (aproximadamente)

-- Volcando estructura para tabla inventario_hotel.reserva
CREATE TABLE IF NOT EXISTS `reserva` (
  `id_reserva` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_entrega` datetime DEFAULT NULL,
  `fecha_salida` datetime DEFAULT NULL,
  `estado` enum('comfirmada','activa','completada','cancelada') DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_habitacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `id_habitacion` (`id_habitacion`),
  KEY `id_ cliente` (`id_cliente`),
  CONSTRAINT `id_ cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_habitacion` FOREIGN KEY (`id_habitacion`) REFERENCES `habitacion` (`id_habitacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.reserva: ~0 rows (aproximadamente)

-- Volcando estructura para tabla inventario_hotel.servicio_adicional
CREATE TABLE IF NOT EXISTS `servicio_adicional` (
  `id_servicio` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `id_reserva` int(11) DEFAULT NULL,
  `fecha_servicio` datetime DEFAULT NULL,
  PRIMARY KEY (`id_servicio`),
  KEY `id_reserva` (`id_reserva`),
  CONSTRAINT `id_reserva` FOREIGN KEY (`id_reserva`) REFERENCES `reserva` (`id_reserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.servicio_adicional: ~0 rows (aproximadamente)

-- Volcando estructura para tabla inventario_hotel.tipo_habitacion
CREATE TABLE IF NOT EXISTS `tipo_habitacion` (
  `nombre_tipo` varchar(50) DEFAULT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `precio_noche` decimal(20,6) DEFAULT NULL,
  `id_tipo` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla inventario_hotel.tipo_habitacion: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
