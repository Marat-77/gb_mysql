-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: db_census
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int unsigned NOT NULL AUTO_INCREMENT,
  `locality` int unsigned NOT NULL,
  `street_name` varchar(50) DEFAULT NULL,
  `house_number` smallint unsigned NOT NULL,
  `flat_number` smallint unsigned NOT NULL DEFAULT '0',
  `housing_type` smallint unsigned NOT NULL,
  PRIMARY KEY (`address_id`),
  UNIQUE KEY `address_locality_idx` (`address_id`,`locality`,`street_name`,`house_number`,`flat_number`,`housing_type`),
  KEY `house_number_idx` (`house_number`),
  KEY `locality` (`locality`),
  KEY `housing_type` (`housing_type`),
  FULLTEXT KEY `street_name_fulltext` (`street_name`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`locality`) REFERENCES `localities` (`locality_id`),
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`housing_type`) REFERENCES `housing_types` (`housing_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица addresses - таблица адресов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `country_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `country_name` varchar(100) NOT NULL COMMENT 'Наименование страны',
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `country_name` (`country_name`),
  FULLTEXT KEY `country_name_fulltext` (`country_name`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица countries - Список-справочник стран';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `educations`
--

DROP TABLE IF EXISTS `educations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `educations` (
  `education_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `education_name` varchar(25) NOT NULL COMMENT 'Наименование вида образования',
  PRIMARY KEY (`education_id`),
  UNIQUE KEY `education_name` (`education_name`),
  FULLTEXT KEY `education_name_fulltext` (`education_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица educations - Список видов образования';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employments`
--

DROP TABLE IF EXISTS `employments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employments` (
  `employment_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `employment_type` varchar(34) NOT NULL COMMENT 'Наименование вида занятости',
  PRIMARY KEY (`employment_id`),
  UNIQUE KEY `employment_type` (`employment_type`),
  FULLTEXT KEY `employment_type_fulltext` (`employment_type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица employments - Список-справочник видов занятости';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ethnic_groups`
--

DROP TABLE IF EXISTS `ethnic_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ethnic_groups` (
  `ethnic_group_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `ethnic_group_name` varchar(30) NOT NULL COMMENT 'национальная принадлежность',
  PRIMARY KEY (`ethnic_group_id`),
  UNIQUE KEY `ethnic_group_name` (`ethnic_group_name`),
  FULLTEXT KEY `ethnic_group_name_fulltext` (`ethnic_group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица ethnic_groups - Список-справочник национальностей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `family_roles`
--

DROP TABLE IF EXISTS `family_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `family_roles` (
  `family_role_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `family_role_name` varchar(30) NOT NULL DEFAULT '0' COMMENT 'роль в семье',
  PRIMARY KEY (`family_role_id`),
  UNIQUE KEY `family_role_name` (`family_role_name`),
  FULLTEXT KEY `family_role_name_fulltext` (`family_role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица family_roles - Список ролей в семье';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `federal_subjects`
--

DROP TABLE IF EXISTS `federal_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `federal_subjects` (
  `federal_subject_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `federal_subject_name` varchar(40) NOT NULL DEFAULT '0' COMMENT 'Название субъекта РФ',
  PRIMARY KEY (`federal_subject_id`),
  UNIQUE KEY `federal_subject_name` (`federal_subject_name`),
  FULLTEXT KEY `fed_subject_name_fulltext` (`federal_subject_name`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица federal_subjects - Список субъектов РФ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `household_members`
--

DROP TABLE IF EXISTS `household_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `household_members` (
  `hm_id` int unsigned NOT NULL AUTO_INCREMENT,
  `household` int unsigned NOT NULL,
  `profile` int unsigned NOT NULL,
  `family_role` smallint unsigned NOT NULL,
  PRIMARY KEY (`hm_id`),
  UNIQUE KEY `profile_family_role_idx` (`hm_id`,`household`,`profile`,`family_role`),
  UNIQUE KEY `household_members_profile_un_idx` (`profile`),
  KEY `household` (`household`),
  KEY `family_role` (`family_role`),
  CONSTRAINT `household_members_ibfk_1` FOREIGN KEY (`household`) REFERENCES `households` (`household_id`),
  CONSTRAINT `household_members_ibfk_2` FOREIGN KEY (`profile`) REFERENCES `profiles` (`profile_id`),
  CONSTRAINT `household_members_ibfk_3` FOREIGN KEY (`family_role`) REFERENCES `family_roles` (`family_role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица household_members - состав домохозяйства';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `households`
--

DROP TABLE IF EXISTS `households`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `households` (
  `household_id` int unsigned NOT NULL AUTO_INCREMENT,
  `address` int unsigned NOT NULL,
  PRIMARY KEY (`household_id`),
  UNIQUE KEY `household_id_address_idx` (`household_id`,`address`),
  KEY `address` (`address`),
  CONSTRAINT `households_ibfk_1` FOREIGN KEY (`address`) REFERENCES `addresses` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица households - домохозяйства';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `housing_types`
--

DROP TABLE IF EXISTS `housing_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `housing_types` (
  `housing_type_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `housing_type_name` varchar(21) NOT NULL DEFAULT '0' COMMENT 'Название типа жилища',
  PRIMARY KEY (`housing_type_id`),
  UNIQUE KEY `housing_type_name` (`housing_type_name`),
  FULLTEXT KEY `housing_type_name_fulltext` (`housing_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица housing_types - Список типов жилища';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `list_income_sources`
--

DROP TABLE IF EXISTS `list_income_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `list_income_sources` (
  `income_source_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `income_source_name` varchar(51) NOT NULL COMMENT 'Наименование источника дохода',
  PRIMARY KEY (`income_source_id`),
  UNIQUE KEY `income_source_name` (`income_source_name`),
  FULLTEXT KEY `income_source_name_fulltext` (`income_source_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица employments - Список видов источников дохода';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `list_languages`
--

DROP TABLE IF EXISTS `list_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `list_languages` (
  `language_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `language_name` varchar(55) NOT NULL COMMENT 'Название языка',
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `language_name` (`language_name`),
  FULLTEXT KEY `language_name_fulltext` (`language_name`)
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица list_languages - Список-справочник языков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localities`
--

DROP TABLE IF EXISTS `localities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `localities` (
  `locality_id` int unsigned NOT NULL AUTO_INCREMENT,
  `locality_name` varchar(100) NOT NULL DEFAULT '0' COMMENT 'Название населенного пункта',
  `federal_subject` smallint unsigned NOT NULL,
  PRIMARY KEY (`locality_id`),
  UNIQUE KEY `locality_id_federal_subject_id_idx` (`locality_id`,`federal_subject`),
  KEY `locality_name_idx` (`locality_name`),
  KEY `federal_subject` (`federal_subject`),
  FULLTEXT KEY `locality_name_fulltext` (`locality_name`),
  CONSTRAINT `localities_ibfk_1` FOREIGN KEY (`federal_subject`) REFERENCES `federal_subjects` (`federal_subject_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица localities - Список населенных пунктов связанных с субъектами РФ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_income_sources`
--

DROP TABLE IF EXISTS `person_income_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_income_sources` (
  `person_income_source_id` int unsigned NOT NULL AUTO_INCREMENT,
  `profile` int unsigned NOT NULL,
  `income_source` smallint unsigned NOT NULL,
  PRIMARY KEY (`person_income_source_id`),
  KEY `profile` (`profile`),
  KEY `income_source` (`income_source`),
  CONSTRAINT `person_income_sources_ibfk_1` FOREIGN KEY (`profile`) REFERENCES `profiles` (`profile_id`),
  CONSTRAINT `person_income_sources_ibfk_2` FOREIGN KEY (`income_source`) REFERENCES `list_income_sources` (`income_source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица person_income_sources - персона-источники дохода';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person_languages`
--

DROP TABLE IF EXISTS `person_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person_languages` (
  `person_language_id` int unsigned NOT NULL AUTO_INCREMENT,
  `profile` int unsigned NOT NULL,
  `language_other` smallint unsigned NOT NULL,
  PRIMARY KEY (`person_language_id`),
  KEY `profile` (`profile`),
  KEY `language_other` (`language_other`),
  CONSTRAINT `person_languages_ibfk_1` FOREIGN KEY (`profile`) REFERENCES `profiles` (`profile_id`),
  CONSTRAINT `person_languages_ibfk_2` FOREIGN KEY (`language_other`) REFERENCES `list_languages` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица person_languages - персона-языки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `profile_id` int unsigned NOT NULL AUTO_INCREMENT,
  `xbirthday` date NOT NULL DEFAULT '0000-00-00' /*!80023 INVISIBLE */ COMMENT 'дата рождения',
  `age` smallint unsigned GENERATED ALWAYS AS (timestampdiff(YEAR,`xbirthday`,_utf8mb4'2021-11-15')) STORED,
  `gender` enum('m','f') NOT NULL COMMENT 'пол',
  `education` smallint unsigned NOT NULL COMMENT 'образование',
  `sitizenship` smallint unsigned NOT NULL DEFAULT '1' COMMENT 'гражданство',
  `arrived_from` smallint unsigned NOT NULL DEFAULT '1' COMMENT 'из какой страны прибыл',
  `russian` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'знание русского языка',
  `ethnic_group` smallint unsigned NOT NULL COMMENT 'национальная пренадлежность',
  `employment` smallint unsigned NOT NULL COMMENT 'занятость',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `profile_id` (`profile_id`),
  KEY `education` (`education`),
  KEY `sitizenship` (`sitizenship`),
  KEY `arrived_from` (`arrived_from`),
  KEY `ethnic_group` (`ethnic_group`),
  KEY `employment` (`employment`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`profile_id`) REFERENCES `db_persons`.`persons` (`person_id`),
  CONSTRAINT `profiles_ibfk_2` FOREIGN KEY (`education`) REFERENCES `educations` (`education_id`),
  CONSTRAINT `profiles_ibfk_3` FOREIGN KEY (`sitizenship`) REFERENCES `countries` (`country_id`),
  CONSTRAINT `profiles_ibfk_4` FOREIGN KEY (`arrived_from`) REFERENCES `countries` (`country_id`),
  CONSTRAINT `profiles_ibfk_5` FOREIGN KEY (`ethnic_group`) REFERENCES `ethnic_groups` (`ethnic_group_id`),
  CONSTRAINT `profiles_ibfk_6` FOREIGN KEY (`employment`) REFERENCES `employments` (`employment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица profiles';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-28 11:28:37
