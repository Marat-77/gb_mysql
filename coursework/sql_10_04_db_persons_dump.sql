-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: db_persons
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
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persons` (
  `person_id` int unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL /*!80023 INVISIBLE */ COMMENT 'Имя',
  `lastname` varchar(50) NOT NULL /*!80023 INVISIBLE */ COMMENT 'Фамилия',
  `patronymic` varchar(60) DEFAULT 'Нет отчества' /*!80023 INVISIBLE */ COMMENT 'Отчество',
  `birthday` date DEFAULT NULL /*!80023 INVISIBLE */ COMMENT 'дата рождения',
  `age` smallint unsigned GENERATED ALWAYS AS (timestampdiff(YEAR,`birthday`,_utf8mb4'2021-11-15')) STORED,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` (`person_id`, `firstname`, `lastname`, `patronymic`, `birthday`) VALUES (1,'Лев','Устюженин','Фролович','1982-01-23'),(2,'Иовилла','Устюженина','Ювеналиевна','1983-08-09'),(3,'Виктор','Устюженин','Львович','2005-12-06'),(4,'Евмения','Устюженина','Львовна','2014-03-06'),(5,'Фрол','Устюженин','Всеславович','1960-09-23'),(6,'Савелий','Коваленков','Дорофей','1976-05-05'),(7,'Анфия','Коваленкова','Лукинична','1978-03-22'),(8,'Дария','Коваленкова','Савельевна','1999-02-25'),(9,'Яна','Коваленкова','Савельевна','2010-04-04'),(10,'Тимур','Коваленков','Савельевич','2014-06-07'),(11,'Тимофей','Кочетков','Серапионович','1950-01-30'),(12,'Марфа','Кочеткова','Валентиновна','1951-03-08'),(13,'Степан','Доронин','Андреевич','1985-02-02'),(14,'София','Доронина','Михайловна','1984-07-08'),(15,'Борис','Доронин','Степанович','2009-03-09'),(16,'Матвей','Доронин','Степанович','2012-08-25'),(17,'Ким','Батманов','Авдеевич','1979-05-15'),(18,'Земфира','Батманова','Салиховна','1983-07-07'),(19,'Ренат','Батманов','Кимович','1999-12-31'),(20,'Денис','Батманов','Кимович','2004-04-20'),(21,'Ростислав','Федяинов','Климович','1994-06-16'),(22,'Илона','Федяинова','Никитична','1995-11-23'),(23,'Сергей','Федяинов','Ростиславович','2014-04-18'),(24,'Юлия','Федяинова','Ростиславовна','2016-05-24'),(25,'Анна','Корнюшина','Петровна','1968-05-18'),(26,'Степан','Корнюшин','Игоревич','1969-12-01'),(27,'Алина','Белова','Степановна','1991-05-27'),(28,'Юнона','Белова','Ильинична','2011-05-18'),(29,'Родион','Невельский','Рудольф','1993-10-14'),(30,'Мирослава','Невельская','Леопольдовна','1993-09-25'),(31,'Злата','Невельская','Родионовна','2012-06-01'),(32,'Тихомир','Невельский','Родионович','2014-05-23');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-28 11:32:14
