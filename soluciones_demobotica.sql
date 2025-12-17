-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 08-08-2023 a las 13:11:28
-- Versión del servidor: 10.6.14-MariaDB-cll-lve
-- Versión de PHP: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `soluciones_demobotica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `unidad_medida` varchar(45) NOT NULL,
  `descripcion_otros` varchar(45) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `afectacion` varchar(20) NOT NULL,
  `stock_salida` int(11) NOT NULL,
  `stock_ingreso` int(11) NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `id_tipo_venta_articulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `unidad_medida`, `descripcion_otros`, `condicion`, `afectacion`, `stock_salida`, `stock_ingreso`, `fecha_vencimiento`, `id_tipo_venta_articulo`) VALUES
(1, 85, '', 'IPUPROFENO', 2, 'PARA ALIVIAR EL DOLOR', '', 'NIU', '', 1, 'Gravado', 8, 10, '0000-00-00', 0),
(2, 85, '', 'ASPIRINA', 0, 'PARA BAJAR LA FIEBRE', '', 'NIU', '', 1, 'Gravado', 0, 0, '0000-00-00', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(77, 'vitrina', '', 1),
(78, 'Anaquel', '', 1),
(79, 'Almacen', '', 1),
(85, 'GRUPO-03', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `confidencial`
--

CREATE TABLE `confidencial` (
  `idconfidencial` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` varchar(8) NOT NULL,
  `fecha` datetime NOT NULL,
  `gastos_totales` decimal(11,2) NOT NULL,
  `compras` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE `cotizacion` (
  `idcotizacion` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL,
  `serie` varchar(100) DEFAULT NULL,
  `referencia` varchar(100) NOT NULL,
  `validez` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `laboratorio` varchar(100) NOT NULL,
  `codigo` varchar(100) NOT NULL,
  `lote` varchar(100) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `incentivo` decimal(11,2) NOT NULL,
  `fecha_vencimiento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `laboratorio`, `codigo`, `lote`, `cantidad`, `precio_compra`, `precio_venta`, `incentivo`, `fecha_vencimiento`) VALUES
(4, 4, 1, 'ANACLETO', '85', '27', 10, 1.50, 2.00, 0.00, '2023-06-30');

--
-- Disparadores `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updtStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN 
UPDATE articulo SET stock = stock + NEW.cantidad, stock_ingreso=stock_ingreso + NEW.cantidad
WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_proforma`
--

CREATE TABLE `detalle_proforma` (
  `iddetalle_proforma` int(11) NOT NULL,
  `idproforma` int(11) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(9,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_puntos`
--

CREATE TABLE `detalle_puntos` (
  `id_detalle_puntos` int(11) NOT NULL,
  `id_puntos` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `puntos` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Disparadores `detalle_puntos`
--
DELIMITER $$
CREATE TRIGGER `tr_updtStockPuntos` AFTER INSERT ON `detalle_puntos` FOR EACH ROW BEGIN
	UPDATE productos SET stock = stock - NEW.cantidad
	WHERE productos.id_producto = NEW.id_producto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL,
  `fecha_mas_vendido` datetime DEFAULT NULL,
  `item` int(11) NOT NULL,
  `serie` varchar(100) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=REDUNDANT;

--
-- Volcado de datos para la tabla `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`, `fecha_mas_vendido`, `item`, `serie`, `estado`) VALUES
(6, 8, 1, 2, 2.00, 0.00, '2023-06-12 21:02:19', 1, '', 'Aceptado'),
(7, 9, 1, 1, 2.00, 0.00, '2023-06-13 16:57:07', 1, '', 'Aceptado'),
(8, 12, 1, 1, 2.00, 0.00, '2023-06-13 17:14:57', 1, '', 'Aceptado'),
(9, 14, 1, 1, 2.00, 0.00, '2023-06-13 17:22:57', 1, '', 'Aceptado'),
(10, 16, 1, 1, 2.00, 0.00, '2023-06-13 17:23:42', 1, '', 'Aceptado'),
(11, 17, 1, 1, 2.00, 0.00, '2023-06-13 17:24:04', 1, '', 'Aceptado'),
(12, 20, 1, 1, 2.00, 0.00, '2023-06-13 17:25:48', 1, '', 'Aceptado');

--
-- Disparadores `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updtStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
	IF(NEW.estado != 'Cancelado' || NEW.estado = null ) THEN
		UPDATE articulo SET stock = stock - NEW.cantidad,
		stock_salida=stock_salida + NEW.cantidad
		WHERE articulo.idarticulo = NEW.idarticulo;
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_entrega`
--

CREATE TABLE `estado_entrega` (
  `cancelado` int(10) NOT NULL,
  `pendiente_entrega` int(10) NOT NULL,
  `sin_servicio` int(10) NOT NULL,
  `por_servicio` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_pago`
--

CREATE TABLE `estado_pago` (
  `pendiente_pago` int(11) NOT NULL,
  `pagado_pago` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `num_cuotas` int(11) DEFAULT NULL,
  `valor_cuota` decimal(11,2) DEFAULT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `num_cuotas`, `valor_cuota`, `total_compra`, `estado`) VALUES
(4, 8, 1, 'Boleta', '02', '27', '2023-06-12 00:00:00', 0.00, NULL, NULL, 15.00, 'Aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moneda`
--

CREATE TABLE `moneda` (
  `idmoneda` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `simbolo` varchar(45) NOT NULL,
  `codigo` varchar(5) NOT NULL,
  `pais_referencia` varchar(100) DEFAULT NULL,
  `num` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `moneda`
--

INSERT INTO `moneda` (`idmoneda`, `descripcion`, `simbolo`, `codigo`, `pais_referencia`, `num`) VALUES
(1, 'Nuevo Sol', 'S/.', 'PEN', 'PERU', '604');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `motivo_documento`
--

CREATE TABLE `motivo_documento` (
  `idmotivo_documento` int(11) NOT NULL,
  `codigo_motivo` varchar(5) NOT NULL,
  `motivo` varchar(100) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `motivo_documento`
--

INSERT INTO `motivo_documento` (`idmotivo_documento`, `codigo_motivo`, `motivo`, `descripcion`) VALUES
(1, '01', 'Anulación de la operación', NULL),
(2, '02', 'Anulación por error en el RUC', NULL),
(3, '03', 'Corrección por error  en la descripcion', NULL),
(4, '04', 'Descuento  global', NULL),
(5, '05', 'Descuento por Item', NULL),
(6, '06', 'Devolución  total', NULL),
(7, '07', 'Devolución parcial', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notacredito`
--

CREATE TABLE `notacredito` (
  `idnota_credito` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL,
  `correccion_descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `notacredito`
--

INSERT INTO `notacredito` (`idnota_credito`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`, `correccion_descripcion`) VALUES
(3, 10, 1, 1, 2.00, 0.00, ''),
(4, 11, 1, 2, 2.00, 0.00, ''),
(5, 13, 1, 1, 2.00, 0.00, ''),
(6, 15, 1, 1, 2.00, 0.00, ''),
(7, 18, 1, 1, 2.00, 0.00, ''),
(8, 19, 1, 1, 2.00, 0.00, ''),
(9, 21, 1, 1, 2.00, 0.00, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `idpago` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `valor_cuota` decimal(10,2) NOT NULL,
  `fecha_pago` datetime NOT NULL,
  `estado` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `perfil`
--

CREATE TABLE `perfil` (
  `idperfil` int(11) NOT NULL,
  `razon_social` varchar(200) NOT NULL,
  `nombre_comercial` varchar(100) DEFAULT NULL,
  `ruc` varchar(45) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `distrito` varchar(50) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `departamento` varchar(50) NOT NULL,
  `codigo_postal` varchar(100) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `email` varchar(80) NOT NULL,
  `logo` varchar(256) NOT NULL,
  `pais` varchar(45) NOT NULL,
  `ubigeo` varchar(45) DEFAULT NULL,
  `ubicacion` varchar(50) DEFAULT NULL,
  `direccion2` varchar(255) DEFAULT NULL,
  `sitio_web` varchar(255) DEFAULT NULL,
  `fecha_autorizacion` date DEFAULT NULL,
  `publicidad` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `perfil`
--

INSERT INTO `perfil` (`idperfil`, `razon_social`, `nombre_comercial`, `ruc`, `direccion`, `distrito`, `provincia`, `departamento`, `codigo_postal`, `telefono`, `email`, `logo`, `pais`, `ubigeo`, `ubicacion`, `direccion2`, `sitio_web`, `fecha_autorizacion`, `publicidad`) VALUES
(1, 'Soluciones Integrales JB SAC', 'soluciones integrales jb sac', '10410697551', 'Lopez de Zuñiga N°  254', 'Chancay', 'Huaral', 'Huaral', '15131', '996720630', 'wilderjulca@solucionesintegralesjb.com', 'sijb.png', 'Perú', '', '', 'Av.Las Rosas 385 Luriama', 'facebook.com', '2023-05-18', 'senati');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acesso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas'),
(8, 'Administracion'),
(9, 'Configuracion'),
(10, 'contabilidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `razon_social` varchar(256) DEFAULT NULL,
  `puntos` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `razon_social`, `puntos`) VALUES
(8, 'Proveedor', 'SUNSETCHANCAY E.I.R.L.', 'DNI', '78876554', 'Lopez de Zuñiga N° 254 Chancay', '987654321', 'ventas@solucionesintegralesjb.com', 'livias', 0),
(9, 'Cliente', 'Livias Valenzuela', 'DNI', '78876554', 'JUNIOR TUPAC AMARU', '978654567', 'livias1245@gmail.com', 'livias', 16);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `puntos` int(11) DEFAULT 0,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nombre`, `codigo`, `stock`, `puntos`, `condicion`) VALUES
(6, 'TELEVISOR', 'TLE-452', 48, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proforma`
--

CREATE TABLE `proforma` (
  `idproforma` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `correlativo` varchar(10) NOT NULL,
  `referencia` varchar(100) NOT NULL,
  `tipo_proforma` varchar(20) NOT NULL,
  `igv_total` decimal(11,2) NOT NULL,
  `total_venta` decimal(9,2) NOT NULL,
  `fecha_hora` date NOT NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puntos`
--

CREATE TABLE `puntos` (
  `id_puntos` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` varchar(8) NOT NULL,
  `fecha` date NOT NULL,
  `total_puntos_descontados` int(11) NOT NULL,
  `estado` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_comprobante`
--

CREATE TABLE `tipo_comprobante` (
  `codigotipo_comprobante` int(11) NOT NULL,
  `descripcion_tipo_comprobante` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `tipo_comprobante`
--

INSERT INTO `tipo_comprobante` (`codigotipo_comprobante`, `descripcion_tipo_comprobante`) VALUES
(1, 'Factura'),
(3, 'Boleta de Venta'),
(7, 'Nota de Credito'),
(8, 'Guia de Remisión Remitente'),
(10, 'Cotizacion'),
(11, 'Credito'),
(12, 'Ticket'),
(13, 'Prestamo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `codigotipo_pago` int(11) NOT NULL,
  `descripcion_tipo_pago` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tipo_pago`
--

INSERT INTO `tipo_pago` (`codigotipo_pago`, `descripcion_tipo_pago`) VALUES
(1, 'Contado'),
(2, 'Credito'),
(3, 'Transferencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_venta_articulo`
--

CREATE TABLE `tipo_venta_articulo` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `tipo_venta_articulo`
--

INSERT INTO `tipo_venta_articulo` (`id`, `descripcion`, `estado`) VALUES
(1, 'Venta con receta médica', 1),
(2, 'Venta sin receta médica', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transporte`
--

CREATE TABLE `transporte` (
  `idtansporte` int(11) NOT NULL,
  `idvehiculo` int(11) NOT NULL,
  `direccion_partida` varchar(200) NOT NULL,
  `direccion_llegada` varchar(200) NOT NULL,
  `hora_salida` datetime NOT NULL,
  `hora_llegada` datetime DEFAULT NULL,
  `condicion` varchar(45) DEFAULT NULL,
  `motivo_traslado` varchar(200) DEFAULT NULL,
  `unidad_medida_peso_bruto` varchar(20) DEFAULT NULL,
  `ubigeo_partida` varchar(45) DEFAULT NULL,
  `ubigeo_llegada` varchar(45) DEFAULT NULL,
  `modalidad_traslado` varchar(25) DEFAULT NULL,
  `idguia_remision` int(11) DEFAULT NULL,
  `iddestinatario` int(11) DEFAULT NULL,
  `idarticulo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `id_ubicacion` int(11) NOT NULL,
  `almacen` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ubicacion`
--

INSERT INTO `ubicacion` (`id_ubicacion`, `almacen`) VALUES
(1, 'Anaquel 1'),
(2, 'Anaquel 2'),
(3, 'Anaquel 3'),
(4, 'Vitrina'),
(5, 'Almacen');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1,
  `incentivo_total` decimal(11,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`, `incentivo_total`) VALUES
(1, 'Soluciones Integrales', 'RUC', '10410697551', 'Lopez de Zuñiga N° 254 Chancay', '996720630', 'ventas@solucionesintegralesjb.com', 'Administrador', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1580835465.png', 1, 76.50),
(2, 'Wilder Julca  Broncano', 'DNI', '41069755', 'Lopez de Zuñiga N° 254', '996720630', 'wilderjulca@solucionesintegralesjb.com', 'Administrador', 'julca', '76aee384f4ad1938f1d7e370dd102cf4e731870a0610a147eb8367d600fcb69c', '1580835510.png', 1, 1.60),
(4, 'Trakoma20', 'RUC', '10410697551', 'Lopez de Zuñiga N° 254 Chancay', '996720630', 'david@123.com', 'Administrador', 'admin2', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(83, 3, 1),
(84, 3, 2),
(85, 3, 4),
(86, 3, 10),
(120, 5, 1),
(121, 5, 2),
(122, 5, 3),
(123, 5, 4),
(124, 5, 6),
(125, 5, 7),
(126, 5, 8),
(127, 5, 9),
(128, 5, 10),
(129, 5, 11),
(141, 2, 1),
(142, 2, 2),
(143, 2, 3),
(144, 2, 4),
(145, 2, 5),
(146, 2, 6),
(147, 2, 7),
(148, 2, 8),
(149, 2, 9),
(150, 2, 10),
(151, 2, 11),
(166, 0, 1),
(167, 5, 1),
(168, 5, 2),
(169, 5, 3),
(170, 5, 4),
(171, 5, 5),
(172, 5, 6),
(173, 5, 7),
(174, 6, 1),
(175, 7, 1),
(176, 7, 2),
(177, 8, 1),
(178, 8, 2),
(179, 8, 3),
(180, 9, 1),
(181, 9, 2),
(182, 9, 3),
(183, 9, 4),
(184, 10, 1),
(185, 10, 2),
(186, 10, 3),
(187, 10, 4),
(188, 10, 5),
(189, 11, 1),
(190, 11, 2),
(191, 11, 3),
(192, 11, 4),
(193, 11, 5),
(194, 11, 6),
(195, 12, 1),
(196, 12, 2),
(197, 12, 3),
(198, 12, 4),
(199, 12, 5),
(200, 12, 6),
(201, 12, 7),
(202, 13, 1),
(203, 13, 2),
(204, 13, 3),
(205, 13, 4),
(206, 13, 5),
(207, 13, 6),
(208, 13, 7),
(209, 14, 1),
(210, 14, 2),
(211, 14, 3),
(226, 15, 1),
(227, 15, 2),
(228, 15, 3),
(229, 15, 4),
(230, 15, 5),
(231, 15, 6),
(232, 16, 1),
(233, 16, 2),
(234, 16, 3),
(235, 16, 4),
(236, 16, 6),
(237, 16, 8),
(238, 16, 10),
(239, 17, 1),
(240, 17, 2),
(241, 17, 3),
(242, 17, 4),
(243, 17, 7),
(244, 17, 8),
(245, 17, 10),
(253, 4, 1),
(254, 4, 2),
(255, 4, 3),
(256, 4, 4),
(257, 4, 7),
(258, 4, 8),
(259, 4, 10),
(293, 18, 1),
(294, 18, 2),
(295, 18, 3),
(296, 18, 4),
(297, 18, 5),
(298, 18, 6),
(299, 18, 7),
(300, 18, 8),
(301, 18, 9),
(302, 19, 1),
(303, 0, 1),
(304, 0, 2),
(305, 0, 1),
(306, 0, 2),
(307, 22, 1),
(308, 22, 2),
(309, 23, 1),
(310, 23, 2),
(311, 23, 3),
(312, 23, 4),
(313, 23, 5),
(314, 23, 6),
(315, 23, 7),
(316, 23, 8),
(317, 23, 9),
(321, 0, 1),
(322, 0, 2),
(323, 26, 1),
(324, 26, 2),
(325, 27, 1),
(326, 27, 2),
(327, 28, 1),
(328, 28, 2),
(329, 29, 1),
(330, 29, 2),
(331, 24, 1),
(332, 24, 2),
(333, 24, 3),
(334, 24, 4),
(335, 24, 5),
(336, 24, 6),
(337, 24, 7),
(338, 24, 8),
(339, 24, 9),
(340, 24, 10),
(351, 1, 1),
(352, 1, 2),
(353, 1, 3),
(354, 1, 4),
(355, 1, 5),
(356, 1, 6),
(357, 1, 7),
(358, 1, 8),
(359, 1, 9),
(360, 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valor_cambio`
--

CREATE TABLE `valor_cambio` (
  `idvalor_cambio` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `valor_compra` decimal(4,3) NOT NULL,
  `valor_venta` decimal(4,3) NOT NULL,
  `idmoneda` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `idvehiculo` int(11) NOT NULL,
  `idconductor` int(11) NOT NULL,
  `placa` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `soat` varchar(80) DEFAULT NULL,
  `marca` varchar(45) NOT NULL,
  `idempresa_transportista` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `codigotipo_comprobante` int(11) NOT NULL,
  `serie` varchar(4) NOT NULL,
  `correlativo` varchar(8) NOT NULL,
  `fecha_hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `impuesto` decimal(4,2) DEFAULT NULL,
  `op_gravadas` decimal(11,2) DEFAULT NULL,
  `op_inafectas` decimal(11,2) DEFAULT NULL,
  `op_exoneradas` decimal(11,2) DEFAULT NULL,
  `op_gratuitas` decimal(11,2) DEFAULT NULL,
  `isc` decimal(11,2) DEFAULT NULL,
  `total_descuentos` decimal(11,2) NOT NULL,
  `total_igv` decimal(11,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `leyenda` varchar(255) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `idmoneda` int(11) NOT NULL,
  `idmotivo_doc` int(11) DEFAULT NULL,
  `sustento` varchar(200) DEFAULT NULL,
  `doc_relacionado` int(11) DEFAULT NULL,
  `codigotipo_pago` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `codigotipo_comprobante`, `serie`, `correlativo`, `fecha_hora`, `impuesto`, `op_gravadas`, `op_inafectas`, `op_exoneradas`, `op_gratuitas`, `isc`, `total_descuentos`, `total_igv`, `total_venta`, `leyenda`, `estado`, `idmoneda`, `idmotivo_doc`, `sustento`, `doc_relacionado`, `codigotipo_pago`) VALUES
(8, 9, 1, 3, 'B001', '00000001', '2023-06-13 22:07:54', 18.00, 3.39, 0.00, 0.00, 0.00, 0.00, 0.00, 0.61, 4.00, 'CUATRO  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(9, 9, 1, 3, 'B001', '00000002', '2023-06-13 21:58:06', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(10, 9, 1, 7, 'B001', '00000001', '2023-06-13 21:58:05', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 9, 0),
(11, 9, 1, 7, 'B001', '00000002', '2023-06-13 22:07:51', 18.00, 3.39, 0.00, 0.00, 0.00, 0.00, 0.00, 0.61, 4.00, 'CUATRO  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 8, 0),
(12, 9, 1, 3, 'B001', '00000003', '2023-06-13 22:15:34', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(13, 9, 1, 7, 'B001', '00000003', '2023-06-13 22:15:33', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 12, 0),
(14, 9, 2, 3, 'B001', '00000004', '2023-06-13 22:23:07', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(15, 9, 2, 7, 'B001', '00000004', '2023-06-13 22:23:07', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'POR DEVOLUCIÓN DEL PRODUCTO', 14, 0),
(16, 9, 1, 3, 'B001', '00000005', '2023-06-13 22:25:08', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(17, 9, 1, 3, 'B001', '00000006', '2023-06-13 22:24:28', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(18, 9, 1, 7, 'B001', '00000005', '2023-06-13 22:24:27', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 17, 0),
(19, 9, 1, 7, 'B001', '00000006', '2023-06-13 22:25:07', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 16, 0),
(20, 9, 1, 3, 'B001', '00000007', '2023-06-13 22:26:17', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y 00/100 SOLES', 'Anulado', 1, NULL, NULL, NULL, 1),
(21, 9, 1, 7, 'B001', '00000007', '2023-06-13 22:26:16', 18.00, 1.69, 0.00, 0.00, 0.00, 0.00, 0.00, 0.31, 2.00, 'DOS  Y /100 SOLES', 'AceptadoNC', 1, 1, 'por error', 20, 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `confidencial`
--
ALTER TABLE `confidencial`
  ADD PRIMARY KEY (`idconfidencial`),
  ADD KEY `confidencial_persona_fk` (`idpersona`),
  ADD KEY `confidencial_usuario_fk` (`idusuario`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  ADD PRIMARY KEY (`idcotizacion`),
  ADD KEY `fk_cotizacion_idventa_idx` (`idventa`),
  ADD KEY `fk_cotizacion_idarticulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_proforma`
--
ALTER TABLE `detalle_proforma`
  ADD PRIMARY KEY (`iddetalle_proforma`),
  ADD KEY `fk_detalle_proforma_proforma` (`idproforma`);

--
-- Indices de la tabla `detalle_puntos`
--
ALTER TABLE `detalle_puntos`
  ADD PRIMARY KEY (`id_detalle_puntos`),
  ADD KEY `fk_detalle_puntos` (`id_puntos`),
  ADD KEY `fk_detalle_productos` (`id_producto`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `moneda`
--
ALTER TABLE `moneda`
  ADD PRIMARY KEY (`idmoneda`);

--
-- Indices de la tabla `motivo_documento`
--
ALTER TABLE `motivo_documento`
  ADD PRIMARY KEY (`idmotivo_documento`);

--
-- Indices de la tabla `notacredito`
--
ALTER TABLE `notacredito`
  ADD PRIMARY KEY (`idnota_credito`),
  ADD KEY `fk_notaCredito_venta_idx` (`idventa`),
  ADD KEY `fk_notaCredito_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`idpago`),
  ADD KEY `FK_pago_ingreso` (`idingreso`);

--
-- Indices de la tabla `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`idperfil`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `proforma`
--
ALTER TABLE `proforma`
  ADD PRIMARY KEY (`idproforma`),
  ADD KEY `fk_proforma_usuario` (`idusuario`),
  ADD KEY `fk_proforma_persona` (`idcliente`);

--
-- Indices de la tabla `puntos`
--
ALTER TABLE `puntos`
  ADD PRIMARY KEY (`id_puntos`),
  ADD KEY `fk_puntos_usuario` (`idusuario`),
  ADD KEY `fk_puntos_persona` (`idcliente`);

--
-- Indices de la tabla `tipo_comprobante`
--
ALTER TABLE `tipo_comprobante`
  ADD PRIMARY KEY (`codigotipo_comprobante`);

--
-- Indices de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`codigotipo_pago`);

--
-- Indices de la tabla `tipo_venta_articulo`
--
ALTER TABLE `tipo_venta_articulo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `transporte`
--
ALTER TABLE `transporte`
  ADD PRIMARY KEY (`idtansporte`),
  ADD KEY `fk_transporte_vehiculo_idx` (`idvehiculo`),
  ADD KEY `fk_transporte_persona_idx` (`iddestinatario`),
  ADD KEY `fk_transporte_articulo_idx` (`idarticulo`),
  ADD KEY `fk_transporte_guia_remision_idx` (`idguia_remision`);

--
-- Indices de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD PRIMARY KEY (`id_ubicacion`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Indices de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `valor_cambio`
--
ALTER TABLE `valor_cambio`
  ADD PRIMARY KEY (`idvalor_cambio`),
  ADD KEY `fk_valor_cambio_moneda_idx` (`idmoneda`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`idvehiculo`),
  ADD KEY `fk_idconductor_idx` (`idconductor`),
  ADD KEY `fk_vehiculo_empresa_transportista_idx` (`idempresa_transportista`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`),
  ADD KEY `fk_venta_codigotipo_comp_idx` (`codigotipo_comprobante`),
  ADD KEY `fk_venta_moneda_idx` (`idmoneda`),
  ADD KEY `fk_venta_motivo_idx` (`idmotivo_doc`),
  ADD KEY `fk_venta_doc_relacionado_idx` (`doc_relacionado`) USING BTREE;

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT de la tabla `confidencial`
--
ALTER TABLE `confidencial`
  MODIFY `idconfidencial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
  MODIFY `idcotizacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `detalle_proforma`
--
ALTER TABLE `detalle_proforma`
  MODIFY `iddetalle_proforma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_puntos`
--
ALTER TABLE `detalle_puntos`
  MODIFY `id_detalle_puntos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `moneda`
--
ALTER TABLE `moneda`
  MODIFY `idmoneda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `motivo_documento`
--
ALTER TABLE `motivo_documento`
  MODIFY `idmotivo_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `notacredito`
--
ALTER TABLE `notacredito`
  MODIFY `idnota_credito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `idpago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `perfil`
--
ALTER TABLE `perfil`
  MODIFY `idperfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proforma`
--
ALTER TABLE `proforma`
  MODIFY `idproforma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `puntos`
--
ALTER TABLE `puntos`
  MODIFY `id_puntos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `codigotipo_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_venta_articulo`
--
ALTER TABLE `tipo_venta_articulo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `transporte`
--
ALTER TABLE `transporte`
  MODIFY `idtansporte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  MODIFY `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=361;

--
-- AUTO_INCREMENT de la tabla `valor_cambio`
--
ALTER TABLE `valor_cambio`
  MODIFY `idvalor_cambio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  MODIFY `idvehiculo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
