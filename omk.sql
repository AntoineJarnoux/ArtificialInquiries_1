-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: omekas
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Table structure for table `api_key`
--

DROP TABLE IF EXISTS `api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_key` (
  `id` varchar(32) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `credential_hash` varchar(60) NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C912ED9D7E3C61F9` (`owner_id`),
  CONSTRAINT `FK_C912ED9D7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_key`
--

LOCK TABLES `api_key` WRITE;
/*!40000 ALTER TABLE `api_key` DISABLE KEYS */;
INSERT INTO `api_key` VALUES ('SDQSmycnfcMlLFbSUxpeLPzSNU8PCcme',1,'test','$2y$10$JfLmQ6qMBBwbus4Wr9IlCO1DBCqPDHynDdujADFMwl0VDh/XtKo4e','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0','2026-10-26 13:50:33','2026-10-06 07:24:01');
/*!40000 ALTER TABLE `api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset`
--

DROP TABLE IF EXISTS `asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `media_type` varchar(255) NOT NULL,
  `storage_id` varchar(190) NOT NULL,
  `extension` varchar(255) DEFAULT NULL,
  `alt_text` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2AF5A5C5CC5DB90` (`storage_id`),
  KEY `IDX_2AF5A5C7E3C61F9` (`owner_id`),
  CONSTRAINT `FK_2AF5A5C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset`
--

LOCK TABLES `asset` WRITE;
/*!40000 ALTER TABLE `asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fulltext_search`
--

DROP TABLE IF EXISTS `fulltext_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fulltext_search` (
  `id` int(11) NOT NULL,
  `resource` varchar(190) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  PRIMARY KEY (`id`,`resource`),
  KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`),
  FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`),
  CONSTRAINT `FK_AA31FE4A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fulltext_search`
--

LOCK TABLES `fulltext_search` WRITE;
/*!40000 ALTER TABLE `fulltext_search` DISABLE KEYS */;
INSERT INTO `fulltext_search` VALUES (3,'items',1,1,'Antoine','Antoine\n2026-10-19'),(4,'items',1,1,'À quoi ressemble un LLM ?','1\nÀ quoi ressemble un LLM ?\nDESSIN'),(5,'items',1,1,'À quoi ressemble ton environnement de travail ?','2\nÀ quoi ressemble ton environnement de travail ?\nDESSIN'),(6,'items',1,1,'En quelques mots, que fais-tu ?','3\nEn quelques mots, que fais-tu ?\nTEXTE'),(7,'items',1,1,'Draw It Like You See It','1\nDraw It Like You See It\n01 Qualifying\nDessine de tête, sans faire de recherche, comment tu imagines un LLM et ton environnement de travail, chacun dans un carré. Puis dis en quelques mots ce que tu fais.\nÀ quoi ressemble un LLM ?\nÀ quoi ressemble ton environnement de travail ?\nEn quelques mots, que fais-tu ?'),(8,'items',1,1,'Trait 1 — dessin LLM','Trait 1 — dessin LLM\nCRAYON\n#232a38\n7\n[[250,300],[650,300],[650,600],[250,600],[250,300]]'),(9,'items',1,1,'Trait 2 — dessin LLM','Trait 2 — dessin LLM\nCRAYON\n#2463eb\n7\n[[100,450],[250,450]]'),(10,'items',1,1,'Trait 3 — dessin LLM','Trait 3 — dessin LLM\nFEUTRE\n#e0a100\n7\n[[650,450],[800,450]]'),(11,'items',1,1,'Réponse dessin — LLM','Réponse dessin — LLM\nÀ quoi ressemble un LLM ?\nTrait 1 — dessin LLM\nTrait 2 — dessin LLM\nTrait 3 — dessin LLM\n2026-10-19T14:04'),(12,'media',1,1,NULL,''),(13,'items',1,1,'Trait 1 — dessin environnement de travail','Trait 1 — dessin environnement de travail\nCRAYON\n#232a38\n7\n[[150,650],[750,650]]'),(14,'items',1,1,'Trait 2 — dessin environnement de travail','Trait 2 — dessin environnement de travail\nCRAYON\n#232a38\n7\n[[300,350],[600,350],[600,550],[300,550],[300,350]]'),(15,'items',1,1,'Trait 3 — dessin environnement de travail','Trait 3 — dessin environnement de travail\nCRAYON\n#2e8b57\n3\n[[450,550],[450,650]]'),(16,'items',1,1,'Réponse dessin — environnement de travail','Réponse dessin — environnement de travail\nÀ quoi ressemble ton environnement de travail ?\nTrait 1 — dessin environnement de travail\nTrait 2 — dessin environnement de travail\nTrait 3 — dessin environnement de travail\n2026-10-19T14:04'),(17,'media',1,1,NULL,''),(18,'items',1,1,'Réponse texte — que fais-tu ?','Réponse texte — que fais-tu ?\nEn quelques mots, que fais-tu ?\nJe développe des services back-end en Java.\n2026-10-19T14:04'),(19,'items',1,1,'Passation 1 — Antoine — avant les autres exercices','Passation 1 — Antoine — avant les autres exercices\n2026-10-19T14:04\nAvant les autres exercices\nAntoine\nDraw It Like You See It\nRéponse dessin — LLM\nRéponse dessin — environnement de travail\nRéponse texte — que fais-tu ?');
/*!40000 ALTER TABLE `fulltext_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(11) NOT NULL,
  `primary_media_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1F1B251ECBE0B084` (`primary_media_id`),
  CONSTRAINT `FK_1F1B251EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1F1B251ECBE0B084` FOREIGN KEY (`primary_media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (3,NULL),(4,NULL),(5,NULL),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,NULL),(11,NULL),(13,NULL),(14,NULL),(15,NULL),(16,NULL),(18,NULL),(19,NULL);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_item_set`
--

DROP TABLE IF EXISTS `item_item_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_item_set` (
  `item_id` int(11) NOT NULL,
  `item_set_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`item_set_id`),
  KEY `IDX_6D0C9625126F525E` (`item_id`),
  KEY `IDX_6D0C9625960278D7` (`item_set_id`),
  CONSTRAINT `FK_6D0C9625126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6D0C9625960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_item_set`
--

LOCK TABLES `item_item_set` WRITE;
/*!40000 ALTER TABLE `item_item_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_item_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_set`
--

DROP TABLE IF EXISTS `item_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_set` (
  `id` int(11) NOT NULL,
  `is_open` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_1015EEEBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_set`
--

LOCK TABLES `item_set` WRITE;
/*!40000 ALTER TABLE `item_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_site`
--

DROP TABLE IF EXISTS `item_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_site` (
  `item_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`item_id`,`site_id`),
  KEY `IDX_A1734D1F126F525E` (`item_id`),
  KEY `IDX_A1734D1FF6BD1646` (`site_id`),
  CONSTRAINT `FK_A1734D1F126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A1734D1FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_site`
--

LOCK TABLES `item_site` WRITE;
/*!40000 ALTER TABLE `item_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `pid` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `class` varchar(255) NOT NULL,
  `args` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `log` longtext DEFAULT NULL,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FBD8E0F87E3C61F9` (`owner_id`),
  CONSTRAINT `FK_FBD8E0F87E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `ingester` varchar(255) NOT NULL,
  `renderer` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `source` longtext DEFAULT NULL,
  `media_type` varchar(190) DEFAULT NULL,
  `storage_id` varchar(190) DEFAULT NULL,
  `extension` varchar(255) DEFAULT NULL,
  `sha256` char(64) DEFAULT NULL,
  `size` bigint(20) DEFAULT NULL,
  `has_original` tinyint(1) NOT NULL,
  `has_thumbnails` tinyint(1) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `lang` varchar(190) DEFAULT NULL,
  `alt_text` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6A2CA10C5CC5DB90` (`storage_id`),
  KEY `IDX_6A2CA10C126F525E` (`item_id`),
  KEY `item_position` (`item_id`,`position`),
  KEY `media_type` (`media_type`),
  CONSTRAINT `FK_6A2CA10C126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `FK_6A2CA10CBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (12,11,'upload','file',NULL,'dessin-LLM.png','image/png','26994e9513ec5ee9cf92fff80e3ed84fb72c8812','png','303f4b72767a2ed529779de7f9da38f3abfe80b312fc8870ee0364f7cb4b0e74',20629,1,1,1,NULL,NULL),(17,16,'upload','file',NULL,'dessin-environnement-de-travail.png','image/png','1e3a012a54c2850b7ab5641d4dda9c417765bfd2','png','f49948f2962dc3e3c8c63f7c4bcaf61b22f3b090f234e82776c719077dfa9ae3',20077,1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `version` varchar(16) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('20171128053327'),('20180412035023'),('20180919072656'),('20180924033501'),('20181002015551'),('20181004043735'),('20181106060421'),('20190307043537'),('20190319020708'),('20190412090532'),('20190423040354'),('20190423071228'),('20190514061351'),('20190515055359'),('20190729023728'),('20190809092609'),('20190815062003'),('20200224022356'),('20200226064602'),('20200325091157'),('20200326091310'),('20200803000000'),('20200831000000'),('20210205101827'),('20210225095734'),('20210810083804'),('20220718090449'),('20220824103916'),('20230124033031'),('20230410074846'),('20230523085358'),('20230601060113'),('20230713101012'),('20231016000000'),('20240103030617'),('20240219000000'),('20240614123811');
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `id` varchar(190) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_creation`
--

DROP TABLE IF EXISTS `password_creation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C77917B4A76ED395` (`user_id`),
  CONSTRAINT `FK_C77917B4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_creation`
--

LOCK TABLES `password_creation` WRITE;
/*!40000 ALTER TABLE `password_creation` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_creation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `vocabulary_id` int(11) NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) NOT NULL,
  `comment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8BF21CDEAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  KEY `IDX_8BF21CDE7E3C61F9` (`owner_id`),
  KEY `IDX_8BF21CDEAD0E05F6` (`vocabulary_id`),
  CONSTRAINT `FK_8BF21CDE7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_8BF21CDEAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property`
--

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;
INSERT INTO `property` VALUES (1,NULL,1,'title','Title','A name given to the resource.'),(2,NULL,1,'creator','Creator','An entity primarily responsible for making the resource.'),(3,NULL,1,'subject','Subject','The topic of the resource.'),(4,NULL,1,'description','Description','An account of the resource.'),(5,NULL,1,'publisher','Publisher','An entity responsible for making the resource available.'),(6,NULL,1,'contributor','Contributor','An entity responsible for making contributions to the resource.'),(7,NULL,1,'date','Date','A point or period of time associated with an event in the lifecycle of the resource.'),(8,NULL,1,'type','Type','The nature or genre of the resource.'),(9,NULL,1,'format','Format','The file format, physical medium, or dimensions of the resource.'),(10,NULL,1,'identifier','Identifier','An unambiguous reference to the resource within a given context.'),(11,NULL,1,'source','Source','A related resource from which the described resource is derived.'),(12,NULL,1,'language','Language','A language of the resource.'),(13,NULL,1,'relation','Relation','A related resource.'),(14,NULL,1,'coverage','Coverage','The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.'),(15,NULL,1,'rights','Rights','Information about rights held in and over the resource.'),(16,NULL,1,'audience','Audience','A class of entity for whom the resource is intended or useful.'),(17,NULL,1,'alternative','Alternative Title','An alternative name for the resource.'),(18,NULL,1,'tableOfContents','Table Of Contents','A list of subunits of the resource.'),(19,NULL,1,'abstract','Abstract','A summary of the resource.'),(20,NULL,1,'created','Date Created','Date of creation of the resource.'),(21,NULL,1,'valid','Date Valid','Date (often a range) of validity of a resource.'),(22,NULL,1,'available','Date Available','Date (often a range) that the resource became or will become available.'),(23,NULL,1,'issued','Date Issued','Date of formal issuance (e.g., publication) of the resource.'),(24,NULL,1,'modified','Date Modified','Date on which the resource was changed.'),(25,NULL,1,'extent','Extent','The size or duration of the resource.'),(26,NULL,1,'medium','Medium','The material or physical carrier of the resource.'),(27,NULL,1,'isVersionOf','Is Version Of','A related resource of which the described resource is a version, edition, or adaptation.'),(28,NULL,1,'hasVersion','Has Version','A related resource that is a version, edition, or adaptation of the described resource.'),(29,NULL,1,'isReplacedBy','Is Replaced By','A related resource that supplants, displaces, or supersedes the described resource.'),(30,NULL,1,'replaces','Replaces','A related resource that is supplanted, displaced, or superseded by the described resource.'),(31,NULL,1,'isRequiredBy','Is Required By','A related resource that requires the described resource to support its function, delivery, or coherence.'),(32,NULL,1,'requires','Requires','A related resource that is required by the described resource to support its function, delivery, or coherence.'),(33,NULL,1,'isPartOf','Is Part Of','A related resource in which the described resource is physically or logically included.'),(34,NULL,1,'hasPart','Has Part','A related resource that is included either physically or logically in the described resource.'),(35,NULL,1,'isReferencedBy','Is Referenced By','A related resource that references, cites, or otherwise points to the described resource.'),(36,NULL,1,'references','References','A related resource that is referenced, cited, or otherwise pointed to by the described resource.'),(37,NULL,1,'isFormatOf','Is Format Of','A related resource that is substantially the same as the described resource, but in another format.'),(38,NULL,1,'hasFormat','Has Format','A related resource that is substantially the same as the pre-existing described resource, but in another format.'),(39,NULL,1,'conformsTo','Conforms To','An established standard to which the described resource conforms.'),(40,NULL,1,'spatial','Spatial Coverage','Spatial characteristics of the resource.'),(41,NULL,1,'temporal','Temporal Coverage','Temporal characteristics of the resource.'),(42,NULL,1,'mediator','Mediator','An entity that mediates access to the resource and for whom the resource is intended or useful.'),(43,NULL,1,'dateAccepted','Date Accepted','Date of acceptance of the resource.'),(44,NULL,1,'dateCopyrighted','Date Copyrighted','Date of copyright.'),(45,NULL,1,'dateSubmitted','Date Submitted','Date of submission of the resource.'),(46,NULL,1,'educationLevel','Audience Education Level','A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.'),(47,NULL,1,'accessRights','Access Rights','Information about who can access the resource or an indication of its security status.'),(48,NULL,1,'bibliographicCitation','Bibliographic Citation','A bibliographic reference for the resource.'),(49,NULL,1,'license','License','A legal document giving official permission to do something with the resource.'),(50,NULL,1,'rightsHolder','Rights Holder','A person or organization owning or managing rights over the resource.'),(51,NULL,1,'provenance','Provenance','A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.'),(52,NULL,1,'instructionalMethod','Instructional Method','A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.'),(53,NULL,1,'accrualMethod','Accrual Method','The method by which items are added to a collection.'),(54,NULL,1,'accrualPeriodicity','Accrual Periodicity','The frequency with which items are added to a collection.'),(55,NULL,1,'accrualPolicy','Accrual Policy','The policy governing the addition of items to a collection.'),(56,NULL,3,'affirmedBy','affirmedBy','A legal decision that affirms a ruling.'),(57,NULL,3,'annotates','annotates','Critical or explanatory note for a Document.'),(58,NULL,3,'authorList','list of authors','An ordered list of authors. Normally, this list is seen as a priority list that order authors by importance.'),(59,NULL,3,'citedBy','cited by','Relates a document to another document that cites the\nfirst document.'),(60,NULL,3,'cites','cites','Relates a document to another document that is cited\nby the first document as reference, comment, review, quotation or for\nanother purpose.'),(61,NULL,3,'contributorList','list of contributors','An ordered list of contributors. Normally, this list is seen as a priority list that order contributors by importance.'),(62,NULL,3,'court','court','A court associated with a legal document; for example, that which issues a decision.'),(63,NULL,3,'degree','degree','The thesis degree.'),(64,NULL,3,'director','director','A Film director.'),(65,NULL,3,'distributor','distributor','Distributor of a document or a collection of documents.'),(66,NULL,3,'editor','editor','A person having managerial and sometimes policy-making responsibility for the editorial part of a publishing firm or of a newspaper, magazine, or other publication.'),(67,NULL,3,'editorList','list of editors','An ordered list of editors. Normally, this list is seen as a priority list that order editors by importance.'),(68,NULL,3,'interviewee','interviewee','An agent that is interviewed by another agent.'),(69,NULL,3,'interviewer','interviewer','An agent that interview another agent.'),(70,NULL,3,'issuer','issuer','An entity responsible for issuing often informally published documents such as press releases, reports, etc.'),(71,NULL,3,'organizer','organizer','The organizer of an event; includes conference organizers, but also government agencies or other bodies that are responsible for conducting hearings.'),(72,NULL,3,'owner','owner','Owner of a document or a collection of documents.'),(73,NULL,3,'performer','performer',NULL),(74,NULL,3,'presentedAt','presented at','Relates a document to an event; for example, a paper to a conference.'),(75,NULL,3,'presents','presents','Relates an event to associated documents; for example, conference to a paper.'),(76,NULL,3,'producer','producer','Producer of a document or a collection of documents.'),(77,NULL,3,'recipient','recipient','An agent that receives a communication document.'),(78,NULL,3,'reproducedIn','reproducedIn','The resource in which another resource is reproduced.'),(79,NULL,3,'reversedBy','reversedBy','A legal decision that reverses a ruling.'),(80,NULL,3,'reviewOf','review of','Relates a review document to a reviewed thing (resource, item, etc.).'),(81,NULL,3,'status','status','The publication status of (typically academic) content.'),(82,NULL,3,'subsequentLegalDecision','subsequentLegalDecision','A legal decision on appeal that takes action on a case (affirming it, reversing it, etc.).'),(83,NULL,3,'transcriptOf','transcript of','Relates a document to some transcribed original.'),(84,NULL,3,'translationOf','translation of','Relates a translated document to the original document.'),(85,NULL,3,'translator','translator','A person who translates written document from one language to another.'),(86,NULL,3,'abstract','abstract','A summary of the resource.'),(87,NULL,3,'argued','date argued','The date on which a legal case is argued before a court. Date is of format xsd:date'),(88,NULL,3,'asin','asin',NULL),(89,NULL,3,'chapter','chapter','An chapter number'),(90,NULL,3,'coden','coden',NULL),(91,NULL,3,'content','content','This property is for a plain-text rendering of the content of a Document. While the plain-text content of an entire document could be described by this property.'),(92,NULL,3,'doi','doi',NULL),(93,NULL,3,'eanucc13','eanucc13',NULL),(94,NULL,3,'edition','edition','The name defining a special edition of a document. Normally its a literal value composed of a version number and words.'),(95,NULL,3,'eissn','eissn',NULL),(96,NULL,3,'gtin14','gtin14',NULL),(97,NULL,3,'handle','handle',NULL),(98,NULL,3,'identifier','identifier',NULL),(99,NULL,3,'isbn','isbn',NULL),(100,NULL,3,'isbn10','isbn10',NULL),(101,NULL,3,'isbn13','isbn13',NULL),(102,NULL,3,'issn','issn',NULL),(103,NULL,3,'issue','issue','An issue number'),(104,NULL,3,'lccn','lccn',NULL),(105,NULL,3,'locator','locator','A description (often numeric) that locates an item within a containing document or collection.'),(106,NULL,3,'numPages','number of pages','The number of pages contained in a document'),(107,NULL,3,'numVolumes','number of volumes','The number of volumes contained in a collection of documents (usually a series, periodical, etc.).'),(108,NULL,3,'number','number','A generic item or document number. Not to be confused with issue number.'),(109,NULL,3,'oclcnum','oclcnum',NULL),(110,NULL,3,'pageEnd','page end','Ending page number within a continuous page range.'),(111,NULL,3,'pageStart','page start','Starting page number within a continuous page range.'),(112,NULL,3,'pages','pages','A string of non-contiguous page spans that locate a Document within a Collection. Example: 23-25, 34, 54-56. For continuous page ranges, use the pageStart and pageEnd properties.'),(113,NULL,3,'pmid','pmid',NULL),(114,NULL,3,'prefixName','prefix name','The prefix of a name'),(115,NULL,3,'section','section','A section number'),(116,NULL,3,'shortDescription','shortDescription',NULL),(117,NULL,3,'shortTitle','short title','The abbreviation of a title.'),(118,NULL,3,'sici','sici',NULL),(119,NULL,3,'suffixName','suffix name','The suffix of a name'),(120,NULL,3,'upc','upc',NULL),(121,NULL,3,'uri','uri','Universal Resource Identifier of a document'),(122,NULL,3,'volume','volume','A volume number'),(123,NULL,4,'mbox','personal mailbox','A  personal mailbox, ie. an Internet mailbox associated with exactly one owner, the first owner of this mailbox. This is a \'static inverse functional property\', in that  there is (across time and change) at most one individual that ever has any particular value for foaf:mbox.'),(124,NULL,4,'mbox_sha1sum','sha1sum of a personal mailbox URI name','The sha1sum of the URI of an Internet mailbox associated with exactly one owner, the  first owner of the mailbox.'),(125,NULL,4,'gender','gender','The gender of this Agent (typically but not necessarily \'male\' or \'female\').'),(126,NULL,4,'geekcode','geekcode','A textual geekcode for this person, see http://www.geekcode.com/geek.html'),(127,NULL,4,'dnaChecksum','DNA checksum','A checksum for the DNA of some thing. Joke.'),(128,NULL,4,'sha1','sha1sum (hex)','A sha1sum hash, in hex.'),(129,NULL,4,'based_near','based near','A location that something is based near, for some broadly human notion of near.'),(130,NULL,4,'title','title','Title (Mr, Mrs, Ms, Dr. etc)'),(131,NULL,4,'nick','nickname','A short informal nickname characterising an agent (includes login identifiers, IRC and other chat nicknames).'),(132,NULL,4,'jabberID','jabber ID','A jabber ID for something.'),(133,NULL,4,'aimChatID','AIM chat ID','An AIM chat ID'),(134,NULL,4,'skypeID','Skype ID','A Skype ID'),(135,NULL,4,'icqChatID','ICQ chat ID','An ICQ chat ID'),(136,NULL,4,'yahooChatID','Yahoo chat ID','A Yahoo chat ID'),(137,NULL,4,'msnChatID','MSN chat ID','An MSN chat ID'),(138,NULL,4,'name','name','A name for some thing.'),(139,NULL,4,'firstName','firstName','The first name of a person.'),(140,NULL,4,'lastName','lastName','The last name of a person.'),(141,NULL,4,'givenName','Given name','The given name of some person.'),(142,NULL,4,'givenname','Given name','The given name of some person.'),(143,NULL,4,'surname','Surname','The surname of some person.'),(144,NULL,4,'family_name','family_name','The family name of some person.'),(145,NULL,4,'familyName','familyName','The family name of some person.'),(146,NULL,4,'phone','phone','A phone,  specified using fully qualified tel: URI scheme (refs: http://www.w3.org/Addressing/schemes.html#tel).'),(147,NULL,4,'homepage','homepage','A homepage for some thing.'),(148,NULL,4,'weblog','weblog','A weblog of some thing (whether person, group, company etc.).'),(149,NULL,4,'openid','openid','An OpenID for an Agent.'),(150,NULL,4,'tipjar','tipjar','A tipjar document for this agent, describing means for payment and reward.'),(151,NULL,4,'plan','plan','A .plan comment, in the tradition of finger and \'.plan\' files.'),(152,NULL,4,'made','made','Something that was made by this agent.'),(153,NULL,4,'maker','maker','An agent that  made this thing.'),(154,NULL,4,'img','image','An image that can be used to represent some thing (ie. those depictions which are particularly representative of something, eg. one\'s photo on a homepage).'),(155,NULL,4,'depiction','depiction','A depiction of some thing.'),(156,NULL,4,'depicts','depicts','A thing depicted in this representation.'),(157,NULL,4,'thumbnail','thumbnail','A derived thumbnail image.'),(158,NULL,4,'myersBriggs','myersBriggs','A Myers Briggs (MBTI) personality classification.'),(159,NULL,4,'workplaceHomepage','workplace homepage','A workplace homepage of some person; the homepage of an organization they work for.'),(160,NULL,4,'workInfoHomepage','work info homepage','A work info homepage of some person; a page about their work for some organization.'),(161,NULL,4,'schoolHomepage','schoolHomepage','A homepage of a school attended by the person.'),(162,NULL,4,'knows','knows','A person known by this person (indicating some level of reciprocated interaction between the parties).'),(163,NULL,4,'interest','interest','A page about a topic of interest to this person.'),(164,NULL,4,'topic_interest','topic_interest','A thing of interest to this person.'),(165,NULL,4,'publications','publications','A link to the publications of this person.'),(166,NULL,4,'currentProject','current project','A current project this person works on.'),(167,NULL,4,'pastProject','past project','A project this person has previously worked on.'),(168,NULL,4,'fundedBy','funded by','An organization funding a project or person.'),(169,NULL,4,'logo','logo','A logo representing some thing.'),(170,NULL,4,'topic','topic','A topic of some page or document.'),(171,NULL,4,'primaryTopic','primary topic','The primary topic of some page or document.'),(172,NULL,4,'focus','focus','The underlying or \'focal\' entity associated with some SKOS-described concept.'),(173,NULL,4,'isPrimaryTopicOf','is primary topic of','A document that this thing is the primary topic of.'),(174,NULL,4,'page','page','A page or document about this thing.'),(175,NULL,4,'theme','theme','A theme.'),(176,NULL,4,'account','account','Indicates an account held by this agent.'),(177,NULL,4,'holdsAccount','account','Indicates an account held by this agent.'),(178,NULL,4,'accountServiceHomepage','account service homepage','Indicates a homepage of the service provide for this online account.'),(179,NULL,4,'accountName','account name','Indicates the name (identifier) associated with this online account.'),(180,NULL,4,'member','member','Indicates a member of a Group'),(181,NULL,4,'membershipClass','membershipClass','Indicates the class of individuals that are a member of a Group'),(182,NULL,4,'birthday','birthday','The birthday of this Agent, represented in mm-dd string form, eg. \'12-31\'.'),(183,NULL,4,'age','age','The age in years of some agent.'),(184,NULL,4,'status','status','A string expressing what the user is happy for the general public (normally) to know about their current activity.'),(185,1,5,'pseudo','pseudo','Pseudo du participant.'),(186,1,5,'inscritLe','inscrit le','Date d\'inscription du participant.'),(187,1,5,'numero','numéro','Numéro de l\'exercice dans le vademecum.'),(188,1,5,'titre','titre','Titre de l\'exercice.'),(189,1,5,'bloc','bloc','Bloc du vademecum auquel appartient l\'exercice (ex. 01 Qualifying).'),(190,1,5,'consigne','consigne','Consigne de l\'exercice.'),(191,1,5,'contientQuestion','contient la question','Lien de l\'exercice vers une de ses questions.'),(192,1,5,'ordre','ordre','Position de la question dans l\'exercice.'),(193,1,5,'libelle','libellé','Texte de la question.'),(194,1,5,'typeQuestion','type de question','DESSIN ou TEXTE.'),(195,1,5,'datePassation','date de passation','Date et heure de la passation.'),(196,1,5,'moment','moment','Moment de la passation dans l\'enquête (ex. avant les autres exercices, après le bloc 03).'),(197,1,5,'realiseePar','réalisée par','Lien de la passation vers le participant qui l\'a faite.'),(198,1,5,'porteSur','porte sur','Lien de la passation vers l\'exercice.'),(199,1,5,'contientReponse','contient la réponse','Lien de la passation vers une de ses réponses.'),(200,1,5,'repondA','répond à','Lien de la réponse vers la question.'),(201,1,5,'modifieeLe','modifiée le','Date de dernière modification de la réponse.'),(202,1,5,'composeDe','composé du trait','Lien de la réponse dessin vers un de ses traits.'),(203,1,5,'texte','texte','Texte de la réponse écrite.'),(204,1,5,'outil','outil','CRAYON, FEUTRE ou GOMME.'),(205,1,5,'couleur','couleur','Couleur du trait (code hexadécimal, ex. #232a38).'),(206,1,5,'epaisseur','épaisseur','Épaisseur du trait en pixels.'),(207,1,5,'points','points','Points par lesquels passe le trait, en JSON : [[x, y], [x, y], …].');
/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `resource_class_id` int(11) DEFAULT NULL,
  `resource_template_id` int(11) DEFAULT NULL,
  `thumbnail_id` int(11) DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BC91F4167E3C61F9` (`owner_id`),
  KEY `IDX_BC91F416448CC1BD` (`resource_class_id`),
  KEY `IDX_BC91F41616131EA` (`resource_template_id`),
  KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`),
  KEY `title` (`title`(190)),
  KEY `is_public` (`is_public`),
  CONSTRAINT `FK_BC91F41616131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_BC91F416448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_BC91F4167E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_BC91F416FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` VALUES (3,1,106,3,NULL,'Antoine',1,'2026-10-19 11:59:42','2026-10-19 11:59:42','Omeka\\Entity\\Item'),(4,1,108,5,NULL,'À quoi ressemble un LLM ?',1,'2026-10-19 11:59:42','2026-10-19 11:59:42','Omeka\\Entity\\Item'),(5,1,108,5,NULL,'À quoi ressemble ton environnement de travail ?',1,'2026-10-19 11:59:43','2026-10-19 11:59:43','Omeka\\Entity\\Item'),(6,1,108,5,NULL,'En quelques mots, que fais-tu ?',1,'2026-10-19 11:59:43','2026-10-19 11:59:43','Omeka\\Entity\\Item'),(7,1,107,2,NULL,'Draw It Like You See It',1,'2026-10-19 11:59:43','2026-10-19 11:59:43','Omeka\\Entity\\Item'),(8,1,113,8,NULL,'Trait 1 — dessin LLM',1,'2026-10-19 11:59:43','2026-10-19 11:59:43','Omeka\\Entity\\Item'),(9,1,113,8,NULL,'Trait 2 — dessin LLM',1,'2026-10-19 11:59:43','2026-10-19 11:59:43','Omeka\\Entity\\Item'),(10,1,113,8,NULL,'Trait 3 — dessin LLM',1,'2026-10-19 11:59:44','2026-10-19 11:59:44','Omeka\\Entity\\Item'),(11,1,111,6,NULL,'Réponse dessin — LLM',1,'2026-10-19 12:04:14','2026-10-19 12:04:14','Omeka\\Entity\\Item'),(12,1,NULL,NULL,NULL,NULL,1,'2026-10-19 12:04:14','2026-10-19 12:04:14','Omeka\\Entity\\Media'),(13,1,113,8,NULL,'Trait 1 — dessin environnement de travail',1,'2026-10-19 12:04:15','2026-10-19 12:04:15','Omeka\\Entity\\Item'),(14,1,113,8,NULL,'Trait 2 — dessin environnement de travail',1,'2026-10-19 12:04:15','2026-10-19 12:04:15','Omeka\\Entity\\Item'),(15,1,113,8,NULL,'Trait 3 — dessin environnement de travail',1,'2026-10-19 12:04:15','2026-10-19 12:04:15','Omeka\\Entity\\Item'),(16,1,111,6,NULL,'Réponse dessin — environnement de travail',1,'2026-10-19 12:04:17','2026-10-19 12:04:17','Omeka\\Entity\\Item'),(17,1,NULL,NULL,NULL,NULL,1,'2026-10-19 12:04:17','2026-10-19 12:04:17','Omeka\\Entity\\Media'),(18,1,112,7,NULL,'Réponse texte — que fais-tu ?',1,'2026-10-19 12:04:17','2026-10-19 12:04:17','Omeka\\Entity\\Item'),(19,1,109,4,NULL,'Passation 1 — Antoine — avant les autres exercices',1,'2026-10-19 12:04:17','2026-10-19 12:04:17','Omeka\\Entity\\Item');
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_class`
--

DROP TABLE IF EXISTS `resource_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `vocabulary_id` int(11) NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) NOT NULL,
  `comment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C6F063ADAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  KEY `IDX_C6F063AD7E3C61F9` (`owner_id`),
  KEY `IDX_C6F063ADAD0E05F6` (`vocabulary_id`),
  CONSTRAINT `FK_C6F063AD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_C6F063ADAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_class`
--

LOCK TABLES `resource_class` WRITE;
/*!40000 ALTER TABLE `resource_class` DISABLE KEYS */;
INSERT INTO `resource_class` VALUES (1,NULL,1,'Agent','Agent','A resource that acts or has the power to act.'),(2,NULL,1,'AgentClass','Agent Class','A group of agents.'),(3,NULL,1,'BibliographicResource','Bibliographic Resource','A book, article, or other documentary resource.'),(4,NULL,1,'FileFormat','File Format','A digital resource format.'),(5,NULL,1,'Frequency','Frequency','A rate at which something recurs.'),(6,NULL,1,'Jurisdiction','Jurisdiction','The extent or range of judicial, law enforcement, or other authority.'),(7,NULL,1,'LicenseDocument','License Document','A legal document giving official permission to do something with a Resource.'),(8,NULL,1,'LinguisticSystem','Linguistic System','A system of signs, symbols, sounds, gestures, or rules used in communication.'),(9,NULL,1,'Location','Location','A spatial region or named place.'),(10,NULL,1,'LocationPeriodOrJurisdiction','Location, Period, or Jurisdiction','A location, period of time, or jurisdiction.'),(11,NULL,1,'MediaType','Media Type','A file format or physical medium.'),(12,NULL,1,'MediaTypeOrExtent','Media Type or Extent','A media type or extent.'),(13,NULL,1,'MethodOfInstruction','Method of Instruction','A process that is used to engender knowledge, attitudes, and skills.'),(14,NULL,1,'MethodOfAccrual','Method of Accrual','A method by which resources are added to a collection.'),(15,NULL,1,'PeriodOfTime','Period of Time','An interval of time that is named or defined by its start and end dates.'),(16,NULL,1,'PhysicalMedium','Physical Medium','A physical material or carrier.'),(17,NULL,1,'PhysicalResource','Physical Resource','A material thing.'),(18,NULL,1,'Policy','Policy','A plan or course of action by an authority, intended to influence and determine decisions, actions, and other matters.'),(19,NULL,1,'ProvenanceStatement','Provenance Statement','A statement of any changes in ownership and custody of a resource since its creation that are significant for its authenticity, integrity, and interpretation.'),(20,NULL,1,'RightsStatement','Rights Statement','A statement about the intellectual property rights (IPR) held in or over a Resource, a legal document giving official permission to do something with a resource, or a statement about access rights.'),(21,NULL,1,'SizeOrDuration','Size or Duration','A dimension or extent, or a time taken to play or execute.'),(22,NULL,1,'Standard','Standard','A basis for comparison; a reference point against which other things can be evaluated.'),(23,NULL,2,'Collection','Collection','An aggregation of resources.'),(24,NULL,2,'Dataset','Dataset','Data encoded in a defined structure.'),(25,NULL,2,'Event','Event','A non-persistent, time-based occurrence.'),(26,NULL,2,'Image','Image','A visual representation other than text.'),(27,NULL,2,'InteractiveResource','Interactive Resource','A resource requiring interaction from the user to be understood, executed, or experienced.'),(28,NULL,2,'Service','Service','A system that provides one or more functions.'),(29,NULL,2,'Software','Software','A computer program in source or compiled form.'),(30,NULL,2,'Sound','Sound','A resource primarily intended to be heard.'),(31,NULL,2,'Text','Text','A resource consisting primarily of words for reading.'),(32,NULL,2,'PhysicalObject','Physical Object','An inanimate, three-dimensional object or substance.'),(33,NULL,2,'StillImage','Still Image','A static visual representation.'),(34,NULL,2,'MovingImage','Moving Image','A series of visual representations imparting an impression of motion when shown in succession.'),(35,NULL,3,'AcademicArticle','Academic Article','A scholarly academic article, typically published in a journal.'),(36,NULL,3,'Article','Article','A written composition in prose, usually nonfiction, on a specific topic, forming an independent part of a book or other publication, as a newspaper or magazine.'),(37,NULL,3,'AudioDocument','audio document','An audio document; aka record.'),(38,NULL,3,'AudioVisualDocument','audio-visual document','An audio-visual document; film, video, and so forth.'),(39,NULL,3,'Bill','Bill','Draft legislation presented for discussion to a legal body.'),(40,NULL,3,'Book','Book','A written or printed work of fiction or nonfiction, usually on sheets of paper fastened or bound together within covers.'),(41,NULL,3,'BookSection','Book Section','A section of a book.'),(42,NULL,3,'Brief','Brief','A written argument submitted to a court.'),(43,NULL,3,'Chapter','Chapter','A chapter of a book.'),(44,NULL,3,'Code','Code','A collection of statutes.'),(45,NULL,3,'CollectedDocument','Collected Document','A document that simultaneously contains other documents.'),(46,NULL,3,'Collection','Collection','A collection of Documents or Collections'),(47,NULL,3,'Conference','Conference','A meeting for consultation or discussion.'),(48,NULL,3,'CourtReporter','Court Reporter','A collection of legal cases.'),(49,NULL,3,'Document','Document','A document (noun) is a bounded physical representation of body of information designed with the capacity (and usually intent) to communicate. A document may manifest symbolic, diagrammatic or sensory-representational information.'),(50,NULL,3,'DocumentPart','document part','a distinct part of a larger document or collected document.'),(51,NULL,3,'DocumentStatus','Document Status','The status of the publication of a document.'),(52,NULL,3,'EditedBook','Edited Book','An edited book.'),(53,NULL,3,'Email','EMail','A written communication addressed to a person or organization and transmitted electronically.'),(54,NULL,3,'Event','Event',NULL),(55,NULL,3,'Excerpt','Excerpt','A passage selected from a larger work.'),(56,NULL,3,'Film','Film','aka movie.'),(57,NULL,3,'Hearing','Hearing','An instance or a session in which testimony and arguments are presented, esp. before an official, as a judge in a lawsuit.'),(58,NULL,3,'Image','Image','A document that presents visual or diagrammatic information.'),(59,NULL,3,'Interview','Interview','A formalized discussion between two or more people.'),(60,NULL,3,'Issue','Issue','something that is printed or published and distributed, esp. a given number of a periodical'),(61,NULL,3,'Journal','Journal','A periodical of scholarly journal Articles.'),(62,NULL,3,'LegalCaseDocument','Legal Case Document','A document accompanying a legal case.'),(63,NULL,3,'LegalDecision','Decision','A document containing an authoritative determination (as a decree or judgment) made after consideration of facts or law.'),(64,NULL,3,'LegalDocument','Legal Document','A legal document; for example, a court decision, a brief, and so forth.'),(65,NULL,3,'Legislation','Legislation','A legal document proposing or enacting a law or a group of laws.'),(66,NULL,3,'Letter','Letter','A written or printed communication addressed to a person or organization and usually transmitted by mail.'),(67,NULL,3,'Magazine','Magazine','A periodical of magazine Articles. A magazine is a publication that is issued periodically, usually bound in a paper cover, and typically contains essays, stories, poems, etc., by many writers, and often photographs and drawings, frequently specializing in a particular subject or area, as hobbies, news, or sports.'),(68,NULL,3,'Manual','Manual','A small reference book, especially one giving instructions.'),(69,NULL,3,'Manuscript','Manuscript','An unpublished Document, which may also be submitted to a publisher for publication.'),(70,NULL,3,'Map','Map','A graphical depiction of geographic features.'),(71,NULL,3,'MultiVolumeBook','Multivolume Book','A loose, thematic, collection of Documents, often Books.'),(72,NULL,3,'Newspaper','Newspaper','A periodical of documents, usually issued daily or weekly, containing current news, editorials, feature articles, and usually advertising.'),(73,NULL,3,'Note','Note','Notes or annotations about a resource.'),(74,NULL,3,'Patent','Patent','A document describing the exclusive right granted by a government to an inventor to manufacture, use, or sell an invention for a certain number of years.'),(75,NULL,3,'Performance','Performance','A public performance.'),(76,NULL,3,'Periodical','Periodical','A group of related documents issued at regular intervals.'),(77,NULL,3,'PersonalCommunication','Personal Communication','A communication between an agent and one or more specific recipients.'),(78,NULL,3,'PersonalCommunicationDocument','Personal Communication Document','A personal communication manifested in some document.'),(79,NULL,3,'Proceedings','Proceedings','A compilation of documents published from an event, such as a conference.'),(80,NULL,3,'Quote','Quote','An excerpted collection of words.'),(81,NULL,3,'ReferenceSource','Reference Source','A document that presents authoritative reference information, such as a dictionary or encylopedia .'),(82,NULL,3,'Report','Report','A document describing an account or statement describing in detail an event, situation, or the like, usually as the result of observation, inquiry, etc..'),(83,NULL,3,'Series','Series','A loose, thematic, collection of Documents, often Books.'),(84,NULL,3,'Slide','Slide','A slide in a slideshow'),(85,NULL,3,'Slideshow','Slideshow','A presentation of a series of slides, usually presented in front of an audience with written text and images.'),(86,NULL,3,'Standard','Standard','A document describing a standard'),(87,NULL,3,'Statute','Statute','A bill enacted into law.'),(88,NULL,3,'Thesis','Thesis','A document created to summarize research findings associated with the completion of an academic degree.'),(89,NULL,3,'ThesisDegree','Thesis degree','The academic degree of a Thesis'),(90,NULL,3,'Webpage','Webpage','A web page is an online document available (at least initially) on the world wide web. A web page is written first and foremost to appear on the web, as distinct from other online resources such as books, manuscripts or audio documents which use the web primarily as a distribution mechanism alongside other more traditional methods such as print.'),(91,NULL,3,'Website','Website','A group of Webpages accessible on the Web.'),(92,NULL,3,'Workshop','Workshop','A seminar, discussion group, or the like, that emphasizes zxchange of ideas and the demonstration and application of techniques, skills, etc.'),(93,NULL,4,'LabelProperty','Label Property','A foaf:LabelProperty is any RDF property with texual values that serve as labels.'),(94,NULL,4,'Person','Person','A person.'),(95,NULL,4,'Document','Document','A document.'),(96,NULL,4,'Organization','Organization','An organization.'),(97,NULL,4,'Group','Group','A class of Agents.'),(98,NULL,4,'Agent','Agent','An agent (eg. person, group, software or physical artifact).'),(99,NULL,4,'Project','Project','A project (a collective endeavour of some kind).'),(100,NULL,4,'Image','Image','An image.'),(101,NULL,4,'PersonalProfileDocument','PersonalProfileDocument','A personal profile RDF document.'),(102,NULL,4,'OnlineAccount','Online Account','An online account.'),(103,NULL,4,'OnlineGamingAccount','Online Gaming Account','An online gaming account.'),(104,NULL,4,'OnlineEcommerceAccount','Online E-commerce Account','An online e-commerce account.'),(105,NULL,4,'OnlineChatAccount','Online Chat Account','An online chat account.'),(106,1,5,'Participant','Participant','Personne qui fait l\'exercice.'),(107,1,5,'Exercice','Exercice','Exercice du vademecum Artificial Inquiries (ex. exercice 1 « Draw It Like You See It »).'),(108,1,5,'Question','Question','Question ou consigne d\'un exercice, à laquelle on répond par un dessin ou un texte.'),(109,1,5,'Passation','Passation','Une fois où un participant fait l\'exercice, à une date et à un moment donnés.'),(110,1,5,'Reponse','Réponse','Réponse à une question pendant une passation (classe abstraite).'),(111,1,5,'ReponseDessin','Réponse dessin','Réponse dessinée dans un carré, composée de traits. L\'image PNG est jointe en média.'),(112,1,5,'ReponseTexte','Réponse texte','Réponse écrite à une question.'),(113,1,5,'Trait','Trait','Un trait d\'un dessin : outil, couleur, épaisseur et liste des points par lesquels il passe.');
/*!40000 ALTER TABLE `resource_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_template`
--

DROP TABLE IF EXISTS `resource_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `resource_class_id` int(11) DEFAULT NULL,
  `title_property_id` int(11) DEFAULT NULL,
  `description_property_id` int(11) DEFAULT NULL,
  `label` varchar(190) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_39ECD52EEA750E8` (`label`),
  KEY `IDX_39ECD52E7E3C61F9` (`owner_id`),
  KEY `IDX_39ECD52E448CC1BD` (`resource_class_id`),
  KEY `IDX_39ECD52E724734A3` (`title_property_id`),
  KEY `IDX_39ECD52EB84E0D1D` (`description_property_id`),
  CONSTRAINT `FK_39ECD52E448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_39ECD52E724734A3` FOREIGN KEY (`title_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_39ECD52E7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_39ECD52EB84E0D1D` FOREIGN KEY (`description_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_template`
--

LOCK TABLES `resource_template` WRITE;
/*!40000 ALTER TABLE `resource_template` DISABLE KEYS */;
INSERT INTO `resource_template` VALUES (1,NULL,NULL,NULL,NULL,'Base Resource'),(2,1,107,188,190,'artinq_Exercice'),(3,1,106,185,NULL,'artinq_Participant'),(4,1,109,1,NULL,'artinq_Passation'),(5,1,108,193,NULL,'artinq_Question'),(6,1,111,1,NULL,'artinq_ReponseDessin'),(7,1,112,1,NULL,'artinq_ReponseTexte'),(8,1,113,1,NULL,'artinq_Trait');
/*!40000 ALTER TABLE `resource_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_template_property`
--

DROP TABLE IF EXISTS `resource_template_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resource_template_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_template_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `alternate_label` varchar(255) DEFAULT NULL,
  `alternate_comment` longtext DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `data_type` longtext DEFAULT NULL COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_4689E2F116131EA549213EC` (`resource_template_id`,`property_id`),
  KEY `IDX_4689E2F116131EA` (`resource_template_id`),
  KEY `IDX_4689E2F1549213EC` (`property_id`),
  CONSTRAINT `FK_4689E2F116131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`),
  CONSTRAINT `FK_4689E2F1549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_template_property`
--

LOCK TABLES `resource_template_property` WRITE;
/*!40000 ALTER TABLE `resource_template_property` DISABLE KEYS */;
INSERT INTO `resource_template_property` VALUES (1,1,1,NULL,NULL,1,NULL,0,0,NULL),(2,1,15,NULL,NULL,2,NULL,0,0,NULL),(3,1,8,NULL,NULL,3,NULL,0,0,NULL),(4,1,2,NULL,NULL,4,NULL,0,0,NULL),(5,1,7,NULL,NULL,5,NULL,0,0,NULL),(6,1,4,NULL,NULL,6,NULL,0,0,NULL),(7,1,9,NULL,NULL,7,NULL,0,0,NULL),(8,1,12,NULL,NULL,8,NULL,0,0,NULL),(9,1,40,'Place',NULL,9,NULL,0,0,NULL),(10,1,5,NULL,NULL,10,NULL,0,0,NULL),(11,1,17,NULL,NULL,11,NULL,0,0,NULL),(12,1,6,NULL,NULL,12,NULL,0,0,NULL),(13,1,25,NULL,NULL,13,NULL,0,0,NULL),(14,1,10,NULL,NULL,14,NULL,0,0,NULL),(15,1,13,NULL,NULL,15,NULL,0,0,NULL),(16,1,29,NULL,NULL,16,NULL,0,0,NULL),(17,1,30,NULL,NULL,17,NULL,0,0,NULL),(18,1,50,NULL,NULL,18,NULL,0,0,NULL),(19,1,3,NULL,NULL,19,NULL,0,0,NULL),(20,1,41,NULL,NULL,20,NULL,0,0,NULL),(21,2,187,NULL,NULL,1,'[\"literal\"]',1,0,NULL),(22,2,188,NULL,NULL,2,'[\"literal\"]',1,0,NULL),(23,2,189,NULL,NULL,3,'[\"literal\"]',0,0,NULL),(24,2,190,NULL,NULL,4,'[\"literal\"]',0,0,NULL),(25,2,191,NULL,NULL,5,'[\"resource:item\"]',0,0,NULL),(26,3,185,NULL,NULL,1,'[\"literal\"]',1,0,NULL),(27,3,186,NULL,NULL,2,'[\"literal\"]',0,0,NULL),(28,4,1,'Titre de la passation',NULL,1,'[\"literal\"]',0,0,NULL),(29,4,195,NULL,NULL,2,'[\"literal\"]',1,0,NULL),(30,4,196,NULL,NULL,3,'[\"literal\"]',0,0,NULL),(31,4,197,NULL,NULL,4,'[\"resource:item\"]',1,0,NULL),(32,4,198,NULL,NULL,5,'[\"resource:item\"]',1,0,NULL),(33,4,199,NULL,NULL,6,'[\"resource:item\"]',0,0,NULL),(34,5,192,NULL,NULL,1,'[\"literal\"]',1,0,NULL),(35,5,193,NULL,NULL,2,'[\"literal\"]',1,0,NULL),(36,5,194,NULL,NULL,3,'[\"literal\"]',1,0,NULL),(37,6,1,'Titre de la réponse',NULL,1,'[\"literal\"]',0,0,NULL),(38,6,200,NULL,NULL,2,'[\"resource:item\"]',1,0,NULL),(39,6,202,NULL,NULL,3,'[\"resource:item\"]',0,0,NULL),(40,6,201,NULL,NULL,4,'[\"literal\"]',0,0,NULL),(41,7,1,'Titre de la réponse',NULL,1,'[\"literal\"]',0,0,NULL),(42,7,200,NULL,NULL,2,'[\"resource:item\"]',1,0,NULL),(43,7,203,NULL,NULL,3,'[\"literal\"]',1,0,NULL),(44,7,201,NULL,NULL,4,'[\"literal\"]',0,0,NULL),(45,8,1,'Titre du trait',NULL,1,'[\"literal\"]',0,0,NULL),(46,8,204,NULL,NULL,2,'[\"literal\"]',1,0,NULL),(47,8,205,NULL,NULL,3,'[\"literal\"]',0,0,NULL),(48,8,206,NULL,NULL,4,'[\"literal\"]',0,0,NULL),(49,8,207,NULL,NULL,5,'[\"literal\"]',1,0,NULL),(50,3,179,'compte','Identifiant du compte utilisé pour se connecter (fournisseur:identifiant, ex. github:AntoineJarnoux)',3,'[\"literal\"]',0,0,NULL);
/*!40000 ALTER TABLE `resource_template_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` varchar(190) NOT NULL,
  `data` longblob NOT NULL,
  `modified` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES ('bc54i8udoheu66ruf62jjairk8','__Laminas|a:3:{s:20:\"_REQUEST_ACCESS_TIME\";d:1792410616.435169;s:6:\"_VALID\";a:1:{s:28:\"Laminas\\Session\\Validator\\Id\";s:26:\"bc54i8udoheu66ruf62jjairk8\";}s:42:\"Laminas_Validator_Csrf_salt_loginform_csrf\";a:1:{s:6:\"EXPIRE\";i:1792453817;}}redirect_url|s:30:\"http://localhost/omeka-s/admin\";Laminas_Validator_Csrf_salt_loginform_csrf|O:26:\"Laminas\\Stdlib\\ArrayObject\":4:{s:7:\"storage\";a:2:{s:9:\"tokenList\";a:1:{s:32:\"ac3e3a3dd24c965963e99dab47f4b090\";s:32:\"ddb8adcaffe98dea25022fb03ee03e40\";}s:4:\"hash\";s:65:\"ddb8adcaffe98dea25022fb03ee03e40-ac3e3a3dd24c965963e99dab47f4b090\";}s:4:\"flag\";i:2;s:13:\"iteratorClass\";s:13:\"ArrayIterator\";s:19:\"protectedProperties\";a:4:{i:0;s:7:\"storage\";i:1;s:4:\"flag\";i:2;s:13:\"iteratorClass\";i:3;s:19:\"protectedProperties\";}}',1792410618),('eickna31pc30iuurtevihecra8','__Laminas|a:4:{s:20:\"_REQUEST_ACCESS_TIME\";d:1791271442.292775;s:6:\"_VALID\";a:1:{s:28:\"Laminas\\Session\\Validator\\Id\";s:26:\"9vp4j0p5usbvdq0lm3qdjspej9\";}s:42:\"Laminas_Validator_Csrf_salt_loginform_csrf\";a:1:{s:6:\"EXPIRE\";i:1791314607;}s:32:\"Laminas_Validator_Csrf_salt_csrf\";a:1:{s:6:\"EXPIRE\";i:1791314642;}}Laminas_Validator_Csrf_salt_loginform_csrf|O:26:\"Laminas\\Stdlib\\ArrayObject\":4:{s:7:\"storage\";a:2:{s:9:\"tokenList\";a:1:{s:32:\"da9427ece4c9c9f468e71dc804ec8164\";s:32:\"1739d73c6be712186b3b0a2b7c20a9b8\";}s:4:\"hash\";s:65:\"1739d73c6be712186b3b0a2b7c20a9b8-da9427ece4c9c9f468e71dc804ec8164\";}s:4:\"flag\";i:2;s:13:\"iteratorClass\";s:13:\"ArrayIterator\";s:19:\"protectedProperties\";a:4:{i:0;s:7:\"storage\";i:1;s:4:\"flag\";i:2;s:13:\"iteratorClass\";i:3;s:19:\"protectedProperties\";}}Laminas_Auth|O:26:\"Laminas\\Stdlib\\ArrayObject\":4:{s:7:\"storage\";a:1:{s:7:\"storage\";i:1;}s:4:\"flag\";i:2;s:13:\"iteratorClass\";s:13:\"ArrayIterator\";s:19:\"protectedProperties\";a:4:{i:0;s:7:\"storage\";i:1;s:4:\"flag\";i:2;s:13:\"iteratorClass\";i:3;s:19:\"protectedProperties\";}}OmekaMessenger|O:26:\"Laminas\\Stdlib\\ArrayObject\":4:{s:7:\"storage\";a:0:{}s:4:\"flag\";i:2;s:13:\"iteratorClass\";s:13:\"ArrayIterator\";s:19:\"protectedProperties\";a:4:{i:0;s:7:\"storage\";i:1;s:4:\"flag\";i:2;s:13:\"iteratorClass\";i:3;s:19:\"protectedProperties\";}}redirect_url|N;Laminas_Validator_Csrf_salt_csrf|O:26:\"Laminas\\Stdlib\\ArrayObject\":4:{s:7:\"storage\";a:2:{s:9:\"tokenList\";a:2:{s:32:\"83a3d7e729df2d2d3ad5874b4d79f300\";s:32:\"419c9c2ebe57795f37dac08ded472619\";s:32:\"ef24d905656e90a427f6c625ee05248b\";s:32:\"9992f749188ff1542c9634ee45df50a2\";}s:4:\"hash\";s:65:\"9992f749188ff1542c9634ee45df50a2-ef24d905656e90a427f6c625ee05248b\";}s:4:\"flag\";i:2;s:13:\"iteratorClass\";s:13:\"ArrayIterator\";s:19:\"protectedProperties\";a:4:{i:0;s:7:\"storage\";i:1;s:4:\"flag\";i:2;s:13:\"iteratorClass\";i:3;s:19:\"protectedProperties\";}}',1791271442);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `setting` (
  `id` varchar(190) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES ('administrator_email','\"antjarnoux@gmail.com\"'),('extension_whitelist','[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"webp\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\"]'),('installation_title','\"test\"'),('locale','\"fr\"'),('media_type_whitelist','[\"application\\/msword\",\"application\\/ogg\",\"application\\/pdf\",\"application\\/rtf\",\"application\\/vnd.ms-access\",\"application\\/vnd.ms-excel\",\"application\\/vnd.ms-powerpoint\",\"application\\/vnd.ms-project\",\"application\\/vnd.ms-write\",\"application\\/vnd.oasis.opendocument.chart\",\"application\\/vnd.oasis.opendocument.database\",\"application\\/vnd.oasis.opendocument.formula\",\"application\\/vnd.oasis.opendocument.graphics\",\"application\\/vnd.oasis.opendocument.presentation\",\"application\\/vnd.oasis.opendocument.spreadsheet\",\"application\\/vnd.oasis.opendocument.text\",\"application\\/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"application\\/vnd.openxmlformats-officedocument.presentationml.presentation\",\"application\\/vnd.openxmlformats-officedocument.spreadsheetml.sheet\",\"application\\/x-gzip\",\"application\\/x-ms-wmp\",\"application\\/x-msdownload\",\"application\\/x-shockwave-flash\",\"application\\/x-tar\",\"application\\/zip\",\"audio\\/midi\",\"audio\\/mp4\",\"audio\\/mpeg\",\"audio\\/ogg\",\"audio\\/x-aac\",\"audio\\/x-aiff\",\"audio\\/x-ms-wma\",\"audio\\/x-ms-wax\",\"audio\\/x-realaudio\",\"audio\\/x-wav\",\"image\\/bmp\",\"image\\/gif\",\"image\\/jp2\",\"image\\/jpeg\",\"image\\/pjpeg\",\"image\\/png\",\"image\\/tiff\",\"image\\/webp\",\"image\\/x-icon\",\"text\\/css\",\"text\\/plain\",\"text\\/richtext\",\"video\\/divx\",\"video\\/mp4\",\"video\\/mpeg\",\"video\\/ogg\",\"video\\/quicktime\",\"video\\/webm\",\"video\\/x-ms-asf,\",\"video\\/x-msvideo\",\"video\\/x-ms-wmv\"]'),('pagination_per_page','25'),('time_zone','\"Europe\\/Berlin\"'),('use_htmlpurifier','\"1\"'),('version','\"4.2.1\"'),('version_notifications','\"1\"');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail_id` int(11) DEFAULT NULL,
  `homepage_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `slug` varchar(190) NOT NULL,
  `theme` varchar(190) NOT NULL,
  `title` varchar(190) NOT NULL,
  `summary` longtext DEFAULT NULL,
  `navigation` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `item_pool` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `assign_new_items` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_694309E4989D9B62` (`slug`),
  UNIQUE KEY `UNIQ_694309E4571EDDA` (`homepage_id`),
  KEY `IDX_694309E4FDFF2E92` (`thumbnail_id`),
  KEY `IDX_694309E47E3C61F9` (`owner_id`),
  CONSTRAINT `FK_694309E4571EDDA` FOREIGN KEY (`homepage_id`) REFERENCES `site_page` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_694309E47E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_694309E4FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_block_attachment`
--

DROP TABLE IF EXISTS `site_block_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_block_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `block_id` int(11) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `caption` longtext NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_236473FEE9ED820C` (`block_id`),
  KEY `IDX_236473FE126F525E` (`item_id`),
  KEY `IDX_236473FEEA9FDD75` (`media_id`),
  KEY `block_position` (`block_id`,`position`),
  CONSTRAINT `FK_236473FE126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_236473FEE9ED820C` FOREIGN KEY (`block_id`) REFERENCES `site_page_block` (`id`),
  CONSTRAINT `FK_236473FEEA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_block_attachment`
--

LOCK TABLES `site_block_attachment` WRITE;
/*!40000 ALTER TABLE `site_block_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_block_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_item_set`
--

DROP TABLE IF EXISTS `site_item_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_item_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `item_set_id` int(11) NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_D4CE134F6BD1646960278D7` (`site_id`,`item_set_id`),
  KEY `IDX_D4CE134F6BD1646` (`site_id`),
  KEY `IDX_D4CE134960278D7` (`item_set_id`),
  KEY `position` (`position`),
  CONSTRAINT `FK_D4CE134960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D4CE134F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_item_set`
--

LOCK TABLES `site_item_set` WRITE;
/*!40000 ALTER TABLE `site_item_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_item_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_page`
--

DROP TABLE IF EXISTS `site_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `slug` varchar(190) NOT NULL,
  `title` varchar(190) NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `layout` varchar(255) DEFAULT NULL,
  `layout_data` longtext DEFAULT NULL COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2F900BD9F6BD1646989D9B62` (`site_id`,`slug`),
  KEY `is_public` (`is_public`),
  KEY `IDX_2F900BD9F6BD1646` (`site_id`),
  CONSTRAINT `FK_2F900BD9F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_page`
--

LOCK TABLES `site_page` WRITE;
/*!40000 ALTER TABLE `site_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_page_block`
--

DROP TABLE IF EXISTS `site_page_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_page_block` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `layout` varchar(80) NOT NULL,
  `data` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  `layout_data` longtext DEFAULT NULL COMMENT '(DC2Type:json)',
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C593E731C4663E4` (`page_id`),
  KEY `page_position` (`page_id`,`position`),
  CONSTRAINT `FK_C593E731C4663E4` FOREIGN KEY (`page_id`) REFERENCES `site_page` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_page_block`
--

LOCK TABLES `site_page_block` WRITE;
/*!40000 ALTER TABLE `site_page_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_page_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_permission`
--

DROP TABLE IF EXISTS `site_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_C0401D6FF6BD1646A76ED395` (`site_id`,`user_id`),
  KEY `IDX_C0401D6FF6BD1646` (`site_id`),
  KEY `IDX_C0401D6FA76ED395` (`user_id`),
  CONSTRAINT `FK_C0401D6FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_C0401D6FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_permission`
--

LOCK TABLES `site_permission` WRITE;
/*!40000 ALTER TABLE `site_permission` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_setting`
--

DROP TABLE IF EXISTS `site_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_setting` (
  `id` varchar(190) NOT NULL,
  `site_id` int(11) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`,`site_id`),
  KEY `IDX_64D05A53F6BD1646` (`site_id`),
  CONSTRAINT `FK_64D05A53F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_setting`
--

LOCK TABLES `site_setting` WRITE;
/*!40000 ALTER TABLE `site_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `site_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(190) NOT NULL,
  `name` varchar(190) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) DEFAULT NULL,
  `role` varchar(190) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'antjarnoux@gmail.com','Antoine','2026-10-06 07:23:27','2026-10-06 07:23:27','$2y$10$BvQ/pKZbiUKiRhtOpI6vd.NsuUM.XswOTOa4B755dx4JZLNSBUUtO','global_admin',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_setting`
--

DROP TABLE IF EXISTS `user_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_setting` (
  `id` varchar(190) NOT NULL,
  `user_id` int(11) NOT NULL,
  `value` longtext NOT NULL COMMENT '(DC2Type:json_array)',
  PRIMARY KEY (`id`,`user_id`),
  KEY `IDX_C779A692A76ED395` (`user_id`),
  CONSTRAINT `FK_C779A692A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_setting`
--

LOCK TABLES `user_setting` WRITE;
/*!40000 ALTER TABLE `user_setting` DISABLE KEYS */;
INSERT INTO `user_setting` VALUES ('browse_defaults_admin_item_sets',1,'{\"sort_by\":\"id\",\"sort_order\":\"desc\"}'),('browse_defaults_admin_items',1,'{\"sort_by\":\"id\",\"sort_order\":\"desc\"}'),('browse_defaults_admin_media',1,'{\"sort_by\":\"id\",\"sort_order\":\"desc\"}'),('browse_defaults_admin_sites',1,'{\"sort_by\":\"title\",\"sort_order\":\"asc\"}'),('columns_admin_item_sets',1,'[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),('columns_admin_items',1,'[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),('columns_admin_media',1,'[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),('columns_admin_sites',1,'[{\"type\":\"slug\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),('default_resource_template',1,'\"\"'),('locale',1,'\"fr\"');
/*!40000 ALTER TABLE `user_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `value`
--

DROP TABLE IF EXISTS `value`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `value_resource_id` int(11) DEFAULT NULL,
  `value_annotation_id` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `lang` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `uri` longtext DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1D7758349B66727E` (`value_annotation_id`),
  KEY `IDX_1D77583489329D25` (`resource_id`),
  KEY `IDX_1D775834549213EC` (`property_id`),
  KEY `IDX_1D7758344BC72506` (`value_resource_id`),
  KEY `value` (`value`(190)),
  KEY `uri` (`uri`(190)),
  KEY `is_public` (`is_public`),
  CONSTRAINT `FK_1D7758344BC72506` FOREIGN KEY (`value_resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1D775834549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_1D77583489329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  CONSTRAINT `FK_1D7758349B66727E` FOREIGN KEY (`value_annotation_id`) REFERENCES `value_annotation` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `value`
--

LOCK TABLES `value` WRITE;
/*!40000 ALTER TABLE `value` DISABLE KEYS */;
INSERT INTO `value` VALUES (2,3,185,NULL,NULL,'literal',NULL,'Antoine',NULL,1),(3,3,186,NULL,NULL,'literal',NULL,'2026-10-19',NULL,1),(4,4,192,NULL,NULL,'literal',NULL,'1',NULL,1),(5,4,193,NULL,NULL,'literal',NULL,'À quoi ressemble un LLM ?',NULL,1),(6,4,194,NULL,NULL,'literal',NULL,'DESSIN',NULL,1),(7,5,192,NULL,NULL,'literal',NULL,'2',NULL,1),(8,5,193,NULL,NULL,'literal',NULL,'À quoi ressemble ton environnement de travail ?',NULL,1),(9,5,194,NULL,NULL,'literal',NULL,'DESSIN',NULL,1),(10,6,192,NULL,NULL,'literal',NULL,'3',NULL,1),(11,6,193,NULL,NULL,'literal',NULL,'En quelques mots, que fais-tu ?',NULL,1),(12,6,194,NULL,NULL,'literal',NULL,'TEXTE',NULL,1),(13,7,187,NULL,NULL,'literal',NULL,'1',NULL,1),(14,7,188,NULL,NULL,'literal',NULL,'Draw It Like You See It',NULL,1),(15,7,189,NULL,NULL,'literal',NULL,'01 Qualifying',NULL,1),(16,7,190,NULL,NULL,'literal',NULL,'Dessine de tête, sans faire de recherche, comment tu imagines un LLM et ton environnement de travail, chacun dans un carré. Puis dis en quelques mots ce que tu fais.',NULL,1),(17,7,191,4,NULL,'resource',NULL,NULL,NULL,1),(18,7,191,5,NULL,'resource',NULL,NULL,NULL,1),(19,7,191,6,NULL,'resource',NULL,NULL,NULL,1),(20,8,1,NULL,NULL,'literal',NULL,'Trait 1 — dessin LLM',NULL,1),(21,8,204,NULL,NULL,'literal',NULL,'CRAYON',NULL,1),(22,8,205,NULL,NULL,'literal',NULL,'#232a38',NULL,1),(23,8,206,NULL,NULL,'literal',NULL,'7',NULL,1),(24,8,207,NULL,NULL,'literal',NULL,'[[250,300],[650,300],[650,600],[250,600],[250,300]]',NULL,1),(25,9,1,NULL,NULL,'literal',NULL,'Trait 2 — dessin LLM',NULL,1),(26,9,204,NULL,NULL,'literal',NULL,'CRAYON',NULL,1),(27,9,205,NULL,NULL,'literal',NULL,'#2463eb',NULL,1),(28,9,206,NULL,NULL,'literal',NULL,'7',NULL,1),(29,9,207,NULL,NULL,'literal',NULL,'[[100,450],[250,450]]',NULL,1),(30,10,1,NULL,NULL,'literal',NULL,'Trait 3 — dessin LLM',NULL,1),(31,10,204,NULL,NULL,'literal',NULL,'FEUTRE',NULL,1),(32,10,205,NULL,NULL,'literal',NULL,'#e0a100',NULL,1),(33,10,206,NULL,NULL,'literal',NULL,'7',NULL,1),(34,10,207,NULL,NULL,'literal',NULL,'[[650,450],[800,450]]',NULL,1),(35,11,1,NULL,NULL,'literal',NULL,'Réponse dessin — LLM',NULL,1),(36,11,200,4,NULL,'resource',NULL,NULL,NULL,1),(37,11,202,8,NULL,'resource',NULL,NULL,NULL,1),(38,11,202,9,NULL,'resource',NULL,NULL,NULL,1),(39,11,202,10,NULL,'resource',NULL,NULL,NULL,1),(40,11,201,NULL,NULL,'literal',NULL,'2026-10-19T14:04',NULL,1),(41,13,1,NULL,NULL,'literal',NULL,'Trait 1 — dessin environnement de travail',NULL,1),(42,13,204,NULL,NULL,'literal',NULL,'CRAYON',NULL,1),(43,13,205,NULL,NULL,'literal',NULL,'#232a38',NULL,1),(44,13,206,NULL,NULL,'literal',NULL,'7',NULL,1),(45,13,207,NULL,NULL,'literal',NULL,'[[150,650],[750,650]]',NULL,1),(46,14,1,NULL,NULL,'literal',NULL,'Trait 2 — dessin environnement de travail',NULL,1),(47,14,204,NULL,NULL,'literal',NULL,'CRAYON',NULL,1),(48,14,205,NULL,NULL,'literal',NULL,'#232a38',NULL,1),(49,14,206,NULL,NULL,'literal',NULL,'7',NULL,1),(50,14,207,NULL,NULL,'literal',NULL,'[[300,350],[600,350],[600,550],[300,550],[300,350]]',NULL,1),(51,15,1,NULL,NULL,'literal',NULL,'Trait 3 — dessin environnement de travail',NULL,1),(52,15,204,NULL,NULL,'literal',NULL,'CRAYON',NULL,1),(53,15,205,NULL,NULL,'literal',NULL,'#2e8b57',NULL,1),(54,15,206,NULL,NULL,'literal',NULL,'3',NULL,1),(55,15,207,NULL,NULL,'literal',NULL,'[[450,550],[450,650]]',NULL,1),(56,16,1,NULL,NULL,'literal',NULL,'Réponse dessin — environnement de travail',NULL,1),(57,16,200,5,NULL,'resource',NULL,NULL,NULL,1),(58,16,202,13,NULL,'resource',NULL,NULL,NULL,1),(59,16,202,14,NULL,'resource',NULL,NULL,NULL,1),(60,16,202,15,NULL,'resource',NULL,NULL,NULL,1),(61,16,201,NULL,NULL,'literal',NULL,'2026-10-19T14:04',NULL,1),(62,18,1,NULL,NULL,'literal',NULL,'Réponse texte — que fais-tu ?',NULL,1),(63,18,200,6,NULL,'resource',NULL,NULL,NULL,1),(64,18,203,NULL,NULL,'literal',NULL,'Je développe des services back-end en Java.',NULL,1),(65,18,201,NULL,NULL,'literal',NULL,'2026-10-19T14:04',NULL,1),(66,19,1,NULL,NULL,'literal',NULL,'Passation 1 — Antoine — avant les autres exercices',NULL,1),(67,19,195,NULL,NULL,'literal',NULL,'2026-10-19T14:04',NULL,1),(68,19,196,NULL,NULL,'literal',NULL,'Avant les autres exercices',NULL,1),(69,19,197,3,NULL,'resource',NULL,NULL,NULL,1),(70,19,198,7,NULL,'resource',NULL,NULL,NULL,1),(71,19,199,11,NULL,'resource',NULL,NULL,NULL,1),(72,19,199,16,NULL,'resource',NULL,NULL,NULL,1),(73,19,199,18,NULL,'resource',NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `value` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `value_annotation`
--

DROP TABLE IF EXISTS `value_annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `value_annotation` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_C03BA4EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `value_annotation`
--

LOCK TABLES `value_annotation` WRITE;
/*!40000 ALTER TABLE `value_annotation` DISABLE KEYS */;
/*!40000 ALTER TABLE `value_annotation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vocabulary`
--

DROP TABLE IF EXISTS `vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vocabulary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `namespace_uri` varchar(190) NOT NULL,
  `prefix` varchar(190) NOT NULL,
  `label` varchar(255) NOT NULL,
  `comment` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9099C97B9B267FDF` (`namespace_uri`),
  UNIQUE KEY `UNIQ_9099C97B93B1868E` (`prefix`),
  KEY `IDX_9099C97B7E3C61F9` (`owner_id`),
  CONSTRAINT `FK_9099C97B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vocabulary`
--

LOCK TABLES `vocabulary` WRITE;
/*!40000 ALTER TABLE `vocabulary` DISABLE KEYS */;
INSERT INTO `vocabulary` VALUES (1,NULL,'http://purl.org/dc/terms/','dcterms','Dublin Core','Basic resource metadata (DCMI Metadata Terms)'),(2,NULL,'http://purl.org/dc/dcmitype/','dctype','Dublin Core Type','Basic resource types (DCMI Type Vocabulary)'),(3,NULL,'http://purl.org/ontology/bibo/','bibo','Bibliographic Ontology','Bibliographic metadata (BIBO)'),(4,NULL,'http://xmlns.com/foaf/0.1/','foaf','Friend of a Friend','Relationships between people and organizations (FOAF)'),(5,1,'https://humanum-p8.fr/omk_artificialinquiries/onto/artinq#','artinq','Artificial Inquiries','Vocabulaire de l\'exercice 1 « Draw It Like You See It » du vademecum Artificial Inquiries');
/*!40000 ALTER TABLE `vocabulary` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-26 20:43:16
