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
  `event` varchar(10) NOT NULL DEFAULT '',
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2015-04-08 08:06:36','postmaster@test.com.local','127.0.0.1','','','login','info','Login success'),(2,'2015-04-08 08:06:56','postmaster@test.com.local','127.0.0.1','','','active','info','Active domain: test.com.local.'),(3,'2015-04-08 08:08:42','postmaster@test.com.local','127.0.0.1','test.com.local','','create','info','Create user: test666@test.com.local.');
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
INSERT INTO `sessions` VALUES ('e1d401d77c6891d4845feaca507de27eae386e5a','2015-04-08 11:11:34','KGRwMQpTJ3VzZXJuYW1lJwpwMgpTJ3Bvc3RtYXN0ZXJAdGVzdC5jb20ubG9jYWwnCnAzCnNTJ2Vu\nYWJsZV9wb2xpY3lkJwpwNApJMDAKc1Mnc3RvcmVfcGFzc3dvcmRfaW5fcGxhaW5fdGV4dCcKcDUK\nSTAwCnNTJ2xhbmcnCnA2ClMnZW5fVVMnCnA3CnNTJ2RvbWFpbkdsb2JhbEFkbWluJwpwOApJMDEK\nc1MnaXAnCnA5ClYxMjcuMC4wLjEKcDEwCnNTJ2xvZ2dlZCcKcDExCkkwMQpzUydjc3JmX3Rva2Vu\nJwpwMTIKUyd6RzN5akVtRmhEeVR4NWpLNVVEYmQ4VzNTV1QzNGp3NicKcDEzCnNTJ3Nlc3Npb25f\naWQnCnAxNApTJ2UxZDQwMWQ3N2M2ODkxZDQ4NDVmZWFjYTUwN2RlMjdlYWUzODZlNWEnCnAxNQpz\nUydhbWF2aXNkX2VuYWJsZV9xdWFyYW50aW5lJwpwMTYKSTAxCnNTJ2RlZmF1bHRfbXRhX3RyYW5z\ncG9ydCcKcDE3ClMnZG92ZWNvdCcKcDE4CnNTJ2VuYWJsZV9jbHVlYnJpbmdlcicKcDE5CkkwMQpz\nUydmYWlsZWRfdGltZXMnCnAyMApJMApzUydpc19nbG9iYWxfYWRtaW4nCnAyMQpJMDAKc1Mnd2Vi\nbWFzdGVyJwpwMjIKUydwb3N0bWFzdGVyQHRlc3QuY29tLmxvY2FsJwpwMjMKc1MnaXNNYWlsVXNl\ncicKcDI0CkkwMQpzLg==\n');
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
INSERT INTO `updatelog` VALUES (1,'2015-04-08');
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

-- Dump completed on 2015-04-08 17:17:38
