-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: deliveriesacceptancedb
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acceptanceitems`
--

DROP TABLE IF EXISTS `acceptanceitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acceptanceitems` (
  `AcceptanceItemID` int NOT NULL AUTO_INCREMENT,
  `AcceptanceID` int NOT NULL,
  `PriceID` int NOT NULL,
  `Weight` decimal(10,2) NOT NULL,
  PRIMARY KEY (`AcceptanceItemID`),
  KEY `fk_Acceptances_AcceptanceItems_idx` (`AcceptanceID`),
  KEY `fk_Products_AcceptanceItems_idx` (`PriceID`),
  CONSTRAINT `fk_Acceptances_AcceptanceItems` FOREIGN KEY (`AcceptanceID`) REFERENCES `acceptances` (`AcceptanceID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Prices_AcceptanceItems` FOREIGN KEY (`PriceID`) REFERENCES `prices` (`PriceID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acceptanceitems`
--

LOCK TABLES `acceptanceitems` WRITE;
/*!40000 ALTER TABLE `acceptanceitems` DISABLE KEYS */;
INSERT INTO `acceptanceitems` VALUES (36,18,12,100.00),(37,18,12,500.00),(38,18,12,1000.00),(39,18,14,250.00),(40,19,15,500.00),(41,19,15,1000.00),(42,19,16,1000.00),(43,19,16,1000.00),(44,20,12,2000.00);
/*!40000 ALTER TABLE `acceptanceitems` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-24 21:52:25
