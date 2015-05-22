-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: roundcubemail
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
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `user_id` int(10) unsigned NOT NULL,
  `cache_key` varchar(128) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `user_cache_index` (`user_id`,`cache_key`),
  CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_index`
--

DROP TABLE IF EXISTS `cache_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_index` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_index`
--

LOCK TABLES `cache_index` WRITE;
/*!40000 ALTER TABLE `cache_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_messages`
--

DROP TABLE IF EXISTS `cache_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_messages` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) unsigned NOT NULL DEFAULT '0',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_messages`
--

LOCK TABLES `cache_messages` WRITE;
/*!40000 ALTER TABLE `cache_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_shared`
--

DROP TABLE IF EXISTS `cache_shared`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_shared` (
  `cache_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  KEY `expires_index` (`expires`),
  KEY `cache_key_index` (`cache_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_shared`
--

LOCK TABLES `cache_shared` WRITE;
/*!40000 ALTER TABLE `cache_shared` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_shared` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_thread`
--

DROP TABLE IF EXISTS `cache_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_thread` (
  `user_id` int(10) unsigned NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`user_id`,`mailbox`),
  KEY `expires_index` (`expires`),
  CONSTRAINT `user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_thread`
--

LOCK TABLES `cache_thread` WRITE;
/*!40000 ALTER TABLE `cache_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactgroupmembers`
--

DROP TABLE IF EXISTS `contactgroupmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactgroupmembers` (
  `contactgroup_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  PRIMARY KEY (`contactgroup_id`,`contact_id`),
  KEY `contactgroupmembers_contact_index` (`contact_id`),
  CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactgroupmembers`
--

LOCK TABLES `contactgroupmembers` WRITE;
/*!40000 ALTER TABLE `contactgroupmembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactgroupmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactgroups`
--

DROP TABLE IF EXISTS `contactgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactgroups` (
  `contactgroup_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`contactgroup_id`),
  KEY `contactgroups_user_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactgroups`
--

LOCK TABLES `contactgroups` WRITE;
/*!40000 ALTER TABLE `contactgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `contactgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`contact_id`),
  KEY `user_contacts_index` (`user_id`,`del`),
  CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dictionary`
--

DROP TABLE IF EXISTS `dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dictionary` (
  `user_id` int(10) unsigned DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL,
  UNIQUE KEY `uniqueness` (`user_id`,`language`),
  CONSTRAINT `user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictionary`
--

LOCK TABLES `dictionary` WRITE;
/*!40000 ALTER TABLE `dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identities`
--

DROP TABLE IF EXISTS `identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identities` (
  `identity_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` text,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identity_id`),
  KEY `user_identities_index` (`user_id`,`del`),
  KEY `email_identities_index` (`email`,`del`),
  CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identities`
--

LOCK TABLES `identities` WRITE;
/*!40000 ALTER TABLE `identities` DISABLE KEYS */;
INSERT INTO `identities` VALUES (1,1,'2015-04-08 14:00:29',0,1,'','','postmaster@test.com.local','','',NULL,0),(2,2,'2015-04-08 14:12:26',0,1,'','','test666@test.com.local','','',NULL,0);
/*!40000 ALTER TABLE `identities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searches`
--

DROP TABLE IF EXISTS `searches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text,
  PRIMARY KEY (`search_id`),
  UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`),
  CONSTRAINT `user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searches`
--

LOCK TABLES `searches` WRITE;
/*!40000 ALTER TABLE `searches` DISABLE KEYS */;
/*!40000 ALTER TABLE `searches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `sess_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL,
  PRIMARY KEY (`sess_id`),
  KEY `changed_index` (`changed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('5jqfsa0u0tlcrr28q8fdfh42h0','2015-04-08 14:31:37','2015-04-08 14:35:13','192.168.0.72','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7c2tpbnxzOjU6ImxhcnJ5IjtpbWFwX25hbWVzcGFjZXxhOjQ6e3M6ODoicGVyc29uYWwiO2E6MTp7aTowO2E6Mjp7aTowO3M6MDoiIjtpOjE7czoxOiIvIjt9fXM6NToib3RoZXIiO2E6MTp7aTowO2E6Mjp7aTowO3M6NzoiU2hhcmVkLyI7aToxO3M6MToiLyI7fX1zOjY6InNoYXJlZCI7TjtzOjY6InByZWZpeCI7czowOiIiO31pbWFwX2RlbGltaXRlcnxzOjE6Ii8iO3VzZXJfaWR8czoxOiIyIjt1c2VybmFtZXxzOjIyOiJ0ZXN0NjY2QHRlc3QuY29tLmxvY2FsIjtzdG9yYWdlX2hvc3R8czo5OiIxMjcuMC4wLjEiO3N0b3JhZ2VfcG9ydHxpOjE0MztzdG9yYWdlX3NzbHxOO3Bhc3N3b3JkfHM6MzI6ImxLb3FRWXJ4TXVyL2dWd0EyZEZ5TTQyZ1d6MHlGQUdxIjtsb2dpbl90aW1lfGk6MTQyODQ5MjY5Nzt0aW1lem9uZXxzOjE1OiJFdXJvcGUvSGVsc2lua2kiO3Rhc2t8czo0OiJtYWlsIjtpbWFwX2hvc3R8czo5OiIxMjcuMC4wLjEiO21ib3h8czo1OiJJTkJPWCI7cGFnZXxpOjE7c29ydF9jb2x8czowOiIiO3NvcnRfb3JkZXJ8czo0OiJERVNDIjtTVE9SQUdFX1RIUkVBRHxhOjM6e2k6MDtzOjEwOiJSRUZFUkVOQ0VTIjtpOjE7czo0OiJSRUZTIjtpOjI7czoxNDoiT1JERVJFRFNVQkpFQ1QiO31TVE9SQUdFX1FVT1RBfGI6MTtTVE9SQUdFX0xJU1QtRVhURU5ERUR8YjoxO3F1b3RhX2Rpc3BsYXl8czo0OiJ0ZXh0IjtsaXN0X2F0dHJpYnxhOjU6e3M6NDoibmFtZSI7czo4OiJtZXNzYWdlcyI7czoyOiJpZCI7czoxMToibWVzc2FnZWxpc3QiO3M6NToiY2xhc3MiO3M6NDg6InJlY29yZHMtdGFibGUgbWVzc2FnZWxpc3Qgc29ydGhlYWRlciBmaXhlZGhlYWRlciI7czoxNToib3B0aW9uc21lbnVpY29uIjtzOjQ6InRydWUiO3M6NzoiY29sdW1ucyI7YTo4OntpOjA7czo3OiJ0aHJlYWRzIjtpOjE7czo3OiJzdWJqZWN0IjtpOjI7czo2OiJzdGF0dXMiO2k6MztzOjY6ImZyb210byI7aTo0O3M6NDoiZGF0ZSI7aTo1O3M6NDoic2l6ZSI7aTo2O3M6NDoiZmxhZyI7aTo3O3M6MTA6ImF0dGFjaG1lbnQiO319c2tpbl9wYXRofHM6MTE6InNraW5zL2xhcnJ5Ijtmb2xkZXJzfGE6NTp7czo1OiJJTkJPWCI7YToyOntzOjM6ImNudCI7aToxO3M6NjoibWF4dWlkIjtpOjE7fXM6NDoiU2VudCI7YToyOntzOjM6ImNudCI7aToxO3M6NjoibWF4dWlkIjtpOjE7fXM6NDoiSnVuayI7YToyOntzOjM6ImNudCI7aTowO3M6NjoibWF4dWlkIjtpOjA7fXM6NToiVHJhc2giO2E6Mjp7czozOiJjbnQiO2k6MDtzOjY6Im1heHVpZCI7aTowO31zOjY6IkRyYWZ0cyI7YToyOntzOjM6ImNudCI7aTowO3M6NjoibWF4dWlkIjtpOjA7fX11bnNlZW5fY291bnR8YTo1OntzOjU6IklOQk9YIjtpOjE7czo0OiJTZW50IjtpOjA7czo0OiJKdW5rIjtpOjA7czo1OiJUcmFzaCI7aTowO3M6NjoiRHJhZnRzIjtpOjA7fVNUT1JBR0VfQUNMfGI6MTs='),('br3ed47i3sg3da4k64e88skqf6','2015-04-08 14:06:29','2015-04-08 14:06:29','127.0.0.1','dGVtcHxiOjE7bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGFza3xzOjU6ImxvZ2luIjs='),('kjkvl371n979td3cv6v9otbrc7','2015-04-08 14:06:29','2015-04-08 14:06:29','127.0.0.1','dGVtcHxiOjE7bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGFza3xzOjU6ImxvZ2luIjs='),('m93tprjogocr7ut3r397555jp4','2015-04-08 14:06:29','2015-04-08 14:06:29','127.0.0.1','dGVtcHxiOjE7bGFuZ3VhZ2V8czo1OiJlbl9VUyI7dGFza3xzOjU6ImxvZ2luIjs='),('qttnrgmkbp7g28tm5a7f9dq8b1','2015-04-08 14:12:26','2015-04-08 14:13:26','127.0.0.1','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7c2tpbnxzOjU6ImxhcnJ5IjtpbWFwX25hbWVzcGFjZXxhOjQ6e3M6ODoicGVyc29uYWwiO2E6MTp7aTowO2E6Mjp7aTowO3M6MDoiIjtpOjE7czoxOiIvIjt9fXM6NToib3RoZXIiO2E6MTp7aTowO2E6Mjp7aTowO3M6NzoiU2hhcmVkLyI7aToxO3M6MToiLyI7fX1zOjY6InNoYXJlZCI7TjtzOjY6InByZWZpeCI7czowOiIiO31pbWFwX2RlbGltaXRlcnxzOjE6Ii8iO3VzZXJfaWR8czoxOiIyIjt1c2VybmFtZXxzOjIyOiJ0ZXN0NjY2QHRlc3QuY29tLmxvY2FsIjtzdG9yYWdlX2hvc3R8czo5OiIxMjcuMC4wLjEiO3N0b3JhZ2VfcG9ydHxpOjE0MztzdG9yYWdlX3NzbHxOO3Bhc3N3b3JkfHM6MzI6Ik90emJON3pGNmlzR3UxMDRnTzJEZ0ZMOFJRSTdhWDdFIjtsb2dpbl90aW1lfGk6MTQyODQ5MTU0Njt0aW1lem9uZXxzOjE1OiJFdXJvcGUvSGVsc2lua2kiO3Rhc2t8czo0OiJtYWlsIjtpbWFwX2hvc3R8czo5OiIxMjcuMC4wLjEiO21ib3h8czo1OiJJTkJPWCI7cGFnZXxpOjE7c29ydF9jb2x8czowOiIiO3NvcnRfb3JkZXJ8czo0OiJERVNDIjtTVE9SQUdFX1RIUkVBRHxhOjM6e2k6MDtzOjEwOiJSRUZFUkVOQ0VTIjtpOjE7czo0OiJSRUZTIjtpOjI7czoxNDoiT1JERVJFRFNVQkpFQ1QiO31TVE9SQUdFX1FVT1RBfGI6MTtTVE9SQUdFX0xJU1QtRVhURU5ERUR8YjoxO3F1b3RhX2Rpc3BsYXl8czo0OiJ0ZXh0IjtsaXN0X2F0dHJpYnxhOjU6e3M6NDoibmFtZSI7czo4OiJtZXNzYWdlcyI7czoyOiJpZCI7czoxMToibWVzc2FnZWxpc3QiO3M6NToiY2xhc3MiO3M6NDg6InJlY29yZHMtdGFibGUgbWVzc2FnZWxpc3Qgc29ydGhlYWRlciBmaXhlZGhlYWRlciI7czoxNToib3B0aW9uc21lbnVpY29uIjtzOjQ6InRydWUiO3M6NzoiY29sdW1ucyI7YTo4OntpOjA7czo3OiJ0aHJlYWRzIjtpOjE7czo3OiJzdWJqZWN0IjtpOjI7czo2OiJzdGF0dXMiO2k6MztzOjY6ImZyb210byI7aTo0O3M6NDoiZGF0ZSI7aTo1O3M6NDoic2l6ZSI7aTo2O3M6NDoiZmxhZyI7aTo3O3M6MTA6ImF0dGFjaG1lbnQiO319c2tpbl9wYXRofHM6MTE6InNraW5zL2xhcnJ5Ijt1bnNlZW5fY291bnR8YTo1OntzOjU6IklOQk9YIjtpOjA7czo2OiJEcmFmdHMiO2k6MDtzOjQ6IlNlbnQiO2k6MDtzOjQ6Ikp1bmsiO2k6MDtzOjU6IlRyYXNoIjtpOjA7fWZvbGRlcnN8YTo1OntzOjU6IklOQk9YIjthOjI6e3M6MzoiY250IjtpOjA7czo2OiJtYXh1aWQiO2k6MDt9czo2OiJEcmFmdHMiO2E6Mjp7czozOiJjbnQiO2k6MDtzOjY6Im1heHVpZCI7aTowO31zOjQ6IlNlbnQiO2E6Mjp7czozOiJjbnQiO2k6MDtzOjY6Im1heHVpZCI7aTowO31zOjQ6Ikp1bmsiO2E6Mjp7czozOiJjbnQiO2k6MDtzOjY6Im1heHVpZCI7aTowO31zOjU6IlRyYXNoIjthOjI6e3M6MzoiY250IjtpOjA7czo2OiJtYXh1aWQiO2k6MDt9fQ=='),('ufq9roggppf4nokqnq8ro8j8n5','2015-04-08 14:00:29','2015-04-08 14:00:46','127.0.0.1','bGFuZ3VhZ2V8czo1OiJlbl9VUyI7c2tpbnxzOjU6ImxhcnJ5IjtpbWFwX25hbWVzcGFjZXxhOjQ6e3M6ODoicGVyc29uYWwiO2E6MTp7aTowO2E6Mjp7aTowO3M6MDoiIjtpOjE7czoxOiIvIjt9fXM6NToib3RoZXIiO2E6MTp7aTowO2E6Mjp7aTowO3M6NzoiU2hhcmVkLyI7aToxO3M6MToiLyI7fX1zOjY6InNoYXJlZCI7TjtzOjY6InByZWZpeCI7czowOiIiO31pbWFwX2RlbGltaXRlcnxzOjE6Ii8iO3VzZXJfaWR8czoxOiIxIjt1c2VybmFtZXxzOjI1OiJwb3N0bWFzdGVyQHRlc3QuY29tLmxvY2FsIjtzdG9yYWdlX2hvc3R8czo5OiIxMjcuMC4wLjEiO3N0b3JhZ2VfcG9ydHxpOjE0MztzdG9yYWdlX3NzbHxOO3Bhc3N3b3JkfHM6MzI6IndNdVVNOUlMcmY4Q1RsME5ycjlFenFzK25Tb0tpMDc1Ijtsb2dpbl90aW1lfGk6MTQyODQ5MDgyOTt0aW1lem9uZXxzOjE1OiJFdXJvcGUvSGVsc2lua2kiO3Rhc2t8czo0OiJtYWlsIjtpbWFwX2hvc3R8czo5OiIxMjcuMC4wLjEiO21ib3h8czo1OiJJTkJPWCI7cGFnZXxpOjE7c29ydF9jb2x8czowOiIiO3NvcnRfb3JkZXJ8czo0OiJERVNDIjtTVE9SQUdFX1RIUkVBRHxhOjM6e2k6MDtzOjEwOiJSRUZFUkVOQ0VTIjtpOjE7czo0OiJSRUZTIjtpOjI7czoxNDoiT1JERVJFRFNVQkpFQ1QiO31TVE9SQUdFX1FVT1RBfGI6MTtTVE9SQUdFX0xJU1QtRVhURU5ERUR8YjoxO3F1b3RhX2Rpc3BsYXl8czo0OiJ0ZXh0IjtsaXN0X2F0dHJpYnxhOjU6e3M6NDoibmFtZSI7czo4OiJtZXNzYWdlcyI7czoyOiJpZCI7czoxMToibWVzc2FnZWxpc3QiO3M6NToiY2xhc3MiO3M6NDg6InJlY29yZHMtdGFibGUgbWVzc2FnZWxpc3Qgc29ydGhlYWRlciBmaXhlZGhlYWRlciI7czoxNToib3B0aW9uc21lbnVpY29uIjtzOjQ6InRydWUiO3M6NzoiY29sdW1ucyI7YTo4OntpOjA7czo3OiJ0aHJlYWRzIjtpOjE7czo3OiJzdWJqZWN0IjtpOjI7czo2OiJzdGF0dXMiO2k6MztzOjY6ImZyb210byI7aTo0O3M6NDoiZGF0ZSI7aTo1O3M6NDoic2l6ZSI7aTo2O3M6NDoiZmxhZyI7aTo3O3M6MTA6ImF0dGFjaG1lbnQiO319c2tpbl9wYXRofHM6MTE6InNraW5zL2xhcnJ5Ijtmb2xkZXJzfGE6MTp7czo1OiJJTkJPWCI7YToyOntzOjM6ImNudCI7aToyO3M6NjoibWF4dWlkIjtpOjI7fX11bnNlZW5fY291bnR8YToxOntzOjU6IklOQk9YIjtpOjI7fWNvbXBvc2VfZGF0YV8xNDEwNDMyMzM4NTUyNTBhNTFkNjJlNXxhOjQ6e3M6MjoiaWQiO3M6MjM6IjE0MTA0MzIzMzg1NTI1MGE1MWQ2MmU1IjtzOjU6InBhcmFtIjthOjM6e3M6NDoibWJveCI7czo1OiJJTkJPWCI7czo5OiJzZW50X21ib3giO3M6NDoiU2VudCI7czoxMDoibWVzc2FnZS1pZCI7czo0OToiPDExYjYwNWQ5MTMwNWNkYmZiYTE2ZGEyZDU5NmE2YmU3QHRlc3QuY29tLmxvY2FsPiI7fXM6NzoibWFpbGJveCI7czo1OiJJTkJPWCI7czo0OiJtb2RlIjtOO31TVE9SQUdFX0FDTHxiOjE7');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` VALUES ('roundcube-version','2014042900');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `preferences` longtext,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`,`mail_host`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'postmaster@test.com.local','127.0.0.1','2015-04-08 14:00:29','2015-04-08 14:00:29','en_US',NULL),(2,'test666@test.com.local','127.0.0.1','2015-04-08 14:12:26','2015-04-08 14:31:37','en_US',NULL);
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

-- Dump completed on 2015-04-08 17:17:26
>>>>>>> origin/master
