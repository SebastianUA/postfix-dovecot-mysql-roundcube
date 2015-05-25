-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: iredadmin
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `deleted_mailboxes`
--

DROP TABLE IF EXISTS `deleted_mailboxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_mailboxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `username` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `maildir` varchar(255) NOT NULL DEFAULT '',
  `admin` varchar(255) NOT NULL DEFAULT '',
  KEY `id` (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `username` (`username`),
  KEY `domain` (`domain`),
  KEY `admin` (`admin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_mailboxes`
--

LOCK TABLES `deleted_mailboxes` WRITE;
/*!40000 ALTER TABLE `deleted_mailboxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_mailboxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin` varchar(255) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `domain` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `event` varchar(20) NOT NULL DEFAULT '',
  `loglevel` varchar(10) NOT NULL DEFAULT 'info',
  `msg` varchar(255) NOT NULL,
  KEY `id` (`id`),
  KEY `timestamp` (`timestamp`),
  KEY `admin` (`admin`),
  KEY `ip` (`ip`),
  KEY `domain` (`domain`),
  KEY `username` (`username`),
  KEY `event` (`event`),
  KEY `loglevel` (`loglevel`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2015-05-22 08:21:04','postmaster@localhost.test.local','127.0.0.1','','','login','info','Login success'),(2,'2015-05-22 08:30:34','postmaster@localhost.test.local','127.0.0.1','','','create','info','Create admin: test_user@localhost.test.local.'),(3,'2015-05-22 08:32:57','postmaster@localhost.test.local','127.0.0.1','test.com.local','','create','info','Create domain: test.com.local.'),(4,'2015-05-22 08:33:49','postmaster@localhost.test.local','127.0.0.1','','','create','info','Create admin: test@test.com.local.'),(5,'2015-05-22 09:01:44','postmaster@localhost.test.local','127.0.0.1','localhost.test.local','','create','info','Create user: test_user@localhost.test.local.'),(6,'2015-05-22 09:02:33','postmaster@localhost.test.local','127.0.0.1','test.com.local','','create','info','Create user: test@test.com.local.');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `session_id` char(128) NOT NULL,
  `atime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` text,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('be5d610a115d23addcaa5bf0c48f4bc80222ef4b','2015-05-22 12:02:33','KGRwMQpTJ3VzZXJuYW1lJwpwMgpTJ3Bvc3RtYXN0ZXJAbG9jYWxob3N0LnRlc3QubG9jYWwnCnAz\nCnNTJ2VuYWJsZV9wb2xpY3lkJwpwNApJMDAKc1Mnc3RvcmVfcGFzc3dvcmRfaW5fcGxhaW5fdGV4\ndCcKcDUKSTAwCnNTJ2xhbmcnCnA2ClMnZW5fVVMnCnA3CnNTJ2RvbWFpbkdsb2JhbEFkbWluJwpw\nOApJMDEKc1MnaXAnCnA5ClYxMjcuMC4wLjEKcDEwCnNTJ2xvZ2dlZCcKcDExCkkwMQpzUydjc3Jm\nX3Rva2VuJwpwMTIKUyc0SjhBOVVOMjNaN20yMzYzNVNlSzdwbTU3NW45MmdXSCcKcDEzCnNTJ3Nl\nc3Npb25faWQnCnAxNApTJ2JlNWQ2MTBhMTE1ZDIzYWRkY2FhNWJmMGM0OGY0YmM4MDIyMmVmNGIn\nCnAxNQpzUydhbWF2aXNkX2VuYWJsZV9xdWFyYW50aW5lJwpwMTYKSTAxCnNTJ2RlZmF1bHRfbXRh\nX3RyYW5zcG9ydCcKcDE3ClMnZG92ZWNvdCcKcDE4CnNTJ2VuYWJsZV9jbHVlYnJpbmdlcicKcDE5\nCkkwMQpzUydmYWlsZWRfdGltZXMnCnAyMApJMApzUydpc19nbG9iYWxfYWRtaW4nCnAyMQpJMDAK\nc1Mnd2VibWFzdGVyJwpwMjIKUydwb3N0bWFzdGVyQGxvY2FsaG9zdC50ZXN0LmxvY2FsJwpwMjMK\nc1MnaXNNYWlsVXNlcicKcDI0CkkwMQpzLg==\n'),('618799b3570015f573e04202ed10828d98a075a7','2015-05-22 15:23:15','KGRwMQpTJ3VzZXJuYW1lJwpwMgpOc1MnZW5hYmxlX3BvbGljeWQnCnAzCkkwMApzUydzdG9yZV9w\nYXNzd29yZF9pbl9wbGFpbl90ZXh0JwpwNApJMDAKc1MnbGFuZycKcDUKUydlbl9VUycKcDYKc1Mn\naXAnCnA3ClYxOTIuMTY4LjEwMy4xMzAKcDgKc1MnbG9nZ2VkJwpwOQpJMDAKc1MnYW1hdmlzZF9l\nbmFibGVfcXVhcmFudGluZScKcDEwCkkwMQpzUydzZXNzaW9uX2lkJwpwMTEKUyc2MTg3OTliMzU3\nMDAxNWY1NzNlMDQyMDJlZDEwODI4ZDk4YTA3NWE3JwpwMTIKc1MnZGVmYXVsdF9tdGFfdHJhbnNw\nb3J0JwpwMTMKUydkb3ZlY290JwpwMTQKc1MnZmFpbGVkX3RpbWVzJwpwMTUKSTAKc1MnaXNfZ2xv\nYmFsX2FkbWluJwpwMTYKSTAwCnNTJ3dlYm1hc3RlcicKcDE3ClMncG9zdG1hc3RlckBsb2NhbGhv\nc3QudGVzdC5sb2NhbCcKcDE4CnNTJ2VuYWJsZV9jbHVlYnJpbmdlcicKcDE5CkkwMQpzLg==\n');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `updatelog`
--

DROP TABLE IF EXISTS `updatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `updatelog` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  KEY `id` (`id`),
  KEY `date` (`date`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `updatelog`
--

LOCK TABLES `updatelog` WRITE;
/*!40000 ALTER TABLE `updatelog` DISABLE KEYS */;
INSERT INTO `updatelog` VALUES (1,'2015-05-22');
/*!40000 ALTER TABLE `updatelog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-05-25 15:24:52
