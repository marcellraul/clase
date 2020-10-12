-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-10-2020 a las 07:08:10
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clase`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `precio` double NOT NULL,
  `stock` int(11) NOT NULL,
  `art_create` datetime NOT NULL DEFAULT current_timestamp(),
  `estatus` char(5) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id`, `descripcion`, `precio`, `stock`, `art_create`, `estatus`) VALUES
(1, 'primero', 1000, 10, '2020-10-11 02:25:12', 'A'),
(2, 'segundo', 2000, 5, '2020-10-11 02:25:47', 'A'),
(3, 'tercero', 3000, 15, '2020-10-11 02:25:47', 'A'),
(4, 'cuarto', 4400, 7, '2020-10-11 02:26:18', 'A'),
(6, 'marcell', 23423, 234, '2020-10-11 17:01:43', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clase`
--

CREATE TABLE `clase` (
  `id` int(11) NOT NULL,
  `clase` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fechacreada` datetime NOT NULL DEFAULT current_timestamp(),
  `estatus` char(5) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `clase`
--

INSERT INTO `clase` (`id`, `clase`, `fechacreada`, `estatus`) VALUES
(1, 'Calculo', '2020-10-11 17:56:22', 'A'),
(2, 'Quimica', '2020-10-11 17:56:22', 'A'),
(3, 'Programacion', '2020-10-11 17:56:37', 'A'),
(4, 'Estadistica', '2020-10-11 17:56:37', 'A'),
(5, 'Sistemas', '2020-10-11 17:56:50', 'A'),
(8, 'S.O', '2020-10-12 05:35:02', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `clases` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fechanac` date NOT NULL,
  `fechacreado` datetime NOT NULL DEFAULT current_timestamp(),
  `estatus` char(5) COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`id`, `nombre`, `clases`, `fechanac`, `fechacreado`, `estatus`) VALUES
(12, 'vale', 'Estadistica', '2020-01-24', '2020-10-12 01:17:54', 'A'),
(14, 'mario', 'Programacion', '2020-06-15', '2020-10-12 01:20:47', 'A'),
(15, 'hermes', 'Calculo', '2020-10-18', '2020-10-12 01:26:29', 'A'),
(20, 'orangel', 'Estadistica', '2020-05-18', '2020-10-12 02:16:36', 'A'),
(21, 'junior', 'Sistemas', '2020-07-15', '2020-10-12 02:18:55', 'A'),
(22, 'Marcell', 'Programacion', '2016-05-20', '2020-10-12 06:11:48', 'A'),
(23, 'Marcell', 'S.O', '2020-03-13', '2020-10-12 06:13:44', 'A');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clase`
--
ALTER TABLE `clase`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `clase`
--
ALTER TABLE `clase`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
