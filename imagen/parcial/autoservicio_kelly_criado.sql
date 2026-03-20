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


-- Volcando estructura de base de datos para autoservicio
CREATE DATABASE IF NOT EXISTS `autoservicio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `autoservicio`;

-- Volcando estructura para tabla autoservicio.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `identificacion` varchar(20) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `telefono_principal` varchar(20) NOT NULL,
  `telefono_secundario` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `direccion` varchar(150) NOT NULL,
  `ciudad` varchar(50) NOT NULL,
  PRIMARY KEY (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.clientes: ~0 rows (aproximadamente)
INSERT IGNORE INTO `clientes` (`identificacion`, `nombre_completo`, `telefono_principal`, `telefono_secundario`, `correo`, `direccion`, `ciudad`) VALUES
	('1063618394', 'Juan Perez', '3137825212', '3147285626', 'juan@gmail.com', 'calll 40 #5-66', 'Aguachica');

-- Volcando estructura para tabla autoservicio.detalle_servicios_orden
CREATE TABLE IF NOT EXISTS `detalle_servicios_orden` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_orden` int(11) DEFAULT NULL,
  `codigo_servicio` int(11) DEFAULT NULL,
  `cedula_mecanico` varchar(20) DEFAULT NULL,
  `precio_real` decimal(10,2) DEFAULT NULL,
  `horas_trabajadas` decimal(4,2) DEFAULT NULL,
  `observaciones_tecnicas` text DEFAULT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_orden` (`id_orden`),
  KEY `codigo_servicio` (`codigo_servicio`),
  KEY `cedula_mecanico` (`cedula_mecanico`),
  CONSTRAINT `detalle_servicios_orden_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes_trabajo` (`id_orden`),
  CONSTRAINT `detalle_servicios_orden_ibfk_2` FOREIGN KEY (`codigo_servicio`) REFERENCES `servicios` (`codigo_servicio`),
  CONSTRAINT `detalle_servicios_orden_ibfk_3` FOREIGN KEY (`cedula_mecanico`) REFERENCES `mecanicos` (`cedula`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.detalle_servicios_orden: ~1 rows (aproximadamente)
INSERT IGNORE INTO `detalle_servicios_orden` (`id_detalle`, `id_orden`, `codigo_servicio`, `cedula_mecanico`, `precio_real`, `horas_trabajadas`, `observaciones_tecnicas`) VALUES
	(123, 1, 1063, '1089374789', 345.50, 3.00, 'todo en orden');

-- Volcando estructura para tabla autoservicio.mecanicos
CREATE TABLE IF NOT EXISTS `mecanicos` (
  `cedula` varchar(20) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `especialidad_principal` enum('Motor','Frenos','Electricidad','Transmision','Suspension','Aire acondicionado') NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `estado` enum('Activo','Inactivo') NOT NULL,
  PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.mecanicos: ~0 rows (aproximadamente)
INSERT IGNORE INTO `mecanicos` (`cedula`, `nombre_completo`, `telefono`, `especialidad_principal`, `fecha_ingreso`, `estado`) VALUES
	('1089374789', 'Dodino Andres', '314256278', 'Motor', '2025-01-15', 'Activo');

-- Volcando estructura para tabla autoservicio.ordenes_trabajo
CREATE TABLE IF NOT EXISTS `ordenes_trabajo` (
  `id_orden` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_ingreso` date NOT NULL,
  `fecha_estimada_entrega` date DEFAULT NULL,
  `fecha_real_entrega` date DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `kilometraje_ingreso` int(11) DEFAULT NULL,
  `observaciones_cliente` text DEFAULT NULL,
  `diagnostico_mecanico` text DEFAULT NULL,
  `estado` enum('Recibido','En diagnostico','En reparacion','En espera de repuestos','Terminado','Entregado') NOT NULL,
  PRIMARY KEY (`id_orden`),
  KEY `placa_vehiculo` (`placa_vehiculo`),
  CONSTRAINT `ordenes_trabajo_ibfk_1` FOREIGN KEY (`placa_vehiculo`) REFERENCES `vehiculos` (`placa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.ordenes_trabajo: ~0 rows (aproximadamente)
INSERT IGNORE INTO `ordenes_trabajo` (`id_orden`, `fecha_ingreso`, `fecha_estimada_entrega`, `fecha_real_entrega`, `placa_vehiculo`, `kilometraje_ingreso`, `observaciones_cliente`, `diagnostico_mecanico`, `estado`) VALUES
	(1, '2026-03-13', '2026-03-13', '2026-03-13', 'ABX-123', 3120, 'Tiene idea de su vehiculo', 'Tiene bien cuidaado el vehiculo', 'Recibido');

-- Volcando estructura para tabla autoservicio.repuestos
CREATE TABLE IF NOT EXISTS `repuestos` (
  `codigo_repuesto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL,
  `cantidad_stock` int(11) DEFAULT NULL,
  `cantidad_minima` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo_repuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.repuestos: ~1 rows (aproximadamente)
INSERT IGNORE INTO `repuestos` (`codigo_repuesto`, `nombre`, `descripcion`, `marca`, `precio_compra`, `precio_venta`, `cantidad_stock`, `cantidad_minima`) VALUES
	(1021, 'Filtro de aceite', 'Ayuda a controlar el flujo de aceite', 'nissan', 120000.00, 170000.00, 6, 2);

-- Volcando estructura para tabla autoservicio.repuestos_orden
CREATE TABLE IF NOT EXISTS `repuestos_orden` (
  `id_registro` int(11) NOT NULL AUTO_INCREMENT,
  `id_orden` int(11) DEFAULT NULL,
  `codigo_repuesto` int(11) DEFAULT NULL,
  `cantidad_usada` int(11) DEFAULT NULL,
  `precio_unitario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_registro`),
  KEY `id_orden` (`id_orden`),
  KEY `codigo_repuesto` (`codigo_repuesto`),
  CONSTRAINT `repuestos_orden_ibfk_1` FOREIGN KEY (`id_orden`) REFERENCES `ordenes_trabajo` (`id_orden`),
  CONSTRAINT `repuestos_orden_ibfk_2` FOREIGN KEY (`codigo_repuesto`) REFERENCES `repuestos` (`codigo_repuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.repuestos_orden: ~0 rows (aproximadamente)
INSERT IGNORE INTO `repuestos_orden` (`id_registro`, `id_orden`, `codigo_repuesto`, `cantidad_usada`, `precio_unitario`) VALUES
	(1, 1, 1021, 2, 170000);

-- Volcando estructura para tabla autoservicio.servicios
CREATE TABLE IF NOT EXISTS `servicios` (
  `codigo_servicio` int(11) NOT NULL,
  `nombre_servicio` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `categoria` enum('Mantenimiento preventivo','Reparacion','Diagnostico','Latoneria y pintura') NOT NULL,
  `precio_base_estimado` int(11) NOT NULL,
  `tiempo_estimado_horas` int(11) NOT NULL,
  PRIMARY KEY (`codigo_servicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.servicios: ~0 rows (aproximadamente)
INSERT IGNORE INTO `servicios` (`codigo_servicio`, `nombre_servicio`, `descripcion`, `categoria`, `precio_base_estimado`, `tiempo_estimado_horas`) VALUES
	(1063, 'Revision preventiva', 'Se revisa el funcionamiento del motor', 'Diagnostico', 500, 3);

-- Volcando estructura para tabla autoservicio.vehiculos
CREATE TABLE IF NOT EXISTS `vehiculos` (
  `placa` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `año_Fabricacion` int(11) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `tipo_combustible` enum('Gasolina','Diesel','Electrico','Hibrido','Gas') DEFAULT NULL,
  `Numero_Color` varchar(50) DEFAULT NULL,
  `Kilometraje` varchar(50) DEFAULT NULL,
  `identificacion_cliente` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`placa`),
  KEY `identificacion_cliente` (`identificacion_cliente`),
  CONSTRAINT `vehiculos_ibfk_1` FOREIGN KEY (`identificacion_cliente`) REFERENCES `clientes` (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla autoservicio.vehiculos: ~1 rows (aproximadamente)
INSERT IGNORE INTO `vehiculos` (`placa`, `marca`, `modelo`, `año_Fabricacion`, `color`, `tipo_combustible`, `Numero_Color`, `Kilometraje`, `identificacion_cliente`) VALUES
	('ABX-123', 'nissan', '2026', 2025, 'gris', 'Diesel', '2', '3120', '1063618394');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
