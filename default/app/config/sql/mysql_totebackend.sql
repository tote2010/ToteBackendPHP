-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 09-01-2020 a las 13:29:14
-- Versión del servidor: 10.1.33-MariaDB
-- Versión de PHP: 7.2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `totebackend`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apps`
--

CREATE TABLE `apps` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `version` varchar(10) DEFAULT NULL,
  `version_name` varchar(10) DEFAULT NULL,
  `googleplay_link` varchar(200) DEFAULT NULL,
  `folder` varchar(50) NOT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` date DEFAULT NULL,
  `modified_in` date DEFAULT NULL,
  `active` tinyint(4) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `apps`
--

INSERT INTO `apps` (`id`, `name`, `version`, `version_name`, `googleplay_link`, `folder`, `logo`, `status`, `created_at`, `modified_in`, `active`) VALUES
(2, 'Nail Art', '8', '1.0.8', 'https://play.google.com/store/apps/details?id=com.itgapps.nailart', 'NailArt', '2019-05-31_09-05-28_nails_art_logo_512_512_2019x144.png', 'Published', '2018-10-20', '2019-05-31', 1),
(3, 'Make Up', '3', '1.0.3', 'https://play.google.com/store/apps/details?id=com.itgapps.makeup', 'MakeUp', '2019-05-31_09-06-03_logo_makeup_2019x192.png', 'Published', '2018-12-08', '2019-05-31', 1),
(4, 'HairStyles', '1', '1.0.0', NULL, 'HairStyles', '2019-05-31_12-02-06_hairstyle_tutorials_1.jpg', 'In Progress', '2019-05-31', '2019-05-31', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditorias`
--

CREATE TABLE `auditorias` (
  `id` int(11) NOT NULL,
  `usuarios_id` int(11) NOT NULL,
  `fecha_at` date NOT NULL,
  `accion_realizada` text NOT NULL,
  `tabla_afectada` varchar(150) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresa`
--

CREATE TABLE `empresa` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `domicilio` varchar(100) NOT NULL,
  `telefono1` varchar(20) NOT NULL,
  `telefono2` varchar(20) DEFAULT NULL,
  `cuit` varchar(13) NOT NULL,
  `img_data_fiscal` varchar(100) DEFAULT NULL,
  `link_data_fiscal` varchar(100) DEFAULT NULL,
  `linkedin` varchar(100) DEFAULT NULL,
  `facebook` varchar(100) DEFAULT NULL,
  `twitter` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `menus_id` int(11) DEFAULT NULL,
  `recursos_id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `url` varchar(100) NOT NULL,
  `posicion` int(11) NOT NULL DEFAULT '100',
  `clases` varchar(50) DEFAULT NULL,
  `icon_fa` varchar(60) DEFAULT NULL,
  `visible_en` int(11) NOT NULL DEFAULT '1',
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `menus`
--

INSERT INTO `menus` (`id`, `menus_id`, `recursos_id`, `nombre`, `url`, `posicion`, `clases`, `icon_fa`, `visible_en`, `activo`) VALUES
(3, 18, 2, 'Roles', 'admin/roles', 20, NULL, NULL, 2, 1),
(4, 18, 3, 'Recursos', 'admin/recursos', 30, NULL, NULL, 2, 1),
(5, 18, 4, 'Menu', 'admin/menu', 100, NULL, NULL, 2, 1),
(7, 18, 5, 'Privilegios', 'admin/privilegios', 90, NULL, NULL, 2, 1),
(18, NULL, 63, 'Develop (Backend)', 'admin/develop', 100, NULL, 'cog', 2, 1),
(19, 62, 14, 'Mi Perfil', 'admin/usuarios/perfil', 90, NULL, NULL, 2, 1),
(21, 18, 15, 'Config. Aplicacion', 'admin', 1000, NULL, NULL, 2, 1),
(23, NULL, 19, 'index', 'index/index', 1000, NULL, NULL, 1, 1),
(59, NULL, 64, 'Settings', 'admin/settings', 200, NULL, 'cogs', 2, 1),
(62, NULL, 15, 'Administración', 'admin/index', 50, NULL, 'tachometer', 2, 1),
(63, 62, 1, 'Usuarios', 'admin/usuarios', 100, NULL, NULL, 2, 1),
(64, 59, 66, 'Empresa', 'admin/empresa/index', 10, NULL, NULL, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos`
--

CREATE TABLE `recursos` (
  `id` int(11) NOT NULL,
  `modulo` varchar(50) DEFAULT NULL,
  `controlador` varchar(50) NOT NULL,
  `accion` varchar(50) DEFAULT NULL,
  `recurso` varchar(200) NOT NULL,
  `descripcion` text,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `recursos`
--

INSERT INTO `recursos` (`id`, `modulo`, `controlador`, `accion`, `recurso`, `descripcion`, `activo`) VALUES
(1, 'admin', 'usuarios', NULL, 'admin/usuarios/*', 'modulo para la administracion de los usuarios del sistema (modo desarrolador)', 1),
(2, 'admin', 'roles', NULL, 'admin/roles/*', 'modulo para la gestion de los roles de la aplicacion\r\n', 1),
(3, 'admin', 'recursos', NULL, 'admin/recursos/*', 'modulo para la gestion de los recursos de la aplicacion', 1),
(4, 'admin', 'menu', NULL, 'admin/menu/*', 'modulo para la administracion del menu en la app', 1),
(5, 'admin', 'privilegios', NULL, 'admin/privilegios/*', 'modulo para la administracion de los privilegios que tendra cada rol', 1),
(11, NULL, 'index', NULL, 'index/*', 'modulo inicial del sistema, donde se loguean los usuarios y donde se desloguean', 1),
(14, 'admin', 'usuarios', 'perfil', 'admin/usuarios/perfil', 'modulo para la configuracion del perfil del usuario', 1),
(15, 'admin', 'index', NULL, 'admin/index/*', 'modulo para la configuración del sistema', 1),
(17, 'admin', 'usuarios', 'index', 'admin/usuarios/index', 'modulo para listar los usuarios del sistema, lo usará¡ el menu administracion', 1),
(63, 'admin', 'develop', NULL, 'admin/develop/*', 'Recurso para menu \"Develop\"', 1),
(64, 'admin', 'settings', NULL, 'admin/settings/*', 'Recurso para menu \"Settings\"', 1),
(65, 'admin', 'usuarios', 'logout', 'admin/usuarios/logout', 'Logout', 1),
(66, 'admin', 'empresa', 'index', 'admin/empresa/index', 'Módulo \"Datos de la Empresa\"', 1),
(67, 'admin', 'perfil', NULL, 'admin/perfil/*', 'Perfil', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `plantilla` varchar(50) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`, `plantilla`, `activo`) VALUES
(1, 'usuario comun (empleado)', 'backend/backend', 1),
(2, 'usuario administrador (gerente)', 'backend/backend', 1),
(3, 'usuario (cliente)', 'default', 1),
(4, 'administrador del sistema', 'backend/backend', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_recursos`
--

CREATE TABLE `roles_recursos` (
  `id` int(11) NOT NULL,
  `roles_id` int(11) NOT NULL,
  `recursos_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `roles_recursos`
--

INSERT INTO `roles_recursos` (`id`, `roles_id`, `recursos_id`) VALUES
(895, 2, 25),
(896, 4, 25),
(899, 2, 26),
(900, 4, 26),
(901, 2, 24),
(902, 4, 24),
(926, 4, 18),
(937, 2, 27),
(938, 4, 27),
(1385, 1, 48),
(1386, 2, 48),
(1387, 4, 48),
(1404, 1, 20),
(1405, 2, 20),
(1406, 4, 20),
(1413, 4, 31),
(3606, 1, 59),
(3607, 2, 59),
(3608, 4, 59),
(3618, 1, 45),
(3619, 2, 45),
(3620, 4, 45),
(3621, 4, 33),
(3622, 1, 46),
(3623, 2, 46),
(3624, 4, 46),
(3625, 1, 57),
(3626, 2, 57),
(3627, 4, 57),
(3628, 1, 54),
(3629, 2, 54),
(3630, 4, 54),
(3631, 1, 47),
(3632, 2, 47),
(3633, 4, 47),
(3634, 2, 50),
(3635, 4, 50),
(3636, 4, 60),
(3637, 1, 55),
(3638, 2, 55),
(3639, 4, 55),
(3640, 1, 21),
(3641, 2, 21),
(3642, 4, 21),
(3643, 4, 35),
(3644, 1, 58),
(3645, 2, 58),
(3646, 4, 58),
(3647, 4, 32),
(3648, 1, 36),
(3649, 2, 36),
(3650, 4, 36),
(3651, 4, 30),
(3652, 1, 29),
(3653, 2, 29),
(3654, 4, 29),
(3655, 1, 49),
(3656, 2, 49),
(3657, 4, 49),
(3658, 1, 52),
(3659, 2, 52),
(3660, 4, 52),
(3661, 1, 23),
(3662, 2, 23),
(3663, 4, 23),
(3664, 1, 53),
(3665, 2, 53),
(3666, 4, 53),
(3667, 1, 28),
(3668, 2, 28),
(3669, 4, 28),
(3670, 2, 41),
(3671, 4, 41),
(3672, 2, 38),
(3673, 4, 38),
(3674, 2, 42),
(3675, 4, 42),
(3676, 2, 39),
(3677, 4, 39),
(3678, 2, 40),
(3679, 4, 40),
(3680, 1, 37),
(3681, 2, 37),
(3682, 4, 37),
(3683, 1, 44),
(3684, 2, 44),
(3685, 2, 43),
(3686, 4, 43),
(3690, 1, 19),
(3691, 2, 19),
(3692, 4, 19),
(3693, 4, 34),
(3694, 1, 22),
(3695, 2, 22),
(3696, 4, 22),
(3905, 4, 62),
(3908, 4, 61),
(4301, 2, 68),
(4302, 4, 68),
(4303, 4, 63),
(4304, 2, 66),
(4305, 4, 66),
(4306, 1, 15),
(4307, 2, 15),
(4308, 4, 15),
(4309, 4, 4),
(4310, 2, 67),
(4311, 4, 67),
(4312, 4, 5),
(4313, 4, 3),
(4314, 2, 2),
(4315, 4, 2),
(4316, 2, 64),
(4317, 4, 64),
(4318, 2, 1),
(4319, 4, 1),
(4320, 4, 17),
(4321, 1, 65),
(4322, 2, 65),
(4323, 4, 65),
(4324, 1, 14),
(4325, 2, 14),
(4326, 4, 14),
(4327, 4, 86),
(4328, 4, 85),
(4329, 4, 80),
(4330, 4, 81),
(4331, 4, 82),
(4332, 4, 83),
(4333, 4, 84),
(4334, 1, 11),
(4335, 2, 11),
(4336, 4, 11),
(4337, 2, 79),
(4338, 4, 79),
(4339, 2, 74),
(4340, 4, 74),
(4341, 2, 75),
(4342, 4, 75),
(4343, 2, 76),
(4344, 4, 76),
(4345, 2, 77),
(4346, 4, 77),
(4347, 2, 78),
(4348, 4, 78),
(4349, 2, 69),
(4350, 4, 69),
(4351, 2, 70),
(4352, 4, 70),
(4353, 2, 71),
(4354, 4, 71),
(4355, 2, 72),
(4356, 4, 72),
(4357, 2, 73),
(4358, 4, 73);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles_usuarios`
--

CREATE TABLE `roles_usuarios` (
  `id` int(11) NOT NULL,
  `roles_id` int(11) NOT NULL,
  `usuarios_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `roles_usuarios`
--

INSERT INTO `roles_usuarios` (`id`, `roles_id`, `usuarios_id`) VALUES
(29, 1, 17),
(30, 4, 18),
(34, 2, 3),
(37, 2, 2),
(38, 4, 27),
(39, 1, 28),
(40, 2, 20),
(41, 1, 21),
(43, 4, 19),
(44, 3, 26),
(45, 1, 26),
(46, 2, 26),
(47, 4, 27),
(48, 2, 28),
(49, 2, 29),
(50, 2, 30),
(51, 2, 30),
(52, 1, 31),
(53, 1, 32),
(54, 2, 33),
(55, 2, 31),
(56, 1, 32),
(57, 4, 33),
(58, 1, 34),
(59, 4, 35),
(60, 4, 36),
(61, 2, 37),
(62, 1, 38);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `clave` varchar(40) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `domicilio` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `img` varchar(100) DEFAULT NULL,
  `activo` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `login`, `clave`, `nombres`, `apellido`, `telefono`, `celular`, `domicilio`, `email`, `img`, `activo`) VALUES
(36, 'admin', 'baPeZ2ZnhwtCs', 'Admin', 'Admin', NULL, NULL, NULL, 'admin@email.com', NULL, 1),
(37, 'gerente', 'baPeZ2ZnhwtCs', 'Gerente', 'Gerente', NULL, NULL, NULL, 'gerente@email.com', NULL, 1),
(38, 'empleado', 'baPeZ2ZnhwtCs', 'Empleado', 'Empleado', NULL, NULL, NULL, 'empleado@email.com', NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apps`
--
ALTER TABLE `apps`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuarios_id` (`usuarios_id`);

--
-- Indices de la tabla `empresa`
--
ALTER TABLE `empresa`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menus_id` (`menus_id`),
  ADD KEY `recursos_id` (`recursos_id`);

--
-- Indices de la tabla `recursos`
--
ALTER TABLE `recursos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rol` (`rol`);

--
-- Indices de la tabla `roles_recursos`
--
ALTER TABLE `roles_recursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_id` (`roles_id`),
  ADD KEY `recursos_id` (`recursos_id`);

--
-- Indices de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roles_id` (`roles_id`),
  ADD KEY `usuarios_id` (`usuarios_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `apps`
--
ALTER TABLE `apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `auditorias`
--
ALTER TABLE `auditorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresa`
--
ALTER TABLE `empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `recursos`
--
ALTER TABLE `recursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `roles_recursos`
--
ALTER TABLE `roles_recursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4359;

--
-- AUTO_INCREMENT de la tabla `roles_usuarios`
--
ALTER TABLE `roles_usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
COMMIT;





/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
