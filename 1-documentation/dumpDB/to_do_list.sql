-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: to_do_list
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_reset_tokens_table',1),(3,'2019_08_19_000000_create_failed_jobs_table',1),(4,'2019_12_14_000001_create_personal_access_tokens_table',1),(5,'2023_11_17_122159_create_tasks_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'postman','c0d6b2ae0e569859edb511738416fce4c536d49c0113fd400156fdc7a5409ef8','[\"*\"]',NULL,NULL,'2023-11-20 05:32:52','2023-11-20 05:32:52'),(2,'App\\Models\\User',2,'postman','3dcef18516b05ae7df22baec8b0cddb7b391db4a4d6838e2473ff0197a42d875','[\"*\"]',NULL,NULL,'2023-11-20 05:35:38','2023-11-20 05:35:38');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `status` enum('todo','done') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'todo',
  `priority` enum('1','2','3','4','5') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `parent_id` bigint unsigned DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_user_id_foreign` (`user_id`),
  KEY `tasks_parent_id_foreign` (`parent_id`),
  CONSTRAINT `tasks_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tasks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,1,'todo','1','Title 1/1','K9oeR3Hf',NULL,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(2,1,'todo','4','Title 1/1/1','qtBgyPxkh',1,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(3,1,'todo','4','Title 1/1/2','07mh76',1,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(4,1,'todo','5','Title 1/1/2/1','tAbutTsfr3',3,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(5,1,'todo','4','Title 2/1','54FAdys',NULL,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(6,1,'todo','5','Title 2/1/1','cf3OtZAT',5,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(7,1,'todo','2','Title 2/1/2','pvJDvOJus',5,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(8,1,'todo','2','Title 2/1/2/1','v3Uyu',7,NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(9,1,'todo','5','Title 3/1','Un3yi6',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(10,1,'todo','1','Title 3/1/1','fT5sI',9,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(11,1,'todo','4','Title 3/1/2','vFBKBV',9,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(12,1,'todo','3','Title 3/1/2/1','5LaRSFZp',11,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(13,1,'todo','2','Title 4/1','BNDAaP',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(14,1,'todo','1','Title 4/1/1','IwXZUE53F',13,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(15,1,'todo','4','Title 4/1/2','m5LWAxLf1',13,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(16,1,'todo','3','Title 4/1/2/1','1ZRkoC3v',15,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(17,1,'todo','2','Title 5/1','Pu7J630Xt',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(18,1,'todo','1','Title 5/1/1','s97S0Uk',17,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(19,1,'todo','4','Title 5/1/2','KWsDLC8FYy',17,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(20,1,'todo','4','Title 5/1/2/1','dq31a9fXKx',19,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(21,2,'todo','5','Title 1/1','cMCfpM',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(22,2,'todo','3','Title 1/1/1','KlYDCUx',21,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(23,2,'todo','5','Title 1/1/2','fJwmhTSae',21,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(24,2,'todo','4','Title 1/1/2/1','XXLGXIm',23,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(25,2,'todo','1','Title 2/1','LKFqoG2R',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(26,2,'todo','3','Title 2/1/1','srG2e8o3',25,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(27,2,'todo','3','Title 2/1/2','y4ihJfL',25,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(28,2,'todo','2','Title 2/1/2/1','o1g4G',27,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(29,2,'todo','1','Title 3/1','m3VMmQA',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(30,2,'todo','1','Title 3/1/1','0pCqaQC',29,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(31,2,'todo','4','Title 3/1/2','tlOD6jdfzj',29,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(32,2,'todo','1','Title 3/1/2/1','RM2ug',31,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(33,2,'todo','3','Title 4/1','Qwvv05',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(34,2,'todo','4','Title 4/1/1','w4ibz',33,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(35,2,'todo','1','Title 4/1/2','wuDoQbYnQ7',33,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(36,2,'todo','4','Title 4/1/2/1','tYbUgKtnCx',35,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(37,2,'todo','1','Title 5/1','EFUXKxTKl8',NULL,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(38,2,'todo','5','Title 5/1/1','QRPnfZ2I',37,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(39,2,'todo','1','Title 5/1/2','N5KZtoIqE',37,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53'),(40,2,'todo','3','Title 5/1/2/1','afn6Xmexv',39,NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'apiUser1','apiUser1@gmail.com',NULL,'$2y$12$Mgmr2htHg/N/FL6s4cVH3upLqQAYa.yI/545SGuvxcZ5iqhUzHkEy',NULL,'2023-11-20 05:17:52','2023-11-20 05:17:52'),(2,'apiUser2','apiUser2@gmail.com',NULL,'$2y$12$72dzPKapYH4n0bcSRwSH4Ozm3opD/nm6RzESB1b7oku.xRz0LUuwC',NULL,'2023-11-20 05:17:53','2023-11-20 05:17:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-20  9:41:04
