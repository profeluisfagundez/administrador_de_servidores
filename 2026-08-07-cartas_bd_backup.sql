/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: cartas
-- ------------------------------------------------------
-- Server version	10.11.18-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cartas`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cartas` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `cartas`;

--
-- Table structure for table `Administrador`
--

DROP TABLE IF EXISTS `Administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Administrador` (
  `IDUsuario` int(11) NOT NULL,
  PRIMARY KEY (`IDUsuario`),
  CONSTRAINT `Administrador_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Administrador`
--

LOCK TABLES `Administrador` WRITE;
/*!40000 ALTER TABLE `Administrador` DISABLE KEYS */;
/*!40000 ALTER TABLE `Administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Carta`
--

DROP TABLE IF EXISTS `Carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Carta` (
  `IDCarta` varchar(3) NOT NULL,
  `URL_Imagen` varchar(100) DEFAULT NULL,
  `Palo` varchar(10) DEFAULT NULL,
  `Numero` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`IDCarta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Carta`
--

LOCK TABLES `Carta` WRITE;
/*!40000 ALTER TABLE `Carta` DISABLE KEYS */;
/*!40000 ALTER TABLE `Carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contiene`
--

DROP TABLE IF EXISTS `Contiene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contiene` (
  `IDCarta` varchar(3) NOT NULL,
  `IDMano` int(11) NOT NULL,
  PRIMARY KEY (`IDCarta`,`IDMano`),
  KEY `IDMano` (`IDMano`),
  CONSTRAINT `Contiene_ibfk_1` FOREIGN KEY (`IDCarta`) REFERENCES `Carta` (`IDCarta`),
  CONSTRAINT `Contiene_ibfk_2` FOREIGN KEY (`IDMano`) REFERENCES `Mano` (`IDMano`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contiene`
--

LOCK TABLES `Contiene` WRITE;
/*!40000 ALTER TABLE `Contiene` DISABLE KEYS */;
/*!40000 ALTER TABLE `Contiene` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Juega`
--

DROP TABLE IF EXISTS `Juega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Juega` (
  `IDUsuario` int(11) NOT NULL,
  `IDPartida` int(11) NOT NULL,
  PRIMARY KEY (`IDUsuario`,`IDPartida`),
  KEY `IDPartida` (`IDPartida`),
  CONSTRAINT `Juega_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`),
  CONSTRAINT `Juega_ibfk_2` FOREIGN KEY (`IDPartida`) REFERENCES `Partida` (`IDPartida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Juega`
--

LOCK TABLES `Juega` WRITE;
/*!40000 ALTER TABLE `Juega` DISABLE KEYS */;
/*!40000 ALTER TABLE `Juega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Jugador`
--

DROP TABLE IF EXISTS `Jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Jugador` (
  `IDUsuario` int(11) NOT NULL,
  `Contra` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`IDUsuario`),
  CONSTRAINT `Jugador_ibfk_1` FOREIGN KEY (`IDUsuario`) REFERENCES `Usuario` (`IDUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Jugador`
--

LOCK TABLES `Jugador` WRITE;
/*!40000 ALTER TABLE `Jugador` DISABLE KEYS */;
INSERT INTO `Jugador` VALUES
(1,'$2y$12$1iFZT0E2PTw8t3FFvrmGheAJWAtgwQhg0GFDaz1zl./1zXb/Wezz.'),
(2,'$2y$12$bDPNqEj.Pxit1noGfaLsw.ECu12M7nHPe6ElmT4g6gZm8a1.rr/1W');
/*!40000 ALTER TABLE `Jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mano`
--

DROP TABLE IF EXISTS `Mano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mano` (
  `IDMano` int(11) NOT NULL AUTO_INCREMENT,
  `IDUsuario` int(11) DEFAULT NULL,
  `IDPartida` int(11) DEFAULT NULL,
  PRIMARY KEY (`IDMano`),
  KEY `IDUsuario` (`IDUsuario`,`IDPartida`),
  CONSTRAINT `Mano_ibfk_1` FOREIGN KEY (`IDUsuario`, `IDPartida`) REFERENCES `Juega` (`IDUsuario`, `IDPartida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mano`
--

LOCK TABLES `Mano` WRITE;
/*!40000 ALTER TABLE `Mano` DISABLE KEYS */;
/*!40000 ALTER TABLE `Mano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Partida`
--

DROP TABLE IF EXISTS `Partida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Partida` (
  `IDPartida` int(11) NOT NULL AUTO_INCREMENT,
  `FechaHora` datetime DEFAULT NULL,
  `Ganador` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDPartida`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Partida`
--

LOCK TABLES `Partida` WRITE;
/*!40000 ALTER TABLE `Partida` DISABLE KEYS */;
/*!40000 ALTER TABLE `Partida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `IDUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IDUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES
(1,'lfagundez'),
(2,'pepito');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'cartas'
--

--
-- Dumping routines for database 'cartas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-07 10:58:13
