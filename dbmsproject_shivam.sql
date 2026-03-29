-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: dbms_project
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `case_details`
--
CREATE DATABASE dbms_project;
USE dbms_project;

DROP TABLE IF EXISTS `case_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_details` (
  `case_id` int NOT NULL,
  `fir_id` int DEFAULT NULL,
  `judgement` text,
  `case_status` varchar(20) DEFAULT NULL,
  `filing_date` date DEFAULT NULL,
  `judgement_date` date DEFAULT NULL,
  PRIMARY KEY (`case_id`),
  UNIQUE KEY `fir_id` (`fir_id`),
  CONSTRAINT `case_details_ibfk_1` FOREIGN KEY (`fir_id`) REFERENCES `fir` (`fir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_details`
--

LOCK TABLES `case_details` WRITE;
/*!40000 ALTER TABLE `case_details` DISABLE KEYS */;
INSERT INTO `case_details` VALUES (201,101,'Pending','Ongoing','2025-12-02',NULL),(202,102,'Under Investigation','Ongoing','2025-12-06',NULL),(203,103,'Closed with fine','Closed','2025-12-11','2025-12-20');
/*!40000 ALTER TABLE `case_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `criminal`
--

DROP TABLE IF EXISTS `criminal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `criminal` (
  `cri_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `identification_mark` varchar(30) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`cri_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criminal`
--

LOCK TABLES `criminal` WRITE;
/*!40000 ALTER TABLE `criminal` DISABLE KEYS */;
INSERT INTO `criminal` VALUES (1,'Rohit Verma','Male','1995-06-15','Arrested','Scar on left cheek','Mumbai'),(2,'Sneha Sharma','Female','1998-09-22','Under Trial','Tattoo on wrist','Delhi'),(3,'Vikram Singh','Male','1990-12-10','Released','Burn mark on hand','Pune');
/*!40000 ALTER TABLE `criminal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evidence`
--

DROP TABLE IF EXISTS `evidence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evidence` (
  `evidence_id` int NOT NULL,
  `fir_id` int DEFAULT NULL,
  `evidence_type` varchar(30) DEFAULT NULL,
  `description` text,
  `collected_date` date DEFAULT NULL,
  PRIMARY KEY (`evidence_id`),
  KEY `fir_id` (`fir_id`),
  CONSTRAINT `evidence_ibfk_1` FOREIGN KEY (`fir_id`) REFERENCES `fir` (`fir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evidence`
--

LOCK TABLES `evidence` WRITE;
/*!40000 ALTER TABLE `evidence` DISABLE KEYS */;
INSERT INTO `evidence` VALUES (401,101,'CCTV Footage','Video from nearby shop','2025-12-01'),(402,102,'Bank Statement','Transaction proof','2025-12-05'),(403,103,'Weapon','Knife used in assault','2025-12-10');
/*!40000 ALTER TABLE `evidence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fir`
--

DROP TABLE IF EXISTS `fir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fir` (
  `fir_id` int NOT NULL,
  `fir_no` varchar(20) NOT NULL,
  `fir_date` date NOT NULL,
  `ps_id` int DEFAULT NULL,
  `cri_id` int DEFAULT NULL,
  `crime_type` varchar(80) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`fir_id`),
  UNIQUE KEY `fir_no` (`fir_no`),
  KEY `ps_id` (`ps_id`),
  KEY `cri_id` (`cri_id`),
  CONSTRAINT `fir_ibfk_1` FOREIGN KEY (`ps_id`) REFERENCES `police_station` (`ps_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fir_ibfk_2` FOREIGN KEY (`cri_id`) REFERENCES `criminal` (`cri_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fir`
--

LOCK TABLES `fir` WRITE;
/*!40000 ALTER TABLE `fir` DISABLE KEYS */;
INSERT INTO `fir` VALUES (101,'FIR2025-001','2025-12-01',1,1,'Theft','Mobile theft case in market'),(102,'FIR2025-002','2025-12-05',2,2,'Fraud','Online payment scam'),(103,'FIR2025-003','2025-12-10',3,3,'Assault','Physical fight in public area');
/*!40000 ALTER TABLE `fir` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `investigating_officer`
--

DROP TABLE IF EXISTS `investigating_officer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `investigating_officer` (
  `officer_id` int NOT NULL,
  `badge_no` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `officer_rank` varchar(30) DEFAULT NULL,
  `contact_no` varchar(15) DEFAULT NULL,
  `ps_id` int DEFAULT NULL,
  PRIMARY KEY (`officer_id`),
  UNIQUE KEY `badge_no` (`badge_no`),
  KEY `ps_id` (`ps_id`),
  CONSTRAINT `investigating_officer_ibfk_1` FOREIGN KEY (`ps_id`) REFERENCES `police_station` (`ps_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investigating_officer`
--

LOCK TABLES `investigating_officer` WRITE;
/*!40000 ALTER TABLE `investigating_officer` DISABLE KEYS */;
INSERT INTO `investigating_officer` VALUES (1,'B123','Inspector Raj Verma','Inspector','9001112233',1),(2,'B456','SI Neha Singh','Sub Inspector','9011122233',2),(3,'B789','ACP Arjun Patil','ACP','9022233445',3);
/*!40000 ALTER TABLE `investigating_officer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jail`
--

DROP TABLE IF EXISTS `jail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jail` (
  `jail_id` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `capacity` int DEFAULT NULL,
  `location` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`jail_id`),
  CONSTRAINT `jail_chk_1` CHECK ((`capacity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jail`
--

LOCK TABLES `jail` WRITE;
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
INSERT INTO `jail` VALUES (1,'Tihar Jail',5000,'Delhi'),(2,'Yerwada Jail',3000,'Pune'),(3,'Arthur Road Jail',2500,'Mumbai');
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jail_records`
--

DROP TABLE IF EXISTS `jail_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jail_records` (
  `record_id` int NOT NULL,
  `cri_id` int DEFAULT NULL,
  `jail_id` int DEFAULT NULL,
  `entry_date` date DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `sentence_duration` int DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `cri_id` (`cri_id`),
  KEY `jail_id` (`jail_id`),
  CONSTRAINT `jail_records_ibfk_1` FOREIGN KEY (`cri_id`) REFERENCES `criminal` (`cri_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jail_records_ibfk_2` FOREIGN KEY (`jail_id`) REFERENCES `jail` (`jail_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jail_records`
--

LOCK TABLES `jail_records` WRITE;
/*!40000 ALTER TABLE `jail_records` DISABLE KEYS */;
INSERT INTO `jail_records` VALUES (501,1,1,'2025-12-02',NULL,180),(502,2,2,'2025-12-06',NULL,365),(503,3,3,'2025-12-12','2025-12-20',30);
/*!40000 ALTER TABLE `jail_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `police_station`
--

DROP TABLE IF EXISTS `police_station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `police_station` (
  `ps_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  `district` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `contactno` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`ps_id`),
  UNIQUE KEY `unique_contact` (`contactno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `police_station`
--

LOCK TABLES `police_station` WRITE;
/*!40000 ALTER TABLE `police_station` DISABLE KEYS */;
INSERT INTO `police_station` VALUES (1,'Andheri Police Station','Mumbai Suburban','Maharashtra','9876543210'),(2,'Connaught Place Police Station','New Delhi','Delhi','9123456780'),(3,'Shivajinagar Police Station','Pune','Maharashtra','9988776655');
/*!40000 ALTER TABLE `police_station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `victim`
--

DROP TABLE IF EXISTS `victim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `victim` (
  `victim_id` int NOT NULL,
  `fir_id` int DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `address` varchar(80) DEFAULT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `injury_details` text,
  PRIMARY KEY (`victim_id`),
  UNIQUE KEY `contact_no` (`contact_no`),
  KEY `fir_id` (`fir_id`),
  CONSTRAINT `victim_ibfk_1` FOREIGN KEY (`fir_id`) REFERENCES `fir` (`fir_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `victim`
--

LOCK TABLES `victim` WRITE;
/*!40000 ALTER TABLE `victim` DISABLE KEYS */;
INSERT INTO `victim` VALUES (301,101,'Rahul Mehta','Mumbai','9111223344','Minor injuries'),(302,102,'Priya Sharma','Delhi','9222334455','Financial loss'),(303,103,'Amit Joshi','Pune','9333445566','Head injury');
/*!40000 ALTER TABLE `victim` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-26 22:43:10
