-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: gva
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `attribute_options`
--

DROP TABLE IF EXISTS `attribute_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_options` (
  `id` int NOT NULL COMMENT '属性選択肢ID (手動割当)',
  `attribute_id` int NOT NULL COMMENT '属性ID',
  `value` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '表示値',
  `option_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '選択肢コード',
  `sort_order` int DEFAULT '0' COMMENT '表示順',
  `swatch_image_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'スウォッチ画像URL',
  `color_code` varchar(7) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '色コード (#RRGGBB)',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_attribute_option_code` (`attribute_id`,`option_code`),
  KEY `idx_attribute_options_attribute_id` (`attribute_id`),
  CONSTRAINT `attribute_options_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='属性が選択式の場合の選択肢マスタ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_options`
--

LOCK TABLES `attribute_options` WRITE;
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;
INSERT INTO `attribute_options` VALUES (101,1,'グレー','gray',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(102,1,'ネイビー','navy',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(103,1,'ベージュ','beige',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(104,1,'ホワイト','white',40,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(105,1,'ブラック','black',50,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(106,1,'ブラウン','brown',60,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(107,1,'グリーン','green',70,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(108,1,'レッド','red',80,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(109,1,'ブルー','blue',90,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(201,2,'シングル','single',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(202,2,'セミダブル','semi_double',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(203,2,'ダブル','double',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(204,2,'クイーン','queen',40,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(205,2,'キング','king',50,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(206,2,'S','s',60,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(207,2,'M','m',70,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(208,2,'L','l',80,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(209,2,'フリーサイズ','free',90,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(301,3,'ポリエステル','polyester',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(302,3,'綿','cotton',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(303,3,'木製','wood',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(304,3,'スチール','steel',40,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(305,3,'合成皮革','synthetic_leather',50,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(306,3,'本革','genuine_leather',60,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(307,3,'ガラス','glass',70,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(308,3,'プラスチック','plastic',80,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1001,10,'日本','jp',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1002,10,'中国','cn',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1003,10,'ベトナム','vn',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1004,10,'タイ','th',40,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1005,10,'マレーシア','my',50,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1201,12,'USBポート付き','usb_port',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1202,12,'調光機能付き','dimmable',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1203,12,'防水','waterproof',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1204,12,'防ダニ','anti_mite',40,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1205,12,'抗菌防臭','antibacterial_odor',50,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1206,12,'リクライニング','reclining',60,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1301,13,'やわらかめ','soft',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1302,13,'ふつう','medium',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1303,13,'かため','firm',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1601,16,'ACアダプター','ac_adapter',10,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1602,16,'乾電池式','battery',20,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1603,16,'USB充電式','usb_rechargeable',30,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32');
/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attributes` (
  `id` int NOT NULL COMMENT '属性ID (手動割当)',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性名',
  `attribute_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '属性コード',
  `input_type` enum('select','text','number','boolean','textarea') COLLATE utf8mb4_general_ci NOT NULL COMMENT '入力形式',
  `display_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'text' COMMENT '表示タイプ (text, image, color_chip等)',
  `is_filterable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '絞り込み検索対象か',
  `is_comparable` tinyint(1) NOT NULL DEFAULT '0' COMMENT '商品比較対象か',
  `sort_order` int DEFAULT '0' COMMENT '表示順',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_code` (`attribute_code`),
  KEY `idx_attributes_is_filterable` (`is_filterable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SKUを構成する属性（仕様）の定義';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (1,'カラー','color','select','text',1,1,10,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(2,'サイズ（選択）','size_select','select','text',1,1,20,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(3,'素材','material','select','text',1,0,30,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(4,'幅(cm)','width_cm','number','text',1,1,40,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(5,'奥行(cm)','depth_cm','number','text',1,1,50,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(6,'高さ(cm)','height_cm','number','text',1,1,60,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(7,'重量(kg)','weight_kg','number','text',0,1,70,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(8,'組立有無','assembly_required','boolean','text',1,0,80,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(9,'梱包サイズ','package_size','text','text',0,0,90,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(10,'原産国','country_of_origin','select','text',1,0,100,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(11,'保証年数','warranty','text','text',0,0,110,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(12,'機能','feature','select','text',1,0,120,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(13,'硬さ（マットレス）','firmness','select','text',1,1,130,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(14,'容量(L)','capacity_l','number','text',1,1,140,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(15,'対応畳数','room_size_tatami','number','text',1,0,150,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(16,'電源タイプ','power_source','select','text',1,0,160,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(17,'備考','remarks','textarea','text',0,0,999,'2025-05-22 19:35:32','2025-05-22 19:35:32');
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_products`
--

DROP TABLE IF EXISTS `campaign_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '関連ID',
  `campaign_id` bigint unsigned NOT NULL COMMENT 'キャンペーンID',
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT '対象商品ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_campaign_product` (`campaign_id`,`product_id`),
  KEY `idx_campaign_products_campaign_id` (`campaign_id`),
  KEY `idx_campaign_products_product_id` (`product_id`),
  CONSTRAINT `campaign_products_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `campaign_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='キャンペーンと対象商品の関連付け';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_products`
--

LOCK TABLES `campaign_products` WRITE;
/*!40000 ALTER TABLE `campaign_products` DISABLE KEYS */;
INSERT INTO `campaign_products` VALUES (1,1,'product-0001'),(2,1,'product-0004'),(3,1,'product-0005'),(4,1,'product-0010'),(5,1,'product-1003'),(6,1,'product-1004'),(7,2,'product-0006'),(8,2,'product-1005'),(9,3,'product-0009'),(10,3,'product-kettle-001');
/*!40000 ALTER TABLE `campaign_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'キャンペーンID',
  `campaign_code` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'キャンペーンコード (URLスラッグ等)',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'キャンペーン名',
  `description` text COLLATE utf8mb4_general_ci COMMENT 'キャンペーン詳細説明',
  `catchphrase` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'キャッチフレーズ (一覧表示用)',
  `banner_image_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'バナー画像URL (一覧表示用)',
  `main_visual_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'メインビジュアル画像URL (詳細ページ用)',
  `start_date` datetime NOT NULL COMMENT '開始日時',
  `end_date` datetime NOT NULL COMMENT '終了日時',
  `target_type` enum('all_products','specific_categories','specific_products') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'specific_products' COMMENT '対象タイプ',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '有効フラグ',
  `sort_order` int DEFAULT '0' COMMENT '表示優先度',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_code` (`campaign_code`),
  KEY `idx_campaigns_active_dates_sort` (`is_active`,`start_date`,`end_date`,`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='キャンペーン情報';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES (1,'newlife2024','新生活応援キャンペーン2024','新生活に必要な家具やインテリアがお得に揃うチャンス！対象商品10%OFFクーポンも配布中。','新生活をニトリで始めよう！','https://dummyimage.com/300x150/f0e68c/000&text=NewLifeBanner','https://dummyimage.com/1200x400/f0e68c/000&text=NewLifeMainVisual','2025-05-07 19:49:58','2025-06-06 19:49:58','specific_products',1,10,'2025-05-22 19:49:58','2025-05-22 19:49:58'),(2,'summercool2024','Nクール夏物特集2024','今年もニトリのNクールでひんやり快適な夏を。新作Nクール寝具やリビングアイテムをご紹介。','夏の暑さ対策はNクールで決まり！','https://dummyimage.com/300x150/add8e6/000&text=NCoolBanner','https://dummyimage.com/1200x400/add8e6/000&text=NCoolMainVisual','2025-05-17 19:49:58','2025-07-01 19:49:58','specific_products',1,5,'2025-05-22 19:49:58','2025-05-22 19:49:58'),(3,'kitchenfair2024','キッチン用品フェア','毎日の料理が楽しくなる、便利なキッチンツールやおしゃれな食器がお買い得。','お得に揃えるキッチンアイテム','https://dummyimage.com/300x150/ffdab9/000&text=KitchenFair',NULL,'2025-06-01 19:49:58','2025-06-16 19:49:58','specific_categories',1,20,'2025-05-22 19:49:58','2025-05-22 19:49:58'),(4,'clearance_sale_2023win','冬物クリアランスセール','冬物アイテム最終処分！在庫限りの大特価。','冬物最終値下げ！','https://dummyimage.com/300x150/a9a9a9/fff&text=ClearanceBanner',NULL,'2025-04-07 19:49:58','2025-05-07 19:49:58','specific_products',0,30,'2025-05-22 19:49:58','2025-05-22 19:49:58');
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casbin_rule`
--

DROP TABLE IF EXISTS `casbin_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casbin_rule` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v0` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v1` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v2` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v3` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v4` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `v5` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_casbin_rule` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casbin_rule`
--

LOCK TABLES `casbin_rule` WRITE;
/*!40000 ALTER TABLE `casbin_rule` DISABLE KEYS */;
INSERT INTO `casbin_rule` VALUES (2,'p','888','/api/createApi','POST','','',''),(5,'p','888','/api/deleteApi','POST','','',''),(8,'p','888','/api/deleteApisByIds','DELETE','','',''),(11,'p','888','/api/enterSyncApi','POST','','',''),(7,'p','888','/api/getAllApis','POST','','',''),(4,'p','888','/api/getApiById','POST','','',''),(10,'p','888','/api/getApiGroups','GET','','',''),(3,'p','888','/api/getApiList','POST','','',''),(12,'p','888','/api/ignoreApi','POST','','',''),(206,'p','888','/api/products/getProductInfo','GET',NULL,NULL,NULL),(9,'p','888','/api/syncApi','GET','','',''),(6,'p','888','/api/updateApi','POST','','',''),(122,'p','888','/attachmentCategory/addCategory','POST','','',''),(123,'p','888','/attachmentCategory/deleteCategory','POST','','',''),(121,'p','888','/attachmentCategory/getCategoryList','GET','','',''),(13,'p','888','/authority/copyAuthority','POST','','',''),(15,'p','888','/authority/createAuthority','POST','','',''),(16,'p','888','/authority/deleteAuthority','POST','','',''),(17,'p','888','/authority/getAuthorityList','POST','','',''),(18,'p','888','/authority/setDataAuthority','POST','','',''),(14,'p','888','/authority/updateAuthority','PUT','','',''),(98,'p','888','/authorityBtn/canRemoveAuthorityBtn','POST','','',''),(97,'p','888','/authorityBtn/getAuthorityBtn','POST','','',''),(96,'p','888','/authorityBtn/setAuthorityBtn','POST','','',''),(74,'p','888','/autoCode/addFunc','POST','','',''),(67,'p','888','/autoCode/createPackage','POST','','',''),(71,'p','888','/autoCode/createPlug','POST','','',''),(64,'p','888','/autoCode/createTemp','POST','','',''),(70,'p','888','/autoCode/delPackage','POST','','',''),(65,'p','888','/autoCode/delSysHistory','POST','','',''),(62,'p','888','/autoCode/getColumn','GET','','',''),(58,'p','888','/autoCode/getDB','GET','','',''),(59,'p','888','/autoCode/getMeta','POST','','',''),(69,'p','888','/autoCode/getPackage','POST','','',''),(66,'p','888','/autoCode/getSysHistory','POST','','',''),(61,'p','888','/autoCode/getTables','GET','','',''),(68,'p','888','/autoCode/getTemplates','GET','','',''),(72,'p','888','/autoCode/installPlugin','POST','','',''),(60,'p','888','/autoCode/preview','POST','','',''),(73,'p','888','/autoCode/pubPlug','POST','','',''),(63,'p','888','/autoCode/rollback','POST','','',''),(222,'p','888','/cart','GET',NULL,NULL,NULL),(223,'p','888','/cart/items','POST',NULL,NULL,NULL),(225,'p','888','/cart/items/:skuId','DELETE',NULL,NULL,NULL),(224,'p','888','/cart/items/:skuId','PUT',NULL,NULL,NULL),(48,'p','888','/casbin/getPolicyPathByAuthorityId','POST','','',''),(47,'p','888','/casbin/updateCasbin','POST','','',''),(240,'p','888','/categories/:categoryId','GET',NULL,NULL,NULL),(239,'p','888','/categories/tree','GET',NULL,NULL,NULL),(56,'p','888','/customer/customer','DELETE','','',''),(53,'p','888','/customer/customer','GET','','',''),(55,'p','888','/customer/customer','POST','','',''),(54,'p','888','/customer/customer','PUT','','',''),(57,'p','888','/customer/customerList','GET','','',''),(91,'p','888','/email/emailTest','POST','','',''),(92,'p','888','/email/sendEmail','POST','','',''),(217,'p','888','/favorites/skus','GET',NULL,NULL,NULL),(226,'p','888','/favorites/skus','POST',NULL,NULL,NULL),(216,'p','888','/favorites/skus/:skuId','DELETE',NULL,NULL,NULL),(215,'p','888','/favorites/skus/:skuId','POST',NULL,NULL,NULL),(40,'p','888','/fileUploadAndDownload/breakpointContinue','POST','','',''),(39,'p','888','/fileUploadAndDownload/breakpointContinueFinish','POST','','',''),(43,'p','888','/fileUploadAndDownload/deleteFile','POST','','',''),(44,'p','888','/fileUploadAndDownload/editFileName','POST','','',''),(38,'p','888','/fileUploadAndDownload/findFile','GET','','',''),(45,'p','888','/fileUploadAndDownload/getFileList','POST','','',''),(46,'p','888','/fileUploadAndDownload/importURL','POST','','',''),(41,'p','888','/fileUploadAndDownload/removeChunk','POST','','',''),(42,'p','888','/fileUploadAndDownload/upload','POST','','',''),(209,'p','888','/getProductInfo/*','GET',NULL,NULL,NULL),(208,'p','888','/getProductInfo/:productCode','GET',NULL,NULL,NULL),(220,'p','888','/history/viewed-skus','GET',NULL,NULL,NULL),(221,'p','888','/history/viewed-skus','POST',NULL,NULL,NULL),(108,'p','888','/info/createInfo','POST','','',''),(109,'p','888','/info/deleteInfo','DELETE','','',''),(110,'p','888','/info/deleteInfoByIds','DELETE','','',''),(112,'p','888','/info/findInfo','GET','','',''),(113,'p','888','/info/getInfoList','GET','','',''),(111,'p','888','/info/updateInfo','PUT','','',''),(49,'p','888','/jwt/jsonInBlacklist','POST','','',''),(21,'p','888','/menu/addBaseMenu','POST','','',''),(23,'p','888','/menu/addMenuAuthority','POST','','',''),(25,'p','888','/menu/deleteBaseMenu','POST','','',''),(27,'p','888','/menu/getBaseMenuById','POST','','',''),(22,'p','888','/menu/getBaseMenuTree','POST','','',''),(19,'p','888','/menu/getMenu','POST','','',''),(24,'p','888','/menu/getMenuAuthority','POST','','',''),(20,'p','888','/menu/getMenuList','POST','','',''),(26,'p','888','/menu/updateBaseMenu','POST','','',''),(237,'p','888','/orders','GET',NULL,NULL,NULL),(236,'p','888','/orders','POST',NULL,NULL,NULL),(238,'p','888','/orders/:orderId','GET',NULL,NULL,NULL),(232,'p','888','/orders/checkout/apply-coupon','POST',NULL,NULL,NULL),(231,'p','888','/orders/checkout/info','GET',NULL,NULL,NULL),(234,'p','888','/orders/checkout/remove-coupon','DELETE',NULL,NULL,NULL),(235,'p','888','/orders/checkout/remove-points','DELETE',NULL,NULL,NULL),(233,'p','888','/orders/checkout/use-points','POST',NULL,NULL,NULL),(219,'p','888','/products/getCoordinates/:productCode/coordinates','GET',NULL,NULL,NULL),(214,'p','888','/products/getImage/:skuId/images','GET',NULL,NULL,NULL),(207,'p','888','/products/getProductInfo','GET',NULL,NULL,NULL),(211,'p','888','/products/getProductInfo/*','GET',NULL,NULL,NULL),(213,'p','888','/products/getQA/:productCode/qa','GET',NULL,NULL,NULL),(218,'p','888','/products/getRelated/:productCode/related','GET',NULL,NULL,NULL),(212,'p','888','/products/getReviews/:productCode/reviews','GET',NULL,NULL,NULL),(228,'p','888','/shipping-addresses','GET',NULL,NULL,NULL),(227,'p','888','/shipping-addresses','POST',NULL,NULL,NULL),(230,'p','888','/shipping-addresses/:addressId','DELETE',NULL,NULL,NULL),(229,'p','888','/shipping-addresses/:addressId','PUT',NULL,NULL,NULL),(94,'p','888','/simpleUploader/checkFileMd5','GET','','',''),(95,'p','888','/simpleUploader/mergeFileMd5','GET','','',''),(93,'p','888','/simpleUploader/upload','POST','','',''),(83,'p','888','/sysDictionary/createSysDictionary','POST','','',''),(84,'p','888','/sysDictionary/deleteSysDictionary','DELETE','','',''),(80,'p','888','/sysDictionary/findSysDictionary','GET','','',''),(82,'p','888','/sysDictionary/getSysDictionaryList','GET','','',''),(81,'p','888','/sysDictionary/updateSysDictionary','PUT','','',''),(77,'p','888','/sysDictionaryDetail/createSysDictionaryDetail','POST','','',''),(79,'p','888','/sysDictionaryDetail/deleteSysDictionaryDetail','DELETE','','',''),(75,'p','888','/sysDictionaryDetail/findSysDictionaryDetail','GET','','',''),(78,'p','888','/sysDictionaryDetail/getSysDictionaryDetailList','GET','','',''),(76,'p','888','/sysDictionaryDetail/updateSysDictionaryDetail','PUT','','',''),(99,'p','888','/sysExportTemplate/createSysExportTemplate','POST','','',''),(100,'p','888','/sysExportTemplate/deleteSysExportTemplate','DELETE','','',''),(101,'p','888','/sysExportTemplate/deleteSysExportTemplateByIds','DELETE','','',''),(105,'p','888','/sysExportTemplate/exportExcel','GET','','',''),(106,'p','888','/sysExportTemplate/exportTemplate','GET','','',''),(103,'p','888','/sysExportTemplate/findSysExportTemplate','GET','','',''),(104,'p','888','/sysExportTemplate/getSysExportTemplateList','GET','','',''),(107,'p','888','/sysExportTemplate/importExcel','POST','','',''),(102,'p','888','/sysExportTemplate/updateSysExportTemplate','PUT','','',''),(87,'p','888','/sysOperationRecord/createSysOperationRecord','POST','','',''),(89,'p','888','/sysOperationRecord/deleteSysOperationRecord','DELETE','','',''),(90,'p','888','/sysOperationRecord/deleteSysOperationRecordByIds','DELETE','','',''),(85,'p','888','/sysOperationRecord/findSysOperationRecord','GET','','',''),(88,'p','888','/sysOperationRecord/getSysOperationRecordList','GET','','',''),(86,'p','888','/sysOperationRecord/updateSysOperationRecord','PUT','','',''),(114,'p','888','/sysParams/createSysParams','POST','','',''),(115,'p','888','/sysParams/deleteSysParams','DELETE','','',''),(116,'p','888','/sysParams/deleteSysParamsByIds','DELETE','','',''),(118,'p','888','/sysParams/findSysParams','GET','','',''),(120,'p','888','/sysParams/getSysParam','GET','','',''),(119,'p','888','/sysParams/getSysParamsList','GET','','',''),(117,'p','888','/sysParams/updateSysParams','PUT','','',''),(52,'p','888','/system/getServerInfo','POST','','',''),(50,'p','888','/system/getSystemConfig','POST','','',''),(51,'p','888','/system/setSystemConfig','POST','','',''),(1,'p','888','/user/admin_register','POST','','',''),(33,'p','888','/user/changePassword','POST','','',''),(205,'p','888','/user/deleteLoginHistoryByIdAndTimeRange','POST',NULL,NULL,NULL),(32,'p','888','/user/deleteUser','DELETE','','',''),(203,'p','888','/user/getLoginHistoryById','GET',NULL,NULL,NULL),(204,'p','888','/user/getLoginHistoryByIdAndTimeRange','POST',NULL,NULL,NULL),(28,'p','888','/user/getUserInfo','GET','','',''),(31,'p','888','/user/getUserList','POST','','',''),(36,'p','888','/user/resetPassword','POST','','',''),(30,'p','888','/user/setSelfInfo','PUT','','',''),(37,'p','888','/user/setSelfSetting','PUT','','',''),(35,'p','888','/user/setUserAuthorities','POST','','',''),(34,'p','888','/user/setUserAuthority','POST','','',''),(29,'p','888','/user/setUserInfo','PUT','','',''),(210,'p','888','getProductInfo/*','GET',NULL,NULL,NULL),(125,'p','8881','/api/createApi','POST','','',''),(128,'p','8881','/api/deleteApi','POST','','',''),(130,'p','8881','/api/getAllApis','POST','','',''),(127,'p','8881','/api/getApiById','POST','','',''),(126,'p','8881','/api/getApiList','POST','','',''),(129,'p','8881','/api/updateApi','POST','','',''),(131,'p','8881','/authority/createAuthority','POST','','',''),(132,'p','8881','/authority/deleteAuthority','POST','','',''),(133,'p','8881','/authority/getAuthorityList','POST','','',''),(134,'p','8881','/authority/setDataAuthority','POST','','',''),(153,'p','8881','/casbin/getPolicyPathByAuthorityId','POST','','',''),(152,'p','8881','/casbin/updateCasbin','POST','','',''),(159,'p','8881','/customer/customer','DELETE','','',''),(160,'p','8881','/customer/customer','GET','','',''),(157,'p','8881','/customer/customer','POST','','',''),(158,'p','8881','/customer/customer','PUT','','',''),(161,'p','8881','/customer/customerList','GET','','',''),(149,'p','8881','/fileUploadAndDownload/deleteFile','POST','','',''),(150,'p','8881','/fileUploadAndDownload/editFileName','POST','','',''),(148,'p','8881','/fileUploadAndDownload/getFileList','POST','','',''),(151,'p','8881','/fileUploadAndDownload/importURL','POST','','',''),(147,'p','8881','/fileUploadAndDownload/upload','POST','','',''),(154,'p','8881','/jwt/jsonInBlacklist','POST','','',''),(137,'p','8881','/menu/addBaseMenu','POST','','',''),(139,'p','8881','/menu/addMenuAuthority','POST','','',''),(141,'p','8881','/menu/deleteBaseMenu','POST','','',''),(143,'p','8881','/menu/getBaseMenuById','POST','','',''),(138,'p','8881','/menu/getBaseMenuTree','POST','','',''),(135,'p','8881','/menu/getMenu','POST','','',''),(140,'p','8881','/menu/getMenuAuthority','POST','','',''),(136,'p','8881','/menu/getMenuList','POST','','',''),(142,'p','8881','/menu/updateBaseMenu','POST','','',''),(155,'p','8881','/system/getSystemConfig','POST','','',''),(156,'p','8881','/system/setSystemConfig','POST','','',''),(124,'p','8881','/user/admin_register','POST','','',''),(144,'p','8881','/user/changePassword','POST','','',''),(162,'p','8881','/user/getUserInfo','GET','','',''),(145,'p','8881','/user/getUserList','POST','','',''),(146,'p','8881','/user/setUserAuthority','POST','','',''),(164,'p','9528','/api/createApi','POST','','',''),(167,'p','9528','/api/deleteApi','POST','','',''),(169,'p','9528','/api/getAllApis','POST','','',''),(166,'p','9528','/api/getApiById','POST','','',''),(165,'p','9528','/api/getApiList','POST','','',''),(168,'p','9528','/api/updateApi','POST','','',''),(170,'p','9528','/authority/createAuthority','POST','','',''),(171,'p','9528','/authority/deleteAuthority','POST','','',''),(172,'p','9528','/authority/getAuthorityList','POST','','',''),(173,'p','9528','/authority/setDataAuthority','POST','','',''),(201,'p','9528','/autoCode/createTemp','POST','','',''),(192,'p','9528','/casbin/getPolicyPathByAuthorityId','POST','','',''),(191,'p','9528','/casbin/updateCasbin','POST','','',''),(199,'p','9528','/customer/customer','DELETE','','',''),(197,'p','9528','/customer/customer','GET','','',''),(198,'p','9528','/customer/customer','POST','','',''),(196,'p','9528','/customer/customer','PUT','','',''),(200,'p','9528','/customer/customerList','GET','','',''),(188,'p','9528','/fileUploadAndDownload/deleteFile','POST','','',''),(189,'p','9528','/fileUploadAndDownload/editFileName','POST','','',''),(187,'p','9528','/fileUploadAndDownload/getFileList','POST','','',''),(190,'p','9528','/fileUploadAndDownload/importURL','POST','','',''),(186,'p','9528','/fileUploadAndDownload/upload','POST','','',''),(193,'p','9528','/jwt/jsonInBlacklist','POST','','',''),(176,'p','9528','/menu/addBaseMenu','POST','','',''),(178,'p','9528','/menu/addMenuAuthority','POST','','',''),(180,'p','9528','/menu/deleteBaseMenu','POST','','',''),(182,'p','9528','/menu/getBaseMenuById','POST','','',''),(177,'p','9528','/menu/getBaseMenuTree','POST','','',''),(174,'p','9528','/menu/getMenu','POST','','',''),(179,'p','9528','/menu/getMenuAuthority','POST','','',''),(175,'p','9528','/menu/getMenuList','POST','','',''),(181,'p','9528','/menu/updateBaseMenu','POST','','',''),(194,'p','9528','/system/getSystemConfig','POST','','',''),(195,'p','9528','/system/setSystemConfig','POST','','',''),(163,'p','9528','/user/admin_register','POST','','',''),(183,'p','9528','/user/changePassword','POST','','',''),(202,'p','9528','/user/getUserInfo','GET','','',''),(184,'p','9528','/user/getUserList','POST','','',''),(185,'p','9528','/user/setUserAuthority','POST','','','');
/*!40000 ALTER TABLE `casbin_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL COMMENT 'カテゴリID (手動割当)',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'カテゴリ名',
  `description` text COLLATE utf8mb4_general_ci COMMENT 'カテゴリ説明',
  `parent_id` int DEFAULT NULL COMMENT '親カテゴリID',
  `level` int NOT NULL COMMENT '階層レベル',
  `sort_order` int DEFAULT '0' COMMENT '表示順',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '有効フラグ',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_categories_parent_id` (`parent_id`),
  KEY `idx_categories_level` (`level`),
  KEY `idx_categories_is_active` (`is_active`),
  KEY `idx_categories_name` (`name`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品カテゴリ階層';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (100,'家具','...',NULL,0,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(110,'ソファ','...',100,1,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(111,'2人掛けソファ',NULL,110,2,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(112,'3人掛けソファ',NULL,110,2,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(113,'カウチソファ・コーナーソファ','...',110,2,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(115,'パーソナルチェア・一人掛けソファ',NULL,110,2,50,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(120,'ベッド・マットレス','...',100,1,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(121,'ベッドフレーム','...',120,2,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(122,'マットレス','...',120,2,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(123,'折りたたみベッド・すのこベッド',NULL,120,2,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(130,'収納家具','...',100,1,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(131,'チェスト・タンス',NULL,130,2,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(132,'本棚・ラック・シェルフ',NULL,130,2,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(133,'テレビ台・ローボード',NULL,130,2,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(140,'テーブル・机','...',100,1,40,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(150,'チェア・椅子','...',100,1,50,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(200,'寝具・寝具カバー','...',NULL,0,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(210,'掛け布団','...',200,1,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(220,'敷き布団・マットレスパッド',NULL,200,1,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(230,'枕','...',200,1,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(240,'寝具カバー・シーツ','...',200,1,40,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(241,'掛け布団カバー',NULL,240,2,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(242,'ボックスシーツ',NULL,240,2,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(243,'枕カバー',NULL,240,2,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(300,'インテリア雑貨','...',NULL,0,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(310,'クッション・座布団',NULL,300,1,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(320,'時計',NULL,300,1,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(330,'照明','...',300,1,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(400,'キッチン用品','...',NULL,0,40,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(410,'食器','...',400,1,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(420,'調理器具','...',400,1,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(430,'キッチン収納','...',400,1,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1211,'シングルベッドフレーム',NULL,121,3,10,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1212,'セミダブルベッドフレーム',NULL,121,3,20,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(1213,'ダブルベッドフレーム',NULL,121,3,30,1,'2025-05-22 19:35:32','2025-05-22 19:35:32');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_attributes`
--

DROP TABLE IF EXISTS `category_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_attributes` (
  `category_id` int NOT NULL,
  `attribute_id` int NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_variant_attribute` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int DEFAULT '0',
  PRIMARY KEY (`category_id`,`attribute_id`),
  KEY `attribute_id` (`attribute_id`),
  KEY `idx_category_attributes_is_variant` (`is_variant_attribute`),
  CONSTRAINT `category_attributes_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `category_attributes_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='カテゴリ別利用属性';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_attributes`
--

LOCK TABLES `category_attributes` WRITE;
/*!40000 ALTER TABLE `category_attributes` DISABLE KEYS */;
INSERT INTO `category_attributes` VALUES (111,1,1,1,10),(111,3,1,0,20),(111,4,1,0,30),(111,5,1,0,40),(111,6,1,0,50),(111,8,0,0,60),(111,11,0,0,70),(112,1,1,1,10),(112,3,1,0,20),(112,4,1,0,30),(112,5,1,0,40),(112,6,1,0,50),(112,8,0,0,60),(112,11,0,0,70),(113,1,1,1,10),(113,3,1,0,20),(113,4,1,0,30),(113,5,1,0,40),(113,6,1,0,50),(113,8,1,0,60),(131,1,0,1,10),(131,3,1,0,20),(131,4,1,0,30),(131,5,1,0,40),(131,6,1,0,50),(131,8,0,0,60),(241,1,1,1,10),(241,2,1,1,20),(241,3,1,0,30),(241,12,0,0,40),(242,1,1,1,10),(242,2,1,1,20),(242,3,1,0,30),(330,1,0,1,10),(330,12,0,0,20),(330,15,0,0,30),(330,16,1,0,40),(420,1,0,1,5),(420,3,1,0,10),(420,4,0,0,20),(420,10,0,0,30),(420,14,0,0,25),(1211,1,0,1,10),(1211,3,1,0,20),(1211,4,1,0,30),(1211,5,1,0,40),(1211,6,1,0,50),(1211,8,1,0,60),(1211,10,0,0,80),(1211,12,0,0,70);
/*!40000 ALTER TABLE `category_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checkout_sessions`
--

DROP TABLE IF EXISTS `checkout_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checkout_sessions` (
  `user_id` bigint unsigned NOT NULL,
  `cart_subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `applied_coupon_id` bigint unsigned DEFAULT NULL,
  `coupon_discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `used_points` int unsigned NOT NULL DEFAULT '0',
  `points_discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `last_updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `applied_coupon_id` (`applied_coupon_id`),
  CONSTRAINT `checkout_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `checkout_sessions_ibfk_2` FOREIGN KEY (`applied_coupon_id`) REFERENCES `coupons` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='チェックアウトセッション';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checkout_sessions`
--

LOCK TABLES `checkout_sessions` WRITE;
/*!40000 ALTER TABLE `checkout_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkout_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinate_set_items`
--

DROP TABLE IF EXISTS `coordinate_set_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinate_set_items` (
  `id` bigint NOT NULL,
  `coordinate_set_id` bigint NOT NULL,
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `display_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_coordinate_set_product` (`coordinate_set_id`,`product_id`),
  KEY `idx_coordinate_set_items_set_id` (`coordinate_set_id`),
  KEY `idx_coordinate_set_items_product_id` (`product_id`),
  CONSTRAINT `coordinate_set_items_ibfk_1` FOREIGN KEY (`coordinate_set_id`) REFERENCES `coordinate_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `coordinate_set_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='コーディネート構成商品';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinate_set_items`
--

LOCK TABLES `coordinate_set_items` WRITE;
/*!40000 ALTER TABLE `coordinate_set_items` DISABLE KEYS */;
INSERT INTO `coordinate_set_items` VALUES (101,1,'product-0001','メインの2人掛けソファ (グレー)',0,'2025-05-22 19:35:32'),(102,1,'product-0010','シンプルな木製チェスト (ナチュラル)',1,'2025-05-22 19:35:32'),(103,1,'product-0008','8畳用LEDシーリングライト',2,'2025-05-22 19:35:32'),(104,1,'product-1002','アクセントにモダンデザインソファ (ブラック)',3,'2025-05-22 19:35:32'),(201,2,'product-0005','天然木すのこベッドフレーム Forest-S (ナチュラル)',0,'2025-05-22 19:35:32'),(202,2,'product-1005','オーガニックコットン掛け布団カバー Pure (シングル・ホワイト)',1,'2025-05-22 19:35:32'),(203,2,'product-0007','ホテルスタイル ボックスシーツ Satin Touch (シングル・ホワイト)',2,'2025-05-22 19:35:32'),(204,2,'product-1003','シンプルなパイプベッドサイドテーブルとして',3,'2025-05-22 19:35:32'),(301,3,'product-kettle-001','スタイリッシュな電気ケトル (ピンク)',0,'2025-05-22 19:35:32'),(302,3,'product-0009','ダイニングテーブルとして使える作業台 (フライパン)',1,'2025-05-22 19:35:32'),(303,3,'product-0008','ペンダントライトで食卓を照らす (シーリングライト)',2,'2025-05-22 19:35:32'),(401,4,'product-0001','テストソファ (product-0001)',0,'2025-05-22 19:35:32'),(402,4,'product-kettle-001','テストケトル',1,'2025-05-22 19:35:32'),(403,4,'product-0004','テストベッド (product-0004)',2,'2025-05-22 19:35:32'),(404,4,'product-0006','テストカバー (product-0006)',3,'2025-05-22 19:35:32'),(405,4,'product-0010','テストチェスト (product-0010)',4,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `coordinate_set_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coordinate_sets`
--

DROP TABLE IF EXISTS `coordinate_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinate_sets` (
  `id` bigint NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `theme_image_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contributor_nickname` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Nitoriスタッフ',
  `contributor_avatar_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contributor_store_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `posted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_coordinate_sets_active_posted` (`is_active`,`posted_at`),
  KEY `idx_coordinate_sets_sort_order` (`sort_order`),
  KEY `idx_coordinate_sets_user_id` (`user_id`),
  CONSTRAINT `coordinate_sets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='コーディネートセット';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinate_sets`
--

LOCK TABLES `coordinate_sets` WRITE;
/*!40000 ALTER TABLE `coordinate_sets` DISABLE KEYS */;
INSERT INTO `coordinate_sets` VALUES (1,'グレーで統一したシックなリビング (改)','テスト用コーディネートソファを中心に、グレー系のアイテムでまとめたシックなリビング空間です。','https://dummyimage.com/800x400/eeeeee/000&text=Gray+Living+Coord+Revamp','山田 花子','https://dummyimage.com/50x50/cccccc/000&text=YH','ニトリ渋谷公園通り店','2025-05-19 19:35:32',1,10,'2025-05-22 19:35:32','2025-05-22 19:35:32',101),(2,'ナチュラルテイストの快適寝室 (改)','テスト用ベッドフレームとコーディネートラグで、心地よい眠りを誘うナチュラルな寝室。','https://dummyimage.com/800x400/f0f8ff/000&text=Natural+Bedroom+S','佐藤 太郎','https://dummyimage.com/50x50/bbbbbb/000&text=ST','ニトリ新宿店','2025-05-17 19:35:32',1,20,'2025-05-22 19:35:32','2025-05-22 19:35:32',102),(3,'モダンキッチンとダイニング (改)','テスト用ケトルとブラックのランプでモダンなキッチンダイニングを演出。','https://dummyimage.com/800x400/a9a9a9/000&text=Modern+Kitchen+Dining','Nitori Styling Lab','https://dummyimage.com/50x50/aaaaaa/000&text=NSL','ニトリネット本部','2025-05-21 19:35:32',1,5,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),(4,'テスト商品オンリーコーディネート','テスト用に作成した商品のみで構成されたコーディネートです。','https://dummyimage.com/800x400/e6e6fa/000&text=Test+Only+Coord','鈴木 一郎',NULL,'ニトリテスト店','2025-05-15 19:35:32',1,15,'2025-05-22 19:35:32','2025-05-22 19:35:32',103);
/*!40000 ALTER TABLE `coordinate_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'クーポンID',
  `coupon_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'クーポンコード',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'クーポン名',
  `description` text COLLATE utf8mb4_general_ci COMMENT 'クーポンの説明',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_general_ci NOT NULL COMMENT '割引タイプ',
  `discount_value` decimal(10,2) NOT NULL COMMENT '割引額または割引率(%)',
  `min_purchase_amount` decimal(12,2) DEFAULT NULL COMMENT '最低利用購入金額',
  `max_discount_amount` decimal(10,2) DEFAULT NULL COMMENT '最大割引額',
  `start_date` datetime NOT NULL COMMENT '有効期間開始日時',
  `end_date` datetime NOT NULL COMMENT '有効期間終了日時',
  `usage_limit_per_user` int unsigned DEFAULT NULL COMMENT 'ユーザー1人あたり利用上限',
  `total_usage_limit` int unsigned DEFAULT NULL COMMENT 'クーポン全体利用上限',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '有効フラグ',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_code` (`coupon_code`),
  KEY `idx_coupons_code_active_dates` (`coupon_code`,`is_active`,`start_date`,`end_date`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='クーポンマスタ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'WELCOME10','初回購入10%OFFクーポン','...','percentage',10.00,3000.00,2000.00,'2025-04-22 19:35:32','2025-06-21 19:35:32',1,10000,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(2,'SPRING500','春の新生活応援500円OFF','...','fixed',500.00,5000.00,NULL,'2025-05-15 19:35:32','2025-05-29 19:35:32',1,500,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(3,'MEMBERONLY','会員様限定特別クーポン','...','fixed',1000.00,10000.00,NULL,'2025-05-22 19:35:32','2025-07-21 19:35:32',1,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(6,'AUTUMN1000','秋の感謝祭1000円OFF','...','fixed',1000.00,10000.00,NULL,'2025-05-19 19:35:32','2025-06-06 19:35:32',1,200,1,'2025-05-22 19:35:32','2025-05-22 19:35:32');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exa_attachment_category`
--

DROP TABLE IF EXISTS `exa_attachment_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exa_attachment_category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分类名称',
  `pid` bigint DEFAULT '0' COMMENT '父节点ID',
  PRIMARY KEY (`id`),
  KEY `idx_exa_attachment_category_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exa_attachment_category`
--

LOCK TABLES `exa_attachment_category` WRITE;
/*!40000 ALTER TABLE `exa_attachment_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `exa_attachment_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exa_customers`
--

DROP TABLE IF EXISTS `exa_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exa_customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `customer_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户名',
  `customer_phone_data` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '客户手机号',
  `sys_user_id` bigint unsigned DEFAULT NULL COMMENT '管理ID',
  `sys_user_authority_id` bigint unsigned DEFAULT NULL COMMENT '管理角色ID',
  PRIMARY KEY (`id`),
  KEY `idx_exa_customers_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exa_customers`
--

LOCK TABLES `exa_customers` WRITE;
/*!40000 ALTER TABLE `exa_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `exa_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exa_file_chunks`
--

DROP TABLE IF EXISTS `exa_file_chunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exa_file_chunks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `exa_file_id` bigint unsigned DEFAULT NULL,
  `file_chunk_number` bigint DEFAULT NULL,
  `file_chunk_path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_exa_file_chunks_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exa_file_chunks`
--

LOCK TABLES `exa_file_chunks` WRITE;
/*!40000 ALTER TABLE `exa_file_chunks` DISABLE KEYS */;
/*!40000 ALTER TABLE `exa_file_chunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exa_file_upload_and_downloads`
--

DROP TABLE IF EXISTS `exa_file_upload_and_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exa_file_upload_and_downloads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件名',
  `class_id` bigint DEFAULT '0' COMMENT '分类id',
  `url` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件地址',
  `tag` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件标签',
  `key` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '编号',
  PRIMARY KEY (`id`),
  KEY `idx_exa_file_upload_and_downloads_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exa_file_upload_and_downloads`
--

LOCK TABLES `exa_file_upload_and_downloads` WRITE;
/*!40000 ALTER TABLE `exa_file_upload_and_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `exa_file_upload_and_downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exa_files`
--

DROP TABLE IF EXISTS `exa_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exa_files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_md5` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `file_path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `chunk_total` bigint DEFAULT NULL,
  `is_finish` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_exa_files_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exa_files`
--

LOCK TABLES `exa_files` WRITE;
/*!40000 ALTER TABLE `exa_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `exa_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gva_announcements_info`
--

DROP TABLE IF EXISTS `gva_announcements_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gva_announcements_info` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '公告标题',
  `content` text COLLATE utf8mb4_general_ci COMMENT '公告内容',
  `user_id` bigint DEFAULT NULL COMMENT '发布者',
  `attachments` json DEFAULT NULL COMMENT '相关附件',
  PRIMARY KEY (`id`),
  KEY `idx_gva_announcements_info_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gva_announcements_info`
--

LOCK TABLES `gva_announcements_info` WRITE;
/*!40000 ALTER TABLE `gva_announcements_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `gva_announcements_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` bigint NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `location_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `reserved_quantity` int NOT NULL DEFAULT '0',
  `last_updated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_inventory_sku_location` (`sku_id`,`location_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `inventory_locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='在庫';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (40001,'sku-0001',1,50,5,'2025-05-22 19:35:32'),(40002,'sku-0001',101,5,0,'2025-05-22 19:35:32'),(40003,'sku-0002',1,0,0,'2025-05-22 19:35:32'),(40004,'sku-0003',1,40,2,'2025-05-22 19:35:32'),(40005,'sku-0003',101,3,0,'2025-05-22 19:35:32'),(40006,'sku-p0001-grn',1,30,2,'2025-05-22 19:35:32'),(40007,'sku-p0001-grn',101,3,0,'2025-05-22 19:35:32'),(40008,'sku-0013',1,25,1,'2025-05-22 19:35:32'),(40009,'sku-0013',101,2,0,'2025-05-22 19:35:32'),(40010,'sku-p0002-dbr',1,20,0,'2025-05-22 19:35:32'),(40011,'sku-p0002-ivr',1,0,0,'2025-05-22 19:35:32'),(40012,'sku-p0003-lgy',1,40,3,'2025-05-22 19:35:32'),(40013,'sku-p0003-lgy',101,4,0,'2025-05-22 19:35:32'),(40014,'sku-p0003-blu',1,35,2,'2025-05-22 19:35:32'),(40015,'sku-0004',1,100,10,'2025-05-22 19:35:32'),(40016,'sku-0004',101,10,0,'2025-05-22 19:35:32'),(40017,'sku-0005',1,80,5,'2025-05-22 19:35:32'),(40018,'sku-0005',101,8,0,'2025-05-22 19:35:32'),(40019,'sku-p0004-bk',1,70,5,'2025-05-22 19:35:32'),(40020,'sku-p0005-na',1,120,8,'2025-05-22 19:35:32'),(40021,'sku-p0005-na',101,12,1,'2025-05-22 19:35:32'),(40022,'sku-p0005-wh',1,110,6,'2025-05-22 19:35:32'),(40023,'sku-0006',1,200,15,'2025-05-22 19:35:32'),(40024,'sku-0006',101,20,2,'2025-05-22 19:35:32'),(40025,'sku-0007',1,180,8,'2025-05-22 19:35:32'),(40026,'sku-0007',101,15,1,'2025-05-22 19:35:32'),(40027,'sku-0008',1,80,3,'2025-05-22 19:35:32'),(40028,'sku-0009',1,70,2,'2025-05-22 19:35:32'),(40029,'sku-0010',1,40,1,'2025-05-22 19:35:32'),(40030,'sku-0011',1,35,0,'2025-05-22 19:35:32'),(40031,'sku-p0006-s-pk',1,90,4,'2025-05-22 19:35:32'),(40032,'sku-p0006-s-pk',101,9,0,'2025-05-22 19:35:32'),(40033,'sku-p0006-sd-pk',1,80,3,'2025-05-22 19:35:32'),(40034,'sku-p0007-s-wh',1,250,20,'2025-05-22 19:35:32'),(40035,'sku-p0007-s-wh',101,25,2,'2025-05-22 19:35:32'),(40036,'sku-p0007-s-gy',1,220,15,'2025-05-22 19:35:32'),(40037,'sku-p0007-sd-wh',1,180,10,'2025-05-22 19:35:32'),(40038,'sku-p0008-8j',1,300,25,'2025-05-22 19:35:32'),(40039,'sku-p0008-8j',101,30,1,'2025-05-22 19:35:32'),(40040,'sku-0012',1,500,50,'2025-05-22 19:35:32'),(40041,'sku-0012',101,50,5,'2025-05-22 19:35:32'),(40042,'sku-0014',1,70,3,'2025-05-22 19:35:32'),(40043,'sku-0014',101,8,0,'2025-05-22 19:35:32'),(40044,'sku-p0010-br',1,60,2,'2025-05-22 19:35:32'),(40045,'sku-1001',1,55,4,'2025-05-22 19:35:32'),(40046,'sku-1001-be',1,0,0,'2025-05-22 19:35:32'),(40047,'sku-1002',1,60,3,'2025-05-22 19:35:32'),(40048,'sku-1002-bk',1,50,1,'2025-05-22 19:35:32'),(40049,'sku-1003',1,150,10,'2025-05-22 19:35:32'),(40050,'sku-1003-wh',1,130,7,'2025-05-22 19:35:32'),(40051,'sku-1004',1,80,5,'2025-05-22 19:35:32'),(40052,'sku-1004-br',1,75,3,'2025-05-22 19:35:32'),(40053,'sku-1005',1,200,12,'2025-05-22 19:35:32'),(40054,'sku-1005-s-gy',1,180,9,'2025-05-22 19:35:32'),(40055,'sku-1005-d-wh',1,0,0,'2025-05-22 19:35:32'),(40056,'sku-kettle-001-pk',1,70,5,'2025-05-22 19:35:32'),(40057,'sku-kettle-001-pk',101,10,1,'2025-05-22 19:35:32'),(40058,'sku-kettle-001-bl',1,60,3,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_locations`
--

DROP TABLE IF EXISTS `inventory_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_locations` (
  `id` int NOT NULL COMMENT '在庫拠点ID (手動割当)',
  `location_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '拠点コード',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '拠点名',
  `location_type` enum('warehouse','store','distribution_center') COLLATE utf8mb4_general_ci NOT NULL COMMENT '拠点タイプ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `location_code` (`location_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='在庫を管理する拠点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_locations`
--

LOCK TABLES `inventory_locations` WRITE;
/*!40000 ALTER TABLE `inventory_locations` DISABLE KEYS */;
INSERT INTO `inventory_locations` VALUES (1,'WH_EAST','東日本倉庫','warehouse'),(2,'WH_WEST','西日本倉庫','warehouse'),(101,'STORE_SBY','渋谷店','store');
/*!40000 ALTER TABLE `inventory_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jwt_blacklists`
--

DROP TABLE IF EXISTS `jwt_blacklists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jwt_blacklists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `jwt` text COLLATE utf8mb4_general_ci COMMENT 'jwt',
  PRIMARY KEY (`id`),
  KEY `idx_jwt_blacklists_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jwt_blacklists`
--

LOCK TABLES `jwt_blacklists` WRITE;
/*!40000 ALTER TABLE `jwt_blacklists` DISABLE KEYS */;
/*!40000 ALTER TABLE `jwt_blacklists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sku_code` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantity` int unsigned NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `subtotal_price` decimal(12,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `sku_id` (`sku_id`),
  KEY `idx_order_items_order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='注文明細';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `order_status` enum('pending_payment','payment_confirmed','processing','shipped','delivered','cancelled','refunded') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending_payment',
  `subtotal_amount` decimal(12,2) NOT NULL,
  `coupon_id` bigint unsigned DEFAULT NULL,
  `coupon_discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `points_used` int unsigned NOT NULL DEFAULT '0',
  `points_discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(12,2) NOT NULL,
  `payjp_charge_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ordered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `notes` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_code` (`order_code`),
  UNIQUE KEY `payjp_charge_id` (`payjp_charge_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `idx_orders_user_id_ordered_at` (`user_id`,`ordered_at` DESC),
  KEY `idx_orders_order_status` (`order_status`),
  KEY `idx_orders_payjp_charge_id` (`payjp_charge_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='注文ヘッダ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_methods`
--

DROP TABLE IF EXISTS `payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_methods` (
  `id` int NOT NULL COMMENT '支払い方法ID (手動割当)',
  `method_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支払い方法コード (例: credit_card)',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '支払い方法名 (例: クレジットカード)',
  `description` text COLLATE utf8mb4_general_ci COMMENT '説明 (手数料情報など)',
  `is_active` tinyint(1) NOT NULL DEFAULT '1' COMMENT '利用可能フラグ',
  `sort_order` int DEFAULT '0' COMMENT '表示順',
  PRIMARY KEY (`id`),
  UNIQUE KEY `method_code` (`method_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='利用可能な支払い方法マスタ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_methods`
--

LOCK TABLES `payment_methods` WRITE;
/*!40000 ALTER TABLE `payment_methods` DISABLE KEYS */;
INSERT INTO `payment_methods` VALUES (1,'credit_card','クレジットカード','VISA、Mastercard、JCB、AMEX、Diners がご利用いただけます。',1,10),(2,'convenience_store_deferred','コンビニ後払い','商品到着後にコンビニでお支払いいただけます。手数料330円(税込)。',1,20),(3,'bank_transfer','銀行振込','ご注文後に指定口座へお振込みください。振込手数料はお客様負担となります。',1,30),(4,'paypay','PayPay','PayPay残高でお支払いいただけます。',0,40);
/*!40000 ALTER TABLE `payment_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `payment_gateway` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'payjp',
  `transaction_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `transaction_type` enum('charge','refund','capture') COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `currency` char(3) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'JPY',
  `status` enum('succeeded','pending','failed','expired','captured','refunded') COLLATE utf8mb4_general_ci NOT NULL,
  `raw_response` text COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `idx_payment_transactions_order_id` (`order_id`),
  CONSTRAINT `payment_transactions_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='支払トランザクション';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transactions`
--

LOCK TABLES `payment_transactions` WRITE;
/*!40000 ALTER TABLE `payment_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price_types`
--

DROP TABLE IF EXISTS `price_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price_types` (
  `id` int NOT NULL COMMENT '価格種別ID (手動割当)',
  `type_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '価格種別コード',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '価格種別名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_code` (`type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='価格の種別';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price_types`
--

LOCK TABLES `price_types` WRITE;
/*!40000 ALTER TABLE `price_types` DISABLE KEYS */;
INSERT INTO `price_types` VALUES (1,'regular','通常価格'),(2,'sale','セール価格'),(3,'member_special','会員特別価格');
/*!40000 ALTER TABLE `price_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `id` bigint NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `price_type_id` int NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `currency_code` char(3) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'JPY',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_prices_sku_id` (`sku_id`),
  KEY `idx_prices_type_active_dates` (`price_type_id`,`is_active`,`start_date`,`end_date`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`price_type_id`) REFERENCES `price_types` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SKU価格';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (30001,'sku-0001',1,39900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30002,'sku-0001',2,34900.00,'JPY','2025-05-12 19:35:32','2025-05-27 19:35:32',1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30003,'sku-0002',1,39900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30004,'sku-0003',1,39900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30005,'sku-p0001-grn',1,40900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30006,'sku-0013',1,52900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30007,'sku-p0002-dbr',1,52900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30008,'sku-p0002-ivr',1,51900.00,'JPY',NULL,NULL,0,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30009,'sku-p0003-lgy',1,45000.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30010,'sku-p0003-blu',1,45000.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30011,'sku-p0003-blu',2,42000.00,'JPY','2025-05-17 19:35:32','2025-06-06 19:35:32',1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30012,'sku-0004',1,29900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30013,'sku-0004',3,27900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30014,'sku-0005',1,29900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30015,'sku-p0004-bk',1,30900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30016,'sku-p0005-na',1,12900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30017,'sku-p0005-wh',1,12900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30018,'sku-0006',1,2990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30019,'sku-0007',1,2990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30020,'sku-0008',1,3490.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30021,'sku-0009',1,3490.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30022,'sku-0010',1,3990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30023,'sku-0011',1,3990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30024,'sku-p0006-s-pk',1,3190.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30025,'sku-p0006-sd-pk',1,3690.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30026,'sku-p0007-s-wh',1,1990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30027,'sku-p0007-s-gy',1,1990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30028,'sku-p0007-sd-wh',1,2490.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30029,'sku-p0008-8j',1,7990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30030,'sku-p0008-8j',2,6990.00,'JPY','2025-05-19 19:35:32','2025-05-29 19:35:32',1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30031,'sku-0012',1,1990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30032,'sku-0014',1,15900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30033,'sku-p0010-br',1,16900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30034,'sku-1001',1,29900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30035,'sku-1001-be',1,29900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30036,'sku-1002',1,35900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30037,'sku-1002',2,32900.00,'JPY','2025-05-12 19:35:32','2025-06-01 19:35:32',1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30038,'sku-1002-bk',1,35900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30039,'sku-1003',1,9990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30040,'sku-1003-wh',1,9990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30041,'sku-1004',1,19900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30042,'sku-1004-br',1,19900.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30043,'sku-1005',1,3990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30044,'sku-1005-s-gy',1,3990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30045,'sku-1005-d-wh',1,4990.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30046,'sku-kettle-001-pk',1,2490.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32'),(30047,'sku-kettle-001-bl',1,2490.00,'JPY',NULL,NULL,1,'2025-05-22 19:35:32','2025-05-22 19:35:32');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_questions`
--

DROP TABLE IF EXISTS `product_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_questions` (
  `id` bigint NOT NULL,
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `nickname` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '匿名さん',
  `question_text` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_questions_product_id_status_created` (`product_id`,`status`,`created_at`),
  KEY `idx_product_questions_user_id` (`user_id`),
  CONSTRAINT `product_questions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_questions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Q&A質問';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_questions`
--

LOCK TABLES `product_questions` WRITE;
/*!40000 ALTER TABLE `product_questions` DISABLE KEYS */;
INSERT INTO `product_questions` VALUES (101,'product-0001',101,'テストユーザー01','...','approved','2025-05-12 19:35:32'),(102,'product-0001',102,'テストユーザー02','...','approved','2025-05-14 19:35:32'),(103,'product-0001',104,'テストユーザー04','...','approved','2025-05-17 19:35:32'),(104,'product-0001',NULL,'匿名さん','...','approved','2025-05-19 19:35:32'),(105,'product-0001',105,'テストユーザー05','...','pending','2025-05-21 19:35:32'),(106,'product-0001',NULL,'質問マン','...','rejected','2025-05-10 19:35:32'),(107,'product-0001',105,'テストユーザー05','...','approved','2025-05-07 19:35:32'),(108,'product-0001',106,'テストユーザー06','...','approved','2025-05-09 19:35:32'),(109,'product-0001',107,'テストユーザー07','...','approved','2025-05-13 19:35:32'),(110,'product-0001',108,'テストユーザー08','...','approved','2025-05-16 19:35:32'),(111,'product-0001',109,'テストユーザー09','...','approved','2025-05-02 19:35:32'),(112,'product-0001',110,'テストユーザー10','...','approved','2025-05-04 19:35:32'),(113,'product-0001',111,'テストユーザー11','...','approved','2025-05-06 19:35:32'),(114,'product-0001',112,'テストユーザー12','...','approved','2025-05-08 19:35:32'),(115,'product-0001',113,'テストユーザー13','...','approved','2025-05-11 19:35:32'),(201,'product-0004',114,'テストユーザー14','...','approved','2025-05-13 19:35:32'),(202,'product-0004',115,'テストユーザー15','...','approved','2025-05-15 19:35:32'),(203,'product-0004',116,'テストユーザー16','...','approved','2025-05-18 19:35:32'),(204,'product-0004',NULL,'ブラウン検討','...','pending','2025-05-20 19:35:32'),(205,'product-0004',117,'テストユーザー17','...','approved','2025-05-11 19:35:32'),(206,'product-0004',118,'テストユーザー18','...','approved','2025-05-09 19:35:32'),(207,'product-0004',119,'テストユーザー19','...','approved','2025-05-12 19:35:32'),(301,'product-0006',120,'テストユーザー20','...','approved','2025-05-17 19:35:32'),(302,'product-0006',121,'テストユーザー21','...','approved','2025-05-19 19:35:32'),(303,'product-0006',122,'テストユーザー22','...','approved','2025-05-21 19:35:32'),(304,'product-0006',123,'テストユーザー23','...','approved','2025-05-14 19:35:32'),(305,'product-0006',NULL,'ピンク希望','...','approved','2025-05-10 19:35:32'),(306,'product-0006',124,'テストユーザー24','...','rejected','2025-05-16 19:35:32'),(401,'product-0010',125,'テストユーザー25','...','approved','2025-05-16 19:35:32'),(402,'product-0010',101,'テストユーザー01','...','approved','2025-05-20 19:35:32'),(403,'product-0010',NULL,'匿名希望','...','pending','2025-05-22 19:35:32'),(404,'product-0010',102,'テストユーザー02','...','approved','2025-05-13 19:35:32'),(501,'product-1001',102,'テストユーザー02','このCozy+ソファのカバーは取り外し可能ですか？','approved','2025-05-21 19:35:32'),(502,'product-1002',104,'テストユーザー04','UrbanChicソファの脚の高さを教えてください。','approved','2025-05-20 19:35:32'),(503,'product-1003',NULL,'匿名さん','Neo-Sパイプベッドの耐荷重はどのくらいですか？','pending','2025-05-22 19:35:32'),(504,'product-1005',106,'テストユーザー06','Pure掛け布団カバーは乾燥機使えますか？','approved','2025-05-19 19:35:32'),(601,'product-kettle-001',110,'テストユーザー10','このケトルの容量は満水で何リットルですか？','approved','2025-05-18 19:35:32'),(602,'product-kettle-001',NULL,'急いでます','自動電源オフ機能はついていますか？','approved','2025-05-20 19:35:32');
/*!40000 ALTER TABLE `product_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` bigint NOT NULL,
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `nickname` varchar(100) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '匿名さん',
  `rating` tinyint unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_reviews_product_id_status_created` (`product_id`,`status`,`created_at`),
  KEY `idx_product_reviews_rating` (`rating`),
  KEY `idx_product_reviews_user_id` (`user_id`),
  CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品レビュー';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
INSERT INTO `product_reviews` VALUES (1,'product-0001',101,'テストユーザー01',4,'座り心地が良い','...','approved','2025-05-15 19:35:32'),(2,'product-0001',102,'テストユーザー02',5,'満足！','...','approved','2025-05-17 19:35:32'),(3,'product-0001',103,'テストユーザー03',3,'思ったより硬め','...','approved','2025-05-19 19:35:32'),(4,'product-0001',NULL,'匿名さん',4,'コスパ良し','...','approved','2025-05-21 19:35:32'),(5,'product-0001',104,'テストユーザー04',2,'ちょっと残念','...','pending','2025-05-22 19:35:32'),(6,'product-0004',107,'テストユーザー07',5,'組み立て簡単！収納力抜群！','...','approved','2025-05-16 19:35:32'),(7,'product-0004',108,'テストユーザー08',4,'コスパ良し','...','approved','2025-05-20 19:35:32'),(8,'product-0006',111,'テストユーザー11',5,'Nクール最高！','...','approved','2025-05-21 19:35:32'),(9,'product-0006',112,'テストユーザー12',4,'サラサラ','...','approved','2025-05-18 19:35:32'),(10,'product-0009',115,'テストユーザー15',4,'使いやすい','...','approved','2025-05-14 19:35:32'),(11,'product-0001',101,'テストユーザー01',5,'2台目です','...','approved','2025-05-12 19:35:32'),(12,'product-0001',104,'テストユーザー04',4,'良いです','...','approved','2025-05-13 19:35:32'),(13,'product-0001',105,'テストユーザー05',4,'おすすめ','...','approved','2025-05-14 19:35:32'),(14,'product-0001',106,'テストユーザー06',5,'おしゃれ','...','approved','2025-05-16 19:35:32'),(15,'product-0001',NULL,'購入者A',3,NULL,'...','approved','2025-05-18 19:35:32'),(16,'product-0004',109,'テストユーザー09',4,'十分です','...','approved','2025-05-10 19:35:32'),(17,'product-0004',110,'テストユーザー10',5,'ホワイト可愛い','...','approved','2025-05-11 19:35:32'),(18,'product-0006',113,'テストユーザー13',5,'家族分購入','...','approved','2025-05-07 19:35:32'),(19,'product-0006',114,'テストユーザー14',4,'まあまあひんやり','...','approved','2025-05-09 19:35:32'),(20,'product-0009',116,'テストユーザー16',5,'安いのに良い','...','approved','2025-05-15 19:35:32'),(21,'product-0001',117,'テストユーザー17',5,'大満足','...','approved','2025-05-02 19:35:32'),(22,'product-0001',118,'テストユーザー18',4,NULL,'...','approved','2025-05-04 19:35:32'),(23,'product-0001',119,'テストユーザー19',5,'買ってよかった','...','approved','2025-05-06 19:35:32'),(24,'product-0001',120,'テストユーザー20',4,'候補です','...','rejected','2025-05-22 19:35:32'),(25,'product-1001',101,'テストユーザー01',4,'組み立てやすい','...','approved','2025-05-21 19:35:32'),(26,'product-1001',102,'テストユーザー02',5,'おしゃれ！','...','approved','2025-05-22 17:35:32'),(27,'product-1002',103,'テストユーザー03',3,'デザインは良いが…','...','approved','2025-05-19 19:35:32'),(28,'product-1003',104,'テストユーザー04',5,'シンプルイズベスト','...','approved','2025-05-18 19:35:32'),(29,'product-1004',105,'テストユーザー05',4,'宮棚が便利','...','approved','2025-05-17 19:35:32'),(30,'product-1005',106,'テストユーザー06',5,'肌触りが最高','...','approved','2025-05-16 19:35:32'),(31,'product-0003',107,'テストユーザー07',4,'コンパクトで良い','...','approved','2025-05-15 19:35:32'),(32,'product-0008',108,'テストユーザー08',5,'明るさ十分','...','approved','2025-05-14 19:35:32'),(33,'product-kettle-001',109,'テストユーザー09',5,'可愛いケトル','...','approved','2025-05-20 19:35:32'),(34,'product-kettle-001',110,'テストユーザー10',4,'すぐ沸く','...','approved','2025-05-21 19:35:32');
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_skus`
--

DROP TABLE IF EXISTS `product_skus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_skus` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'SKU ID',
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `sku_code` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive','discontinued') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `barcode` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `weight` decimal(10,3) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `depth` decimal(10,2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku_code` (`sku_code`),
  KEY `product_id` (`product_id`),
  KEY `idx_product_skus_status` (`status`),
  KEY `idx_product_skus_deleted_at` (`deleted_at`),
  CONSTRAINT `product_skus_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='在庫管理の最小単位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_skus`
--

LOCK TABLES `product_skus` WRITE;
/*!40000 ALTER TABLE `product_skus` DISABLE KEYS */;
INSERT INTO `product_skus` VALUES ('sku-0001','product-0001','7801001-GRY','active',NULL,35.000,145.00,85.00,90.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0002','product-0001','7801001-NVY','active',NULL,35.000,145.00,85.00,90.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0003','product-0001','7801001-BEG','active',NULL,35.000,145.00,85.00,90.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0004','product-0004','7501001-WH','active',NULL,55.000,100.00,80.00,205.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0005','product-0004','7501001-BRN','active',NULL,55.000,100.00,80.00,205.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0006','product-0006','7701001-S-BL','active',NULL,0.800,150.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0007','product-0006','7701001-S-GY','active',NULL,0.800,150.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0008','product-0006','7701001-SD-BL','active',NULL,0.900,170.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0009','product-0006','7701001-SD-GY','active',NULL,0.900,170.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0010','product-0006','7701001-D-BL','active',NULL,1.000,190.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0011','product-0006','7701001-D-GY','active',NULL,1.000,190.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0012','product-0009','8901001','active',NULL,0.700,27.00,5.00,45.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0013','product-0002','7802001-BLK','active',NULL,45.000,180.00,88.00,92.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-0014','product-0010','6401001-NA','active',NULL,25.000,80.00,90.00,40.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1001','product-1001','7801103-GRN','active',NULL,28.000,130.00,75.00,80.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1001-be','product-1001','7801103-BEG','active',NULL,28.000,130.00,75.00,80.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1002','product-1002','7801104-DBR','active',NULL,32.000,140.00,78.00,85.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1002-bk','product-1002','7801104-BLK','active',NULL,32.000,140.00,78.00,85.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1003','product-1003','7501105-BLK','active',NULL,18.000,98.00,60.00,208.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1003-wh','product-1003','7501105-WH','active',NULL,18.000,98.00,60.00,208.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1004','product-1004','7501106-NA','active',NULL,30.000,102.00,85.00,210.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1004-br','product-1004','7501106-BR','active',NULL,30.000,102.00,85.00,210.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1005','product-1005','7701107-S-WH','active',NULL,0.900,150.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1005-d-wh','product-1005','7701107-D-WH','active',NULL,1.100,190.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-1005-s-gy','product-1005','7701107-S-GY','active',NULL,0.900,150.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-kettle-001-bl','product-kettle-001','8970001-BL','active',NULL,0.800,20.00,22.00,15.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-kettle-001-pk','product-kettle-001','8970001-PK','active',NULL,0.800,20.00,22.00,15.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0001-grn','product-0001','7801001-GRN','active',NULL,35.000,145.00,85.00,90.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0002-dbr','product-0002','7802001-DBR','active',NULL,45.000,180.00,88.00,92.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0002-ivr','product-0002','7802001-IVR','inactive',NULL,45.000,180.00,88.00,92.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0003-blu','product-0003','7803002-BLU','active',NULL,50.000,190.00,70.00,130.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0003-lgy','product-0003','7803002-LGY','active',NULL,50.000,190.00,70.00,130.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0004-bk','product-0004','7501001-BK','active',NULL,55.000,100.00,80.00,205.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0005-na','product-0005','7502001-NA','active',NULL,25.000,98.00,65.00,200.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0005-wh','product-0005','7502001-WH','active',NULL,25.000,98.00,65.00,200.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0006-s-pk','product-0006','7701001-S-PK','active',NULL,0.800,150.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0006-sd-pk','product-0006','7701001-SD-PK','active',NULL,0.900,170.00,210.00,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0007-s-gy','product-0007','7702002-S-GY','active',NULL,0.500,100.00,200.00,30.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0007-s-wh','product-0007','7702002-S-WH','active',NULL,0.500,100.00,200.00,30.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0007-sd-wh','product-0007','7702002-SD-WH','active',NULL,0.600,120.00,200.00,30.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0008-8j','product-0008','8301001-8J','active',NULL,1.200,NULL,NULL,NULL,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL),('sku-p0010-br','product-0010','6401001-BR','active',NULL,25.000,80.00,90.00,40.00,'2025-05-22 19:35:32','2025-05-22 19:35:32',NULL);
/*!40000 ALTER TABLE `product_skus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品ID',
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `product_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_id` int NOT NULL,
  `brand_id` int DEFAULT NULL,
  `default_sku_id` char(36) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('draft','active','inactive','discontinued') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'draft',
  `is_taxable` tinyint(1) NOT NULL DEFAULT '1',
  `meta_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `meta_description` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_code` (`product_code`),
  KEY `idx_products_category_id` (`category_id`),
  KEY `idx_products_status` (`status`),
  KEY `idx_products_deleted_at` (`deleted_at`),
  KEY `idx_products_name` (`name`),
  KEY `idx_products_default_sku_id` (`default_sku_id`),
  CONSTRAINT `fk_products_default_sku` FOREIGN KEY (`default_sku_id`) REFERENCES `product_skus` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='商品の基本情報';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('product-0001','布張り2人用ソファ N-Pocket A1','...','7801001',111,NULL,'sku-0001','active',1,NULL,NULL,'2025-05-12 19:35:32','2025-05-22 19:35:32',NULL),('product-0002','レザー調3人用ソファ Elegance','...','7802001',112,NULL,'sku-0013','active',1,NULL,NULL,'2025-05-10 19:35:32','2025-05-22 19:35:32',NULL),('product-0003','コンパクトカウチソファ Comfort Mini','...','7803002',113,NULL,'sku-p0003-lgy','active',1,NULL,NULL,'2025-05-14 19:35:32','2025-05-22 19:35:32',NULL),('product-0004','収納付きシングルベッドフレーム Atlas USB','...','7501001',1211,NULL,'sku-0004','active',1,NULL,NULL,'2025-05-07 19:35:32','2025-05-22 19:35:32',NULL),('product-0005','天然木すのこベッドフレーム Forest-S','...','7502001',1211,NULL,'sku-p0005-na','active',1,NULL,NULL,'2025-05-09 19:35:32','2025-05-22 19:35:32',NULL),('product-0006','NクールSP 掛け布団カバー i-n','...','7701001',241,NULL,'sku-0007','active',1,NULL,NULL,'2025-05-15 19:35:32','2025-05-22 19:35:32',NULL),('product-0007','ホテルスタイル ボックスシーツ Satin Touch','...','7702002',242,NULL,'sku-p0007-s-wh','active',1,NULL,NULL,'2025-05-13 19:35:32','2025-05-22 19:35:32',NULL),('product-0008','LEDシーリングライト 8畳用 リモコン付き','...','8301001',330,NULL,'sku-p0008-8j','active',1,NULL,NULL,'2025-05-11 19:35:32','2025-05-22 19:35:32',NULL),('product-0009','超軽量IH対応 フライパン 26cm MarbleCoat','...','8901001',420,NULL,'sku-0012','active',1,NULL,NULL,'2025-05-08 19:35:32','2025-05-22 19:35:32',NULL),('product-0010','木製4段チェスト Cube Natural','...','6401001',131,NULL,'sku-0014','active',1,NULL,NULL,'2025-05-16 19:35:32','2025-05-22 19:35:32',NULL),('product-1001','ファブリックアームソファ CozyPlace 2P','...','7801103',111,NULL,'sku-1001','active',1,NULL,NULL,'2025-05-20 19:35:32','2025-05-22 19:35:32',NULL),('product-1002','モダンデザインソファ UrbanChic 2P','...','7801104',111,NULL,'sku-1002-bk','active',1,NULL,NULL,'2025-05-17 19:35:32','2025-05-22 19:35:32',NULL),('product-1003','シンプルパイプベッドフレーム Neo-S','...','7501105',1211,NULL,'sku-1003-wh','active',1,NULL,NULL,'2025-05-21 19:35:32','2025-05-22 19:35:32',NULL),('product-1004','宮付き多機能ベッドフレーム Luce-S','...','7501106',1211,NULL,NULL,'active',1,NULL,NULL,'2025-05-18 19:35:32','2025-05-18 19:35:32',NULL),('product-1005','オーガニックコットン掛け布団カバー Pure','...','7701107',241,NULL,'sku-1005-s-gy','active',1,NULL,NULL,'2025-05-19 19:35:32','2025-05-22 19:35:32',NULL),('product-kettle-001','パステルカラー電気ケトル 1.0L','...','8970001',420,NULL,'sku-kettle-001-pk','active',1,NULL,NULL,'2025-05-02 19:35:32','2025-05-22 19:35:32',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_answers`
--

DROP TABLE IF EXISTS `question_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_answers` (
  `id` bigint NOT NULL,
  `question_id` bigint NOT NULL,
  `answerer_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `answer_text` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_question_answers_question_id_status` (`question_id`,`status`),
  CONSTRAINT `question_answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `product_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Q&A回答';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_answers`
--

LOCK TABLES `question_answers` WRITE;
/*!40000 ALTER TABLE `question_answers` DISABLE KEYS */;
INSERT INTO `question_answers` VALUES (201,101,'ニトリネットお客様相談室','...','approved','2025-05-13 19:35:32'),(202,102,'ニトリネットお客様相談室','...','approved','2025-05-15 19:35:32'),(203,104,'ニトリネットお客様相談室','...','approved','2025-05-20 19:35:32'),(204,107,'ニトリネットお客様相談室','...','approved','2025-05-08 19:35:32'),(205,108,'ニトリネットお客様相談室','...','approved','2025-05-10 19:35:32'),(206,201,'ニトリネットお客様相談室','...','approved','2025-05-14 19:35:32'),(207,202,'ニトリネットお客様相談室','...','approved','2025-05-16 19:35:32'),(208,301,'ニトリネットお客様相談室','...','approved','2025-05-18 19:35:32'),(209,302,'ニトリネットお客様相談室','...','approved','2025-05-20 19:35:32'),(211,303,'ニトリネットお客様相談室','...','approved','2025-05-22 19:35:32'),(212,401,'ニトリネットお客様相談室','...','approved','2025-05-17 19:35:32'),(213,103,'ニトリネットお客様相談室','...','approved','2025-05-21 19:35:32'),(301,109,'ニトリネットお客様相談室','...','approved','2025-05-14 19:35:32'),(302,110,'ニトリネットお客様相談室','...','approved','2025-05-17 19:35:32'),(303,111,'ニトリネットお客様相談室','...','approved','2025-05-03 19:35:32'),(304,113,'ニトリネットお客様相談室','...','approved','2025-05-07 19:35:32'),(305,203,'ニトリネットお客様相談室','...','approved','2025-05-19 19:35:32'),(306,205,'ニトリネットお客様相談室','...','approved','2025-05-12 19:35:32'),(307,206,'ニトリネットお客様相談室','...','approved','2025-05-10 19:35:32'),(308,304,'ニトリネットお客様相談室','...','approved','2025-05-15 19:35:32'),(309,305,'ニトリネットお客様相談室','...','approved','2025-05-11 19:35:32'),(310,402,'ニトリネットお客様相談室','...','approved','2025-05-21 19:35:32'),(311,404,'ニトリネットお客様相談室','...','approved','2025-05-14 19:35:32'),(401,501,'ニトリネットお客様相談室','...','approved','2025-05-22 19:35:32'),(402,502,'ニトリネットお客様相談室','...','approved','2025-05-21 19:35:32'),(403,504,'ニトリネットお客様相談室','...','approved','2025-05-20 19:35:32'),(404,601,'ニトリネットお客様相談室','お問い合わせありがとうございます。こちらのケトルの満水容量は1.0リットルでございます。','approved','2025-05-19 19:35:32'),(405,602,'ニトリネットお客様相談室','はい、こちらのケトルには自動電源オフ機能および空だき防止機能が付いておりますので、安心してお使いいただけます。','approved','2025-05-21 19:35:32');
/*!40000 ALTER TABLE `question_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_images`
--

DROP TABLE IF EXISTS `review_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_images` (
  `id` bigint NOT NULL,
  `review_id` bigint NOT NULL,
  `image_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_review_images_review_id` (`review_id`),
  CONSTRAINT `review_images_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `product_reviews` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='レビュー画像';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_images`
--

LOCK TABLES `review_images` WRITE;
/*!40000 ALTER TABLE `review_images` DISABLE KEYS */;
INSERT INTO `review_images` VALUES (101,2,'https://dummyimage.com/600x400/cccccc/000&text=Review+Image+1',0,'2025-05-22 19:35:32'),(102,2,'https://dummyimage.com/600x400/cccccc/000&text=Review+Image+2',1,'2025-05-22 19:35:32'),(103,6,'https://dummyimage.com/600x400/ffffff/000&text=Bed+Review+Image',0,'2025-05-22 19:35:32'),(104,8,'https://dummyimage.com/600x400/add8e6/000&text=N+Cool+Review',0,'2025-05-22 19:35:32'),(105,21,'https://dummyimage.com/600x400/cccccc/000&text=Sofa+Review+Pic',0,'2025-05-22 19:35:32'),(106,25,'https://dummyimage.com/600x400/008000/fff&text=Cozy+Sofa+Review',0,'2025-05-22 19:35:32'),(107,29,'https://dummyimage.com/600x400/deb887/000&text=Luce+Bed+Review',0,'2025-05-22 19:35:32'),(108,33,'https://dummyimage.com/600x400/ffc0cb/000&text=Kettle+Review',0,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `review_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_summaries`
--

DROP TABLE IF EXISTS `review_summaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_summaries` (
  `product_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `average_rating` decimal(3,2) NOT NULL DEFAULT '0.00',
  `review_count` int unsigned NOT NULL DEFAULT '0',
  `rating_1_count` int unsigned NOT NULL DEFAULT '0',
  `rating_2_count` int unsigned NOT NULL DEFAULT '0',
  `rating_3_count` int unsigned NOT NULL DEFAULT '0',
  `rating_4_count` int unsigned NOT NULL DEFAULT '0',
  `rating_5_count` int unsigned NOT NULL DEFAULT '0',
  `last_calculated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `review_summaries_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='レビュー集計';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_summaries`
--

LOCK TABLES `review_summaries` WRITE;
/*!40000 ALTER TABLE `review_summaries` DISABLE KEYS */;
INSERT INTO `review_summaries` VALUES ('product-0001',4.21,14,0,0,2,6,6,'2025-05-22 19:35:32'),('product-0002',0.00,0,0,0,0,0,0,NULL),('product-0003',4.00,1,0,0,0,1,0,'2025-05-22 19:35:32'),('product-0004',4.50,4,0,0,0,2,2,'2025-05-22 19:35:32'),('product-0006',4.50,4,0,0,0,2,2,'2025-05-22 19:35:32'),('product-0008',5.00,1,0,0,0,0,1,'2025-05-22 19:35:32'),('product-0009',4.50,2,0,0,0,1,1,'2025-05-22 19:35:32'),('product-0010',0.00,0,0,0,0,0,0,NULL),('product-1001',4.50,2,0,0,0,1,1,'2025-05-22 19:35:32'),('product-1002',3.00,1,0,0,1,0,0,'2025-05-22 19:35:32'),('product-1003',5.00,1,0,0,0,0,1,'2025-05-22 19:35:32'),('product-1004',4.00,1,0,0,0,1,0,'2025-05-22 19:35:32'),('product-1005',5.00,1,0,0,0,0,1,'2025-05-22 19:35:32'),('product-kettle-001',4.50,2,0,0,0,1,1,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `review_summaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_channels`
--

DROP TABLE IF EXISTS `sales_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_channels` (
  `id` int NOT NULL COMMENT '販売チャネルID (手動割当)',
  `channel_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'チャネルコード',
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'チャネル名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_code` (`channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='販売チャネル';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_channels`
--

LOCK TABLES `sales_channels` WRITE;
/*!40000 ALTER TABLE `sales_channels` DISABLE KEYS */;
INSERT INTO `sales_channels` VALUES (1,'ONLINE_JP','ニトリネット（日本）'),(2,'STORE_JP','日本国内店舗');
/*!40000 ALTER TABLE `sales_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_availability`
--

DROP TABLE IF EXISTS `sku_availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sku_availability` (
  `id` bigint NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `sales_channel_id` int NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `available_from` datetime DEFAULT NULL,
  `available_until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sku_availability` (`sku_id`,`sales_channel_id`),
  KEY `idx_sku_availability_channel_available` (`sales_channel_id`,`is_available`),
  CONSTRAINT `sku_availability_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sku_availability_ibfk_2` FOREIGN KEY (`sales_channel_id`) REFERENCES `sales_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SKU販売可否';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_availability`
--

LOCK TABLES `sku_availability` WRITE;
/*!40000 ALTER TABLE `sku_availability` DISABLE KEYS */;
INSERT INTO `sku_availability` VALUES (50001,'sku-0001',1,1,NULL,NULL),(50002,'sku-0001',2,1,NULL,NULL),(50003,'sku-0002',1,1,NULL,NULL),(50004,'sku-0002',2,0,NULL,NULL),(50005,'sku-0003',1,1,NULL,NULL),(50006,'sku-0003',2,1,NULL,NULL),(50007,'sku-p0001-grn',1,1,NULL,NULL),(50008,'sku-p0001-grn',2,1,NULL,NULL),(50009,'sku-0013',1,1,NULL,NULL),(50010,'sku-0013',2,1,NULL,NULL),(50011,'sku-p0002-dbr',1,1,NULL,NULL),(50012,'sku-p0002-dbr',2,1,NULL,NULL),(50013,'sku-p0002-ivr',1,0,NULL,NULL),(50014,'sku-p0003-lgy',1,1,NULL,NULL),(50015,'sku-p0003-lgy',2,0,NULL,NULL),(50016,'sku-p0003-blu',1,1,NULL,NULL),(50017,'sku-p0003-blu',2,0,NULL,NULL),(50018,'sku-0004',1,1,NULL,NULL),(50019,'sku-0004',2,1,NULL,NULL),(50020,'sku-0005',1,1,NULL,NULL),(50021,'sku-0005',2,1,NULL,NULL),(50022,'sku-p0004-bk',1,1,NULL,NULL),(50023,'sku-p0004-bk',2,1,NULL,NULL),(50024,'sku-p0005-na',1,1,NULL,NULL),(50025,'sku-p0005-na',2,1,NULL,NULL),(50026,'sku-p0005-wh',1,1,NULL,NULL),(50027,'sku-p0005-wh',2,1,NULL,NULL),(50028,'sku-0006',1,1,NULL,NULL),(50029,'sku-0006',2,1,NULL,NULL),(50030,'sku-0007',1,1,NULL,NULL),(50031,'sku-0007',2,1,NULL,NULL),(50032,'sku-0008',1,1,NULL,NULL),(50033,'sku-0008',2,1,NULL,NULL),(50034,'sku-0009',1,1,NULL,NULL),(50035,'sku-0009',2,1,NULL,NULL),(50036,'sku-0010',1,1,NULL,NULL),(50037,'sku-0010',2,1,NULL,NULL),(50038,'sku-0011',1,1,NULL,NULL),(50039,'sku-0011',2,1,NULL,NULL),(50040,'sku-p0006-s-pk',1,1,NULL,NULL),(50041,'sku-p0006-s-pk',2,1,NULL,NULL),(50042,'sku-p0006-sd-pk',1,1,NULL,NULL),(50043,'sku-p0006-sd-pk',2,1,NULL,NULL),(50044,'sku-p0007-s-wh',1,1,NULL,NULL),(50045,'sku-p0007-s-wh',2,1,NULL,NULL),(50046,'sku-p0007-s-gy',1,1,NULL,NULL),(50047,'sku-p0007-s-gy',2,1,NULL,NULL),(50048,'sku-p0007-sd-wh',1,1,NULL,NULL),(50049,'sku-p0007-sd-wh',2,1,NULL,NULL),(50050,'sku-p0008-8j',1,1,NULL,NULL),(50051,'sku-p0008-8j',2,1,NULL,NULL),(50052,'sku-0012',1,1,NULL,NULL),(50053,'sku-0012',2,1,NULL,NULL),(50054,'sku-0014',1,1,NULL,NULL),(50055,'sku-0014',2,1,NULL,NULL),(50056,'sku-p0010-br',1,1,NULL,NULL),(50057,'sku-p0010-br',2,1,NULL,NULL),(50058,'sku-1001',1,1,NULL,NULL),(50059,'sku-1001',2,1,NULL,NULL),(50060,'sku-1001-be',1,1,NULL,NULL),(50061,'sku-1001-be',2,1,NULL,NULL),(50062,'sku-1002',1,1,NULL,NULL),(50063,'sku-1002',2,1,NULL,NULL),(50064,'sku-1002-bk',1,1,NULL,NULL),(50065,'sku-1002-bk',2,0,NULL,NULL),(50066,'sku-1003',1,1,NULL,NULL),(50067,'sku-1003',2,1,NULL,NULL),(50068,'sku-1003-wh',1,1,NULL,NULL),(50069,'sku-1003-wh',2,1,NULL,NULL),(50070,'sku-1004',1,1,NULL,NULL),(50071,'sku-1004',2,1,NULL,NULL),(50072,'sku-1004-br',1,1,NULL,NULL),(50073,'sku-1004-br',2,1,NULL,NULL),(50074,'sku-1005',1,1,NULL,NULL),(50075,'sku-1005',2,1,NULL,NULL),(50076,'sku-1005-s-gy',1,1,NULL,NULL),(50077,'sku-1005-s-gy',2,1,NULL,NULL),(50078,'sku-1005-d-wh',1,1,NULL,NULL),(50079,'sku-1005-d-wh',2,1,NULL,NULL),(50080,'sku-kettle-001-pk',1,1,NULL,NULL),(50081,'sku-kettle-001-pk',2,1,NULL,NULL),(50082,'sku-kettle-001-bl',1,1,NULL,NULL),(50083,'sku-kettle-001-bl',2,1,NULL,NULL);
/*!40000 ALTER TABLE `sku_availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_images`
--

DROP TABLE IF EXISTS `sku_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sku_images` (
  `id` int NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `main_image_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail_url` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `alt_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_sku_images_sku_id_sort` (`sku_id`,`sort_order`),
  CONSTRAINT `sku_images_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SKU画像ペア';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_images`
--

LOCK TABLES `sku_images` WRITE;
/*!40000 ALTER TABLE `sku_images` DISABLE KEYS */;
INSERT INTO `sku_images` VALUES (201,'sku-0001','https://dummyimage.com/600x600/cccccc/000&text=Sofa+Gray+Main','https://dummyimage.com/100x100/cccccc/000&text=Sofa+Gray+Thumb','グレーソファ正面',0,'2025-05-22 19:35:32'),(202,'sku-0001','https://dummyimage.com/600x600/cccccc/000&text=Sofa+Gray+Side','https://dummyimage.com/100x100/cccccc/000&text=Sofa+Gray+Side+Thumb','グレーソファ横',1,'2025-05-22 19:35:32'),(203,'sku-0002','https://dummyimage.com/600x600/000080/fff&text=Sofa+Navy+Main','https://dummyimage.com/100x100/000080/fff&text=Sofa+Navy+Thumb','ネイビーソファ正面',0,'2025-05-22 19:35:32'),(204,'sku-0003','https://dummyimage.com/600x600/f5f5dc/000&text=Sofa+Beige+Main','https://dummyimage.com/100x100/f5f5dc/000&text=Sofa+Beige+Thumb','ベージュソファ正面',0,'2025-05-22 19:35:32'),(205,'sku-p0001-grn','https://dummyimage.com/600x600/008000/fff&text=Sofa+Green+Main','https://dummyimage.com/100x100/008000/fff&text=Sofa+Green+Thumb','グリーンソファ正面',0,'2025-05-22 19:35:32'),(206,'sku-0013','https://dummyimage.com/600x600/000000/fff&text=Sofa+Black+Main','https://dummyimage.com/100x100/000000/fff&text=Sofa+Black+Thumb','ブラック3人用ソファ正面',0,'2025-05-22 19:35:32'),(207,'sku-p0002-dbr','https://dummyimage.com/600x600/8b4513/fff&text=Sofa+DBR+Main','https://dummyimage.com/100x100/8b4513/fff&text=Sofa+DBR+Thumb','ダークブラウン3人用ソファ正面',0,'2025-05-22 19:35:32'),(208,'sku-p0002-ivr','https://dummyimage.com/600x600/f0e68c/000&text=Sofa+IVR+Main','https://dummyimage.com/100x100/f0e68c/000&text=Sofa+IVR+Thumb','アイボリー3人用ソファ正面',0,'2025-05-22 19:35:32'),(209,'sku-p0003-lgy','https://dummyimage.com/600x600/d3d3d3/000&text=Couch+LGY+Main','https://dummyimage.com/100x100/d3d3d3/000&text=Couch+LGY+Thumb','ライトグレーカウチ正面',0,'2025-05-22 19:35:32'),(210,'sku-p0003-blu','https://dummyimage.com/600x600/add8e6/000&text=Couch+BLU+Main','https://dummyimage.com/100x100/add8e6/000&text=Couch+BLU+Thumb','ブルーカウチ正面',0,'2025-05-22 19:35:32'),(211,'sku-0004','https://dummyimage.com/600x600/ffffff/000&text=Bed+WH+Main','https://dummyimage.com/100x100/ffffff/000&text=Bed+WH+Thumb','ホワイトベッド',0,'2025-05-22 19:35:32'),(212,'sku-0005','https://dummyimage.com/600x600/a52a2a/fff&text=Bed+BRN+Main','https://dummyimage.com/100x100/a52a2a/fff&text=Bed+BRN+Thumb','ブラウンベッド',0,'2025-05-22 19:35:32'),(213,'sku-p0004-bk','https://dummyimage.com/600x600/000000/fff&text=Bed+BK+Main','https://dummyimage.com/100x100/000000/fff&text=Bed+BK+Thumb','ブラックベッドフレーム',0,'2025-05-22 19:35:32'),(214,'sku-p0005-na','https://dummyimage.com/600x600/deb887/000&text=Bed+NA+Main','https://dummyimage.com/100x100/deb887/000&text=Bed+NA+Thumb','ナチュラルすのこベッド',0,'2025-05-22 19:35:32'),(215,'sku-p0005-wh','https://dummyimage.com/600x600/faf0e6/000&text=Bed+ForestWH+Main','https://dummyimage.com/100x100/faf0e6/000&text=Bed+ForestWH+Thumb','ホワイトすのこベッド',0,'2025-05-22 19:35:32'),(216,'sku-0006','https://dummyimage.com/600x600/add8e6/000&text=Cover+S+BL+Main','https://dummyimage.com/100x100/add8e6/000&text=Cover+S+BL+Thumb','カバーSブルー',0,'2025-05-22 19:35:32'),(217,'sku-0007','https://dummyimage.com/600x600/cccccc/000&text=Cover+S+GY+Main','https://dummyimage.com/100x100/cccccc/000&text=Cover+S+GY+Thumb','カバーSグレー',0,'2025-05-22 19:35:32'),(218,'sku-0008','https://dummyimage.com/600x600/add8e6/000&text=Cover+SD+BL+Main','https://dummyimage.com/100x100/add8e6/000&text=Cover+SD+BL+Thumb','カバーSDブルー',0,'2025-05-22 19:35:32'),(219,'sku-0009','https://dummyimage.com/600x600/cccccc/000&text=Cover+SD+GY+Main','https://dummyimage.com/100x100/cccccc/000&text=Cover+SD+GY+Thumb','カバーSDグレー',0,'2025-05-22 19:35:32'),(220,'sku-0010','https://dummyimage.com/600x600/add8e6/000&text=Cover+D+BL+Main','https://dummyimage.com/100x100/add8e6/000&text=Cover+D+BL+Thumb','カバーDブルー',0,'2025-05-22 19:35:32'),(221,'sku-0011','https://dummyimage.com/600x600/cccccc/000&text=Cover+D+GY+Main','https://dummyimage.com/100x100/cccccc/000&text=Cover+D+GY+Thumb','カバーDグレー',0,'2025-05-22 19:35:32'),(222,'sku-p0006-s-pk','https://dummyimage.com/600x600/ffc0cb/000&text=Cover+S+PK+Main','https://dummyimage.com/100x100/ffc0cb/000&text=Cover+S+PK+Thumb','ピンク掛けカバーS',0,'2025-05-22 19:35:32'),(223,'sku-p0006-sd-pk','https://dummyimage.com/600x600/ffc0cb/000&text=Cover+SD+PK+Main','https://dummyimage.com/100x100/ffc0cb/000&text=Cover+SD+PK+Thumb','ピンク掛けカバーSD',0,'2025-05-22 19:35:32'),(224,'sku-p0007-s-wh','https://dummyimage.com/600x600/ffffff/000&text=BoxSht+S+WH+Main','https://dummyimage.com/100x100/ffffff/000&text=BoxSht+S+WH+Thumb','白ボックスシーツS',0,'2025-05-22 19:35:32'),(225,'sku-p0007-s-gy','https://dummyimage.com/600x600/cccccc/000&text=BoxSht+S+GY+Main','https://dummyimage.com/100x100/cccccc/000&text=BoxSht+S+GY+Thumb','グレーボックスシーツS',0,'2025-05-22 19:35:32'),(226,'sku-p0007-sd-wh','https://dummyimage.com/600x600/ffffff/000&text=BoxSht+SD+WH+Main','https://dummyimage.com/100x100/ffffff/000&text=BoxSht+SD+WH+Thumb','白ボックスシーツSD',0,'2025-05-22 19:35:32'),(227,'sku-p0008-8j','https://dummyimage.com/600x600/eeeeee/000&text=CeilingLight+Main','https://dummyimage.com/100x100/eeeeee/000&text=CeilingLight+Thumb','LEDシーリングライト',0,'2025-05-22 19:35:32'),(228,'sku-0012','https://dummyimage.com/600x600/silver/000&text=Frypan+26cm+Main','https://dummyimage.com/100x100/silver/000&text=Frypan+26cm+Thumb','IH対応フライパン26cm',0,'2025-05-22 19:35:32'),(229,'sku-0014','https://dummyimage.com/600x600/deb887/000&text=Chest+NA+Main','https://dummyimage.com/100x100/deb887/000&text=Chest+NA+Thumb','チェスト ナチュラル',0,'2025-05-22 19:35:32'),(230,'sku-p0010-br','https://dummyimage.com/600x600/8b4513/fff&text=Chest+BR+Main','https://dummyimage.com/100x100/8b4513/fff&text=Chest+BR+Thumb','ブラウンチェスト',0,'2025-05-22 19:35:32'),(231,'sku-1001','https://dummyimage.com/600x600/008000/fff&text=Sofa+Cozy+GRN+Main','https://dummyimage.com/100x100/008000/fff&text=Sofa+Cozy+GRN+Thumb','グリーンCozyソファ',0,'2025-05-22 19:35:32'),(232,'sku-1001-be','https://dummyimage.com/600x600/f5f5dc/000&text=Sofa+Cozy+BEG+Main','https://dummyimage.com/100x100/f5f5dc/000&text=Sofa+Cozy+BEG+Thumb','ベージュCozyソファ',0,'2025-05-22 19:35:32'),(233,'sku-1002','https://dummyimage.com/600x600/a0522d/fff&text=Sofa+Urban+DBR+Main','https://dummyimage.com/100x100/a0522d/fff&text=Sofa+Urban+DBR+Thumb','DBR Urbanソファ',0,'2025-05-22 19:35:32'),(234,'sku-1002-bk','https://dummyimage.com/600x600/1a1a1a/fff&text=Sofa+Urban+BLK+Main','https://dummyimage.com/100x100/1a1a1a/fff&text=Sofa+Urban+BLK+Thumb','ブラックUrbanソファ',0,'2025-05-22 19:35:32'),(235,'sku-1003','https://dummyimage.com/600x600/333333/fff&text=Bed+Neo+BLK+Main','https://dummyimage.com/100x100/333333/fff&text=Bed+Neo+BLK+Thumb','ブラックNeoベッド',0,'2025-05-22 19:35:32'),(236,'sku-1003-wh','https://dummyimage.com/600x600/fafafa/000&text=Bed+Neo+WH+Main','https://dummyimage.com/100x100/fafafa/000&text=Bed+Neo+WH+Thumb','ホワイトNeoベッド',0,'2025-05-22 19:35:32'),(237,'sku-1004','https://dummyimage.com/600x600/f4a460/000&text=Bed+Luce+NA+Main','https://dummyimage.com/100x100/f4a460/000&text=Bed+Luce+NA+Thumb','ナチュラルLuceベッド',0,'2025-05-22 19:35:32'),(238,'sku-1004-br','https://dummyimage.com/600x600/964b00/fff&text=Bed+Luce+BR+Main','https://dummyimage.com/100x100/964b00/fff&text=Bed+Luce+BR+Thumb','ブラウンLuceベッド',0,'2025-05-22 19:35:32'),(239,'sku-1005','https://dummyimage.com/600x600/f0fff0/000&text=Cover+Pure+WH+S+Main','https://dummyimage.com/100x100/f0fff0/000&text=Cover+Pure+WH+S+Thumb','白PureカバーS',0,'2025-05-22 19:35:32'),(240,'sku-1005-s-gy','https://dummyimage.com/600x600/c0c0c0/000&text=Cover+Pure+GY+S+Main','https://dummyimage.com/100x100/c0c0c0/000&text=Cover+Pure+GY+S+Thumb','グレーPureカバーS',0,'2025-05-22 19:35:32'),(241,'sku-1005-d-wh','https://dummyimage.com/600x600/f0f0f0/000&text=Cover+Pure+WH+D+Main','https://dummyimage.com/100x100/f0f0f0/000&text=Cover+Pure+WH+D+Thumb','白PureカバーD',0,'2025-05-22 19:35:32'),(242,'sku-kettle-001-pk','https://dummyimage.com/600x600/ffc0cb/000&text=Kettle+PK+Main','https://dummyimage.com/100x100/ffc0cb/000&text=Kettle+PK+Thumb','ピンクケトル',0,'2025-05-22 19:35:32'),(243,'sku-kettle-001-bl','https://dummyimage.com/600x600/add8e6/000&text=Kettle+BL+Main','https://dummyimage.com/100x100/add8e6/000&text=Kettle+BL+Thumb','ブルーケトル',0,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `sku_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_values`
--

DROP TABLE IF EXISTS `sku_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sku_values` (
  `id` bigint NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `attribute_id` int NOT NULL,
  `option_id` int DEFAULT NULL,
  `value_string` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value_number` decimal(15,4) DEFAULT NULL,
  `value_boolean` tinyint(1) DEFAULT NULL,
  `value_text` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sku_attribute` (`sku_id`,`attribute_id`),
  KEY `idx_sku_values_option_id` (`option_id`),
  KEY `idx_sku_values_attribute_option` (`attribute_id`,`option_id`),
  CONSTRAINT `sku_values_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sku_values_ibfk_2` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sku_values_ibfk_3` FOREIGN KEY (`option_id`) REFERENCES `attribute_options` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SKU属性値';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_values`
--

LOCK TABLES `sku_values` WRITE;
/*!40000 ALTER TABLE `sku_values` DISABLE KEYS */;
INSERT INTO `sku_values` VALUES (20001,'sku-0001',1,101,NULL,NULL,NULL,NULL),(20002,'sku-0001',3,301,NULL,NULL,NULL,NULL),(20003,'sku-0001',4,NULL,NULL,145.0000,NULL,NULL),(20004,'sku-0001',5,NULL,NULL,90.0000,NULL,NULL),(20005,'sku-0001',6,NULL,NULL,85.0000,NULL,NULL),(20006,'sku-0001',8,NULL,NULL,NULL,1,NULL),(20007,'sku-0001',11,NULL,'1年保証',NULL,NULL,NULL),(20008,'sku-0002',1,102,NULL,NULL,NULL,NULL),(20009,'sku-0002',3,301,NULL,NULL,NULL,NULL),(20010,'sku-0002',4,NULL,NULL,145.0000,NULL,NULL),(20011,'sku-0002',5,NULL,NULL,90.0000,NULL,NULL),(20012,'sku-0002',6,NULL,NULL,85.0000,NULL,NULL),(20013,'sku-0002',8,NULL,NULL,NULL,1,NULL),(20014,'sku-0002',11,NULL,'1年保証',NULL,NULL,NULL),(20015,'sku-0003',1,103,NULL,NULL,NULL,NULL),(20016,'sku-0003',3,301,NULL,NULL,NULL,NULL),(20017,'sku-0003',4,NULL,NULL,145.0000,NULL,NULL),(20018,'sku-0003',5,NULL,NULL,90.0000,NULL,NULL),(20019,'sku-0003',6,NULL,NULL,85.0000,NULL,NULL),(20020,'sku-0003',8,NULL,NULL,NULL,1,NULL),(20021,'sku-0003',11,NULL,'1年保証',NULL,NULL,NULL),(20022,'sku-p0001-grn',1,107,NULL,NULL,NULL,NULL),(20023,'sku-p0001-grn',3,301,NULL,NULL,NULL,NULL),(20024,'sku-p0001-grn',4,NULL,NULL,145.0000,NULL,NULL),(20025,'sku-p0001-grn',5,NULL,NULL,90.0000,NULL,NULL),(20026,'sku-p0001-grn',6,NULL,NULL,85.0000,NULL,NULL),(20027,'sku-p0001-grn',8,NULL,NULL,NULL,1,NULL),(20028,'sku-p0001-grn',11,NULL,'1年保証',NULL,NULL,NULL),(20029,'sku-0013',1,105,NULL,NULL,NULL,NULL),(20030,'sku-0013',3,305,NULL,NULL,NULL,NULL),(20031,'sku-0013',4,NULL,NULL,180.0000,NULL,NULL),(20032,'sku-0013',5,NULL,NULL,92.0000,NULL,NULL),(20033,'sku-0013',6,NULL,NULL,88.0000,NULL,NULL),(20034,'sku-0013',8,NULL,NULL,NULL,1,NULL),(20035,'sku-0013',11,NULL,'3年保証',NULL,NULL,NULL),(20036,'sku-p0002-dbr',1,106,NULL,NULL,NULL,NULL),(20037,'sku-p0002-dbr',3,305,NULL,NULL,NULL,NULL),(20038,'sku-p0002-dbr',4,NULL,NULL,180.0000,NULL,NULL),(20039,'sku-p0002-dbr',5,NULL,NULL,92.0000,NULL,NULL),(20040,'sku-p0002-dbr',6,NULL,NULL,88.0000,NULL,NULL),(20041,'sku-p0002-dbr',8,NULL,NULL,NULL,1,NULL),(20042,'sku-p0002-dbr',11,NULL,'3年保証',NULL,NULL,NULL),(20043,'sku-p0002-ivr',1,104,NULL,NULL,NULL,NULL),(20044,'sku-p0002-ivr',3,305,NULL,NULL,NULL,NULL),(20045,'sku-p0002-ivr',4,NULL,NULL,180.0000,NULL,NULL),(20046,'sku-p0002-ivr',5,NULL,NULL,92.0000,NULL,NULL),(20047,'sku-p0002-ivr',6,NULL,NULL,88.0000,NULL,NULL),(20048,'sku-p0002-ivr',8,NULL,NULL,NULL,1,NULL),(20049,'sku-p0002-ivr',11,NULL,'3年保証',NULL,NULL,NULL),(20050,'sku-p0003-lgy',1,101,NULL,NULL,NULL,NULL),(20051,'sku-p0003-lgy',3,301,NULL,NULL,NULL,NULL),(20052,'sku-p0003-lgy',4,NULL,NULL,190.0000,NULL,NULL),(20053,'sku-p0003-lgy',5,NULL,NULL,130.0000,NULL,NULL),(20054,'sku-p0003-lgy',6,NULL,NULL,70.0000,NULL,NULL),(20055,'sku-p0003-lgy',8,NULL,NULL,NULL,1,NULL),(20056,'sku-p0003-blu',1,109,NULL,NULL,NULL,NULL),(20057,'sku-p0003-blu',3,301,NULL,NULL,NULL,NULL),(20058,'sku-p0003-blu',4,NULL,NULL,190.0000,NULL,NULL),(20059,'sku-p0003-blu',5,NULL,NULL,130.0000,NULL,NULL),(20060,'sku-p0003-blu',6,NULL,NULL,70.0000,NULL,NULL),(20061,'sku-p0003-blu',8,NULL,NULL,NULL,1,NULL),(20062,'sku-0004',1,104,NULL,NULL,NULL,NULL),(20063,'sku-0004',3,303,NULL,NULL,NULL,NULL),(20064,'sku-0004',12,1201,NULL,NULL,NULL,NULL),(20065,'sku-0005',1,106,NULL,NULL,NULL,NULL),(20066,'sku-0005',3,303,NULL,NULL,NULL,NULL),(20067,'sku-0005',12,1201,NULL,NULL,NULL,NULL),(20068,'sku-p0004-bk',1,105,NULL,NULL,NULL,NULL),(20069,'sku-p0004-bk',3,303,NULL,NULL,NULL,NULL),(20070,'sku-p0004-bk',12,1201,NULL,NULL,NULL,NULL),(20071,'sku-p0005-na',1,NULL,'ナチュラル',NULL,NULL,NULL),(20072,'sku-p0005-na',3,303,NULL,NULL,NULL,NULL),(20073,'sku-p0005-wh',1,104,NULL,NULL,NULL,NULL),(20074,'sku-p0005-wh',3,303,NULL,NULL,NULL,NULL),(20075,'sku-0006',1,109,NULL,NULL,NULL,NULL),(20076,'sku-0006',2,201,NULL,NULL,NULL,NULL),(20077,'sku-0006',3,301,NULL,NULL,NULL,NULL),(20078,'sku-0006',12,1205,NULL,NULL,NULL,NULL),(20079,'sku-0007',1,101,NULL,NULL,NULL,NULL),(20080,'sku-0007',2,201,NULL,NULL,NULL,NULL),(20081,'sku-0007',3,301,NULL,NULL,NULL,NULL),(20082,'sku-0007',12,1205,NULL,NULL,NULL,NULL),(20083,'sku-0008',1,109,NULL,NULL,NULL,NULL),(20084,'sku-0008',2,202,NULL,NULL,NULL,NULL),(20085,'sku-0008',3,301,NULL,NULL,NULL,NULL),(20086,'sku-0008',12,1205,NULL,NULL,NULL,NULL),(20087,'sku-0009',1,101,NULL,NULL,NULL,NULL),(20088,'sku-0009',2,202,NULL,NULL,NULL,NULL),(20089,'sku-0009',3,301,NULL,NULL,NULL,NULL),(20090,'sku-0009',12,1205,NULL,NULL,NULL,NULL),(20091,'sku-0010',1,109,NULL,NULL,NULL,NULL),(20092,'sku-0010',2,203,NULL,NULL,NULL,NULL),(20093,'sku-0010',3,301,NULL,NULL,NULL,NULL),(20094,'sku-0010',12,1205,NULL,NULL,NULL,NULL),(20095,'sku-0011',1,101,NULL,NULL,NULL,NULL),(20096,'sku-0011',2,203,NULL,NULL,NULL,NULL),(20097,'sku-0011',3,301,NULL,NULL,NULL,NULL),(20098,'sku-0011',12,1205,NULL,NULL,NULL,NULL),(20099,'sku-p0006-s-pk',1,NULL,'ピンク',NULL,NULL,NULL),(20100,'sku-p0006-s-pk',2,201,NULL,NULL,NULL,NULL),(20101,'sku-p0006-s-pk',3,301,NULL,NULL,NULL,NULL),(20102,'sku-p0006-s-pk',12,1205,NULL,NULL,NULL,NULL),(20103,'sku-p0006-sd-pk',1,NULL,'ピンク',NULL,NULL,NULL),(20104,'sku-p0006-sd-pk',2,202,NULL,NULL,NULL,NULL),(20105,'sku-p0006-sd-pk',3,301,NULL,NULL,NULL,NULL),(20106,'sku-p0006-sd-pk',12,1205,NULL,NULL,NULL,NULL),(20107,'sku-p0007-s-wh',1,104,NULL,NULL,NULL,NULL),(20108,'sku-p0007-s-wh',2,201,NULL,NULL,NULL,NULL),(20109,'sku-p0007-s-wh',3,302,NULL,NULL,NULL,NULL),(20110,'sku-p0007-s-gy',1,101,NULL,NULL,NULL,NULL),(20111,'sku-p0007-s-gy',2,201,NULL,NULL,NULL,NULL),(20112,'sku-p0007-s-gy',3,302,NULL,NULL,NULL,NULL),(20113,'sku-p0007-sd-wh',1,104,NULL,NULL,NULL,NULL),(20114,'sku-p0007-sd-wh',2,202,NULL,NULL,NULL,NULL),(20115,'sku-p0007-sd-wh',3,302,NULL,NULL,NULL,NULL),(20116,'sku-p0008-8j',12,1202,NULL,NULL,NULL,NULL),(20117,'sku-p0008-8j',15,NULL,NULL,8.0000,NULL,NULL),(20118,'sku-p0008-8j',16,1601,NULL,NULL,NULL,NULL),(20119,'sku-0012',3,304,NULL,NULL,NULL,NULL),(20120,'sku-0012',4,NULL,NULL,26.0000,NULL,NULL),(20121,'sku-0012',10,1002,NULL,NULL,NULL,NULL),(20122,'sku-0014',1,NULL,'ナチュラル',NULL,NULL,NULL),(20123,'sku-0014',3,303,NULL,NULL,NULL,NULL),(20124,'sku-0014',8,NULL,NULL,NULL,0,NULL),(20125,'sku-p0010-br',1,106,NULL,NULL,NULL,NULL),(20126,'sku-p0010-br',3,303,NULL,NULL,NULL,NULL),(20127,'sku-p0010-br',8,NULL,NULL,NULL,0,NULL),(20128,'sku-1001',1,107,NULL,NULL,NULL,NULL),(20129,'sku-1001',3,301,NULL,NULL,NULL,NULL),(20130,'sku-1001',8,NULL,NULL,NULL,1,NULL),(20131,'sku-1001-be',1,103,NULL,NULL,NULL,NULL),(20132,'sku-1001-be',3,301,NULL,NULL,NULL,NULL),(20133,'sku-1001-be',8,NULL,NULL,NULL,1,NULL),(20134,'sku-1002',1,106,NULL,NULL,NULL,NULL),(20135,'sku-1002',3,305,NULL,NULL,NULL,NULL),(20136,'sku-1002',8,NULL,NULL,NULL,0,NULL),(20137,'sku-1002-bk',1,105,NULL,NULL,NULL,NULL),(20138,'sku-1002-bk',3,305,NULL,NULL,NULL,NULL),(20139,'sku-1002-bk',8,NULL,NULL,NULL,0,NULL),(20140,'sku-1003',1,105,NULL,NULL,NULL,NULL),(20141,'sku-1003',3,304,NULL,NULL,NULL,NULL),(20142,'sku-1003',8,NULL,NULL,NULL,1,NULL),(20143,'sku-1003-wh',1,104,NULL,NULL,NULL,NULL),(20144,'sku-1003-wh',3,304,NULL,NULL,NULL,NULL),(20145,'sku-1003-wh',8,NULL,NULL,NULL,1,NULL),(20146,'sku-1004',1,NULL,'ナチュラル',NULL,NULL,NULL),(20147,'sku-1004',3,303,NULL,NULL,NULL,NULL),(20148,'sku-1004',12,1201,NULL,NULL,NULL,NULL),(20149,'sku-1004-br',1,106,NULL,NULL,NULL,NULL),(20150,'sku-1004-br',3,303,NULL,NULL,NULL,NULL),(20151,'sku-1004-br',12,1201,NULL,NULL,NULL,NULL),(20152,'sku-1005',1,104,NULL,NULL,NULL,NULL),(20153,'sku-1005',2,201,NULL,NULL,NULL,NULL),(20154,'sku-1005',3,302,NULL,NULL,NULL,NULL),(20155,'sku-1005-s-gy',1,101,NULL,NULL,NULL,NULL),(20156,'sku-1005-s-gy',2,201,NULL,NULL,NULL,NULL),(20157,'sku-1005-s-gy',3,302,NULL,NULL,NULL,NULL),(20158,'sku-1005-d-wh',1,104,NULL,NULL,NULL,NULL),(20159,'sku-1005-d-wh',2,203,NULL,NULL,NULL,NULL),(20160,'sku-1005-d-wh',3,302,NULL,NULL,NULL,NULL),(20161,'sku-kettle-001-pk',1,NULL,'パステルピンク',NULL,NULL,NULL),(20162,'sku-kettle-001-pk',3,308,NULL,NULL,NULL,NULL),(20163,'sku-kettle-001-pk',14,NULL,NULL,1.0000,NULL,NULL),(20164,'sku-kettle-001-bl',1,NULL,'パステルブルー',NULL,NULL,NULL),(20165,'sku-kettle-001-bl',3,308,NULL,NULL,NULL,NULL),(20166,'sku-kettle-001-bl',14,NULL,NULL,1.0000,NULL,NULL);
/*!40000 ALTER TABLE `sku_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_apis`
--

DROP TABLE IF EXISTS `sys_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_apis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api路径',
  `description` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api中文描述',
  `api_group` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api组',
  `method` varchar(191) COLLATE utf8mb4_general_ci DEFAULT 'POST' COMMENT '方法',
  PRIMARY KEY (`id`),
  KEY `idx_sys_apis_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_apis`
--

LOCK TABLES `sys_apis` WRITE;
/*!40000 ALTER TABLE `sys_apis` DISABLE KEYS */;
INSERT INTO `sys_apis` VALUES (1,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/jwt/jsonInBlacklist','jwt加入黑名单(退出，必选)','jwt','POST'),(2,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/deleteUser','删除用户','系统用户','DELETE'),(3,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/admin_register','用户注册','系统用户','POST'),(4,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/getUserList','获取用户列表','系统用户','POST'),(5,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/setUserInfo','设置用户信息','系统用户','PUT'),(6,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/setSelfInfo','设置自身信息(必选)','系统用户','PUT'),(7,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/getUserInfo','获取自身信息(必选)','系统用户','GET'),(8,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/setUserAuthorities','设置权限组','系统用户','POST'),(9,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/changePassword','修改密码（建议选择)','系统用户','POST'),(10,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/setUserAuthority','修改用户角色(必选)','系统用户','POST'),(11,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/resetPassword','重置用户密码','系统用户','POST'),(12,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/user/setSelfSetting','用户界面配置','系统用户','PUT'),(13,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/createApi','创建api','api','POST'),(14,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/deleteApi','删除Api','api','POST'),(15,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/updateApi','更新Api','api','POST'),(16,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/getApiList','获取api列表','api','POST'),(17,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/getAllApis','获取所有api','api','POST'),(18,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/getApiById','获取api详细信息','api','POST'),(19,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/deleteApisByIds','批量删除api','api','DELETE'),(20,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/syncApi','获取待同步API','api','GET'),(21,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/getApiGroups','获取路由组','api','GET'),(22,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/enterSyncApi','确认同步API','api','POST'),(23,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/api/ignoreApi','忽略API','api','POST'),(24,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/copyAuthority','拷贝角色','角色','POST'),(25,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/createAuthority','创建角色','角色','POST'),(26,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/deleteAuthority','删除角色','角色','POST'),(27,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/updateAuthority','更新角色信息','角色','PUT'),(28,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/getAuthorityList','获取角色列表','角色','POST'),(29,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authority/setDataAuthority','设置角色资源权限','角色','POST'),(30,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/casbin/updateCasbin','更改角色api权限','casbin','POST'),(31,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/casbin/getPolicyPathByAuthorityId','获取权限列表','casbin','POST'),(32,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/addBaseMenu','新增菜单','菜单','POST'),(33,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/getMenu','获取菜单树(必选)','菜单','POST'),(34,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/deleteBaseMenu','删除菜单','菜单','POST'),(35,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/updateBaseMenu','更新菜单','菜单','POST'),(36,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/getBaseMenuById','根据id获取菜单','菜单','POST'),(37,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/getMenuList','分页获取基础menu列表','菜单','POST'),(38,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/getBaseMenuTree','获取用户动态路由','菜单','POST'),(39,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/getMenuAuthority','获取指定角色menu','菜单','POST'),(40,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/menu/addMenuAuthority','增加menu和角色关联关系','菜单','POST'),(41,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/findFile','寻找目标文件（秒传）','分片上传','GET'),(42,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/breakpointContinue','断点续传','分片上传','POST'),(43,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/breakpointContinueFinish','断点续传完成','分片上传','POST'),(44,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/removeChunk','上传完成移除文件','分片上传','POST'),(45,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/upload','文件上传（建议选择）','文件上传与下载','POST'),(46,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/deleteFile','删除文件','文件上传与下载','POST'),(47,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/editFileName','文件名或者备注编辑','文件上传与下载','POST'),(48,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/getFileList','获取上传文件列表','文件上传与下载','POST'),(49,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/fileUploadAndDownload/importURL','导入URL','文件上传与下载','POST'),(50,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/system/getServerInfo','获取服务器信息','系统服务','POST'),(51,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/system/getSystemConfig','获取配置文件内容','系统服务','POST'),(52,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/system/setSystemConfig','设置配置文件内容','系统服务','POST'),(53,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/customer/customer','更新客户','客户','PUT'),(54,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/customer/customer','创建客户','客户','POST'),(55,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/customer/customer','删除客户','客户','DELETE'),(56,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/customer/customer','获取单一客户','客户','GET'),(57,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/customer/customerList','获取客户列表','客户','GET'),(58,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getDB','获取所有数据库','代码生成器','GET'),(59,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getTables','获取数据库表','代码生成器','GET'),(60,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/createTemp','自动化代码','代码生成器','POST'),(61,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/preview','预览自动化代码','代码生成器','POST'),(62,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getColumn','获取所选table的所有字段','代码生成器','GET'),(63,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/installPlugin','安装插件','代码生成器','POST'),(64,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/pubPlug','打包插件','代码生成器','POST'),(65,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/createPackage','配置模板','模板配置','POST'),(66,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getTemplates','获取模板文件','模板配置','GET'),(67,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getPackage','获取所有模板','模板配置','POST'),(68,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/delPackage','删除模板','模板配置','POST'),(69,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getMeta','获取meta信息','代码生成器历史','POST'),(70,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/rollback','回滚自动生成代码','代码生成器历史','POST'),(71,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/getSysHistory','查询回滚记录','代码生成器历史','POST'),(72,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/delSysHistory','删除回滚记录','代码生成器历史','POST'),(73,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/autoCode/addFunc','增加模板方法','代码生成器历史','POST'),(74,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionaryDetail/updateSysDictionaryDetail','更新字典内容','系统字典详情','PUT'),(75,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionaryDetail/createSysDictionaryDetail','新增字典内容','系统字典详情','POST'),(76,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionaryDetail/deleteSysDictionaryDetail','删除字典内容','系统字典详情','DELETE'),(77,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionaryDetail/findSysDictionaryDetail','根据ID获取字典内容','系统字典详情','GET'),(78,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionaryDetail/getSysDictionaryDetailList','获取字典内容列表','系统字典详情','GET'),(79,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionary/createSysDictionary','新增字典','系统字典','POST'),(80,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionary/deleteSysDictionary','删除字典','系统字典','DELETE'),(81,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionary/updateSysDictionary','更新字典','系统字典','PUT'),(82,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionary/findSysDictionary','根据ID获取字典（建议选择）','系统字典','GET'),(83,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysDictionary/getSysDictionaryList','获取字典列表','系统字典','GET'),(84,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysOperationRecord/createSysOperationRecord','新增操作记录','操作记录','POST'),(85,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysOperationRecord/findSysOperationRecord','根据ID获取操作记录','操作记录','GET'),(86,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysOperationRecord/getSysOperationRecordList','获取操作记录列表','操作记录','GET'),(87,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysOperationRecord/deleteSysOperationRecord','删除操作记录','操作记录','DELETE'),(88,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysOperationRecord/deleteSysOperationRecordByIds','批量删除操作历史','操作记录','DELETE'),(89,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/simpleUploader/upload','插件版分片上传','断点续传(插件版)','POST'),(90,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/simpleUploader/checkFileMd5','文件完整度验证','断点续传(插件版)','GET'),(91,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/simpleUploader/mergeFileMd5','上传完成合并文件','断点续传(插件版)','GET'),(92,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/email/emailTest','发送测试邮件','email','POST'),(93,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/email/sendEmail','发送邮件','email','POST'),(94,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authorityBtn/setAuthorityBtn','设置按钮权限','按钮权限','POST'),(95,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authorityBtn/getAuthorityBtn','获取已有按钮权限','按钮权限','POST'),(96,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/authorityBtn/canRemoveAuthorityBtn','删除按钮','按钮权限','POST'),(97,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/createSysExportTemplate','新增导出模板','导出模板','POST'),(98,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/deleteSysExportTemplate','删除导出模板','导出模板','DELETE'),(99,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/deleteSysExportTemplateByIds','批量删除导出模板','导出模板','DELETE'),(100,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/updateSysExportTemplate','更新导出模板','导出模板','PUT'),(101,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/findSysExportTemplate','根据ID获取导出模板','导出模板','GET'),(102,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/getSysExportTemplateList','获取导出模板列表','导出模板','GET'),(103,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/exportExcel','导出Excel','导出模板','GET'),(104,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/exportTemplate','下载模板','导出模板','GET'),(105,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysExportTemplate/importExcel','导入Excel','导出模板','POST'),(106,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/createInfo','新建公告','公告','POST'),(107,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/deleteInfo','删除公告','公告','DELETE'),(108,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/deleteInfoByIds','批量删除公告','公告','DELETE'),(109,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/updateInfo','更新公告','公告','PUT'),(110,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/findInfo','根据ID获取公告','公告','GET'),(111,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/info/getInfoList','获取公告列表','公告','GET'),(112,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/createSysParams','新建参数','参数管理','POST'),(113,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/deleteSysParams','删除参数','参数管理','DELETE'),(114,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/deleteSysParamsByIds','批量删除参数','参数管理','DELETE'),(115,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/updateSysParams','更新参数','参数管理','PUT'),(116,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/findSysParams','根据ID获取参数','参数管理','GET'),(117,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/getSysParamsList','获取参数列表','参数管理','GET'),(118,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/sysParams/getSysParam','获取参数列表','参数管理','GET'),(119,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/attachmentCategory/getCategoryList','分类列表','媒体库分类','GET'),(120,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/attachmentCategory/addCategory','添加/编辑分类','媒体库分类','POST'),(121,'2025-04-18 17:09:39.502','2025-04-18 17:09:39.502',NULL,'/attachmentCategory/deleteCategory','删除分类','媒体库分类','POST');
/*!40000 ALTER TABLE `sys_apis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_authorities`
--

DROP TABLE IF EXISTS `sys_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_authorities` (
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `authority_id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `authority_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '角色名',
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父角色ID',
  `default_router` varchar(191) COLLATE utf8mb4_general_ci DEFAULT 'dashboard' COMMENT '默认菜单',
  PRIMARY KEY (`authority_id`),
  UNIQUE KEY `uni_sys_authorities_authority_id` (`authority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9529 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_authorities`
--

LOCK TABLES `sys_authorities` WRITE;
/*!40000 ALTER TABLE `sys_authorities` DISABLE KEYS */;
INSERT INTO `sys_authorities` VALUES ('2025-04-18 17:09:39.526','2025-04-18 17:09:39.761',NULL,888,'普通用户',0,'dashboard'),('2025-04-18 17:09:39.526','2025-04-18 17:09:39.777',NULL,8881,'普通用户子角色',888,'dashboard'),('2025-04-18 17:09:39.526','2025-04-18 17:09:39.767',NULL,9528,'测试角色',0,'dashboard');
/*!40000 ALTER TABLE `sys_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_authority_btns`
--

DROP TABLE IF EXISTS `sys_authority_btns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_authority_btns` (
  `authority_id` bigint unsigned DEFAULT NULL COMMENT '角色ID',
  `sys_menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  `sys_base_menu_btn_id` bigint unsigned DEFAULT NULL COMMENT '菜单按钮ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_authority_btns`
--

LOCK TABLES `sys_authority_btns` WRITE;
/*!40000 ALTER TABLE `sys_authority_btns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_authority_btns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_authority_menus`
--

DROP TABLE IF EXISTS `sys_authority_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_authority_menus` (
  `sys_base_menu_id` bigint unsigned NOT NULL,
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_base_menu_id`,`sys_authority_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_authority_menus`
--

LOCK TABLES `sys_authority_menus` WRITE;
/*!40000 ALTER TABLE `sys_authority_menus` DISABLE KEYS */;
INSERT INTO `sys_authority_menus` VALUES (1,888),(1,8881),(1,9528),(2,888),(2,8881),(2,9528),(3,888),(4,888),(4,8881),(5,888),(5,8881),(6,888),(6,8881),(7,888),(7,8881),(8,888),(8,8881),(8,9528),(9,888),(9,8881),(10,888),(10,8881),(11,888),(11,8881),(12,888),(13,888),(13,8881),(14,888),(14,8881),(15,888),(15,8881),(16,888),(16,8881),(17,888),(17,8881),(18,888),(19,888),(20,888),(21,888),(22,888),(23,888),(24,888),(25,888),(26,888),(27,888),(28,888),(29,888),(30,888),(31,888),(32,888);
/*!40000 ALTER TABLE `sys_authority_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_auto_code_histories`
--

DROP TABLE IF EXISTS `sys_auto_code_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_auto_code_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `table_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表名',
  `package` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模块名/插件名',
  `request` text COLLATE utf8mb4_general_ci COMMENT '前端传入的结构化信息',
  `struct_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结构体名称',
  `abbreviation` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结构体名称缩写',
  `business_db` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务库',
  `description` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Struct中文名称',
  `templates` text COLLATE utf8mb4_general_ci COMMENT '模板信息',
  `Injections` text COLLATE utf8mb4_general_ci COMMENT '注入路径',
  `flag` bigint DEFAULT NULL COMMENT '[0:创建,1:回滚]',
  `api_ids` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api表注册内容',
  `menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  `export_template_id` bigint unsigned DEFAULT NULL COMMENT '导出模板ID',
  `package_id` bigint unsigned DEFAULT NULL COMMENT '包ID',
  PRIMARY KEY (`id`),
  KEY `idx_sys_auto_code_histories_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_auto_code_histories`
--

LOCK TABLES `sys_auto_code_histories` WRITE;
/*!40000 ALTER TABLE `sys_auto_code_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_auto_code_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_auto_code_packages`
--

DROP TABLE IF EXISTS `sys_auto_code_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_auto_code_packages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `desc` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  `label` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '展示名',
  `template` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模版',
  `package_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包名',
  `module` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_sys_auto_code_packages_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_auto_code_packages`
--

LOCK TABLES `sys_auto_code_packages` WRITE;
/*!40000 ALTER TABLE `sys_auto_code_packages` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_auto_code_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_base_menu_btns`
--

DROP TABLE IF EXISTS `sys_base_menu_btns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_base_menu_btns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '按钮关键key',
  `desc` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sys_base_menu_id` bigint unsigned DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menu_btns_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_base_menu_btns`
--

LOCK TABLES `sys_base_menu_btns` WRITE;
/*!40000 ALTER TABLE `sys_base_menu_btns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_base_menu_btns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_base_menu_parameters`
--

DROP TABLE IF EXISTS `sys_base_menu_parameters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_base_menu_parameters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `sys_base_menu_id` bigint unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数为params还是query',
  `key` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数的key',
  `value` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '地址栏携带参数的值',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menu_parameters_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_base_menu_parameters`
--

LOCK TABLES `sys_base_menu_parameters` WRITE;
/*!40000 ALTER TABLE `sys_base_menu_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_base_menu_parameters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_base_menus`
--

DROP TABLE IF EXISTS `sys_base_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_base_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `menu_level` bigint unsigned DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL COMMENT '父菜单ID',
  `path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由path',
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路由name',
  `hidden` tinyint(1) DEFAULT NULL COMMENT '是否在列表隐藏',
  `component` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '对应前端文件路径',
  `sort` bigint DEFAULT NULL COMMENT '排序标记',
  `active_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附加属性',
  `keep_alive` tinyint(1) DEFAULT NULL COMMENT '附加属性',
  `default_menu` tinyint(1) DEFAULT NULL COMMENT '附加属性',
  `title` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附加属性',
  `icon` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附加属性',
  `close_tab` tinyint(1) DEFAULT NULL COMMENT '附加属性',
  `transition_type` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '附加属性',
  PRIMARY KEY (`id`),
  KEY `idx_sys_base_menus_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_base_menus`
--

LOCK TABLES `sys_base_menus` WRITE;
/*!40000 ALTER TABLE `sys_base_menus` DISABLE KEYS */;
INSERT INTO `sys_base_menus` VALUES (1,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'dashboard','dashboard',0,'view/dashboard/index.vue',1,'',0,0,'仪表盘','odometer',0,''),(2,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'about','about',0,'view/about/index.vue',9,'',0,0,'关于我们','info-filled',0,''),(3,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'admin','superAdmin',0,'view/superAdmin/index.vue',3,'',0,0,'超级管理员','user',0,''),(4,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'authority','authority',0,'view/superAdmin/authority/authority.vue',1,'',0,0,'角色管理','avatar',0,''),(5,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'menu','menu',0,'view/superAdmin/menu/menu.vue',2,'',1,0,'菜单管理','tickets',0,''),(6,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'api','api',0,'view/superAdmin/api/api.vue',3,'',1,0,'api管理','platform',0,''),(7,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'user','user',0,'view/superAdmin/user/user.vue',4,'',0,0,'用户管理','coordinate',0,''),(8,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'dictionary','dictionary',0,'view/superAdmin/dictionary/sysDictionary.vue',5,'',0,0,'字典管理','notebook',0,''),(9,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'operation','operation',0,'view/superAdmin/operation/sysOperationRecord.vue',6,'',0,0,'操作历史','pie-chart',0,''),(10,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'person','person',1,'view/person/person.vue',4,'',0,0,'个人信息','message',0,''),(11,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'example','example',0,'view/example/index.vue',7,'',0,0,'示例文件','management',0,''),(12,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,11,'upload','upload',0,'view/example/upload/upload.vue',5,'',0,0,'媒体库（上传下载）','upload',0,''),(13,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,11,'breakpoint','breakpoint',0,'view/example/breakpoint/breakpoint.vue',6,'',0,0,'断点续传','upload-filled',0,''),(14,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,11,'customer','customer',0,'view/example/customer/customer.vue',7,'',0,0,'客户列表（资源示例）','avatar',0,''),(15,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'systemTools','systemTools',0,'view/systemTools/index.vue',5,'',0,0,'系统工具','tools',0,''),(16,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'autoCode','autoCode',0,'view/systemTools/autoCode/index.vue',1,'',1,0,'代码生成器','cpu',0,''),(17,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'formCreate','formCreate',0,'view/systemTools/formCreate/index.vue',3,'',1,0,'表单生成器','magic-stick',0,''),(18,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'system','system',0,'view/systemTools/system/system.vue',4,'',0,0,'系统配置','operation',0,''),(19,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'autoCodeAdmin','autoCodeAdmin',0,'view/systemTools/autoCodeAdmin/index.vue',2,'',0,0,'自动化代码管理','magic-stick',0,''),(20,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'autoCodeEdit/:id','autoCodeEdit',1,'view/systemTools/autoCode/index.vue',0,'',0,0,'自动化代码-${id}','magic-stick',0,''),(21,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'autoPkg','autoPkg',0,'view/systemTools/autoPkg/autoPkg.vue',0,'',0,0,'模板配置','folder',0,''),(22,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'https://www.gin-vue-admin.com','https://www.gin-vue-admin.com',0,'/',0,'',0,0,'官方网站','customer-gva',0,''),(23,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'state','state',0,'view/system/state.vue',8,'',0,0,'服务器状态','cloudy',0,''),(24,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,0,'plugin','plugin',0,'view/routerHolder.vue',6,'',0,0,'插件系统','cherry',0,''),(25,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,24,'https://plugin.gin-vue-admin.com/','https://plugin.gin-vue-admin.com/',0,'https://plugin.gin-vue-admin.com/',0,'',0,0,'插件市场','shop',0,''),(26,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,24,'installPlugin','installPlugin',0,'view/systemTools/installPlugin/index.vue',1,'',0,0,'插件安装','box',0,''),(27,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,24,'pubPlug','pubPlug',0,'view/systemTools/pubPlug/pubPlug.vue',3,'',0,0,'打包插件','files',0,''),(28,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,24,'plugin-email','plugin-email',0,'plugin/email/view/index.vue',4,'',0,0,'邮件插件','message',0,''),(29,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'exportTemplate','exportTemplate',0,'view/systemTools/exportTemplate/exportTemplate.vue',5,'',0,0,'导出模板','reading',0,''),(30,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,24,'anInfo','anInfo',0,'plugin/announcement/view/info.vue',5,'',0,0,'公告管理[示例]','scaleToOriginal',0,''),(31,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,3,'sysParams','sysParams',0,'view/superAdmin/params/sysParams.vue',7,'',0,0,'参数管理','compass',0,''),(32,'2025-04-18 17:09:39.583','2025-04-18 17:09:39.583',NULL,0,15,'picture','picture',0,'view/systemTools/autoCode/picture.vue',6,'',0,0,'AI页面绘制','picture-filled',0,'');
/*!40000 ALTER TABLE `sys_base_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_data_authority_id`
--

DROP TABLE IF EXISTS `sys_data_authority_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_data_authority_id` (
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  `data_authority_id_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_authority_authority_id`,`data_authority_id_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_data_authority_id`
--

LOCK TABLES `sys_data_authority_id` WRITE;
/*!40000 ALTER TABLE `sys_data_authority_id` DISABLE KEYS */;
INSERT INTO `sys_data_authority_id` VALUES (888,888),(888,8881),(888,9528),(9528,8881),(9528,9528);
/*!40000 ALTER TABLE `sys_data_authority_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dictionaries`
--

DROP TABLE IF EXISTS `sys_dictionaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dictionaries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典名（中）',
  `type` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典名（英）',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `desc` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `idx_sys_dictionaries_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dictionaries`
--

LOCK TABLES `sys_dictionaries` WRITE;
/*!40000 ALTER TABLE `sys_dictionaries` DISABLE KEYS */;
INSERT INTO `sys_dictionaries` VALUES (1,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.550',NULL,'性别','gender',1,'性别字典'),(2,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.555',NULL,'数据库int类型','int',1,'int类型对应的数据库类型'),(3,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.561',NULL,'数据库时间日期类型','time.Time',1,'数据库时间日期类型'),(4,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.567',NULL,'数据库浮点型','float64',1,'数据库浮点型'),(5,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.571',NULL,'数据库字符串','string',1,'数据库字符串'),(6,'2025-04-18 17:09:39.544','2025-04-18 17:09:39.577',NULL,'数据库bool类型','bool',1,'数据库bool类型');
/*!40000 ALTER TABLE `sys_dictionaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dictionary_details`
--

DROP TABLE IF EXISTS `sys_dictionary_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dictionary_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `label` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '展示值',
  `value` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '字典值',
  `extend` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '扩展值',
  `status` tinyint(1) DEFAULT NULL COMMENT '启用状态',
  `sort` bigint DEFAULT NULL COMMENT '排序标记',
  `sys_dictionary_id` bigint unsigned DEFAULT NULL COMMENT '关联标记',
  PRIMARY KEY (`id`),
  KEY `idx_sys_dictionary_details_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dictionary_details`
--

LOCK TABLES `sys_dictionary_details` WRITE;
/*!40000 ALTER TABLE `sys_dictionary_details` DISABLE KEYS */;
INSERT INTO `sys_dictionary_details` VALUES (1,'2025-04-18 17:09:39.550','2025-04-18 17:09:39.550',NULL,'男','1','',1,1,1),(2,'2025-04-18 17:09:39.550','2025-04-18 17:09:39.550',NULL,'女','2','',1,2,1),(3,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'smallint','1','mysql',1,1,2),(4,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'mediumint','2','mysql',1,2,2),(5,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'int','3','mysql',1,3,2),(6,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'bigint','4','mysql',1,4,2),(7,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'int2','5','pgsql',1,5,2),(8,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'int4','6','pgsql',1,6,2),(9,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'int6','7','pgsql',1,7,2),(10,'2025-04-18 17:09:39.556','2025-04-18 17:09:39.556',NULL,'int8','8','pgsql',1,8,2),(11,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'date','','',1,0,3),(12,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'time','1','mysql',1,1,3),(13,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'year','2','mysql',1,2,3),(14,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'datetime','3','mysql',1,3,3),(15,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'timestamp','5','mysql',1,5,3),(16,'2025-04-18 17:09:39.562','2025-04-18 17:09:39.562',NULL,'timestamptz','6','pgsql',1,5,3),(17,'2025-04-18 17:09:39.567','2025-04-18 17:09:39.567',NULL,'float','','',1,0,4),(18,'2025-04-18 17:09:39.567','2025-04-18 17:09:39.567',NULL,'double','1','mysql',1,1,4),(19,'2025-04-18 17:09:39.567','2025-04-18 17:09:39.567',NULL,'decimal','2','mysql',1,2,4),(20,'2025-04-18 17:09:39.567','2025-04-18 17:09:39.567',NULL,'numeric','3','pgsql',1,3,4),(21,'2025-04-18 17:09:39.567','2025-04-18 17:09:39.567',NULL,'smallserial','4','pgsql',1,4,4),(22,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'char','','',1,0,5),(23,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'varchar','1','mysql',1,1,5),(24,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'tinyblob','2','mysql',1,2,5),(25,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'tinytext','3','mysql',1,3,5),(26,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'text','4','mysql',1,4,5),(27,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'blob','5','mysql',1,5,5),(28,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'mediumblob','6','mysql',1,6,5),(29,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'mediumtext','7','mysql',1,7,5),(30,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'longblob','8','mysql',1,8,5),(31,'2025-04-18 17:09:39.572','2025-04-18 17:09:39.572',NULL,'longtext','9','mysql',1,9,5),(32,'2025-04-18 17:09:39.578','2025-04-18 17:09:39.578',NULL,'tinyint','1','mysql',1,0,6),(33,'2025-04-18 17:09:39.578','2025-04-18 17:09:39.578',NULL,'bool','2','pgsql',1,0,6);
/*!40000 ALTER TABLE `sys_dictionary_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_export_template_condition`
--

DROP TABLE IF EXISTS `sys_export_template_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_export_template_condition` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `template_id` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `from` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '条件取的key',
  `column` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '作为查询条件的字段',
  `operator` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作符',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_template_condition_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_export_template_condition`
--

LOCK TABLES `sys_export_template_condition` WRITE;
/*!40000 ALTER TABLE `sys_export_template_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_export_template_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_export_template_join`
--

DROP TABLE IF EXISTS `sys_export_template_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_export_template_join` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `template_id` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `joins` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联',
  `table` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联表',
  `on` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '关联条件',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_template_join_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_export_template_join`
--

LOCK TABLES `sys_export_template_join` WRITE;
/*!40000 ALTER TABLE `sys_export_template_join` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_export_template_join` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_export_templates`
--

DROP TABLE IF EXISTS `sys_export_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_export_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `db_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '数据库名称',
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板名称',
  `table_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '表名称',
  `template_id` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '模板标识',
  `template_info` text COLLATE utf8mb4_general_ci,
  `limit` bigint DEFAULT NULL COMMENT '导出限制',
  `order` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_sys_export_templates_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_export_templates`
--

LOCK TABLES `sys_export_templates` WRITE;
/*!40000 ALTER TABLE `sys_export_templates` DISABLE KEYS */;
INSERT INTO `sys_export_templates` VALUES (1,'2025-04-18 17:09:39.756','2025-04-18 17:09:39.756',NULL,'','api','sys_apis','api','{\n\"path\":\"路径\",\n\"method\":\"方法（大写）\",\n\"description\":\"方法介绍\",\n\"api_group\":\"方法分组\"\n}',NULL,'');
/*!40000 ALTER TABLE `sys_export_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_ignore_apis`
--

DROP TABLE IF EXISTS `sys_ignore_apis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_ignore_apis` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'api路径',
  `method` varchar(191) COLLATE utf8mb4_general_ci DEFAULT 'POST' COMMENT '方法',
  PRIMARY KEY (`id`),
  KEY `idx_sys_ignore_apis_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_ignore_apis`
--

LOCK TABLES `sys_ignore_apis` WRITE;
/*!40000 ALTER TABLE `sys_ignore_apis` DISABLE KEYS */;
INSERT INTO `sys_ignore_apis` VALUES (1,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/swagger/*any','GET'),(2,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/api/freshCasbin','GET'),(3,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/uploads/file/*filepath','GET'),(4,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/health','GET'),(5,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/uploads/file/*filepath','HEAD'),(6,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/autoCode/llmAuto','POST'),(7,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/system/reloadSystem','POST'),(8,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/base/login','POST'),(9,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/base/captcha','POST'),(10,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/init/initdb','POST'),(11,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/init/checkdb','POST'),(12,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/info/getInfoDataSource','GET'),(13,'2025-04-18 17:09:39.512','2025-04-18 17:09:39.512',NULL,'/info/getInfoPublic','GET');
/*!40000 ALTER TABLE `sys_ignore_apis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_operation_records`
--

DROP TABLE IF EXISTS `sys_operation_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_operation_records` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `ip` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求ip',
  `method` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求方法',
  `path` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求路径',
  `status` bigint DEFAULT NULL COMMENT '请求状态',
  `latency` bigint DEFAULT NULL COMMENT '延迟',
  `agent` text COLLATE utf8mb4_general_ci COMMENT '代理',
  `error_message` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '错误信息',
  `body` text COLLATE utf8mb4_general_ci COMMENT '请求Body',
  `resp` text COLLATE utf8mb4_general_ci COMMENT '响应Body',
  `user_id` bigint unsigned DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `idx_sys_operation_records_deleted_at` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_operation_records`
--

LOCK TABLES `sys_operation_records` WRITE;
/*!40000 ALTER TABLE `sys_operation_records` DISABLE KEYS */;
INSERT INTO `sys_operation_records` VALUES (1,'2025-04-19 12:00:05.571','2025-04-19 12:00:05.571',NULL,'::1','POST','/user/admin_register',200,0,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{\n  \"authorityId\": \"int 角色id\",\n  \"authorityIds\": \"[]uint 角色id\",\n  \"email\": \"电子邮箱\",\n  \"enable\": \"int 是否启用\",\n  \"headerImg\": \"头像链接\",\n  \"nickName\": \"昵称\",\n  \"passWord\": \"密码\",\n  \"phone\": \"电话号码\",\n  \"userName\": \"用户名\"\n}','{\"code\":7,\"data\":{},\"msg\":\"json: cannot unmarshal string into Go struct field Register.authorityId of type uint\"}',1),(2,'2025-04-21 15:52:59.875','2025-04-21 15:52:59.875',NULL,'127.0.0.1','POST','/user/admin_register',200,63131000,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{\"userName\":\"555555\",\"password\":\"555555\",\"nickName\":\"555555\",\"headerImg\":\"\",\"authorityId\":888,\"authorityIds\":[888],\"enable\":1,\"phone\":\"\",\"email\":\"\"}','{\"code\":0,\"data\":{\"user\":{\"ID\":3,\"CreatedAt\":\"2025-04-21T15:52:59.867+09:00\",\"UpdatedAt\":\"2025-04-21T15:52:59.867+09:00\",\"uuid\":\"275d7c5c-ab75-4c45-a054-56ef5544fc75\",\"userName\":\"555555\",\"nickName\":\"555555\",\"headerImg\":\"https://qmplusimg.henrongyi.top/gva_header.jpg\",\"authorityId\":888,\"authority\":{\"CreatedAt\":\"0001-01-01T00:00:00Z\",\"UpdatedAt\":\"0001-01-01T00:00:00Z\",\"DeletedAt\":null,\"authorityId\":0,\"authorityName\":\"\",\"parentId\":null,\"dataAuthorityId\":null,\"children\":null,\"menus\":null,\"defaultRouter\":\"\"},\"authorities\":[{\"CreatedAt\":\"2025-04-21T15:52:59.869+09:00\",\"UpdatedAt\":\"2025-04-21T15:52:59.869+09:00\",\"DeletedAt\":null,\"authorityId\":888,\"authorityName\":\"\",\"parentId\":null,\"dataAuthorityId\":null,\"children\":null,\"menus\":null,\"defaultRouter\":\"dashboard\"}],\"phone\":\"\",\"email\":\"\",\"gender\":\"\",\"nationality\":\"\",\"enable\":1,\"originSetting\":null}},\"msg\":\"注册成功\"}',1),(3,'2025-04-21 16:21:50.121','2025-04-21 16:21:50.121',NULL,'127.0.0.1','POST','/user/setUserAuthority',200,9654200,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{\"authorityId\":9528}','{\"code\":0,\"data\":{},\"msg\":\"修改成功\"}',1),(4,'2025-04-21 16:22:03.907','2025-04-21 16:22:03.907',NULL,'127.0.0.1','POST','/user/setUserAuthority',200,10118200,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{\"authorityId\":888}','{\"code\":0,\"data\":{},\"msg\":\"修改成功\"}',1),(5,'2025-04-21 16:27:04.359','2025-04-21 16:27:04.359',NULL,'127.0.0.1','GET','/api/getApiGroups',200,855600,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{}','{\"code\":0,\"data\":{\"apiGroupMap\":{\"api\":\"api\",\"attachmentCategory\":\"媒体库分类\",\"authority\":\"角色\",\"authorityBtn\":\"按钮权限\",\"autoCode\":\"代码生成器历史\",\"casbin\":\"casbin\",\"customer\":\"客户\",\"email\":\"email\",\"fileUploadAndDownload\":\"文件上传与下载\",\"info\":\"公告\",\"jwt\":\"jwt\",\"menu\":\"菜单\",\"simpleUploader\":\"断点续传(插件版)\",\"sysDictionary\":\"系统字典\",\"sysDictionaryDetail\":\"系统字典详情\",\"sysExportTemplate\":\"导出模板\",\"sysOperationRecord\":\"操作记录\",\"sysParams\":\"参数管理\",\"system\":\"系统服务\",\"user\":\"系统用户\"},\"groups\":[\"jwt\",\"系统用户\",\"api\",\"角色\",\"casbin\",\"菜单\",\"分片上传\",\"文件上传与下载\",\"系统服务\",\"客户\",\"代码生成器\",\"模板配置\",\"代码生成器历史\",\"系统字典详情\",\"系统字典\",\"操作记录\",\"断点续传(插件版)\",\"email\",\"按钮权限\",\"导出模板\",\"公告\",\"参数管理\",\"媒体库分类\"]},\"msg\":\"成功\"}',1),(6,'2025-04-22 15:32:17.959','2025-04-22 15:32:17.959',NULL,'127.0.0.1','GET','/api/getApiGroups',200,1607200,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{}','{\"code\":0,\"data\":{\"apiGroupMap\":{\"api\":\"api\",\"attachmentCategory\":\"媒体库分类\",\"authority\":\"角色\",\"authorityBtn\":\"按钮权限\",\"autoCode\":\"代码生成器历史\",\"casbin\":\"casbin\",\"customer\":\"客户\",\"email\":\"email\",\"fileUploadAndDownload\":\"文件上传与下载\",\"info\":\"公告\",\"jwt\":\"jwt\",\"menu\":\"菜单\",\"simpleUploader\":\"断点续传(插件版)\",\"sysDictionary\":\"系统字典\",\"sysDictionaryDetail\":\"系统字典详情\",\"sysExportTemplate\":\"导出模板\",\"sysOperationRecord\":\"操作记录\",\"sysParams\":\"参数管理\",\"system\":\"系统服务\",\"user\":\"系统用户\"},\"groups\":[\"jwt\",\"系统用户\",\"api\",\"角色\",\"casbin\",\"菜单\",\"分片上传\",\"文件上传与下载\",\"系统服务\",\"客户\",\"代码生成器\",\"模板配置\",\"代码生成器历史\",\"系统字典详情\",\"系统字典\",\"操作记录\",\"断点续传(插件版)\",\"email\",\"按钮权限\",\"导出模板\",\"公告\",\"参数管理\",\"媒体库分类\"]},\"msg\":\"成功\"}',1),(7,'2025-04-22 17:19:52.200','2025-04-22 17:19:52.200',NULL,'127.0.0.1','POST','/user/admin_register',200,63796500,'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','','{\"userName\":\"666666\",\"password\":\"666666\",\"nickName\":\"666666\",\"headerImg\":\"\",\"authorityId\":888,\"authorityIds\":[888],\"enable\":1}','{\"code\":0,\"data\":{\"user\":{\"ID\":4,\"CreatedAt\":\"2025-04-22T17:19:52.192+09:00\",\"UpdatedAt\":\"2025-04-22T17:19:52.192+09:00\",\"uuid\":\"1f2fae0b-0b7d-4a05-99c8-71440643daac\",\"userName\":\"666666\",\"nickName\":\"666666\",\"headerImg\":\"https://qmplusimg.henrongyi.top/gva_header.jpg\",\"authorityId\":888,\"authority\":{\"CreatedAt\":\"0001-01-01T00:00:00Z\",\"UpdatedAt\":\"0001-01-01T00:00:00Z\",\"DeletedAt\":null,\"authorityId\":0,\"authorityName\":\"\",\"parentId\":null,\"dataAuthorityId\":null,\"children\":null,\"menus\":null,\"defaultRouter\":\"\"},\"authorities\":[{\"CreatedAt\":\"2025-04-22T17:19:52.193+09:00\",\"UpdatedAt\":\"2025-04-22T17:19:52.193+09:00\",\"DeletedAt\":null,\"authorityId\":888,\"authorityName\":\"\",\"parentId\":null,\"dataAuthorityId\":null,\"children\":null,\"menus\":null,\"defaultRouter\":\"dashboard\"}],\"phone\":\"\",\"email\":\"\",\"gender\":\"\",\"nationality\":\"\",\"enable\":1,\"originSetting\":null}},\"msg\":\"注册成功\"}',1);
/*!40000 ALTER TABLE `sys_operation_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_params`
--

DROP TABLE IF EXISTS `sys_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_params` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数名称',
  `key` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数键',
  `value` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数值',
  `desc` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数说明',
  PRIMARY KEY (`id`),
  KEY `idx_sys_params_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_params`
--

LOCK TABLES `sys_params` WRITE;
/*!40000 ALTER TABLE `sys_params` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_authority`
--

DROP TABLE IF EXISTS `sys_user_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_authority` (
  `sys_user_id` bigint unsigned NOT NULL,
  `sys_authority_authority_id` bigint unsigned NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`sys_user_id`,`sys_authority_authority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_authority`
--

LOCK TABLES `sys_user_authority` WRITE;
/*!40000 ALTER TABLE `sys_user_authority` DISABLE KEYS */;
INSERT INTO `sys_user_authority` VALUES (1,888),(1,8881),(1,9528),(2,888),(3,888),(4,888);
/*!40000 ALTER TABLE `sys_user_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users`
--

DROP TABLE IF EXISTS `sys_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户UUID',
  `username` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录名',
  `password` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户登录密码',
  `nick_name` varchar(191) COLLATE utf8mb4_general_ci DEFAULT '系统用户' COMMENT '用户昵称',
  `header_img` varchar(191) COLLATE utf8mb4_general_ci DEFAULT 'https://qmplusimg.henrongyi.top/gva_header.jpg' COMMENT '用户头像',
  `authority_id` bigint unsigned DEFAULT '888' COMMENT '用户角色ID',
  `phone` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户手机号',
  `email` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户邮箱',
  `enable` bigint DEFAULT '1' COMMENT '用户是否被冻结 1正常 2冻结',
  `origin_setting` text COLLATE utf8mb4_general_ci COMMENT '配置',
  `gender` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户性别',
  `nationality` varchar(191) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户国籍',
  PRIMARY KEY (`id`),
  KEY `idx_sys_users_deleted_at` (`deleted_at`),
  KEY `idx_sys_users_uuid` (`uuid`),
  KEY `idx_sys_users_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users`
--

LOCK TABLES `sys_users` WRITE;
/*!40000 ALTER TABLE `sys_users` DISABLE KEYS */;
INSERT INTO `sys_users` VALUES (1,'2025-04-18 17:09:39.740','2025-04-21 16:22:03.900',NULL,'94ff7458-31aa-4dd0-b2ac-6c10aad434b6','admin','$2a$10$V9YiNM5Iy/J4K/Cxc1wAi.EsEhiWv4pTxk2q2XGhAgOlQlMRBWZAG','Mr.奇淼','https://qmplusimg.henrongyi.top/gva_header.jpg',888,'17611111111','333333333@qq.com',1,NULL,'男','中国'),(2,'2025-04-18 17:09:39.740','2025-04-18 17:09:39.751',NULL,'ac7a6bf8-d8a0-45ea-a0a7-39f73de9bea9','a303176530','$2a$10$lObFj08QzZ2NEKNXvC5tIOk0b78fxZuDDSYVjtKhwmvgXzU7uSFfW','用户1','https:///qmplusimg.henrongyi.top/1572075907logo.png',9528,'17611111111','333333333@qq.com',1,NULL,'女','美国'),(3,'2025-04-21 15:52:59.867','2025-04-21 15:52:59.867',NULL,'275d7c5c-ab75-4c45-a054-56ef5544fc75','555555','$2a$10$yTgUxCqe6wcQSVmAkUSeYuNNIWfBJNHZZ4ZQkbVVoaKfMWSlU6.wS','555555','https://qmplusimg.henrongyi.top/gva_header.jpg',888,'','',1,NULL,'',''),(4,'2025-04-22 17:19:52.192','2025-04-22 17:19:52.192',NULL,'1f2fae0b-0b7d-4a05-99c8-71440643daac','666666','$2a$10$tGZhAfmzgc.aB4nJKBF7BuKAwqwGAHqHQJluTROMG0XS5/rV2aOt2','666666','https://qmplusimg.henrongyi.top/gva_header.jpg',888,'','',1,NULL,'',''),(101,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f64cba-2956-11f0-af4e-00155d1180e6','testuser01','hashed_password','テストユーザー01','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(102,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f6766e-2956-11f0-af4e-00155d1180e6','testuser02','hashed_password','テストユーザー02','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(103,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f67811-2956-11f0-af4e-00155d1180e6','testuser03','hashed_password','テストユーザー03','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(104,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f6793e-2956-11f0-af4e-00155d1180e6','testuser04','hashed_password','テストユーザー04','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(105,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f67a2e-2956-11f0-af4e-00155d1180e6','testuser05','hashed_password','テストユーザー05','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(106,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f6863a-2956-11f0-af4e-00155d1180e6','testuser06','hashed_password','テストユーザー06','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(107,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68717-2956-11f0-af4e-00155d1180e6','testuser07','hashed_password','テストユーザー07','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(108,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f687aa-2956-11f0-af4e-00155d1180e6','testuser08','hashed_password','テストユーザー08','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(109,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68850-2956-11f0-af4e-00155d1180e6','testuser09','hashed_password','テストユーザー09','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(110,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f688d8-2956-11f0-af4e-00155d1180e6','testuser10','hashed_password','テストユーザー10','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(111,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68982-2956-11f0-af4e-00155d1180e6','testuser11','hashed_password','テストユーザー11','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(112,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68a01-2956-11f0-af4e-00155d1180e6','testuser12','hashed_password','テストユーザー12','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(113,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68a89-2956-11f0-af4e-00155d1180e6','testuser13','hashed_password','テストユーザー13','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(114,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68b1f-2956-11f0-af4e-00155d1180e6','testuser14','hashed_password','テストユーザー14','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(115,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68bc3-2956-11f0-af4e-00155d1180e6','testuser15','hashed_password','テストユーザー15','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(116,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68c7f-2956-11f0-af4e-00155d1180e6','testuser16','hashed_password','テストユーザー16','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(117,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68d15-2956-11f0-af4e-00155d1180e6','testuser17','hashed_password','テストユーザー17','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(118,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68d9e-2956-11f0-af4e-00155d1180e6','testuser18','hashed_password','テストユーザー18','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(119,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68e13-2956-11f0-af4e-00155d1180e6','testuser19','hashed_password','テストユーザー19','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(120,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68e9e-2956-11f0-af4e-00155d1180e6','testuser20','hashed_password','テストユーザー20','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(121,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68f42-2956-11f0-af4e-00155d1180e6','testuser21','hashed_password','テスト２１','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(122,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f68fc8-2956-11f0-af4e-00155d1180e6','testuser22','hashed_password','テスト２２','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(123,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f6906a-2956-11f0-af4e-00155d1180e6','testuser23','hashed_password','テスト２３','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(124,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f690e0-2956-11f0-af4e-00155d1180e6','testuser24','hashed_password','テスト２４','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL),(125,'2025-05-05 11:10:39.000','2025-05-05 11:10:39.000',NULL,'23f69168-2956-11f0-af4e-00155d1180e6','testuser25','hashed_password','テスト２５','header.jpg',888,NULL,NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_answer_helpful_votes`
--

DROP TABLE IF EXISTS `user_answer_helpful_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_answer_helpful_votes` (
  `user_id` bigint unsigned NOT NULL,
  `answer_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`answer_id`),
  KEY `idx_user_answer_helpful_votes_answer_id` (`answer_id`),
  CONSTRAINT `user_answer_helpful_votes_ibfk_1` FOREIGN KEY (`answer_id`) REFERENCES `question_answers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_answer_helpful_votes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Q&A回答参考になった投票';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_answer_helpful_votes`
--

LOCK TABLES `user_answer_helpful_votes` WRITE;
/*!40000 ALTER TABLE `user_answer_helpful_votes` DISABLE KEYS */;
INSERT INTO `user_answer_helpful_votes` VALUES (101,201,'2025-05-22 19:35:32'),(101,202,'2025-05-22 19:35:32'),(101,203,'2025-05-22 19:35:32'),(101,206,'2025-05-22 19:35:32'),(101,208,'2025-05-22 19:35:32'),(101,209,'2025-05-22 19:35:32'),(101,213,'2025-05-22 19:35:32'),(101,401,'2025-05-22 19:35:32'),(102,201,'2025-05-22 19:35:32'),(102,202,'2025-05-22 19:35:32'),(102,203,'2025-05-22 19:35:32'),(102,206,'2025-05-22 19:35:32'),(102,208,'2025-05-22 19:35:32'),(102,212,'2025-05-22 19:35:32'),(102,213,'2025-05-22 19:35:32'),(102,402,'2025-05-22 19:35:32'),(103,201,'2025-05-22 19:35:32'),(103,202,'2025-05-22 19:35:32'),(103,203,'2025-05-22 19:35:32'),(103,206,'2025-05-22 19:35:32'),(103,208,'2025-05-22 19:35:32'),(103,209,'2025-05-22 19:35:32'),(103,401,'2025-05-22 19:35:32'),(104,201,'2025-05-22 19:35:32'),(104,202,'2025-05-22 19:35:32'),(104,203,'2025-05-22 19:35:32'),(104,208,'2025-05-22 19:35:32'),(104,212,'2025-05-22 19:35:32'),(104,402,'2025-05-22 19:35:32'),(105,201,'2025-05-22 19:35:32'),(105,202,'2025-05-22 19:35:32'),(105,206,'2025-05-22 19:35:32'),(105,208,'2025-05-22 19:35:32'),(105,209,'2025-05-22 19:35:32'),(105,401,'2025-05-22 19:35:32'),(106,201,'2025-05-22 19:35:32'),(106,202,'2025-05-22 19:35:32'),(106,203,'2025-05-22 19:35:32'),(106,206,'2025-05-22 19:35:32'),(106,208,'2025-05-22 19:35:32'),(106,212,'2025-05-22 19:35:32'),(107,201,'2025-05-22 19:35:32'),(107,202,'2025-05-22 19:35:32'),(107,203,'2025-05-22 19:35:32'),(107,206,'2025-05-22 19:35:32'),(107,208,'2025-05-22 19:35:32'),(107,209,'2025-05-22 19:35:32'),(107,403,'2025-05-22 19:35:32'),(108,201,'2025-05-22 19:35:32'),(108,202,'2025-05-22 19:35:32'),(108,203,'2025-05-22 19:35:32'),(108,208,'2025-05-22 19:35:32'),(108,212,'2025-05-22 19:35:32'),(108,403,'2025-05-22 19:35:32'),(109,201,'2025-05-22 19:35:32'),(109,202,'2025-05-22 19:35:32'),(109,203,'2025-05-22 19:35:32'),(109,208,'2025-05-22 19:35:32'),(109,209,'2025-05-22 19:35:32'),(109,403,'2025-05-22 19:35:32'),(110,201,'2025-05-22 19:35:32'),(110,202,'2025-05-22 19:35:32'),(110,206,'2025-05-22 19:35:32'),(110,208,'2025-05-22 19:35:32'),(110,212,'2025-05-22 19:35:32'),(110,403,'2025-05-22 19:35:32'),(111,201,'2025-05-22 19:35:32'),(111,202,'2025-05-22 19:35:32'),(111,203,'2025-05-22 19:35:32'),(111,206,'2025-05-22 19:35:32'),(111,208,'2025-05-22 19:35:32'),(111,209,'2025-05-22 19:35:32'),(111,404,'2025-05-22 19:35:32'),(112,201,'2025-05-22 19:35:32'),(112,202,'2025-05-22 19:35:32'),(112,203,'2025-05-22 19:35:32'),(112,208,'2025-05-22 19:35:32'),(112,212,'2025-05-22 19:35:32'),(112,404,'2025-05-22 19:35:32'),(113,201,'2025-05-22 19:35:32'),(113,202,'2025-05-22 19:35:32'),(113,203,'2025-05-22 19:35:32'),(113,208,'2025-05-22 19:35:32'),(113,209,'2025-05-22 19:35:32'),(113,404,'2025-05-22 19:35:32'),(114,201,'2025-05-22 19:35:32'),(114,202,'2025-05-22 19:35:32'),(114,203,'2025-05-22 19:35:32'),(114,208,'2025-05-22 19:35:32'),(114,212,'2025-05-22 19:35:32'),(114,404,'2025-05-22 19:35:32'),(115,201,'2025-05-22 19:35:32'),(115,202,'2025-05-22 19:35:32'),(115,206,'2025-05-22 19:35:32'),(115,208,'2025-05-22 19:35:32'),(115,209,'2025-05-22 19:35:32'),(115,404,'2025-05-22 19:35:32'),(116,201,'2025-05-22 19:35:32'),(116,203,'2025-05-22 19:35:32'),(116,206,'2025-05-22 19:35:32'),(116,208,'2025-05-22 19:35:32'),(116,212,'2025-05-22 19:35:32'),(116,405,'2025-05-22 19:35:32'),(117,201,'2025-05-22 19:35:32'),(117,203,'2025-05-22 19:35:32'),(117,208,'2025-05-22 19:35:32'),(117,405,'2025-05-22 19:35:32'),(118,201,'2025-05-22 19:35:32'),(118,203,'2025-05-22 19:35:32'),(118,208,'2025-05-22 19:35:32'),(118,212,'2025-05-22 19:35:32'),(118,405,'2025-05-22 19:35:32'),(119,201,'2025-05-22 19:35:32'),(119,208,'2025-05-22 19:35:32'),(120,201,'2025-05-22 19:35:32'),(120,208,'2025-05-22 19:35:32'),(120,212,'2025-05-22 19:35:32'),(121,201,'2025-05-22 19:35:32'),(121,203,'2025-05-22 19:35:32'),(121,206,'2025-05-22 19:35:32'),(122,201,'2025-05-22 19:35:32'),(122,203,'2025-05-22 19:35:32'),(123,201,'2025-05-22 19:35:32'),(123,203,'2025-05-22 19:35:32'),(124,201,'2025-05-22 19:35:32'),(124,208,'2025-05-22 19:35:32'),(125,201,'2025-05-22 19:35:32'),(125,206,'2025-05-22 19:35:32'),(125,208,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `user_answer_helpful_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_cart_items`
--

DROP TABLE IF EXISTS `user_cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_cart_items` (
  `user_id` bigint unsigned NOT NULL COMMENT 'ユーザーID (sys_users.id 参照)',
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'カート内SKU ID (product_skus.id 参照)',
  `quantity` int unsigned NOT NULL DEFAULT '1' COMMENT '数量',
  `added_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最初に追加された日時',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  PRIMARY KEY (`user_id`,`sku_id`),
  KEY `sku_id` (`sku_id`),
  KEY `idx_user_cart_items_user_id` (`user_id`),
  CONSTRAINT `user_cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_cart_items_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ユーザーのカート内商品リスト';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_cart_items`
--

LOCK TABLES `user_cart_items` WRITE;
/*!40000 ALTER TABLE `user_cart_items` DISABLE KEYS */;
INSERT INTO `user_cart_items` VALUES (1,'sku-0001',1,'2025-05-19 08:57:56','2025-05-19 08:57:56'),(101,'sku-0001',3,'2025-05-06 16:23:30','2025-05-08 16:23:30'),(101,'sku-0007',2,'2025-05-07 16:23:30','2025-05-08 15:53:30'),(101,'sku-1001',1,'2025-05-08 11:23:30','2025-05-08 16:23:30'),(102,'sku-0004',1,'2025-05-05 16:23:30','2025-05-08 16:23:30'),(102,'sku-0005',1,'2025-05-05 16:23:30','2025-05-08 16:23:30'),(102,'sku-1002-bk',1,'2025-05-08 16:23:30','2025-05-08 16:23:30'),(102,'sku-p0008-8j',1,'2025-05-07 16:23:30','2025-05-08 14:23:30'),(103,'sku-0012',3,'2025-05-08 16:23:30','2025-05-08 16:23:30'),(103,'sku-p0006-s-pk',1,'2025-05-08 16:23:30','2025-05-08 16:23:30'),(104,'sku-1004-br',2,'2025-05-07 16:23:30','2025-05-08 16:23:30'),(104,'sku-p0004-bk',1,'2025-05-08 11:23:30','2025-05-08 16:23:30'),(105,'sku-1005',1,'2025-05-08 10:23:30','2025-05-08 15:23:30'),(105,'sku-1005-s-gy',1,'2025-05-08 10:23:30','2025-05-08 15:23:30'),(106,'sku-0014',1,'2025-05-08 16:23:30','2025-05-08 16:23:30'),(106,'sku-p0002-dbr',1,'2025-05-06 16:23:30','2025-05-08 16:23:30');
/*!40000 ALTER TABLE `user_cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_coupons`
--

DROP TABLE IF EXISTS `user_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_coupons` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `coupon_id` bigint unsigned NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0',
  `used_at` datetime DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `obtained_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_coupon` (`user_id`,`coupon_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `idx_user_coupons_user_id_used` (`user_id`,`is_used`),
  KEY `idx_user_coupons_order_id` (`order_id`),
  CONSTRAINT `user_coupons_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_coupons_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_coupons_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ユーザー保有クーポン';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_coupons`
--

LOCK TABLES `user_coupons` WRITE;
/*!40000 ALTER TABLE `user_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_favorite_skus`
--

DROP TABLE IF EXISTS `user_favorite_skus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_favorite_skus` (
  `user_id` bigint unsigned NOT NULL,
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`sku_id`),
  KEY `idx_user_favorite_skus_user_id_created` (`user_id`,`created_at`),
  KEY `idx_user_favorite_skus_sku_id` (`sku_id`),
  CONSTRAINT `user_favorite_skus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_favorite_skus_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='お気に入りSKU';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_favorite_skus`
--

LOCK TABLES `user_favorite_skus` WRITE;
/*!40000 ALTER TABLE `user_favorite_skus` DISABLE KEYS */;
INSERT INTO `user_favorite_skus` VALUES (101,'sku-0001','2025-05-17 19:35:32'),(101,'sku-0007','2025-05-19 19:35:32'),(101,'sku-0013','2025-05-21 19:35:32'),(101,'sku-1001','2025-05-22 18:35:32'),(102,'sku-0004','2025-05-12 19:35:32'),(102,'sku-0001','2025-05-20 19:35:32'),(102,'sku-1002-bk','2025-05-22 17:35:32'),(103,'sku-0007','2025-05-15 19:35:32'),(103,'sku-1003-wh','2025-05-22 16:35:32'),(104,'sku-1004-br','2025-05-22 15:35:32'),(105,'sku-1005-s-gy','2025-05-22 14:35:32'),(106,'sku-kettle-001-pk','2025-05-21 19:35:32');
/*!40000 ALTER TABLE `user_favorite_skus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login_history`
--

DROP TABLE IF EXISTS `user_login_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `login_time` datetime NOT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户登录历史记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login_history`
--

LOCK TABLES `user_login_history` WRITE;
/*!40000 ALTER TABLE `user_login_history` DISABLE KEYS */;
INSERT INTO `user_login_history` VALUES (1,1,'2025-04-21 14:09:08'),(2,1,'2025-04-21 14:11:21'),(3,1,'2025-04-21 14:11:58'),(4,1,'2025-04-21 15:41:32'),(5,3,'2025-04-21 15:53:21'),(6,1,'2025-04-21 16:17:27'),(7,1,'2025-04-22 16:20:26'),(9,1,'2025-04-22 19:09:43');
/*!40000 ALTER TABLE `user_login_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_points`
--

DROP TABLE IF EXISTS `user_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_points` (
  `user_id` bigint unsigned NOT NULL,
  `available_points` int NOT NULL DEFAULT '0',
  `last_updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_points_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ユーザーポイント';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_points`
--

LOCK TABLES `user_points` WRITE;
/*!40000 ALTER TABLE `user_points` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_review_helpful_votes`
--

DROP TABLE IF EXISTS `user_review_helpful_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_review_helpful_votes` (
  `user_id` bigint unsigned NOT NULL,
  `review_id` bigint NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`review_id`),
  KEY `idx_user_review_helpful_votes_review_id` (`review_id`),
  CONSTRAINT `user_review_helpful_votes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `product_reviews` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_review_helpful_votes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='レビュー参考になった投票';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_review_helpful_votes`
--

LOCK TABLES `user_review_helpful_votes` WRITE;
/*!40000 ALTER TABLE `user_review_helpful_votes` DISABLE KEYS */;
INSERT INTO `user_review_helpful_votes` VALUES (101,1,'2025-05-22 19:35:32'),(101,2,'2025-05-22 19:35:32'),(101,8,'2025-05-22 19:35:32'),(101,26,'2025-05-22 19:35:32'),(101,28,'2025-05-22 19:35:32'),(102,1,'2025-05-22 19:35:32'),(102,6,'2025-05-22 19:35:32'),(102,28,'2025-05-22 19:35:32'),(103,1,'2025-05-22 19:35:32'),(103,8,'2025-05-22 19:35:32'),(103,25,'2025-05-22 19:35:32'),(103,28,'2025-05-22 19:35:32'),(104,2,'2025-05-22 19:35:32'),(104,25,'2025-05-22 19:35:32'),(104,28,'2025-05-22 19:35:32'),(105,2,'2025-05-22 19:35:32'),(105,26,'2025-05-22 19:35:32'),(105,28,'2025-05-22 19:35:32'),(106,2,'2025-05-22 19:35:32'),(106,26,'2025-05-22 19:35:32'),(107,2,'2025-05-22 19:35:32'),(107,29,'2025-05-22 19:35:32'),(108,6,'2025-05-22 19:35:32'),(108,29,'2025-05-22 19:35:32'),(109,8,'2025-05-22 19:35:32'),(109,30,'2025-05-22 19:35:32'),(110,8,'2025-05-22 19:35:32'),(110,30,'2025-05-22 19:35:32'),(110,33,'2025-05-22 19:35:32'),(111,9,'2025-05-22 19:35:32'),(111,30,'2025-05-22 19:35:32'),(111,33,'2025-05-22 19:35:32'),(112,11,'2025-05-22 19:35:32'),(112,34,'2025-05-22 19:35:32'),(113,11,'2025-05-22 19:35:32'),(114,11,'2025-05-22 19:35:32'),(115,11,'2025-05-22 19:35:32'),(116,14,'2025-05-22 19:35:32'),(117,21,'2025-05-22 19:35:32'),(118,21,'2025-05-22 19:35:32'),(119,21,'2025-05-22 19:35:32'),(120,21,'2025-05-22 19:35:32'),(121,21,'2025-05-22 19:35:32'),(122,21,'2025-05-22 19:35:32'),(123,21,'2025-05-22 19:35:32'),(124,21,'2025-05-22 19:35:32'),(125,21,'2025-05-22 19:35:32');
/*!40000 ALTER TABLE `user_review_helpful_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_shipping_addresses`
--

DROP TABLE IF EXISTS `user_shipping_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_shipping_addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '配送先住所ID',
  `user_id` bigint unsigned NOT NULL COMMENT 'ユーザーID (sys_users.id 参照)',
  `postal_code` varchar(10) COLLATE utf8mb4_general_ci NOT NULL COMMENT '郵便番号 (例: 100-0001)',
  `prefecture` varchar(50) COLLATE utf8mb4_general_ci NOT NULL COMMENT '都道府県',
  `city` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '市区町村',
  `address_line1` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '番地など',
  `address_line2` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '建物名・部屋番号など',
  `recipient_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT '受取人氏名',
  `phone_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL COMMENT '電話番号',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'デフォルト配送先フラグ',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '登録日時',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終更新日時',
  `deleted_at` datetime DEFAULT NULL COMMENT '論理削除日時',
  PRIMARY KEY (`id`),
  KEY `idx_user_shipping_addresses_user_id` (`user_id`,`deleted_at`),
  KEY `idx_user_shipping_addresses_is_default` (`user_id`,`is_default`,`deleted_at`),
  CONSTRAINT `user_shipping_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ユーザーの配送先住所リスト';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_shipping_addresses`
--

LOCK TABLES `user_shipping_addresses` WRITE;
/*!40000 ALTER TABLE `user_shipping_addresses` DISABLE KEYS */;
INSERT INTO `user_shipping_addresses` VALUES (1,1,'100-0001','東京都','千代田区','千代田1-1-1','パレスビル 10F','管理者 太郎','09011112222',1,'2025-05-06 14:53:25','2025-05-08 14:53:25',NULL),(2,1,'150-0002','東京都','渋谷区','渋谷2-21-1','ヒカリエオフィス','管理者 次郎 (会社)','08033334444',0,'2025-04-29 14:53:25','2025-05-04 14:53:25',NULL),(3,2,'530-0001','大阪府','大阪市北区','梅田3-1-3','ルクアイーレ 501号室','ユーザー1 様','07055556666',1,'2025-05-02 14:53:25','2025-05-09 14:53:25',NULL),(4,101,'273-0012','千葉県','船橋市','浜町2-1-1','ららぽーとTOKYO-BAY 西館 2F ニトリ配送センター','テスト ユーザー01','08012340001',1,'2025-05-07 14:53:25','2025-05-07 14:53:25',NULL),(5,101,'135-0063','東京都','江東区','有明2-1-8','有明ガーデン店 気付','テスト ユーザー01 (店舗受取用)','08012340001',0,'2025-05-08 14:53:25','2025-05-08 14:53:25',NULL),(6,102,'HOK-001','北海道','札幌市北区','新琴似七条1-2-39',NULL,'テストユーザー02（実家）','0117691234',1,'2025-05-04 14:53:25','2025-05-06 14:53:25',NULL),(7,104,'812-0012','福岡県','福岡市博多区','博多駅中央街1-1','博多阪急 ニトリ','テストユーザー04（勤務先）','0920004444',1,'2025-05-05 14:53:25','2025-05-05 14:53:25',NULL),(8,1,'125-0035','东京都','葛饰区','南水元','1-18-10','杨','08011112222',0,'2025-05-09 19:50:00','2025-05-09 22:12:26',NULL),(9,1,'128-0035','大阪府','新宿区','西水元','1-18-10','杨','08011112222',0,'2025-05-09 22:22:13','2025-05-09 22:22:13',NULL);
/*!40000 ALTER TABLE `user_shipping_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_viewed_skus`
--

DROP TABLE IF EXISTS `user_viewed_skus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_viewed_skus` (
  `user_id` bigint unsigned NOT NULL COMMENT 'ユーザーID (sys_users.id 参照)',
  `sku_id` char(36) COLLATE utf8mb4_general_ci NOT NULL COMMENT '閲覧したSKU ID (product_skus.id 参照)',
  `viewed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最終閲覧日時',
  PRIMARY KEY (`user_id`,`sku_id`),
  KEY `sku_id` (`sku_id`),
  KEY `idx_user_viewed_skus_user_id_viewed_at` (`user_id`,`viewed_at` DESC),
  CONSTRAINT `user_viewed_skus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_viewed_skus_ibfk_2` FOREIGN KEY (`sku_id`) REFERENCES `product_skus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='ユーザーのSKU閲覧履歴 (最新日時)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_viewed_skus`
--

LOCK TABLES `user_viewed_skus` WRITE;
/*!40000 ALTER TABLE `user_viewed_skus` DISABLE KEYS */;
INSERT INTO `user_viewed_skus` VALUES (101,'sku-0007','2025-05-08 16:19:31'),(101,'sku-0001','2025-05-08 16:15:31'),(101,'sku-1001','2025-05-08 15:50:31'),(101,'sku-0004','2025-05-08 14:20:31'),(101,'sku-0012','2025-05-07 16:20:31'),(101,'sku-1004-br','2025-05-05 16:20:31'),(101,'sku-p0003-lgy','2025-05-03 16:20:31'),(101,'sku-0013','2025-05-01 16:20:31'),(102,'sku-0001','2025-05-08 16:18:31'),(102,'sku-0004','2025-05-08 16:10:31'),(102,'sku-0005','2025-05-08 16:05:31'),(102,'sku-p0005-wh','2025-05-08 15:20:31'),(102,'sku-1003-wh','2025-05-08 11:20:31'),(102,'sku-1002-bk','2025-05-04 16:20:31'),(102,'sku-p0007-s-wh','2025-05-02 16:20:31'),(103,'sku-0007','2025-05-08 16:19:31'),(103,'sku-0003','2025-05-08 16:17:31'),(103,'sku-p0006-s-pk','2025-05-08 16:10:31'),(103,'sku-1005-s-gy','2025-05-08 16:00:31'),(103,'sku-0011','2025-05-08 15:20:31'),(104,'sku-1004-br','2025-05-08 16:00:31'),(104,'sku-p0004-bk','2025-05-08 15:35:31'),(104,'sku-0005','2025-05-08 14:20:31'),(104,'sku-1003','2025-05-07 16:20:31'),(105,'sku-1005-s-gy','2025-05-08 16:15:31'),(105,'sku-1005','2025-05-08 16:10:31'),(105,'sku-1005-d-wh','2025-05-08 15:50:31'),(105,'sku-0011','2025-05-06 16:20:31'),(106,'sku-p0001-grn','2025-05-08 16:19:31'),(106,'sku-0012','2025-05-08 16:15:31'),(106,'sku-p0002-dbr','2025-05-07 16:20:31'),(107,'sku-p0003-blu','2025-05-08 16:18:31'),(107,'sku-0001','2025-05-08 15:20:31'),(107,'sku-1001-be','2025-05-08 13:20:31'),(108,'sku-p0008-8j','2025-05-08 16:19:31'),(108,'sku-0004','2025-05-07 16:20:31'),(109,'sku-0014','2025-05-08 16:17:31'),(109,'sku-p0010-br','2025-05-08 16:10:31'),(109,'sku-0005','2025-05-08 14:20:31'),(110,'sku-0006','2025-05-08 16:19:31'),(110,'sku-0012','2025-05-08 15:20:31'),(110,'sku-0008','2025-05-08 14:20:31');
/*!40000 ALTER TABLE `user_viewed_skus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-23 14:26:10
