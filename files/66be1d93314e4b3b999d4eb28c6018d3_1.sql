-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (arm64)
--
-- Host: 127.0.0.1    Database: springbootfresh
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `nums` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,27,13,NULL,NULL),(4,27,14,'2023-01-22 14:33:51',NULL),(5,27,16,'2023-01-22 16:00:16',NULL),(6,27,17,'2023-01-22 19:48:02',NULL),(8,28,16,'2023-01-22 20:27:39',NULL),(9,27,18,'2023-02-05 09:17:57',NULL);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `check_code`
--

DROP TABLE IF EXISTS `check_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_code` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `send` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `recive` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='验证码';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `check_code`
--

LOCK TABLES `check_code` WRITE;
/*!40000 ALTER TABLE `check_code` DISABLE KEYS */;
INSERT INTO `check_code` VALUES (1,'4989','103370344@qq.com',NULL,'2023-02-05 20:34:48'),(2,'2341','103370344@qq.com',NULL,'2023-02-05 20:37:08'),(3,'4197','103370344@qq.com',NULL,'2023-02-05 20:38:08'),(4,'9869','103370344@qq.com',NULL,'2023-02-05 20:45:24');
/*!40000 ALTER TABLE `check_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `score` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `goods_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (4,36,27,'121313123','2','2023-01-22 22:07:47',16),(5,33,27,'还行','4','2023-01-22 22:08:51',16);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,27,14,'2023-01-22 14:08:24'),(3,27,16,'2023-01-22 15:13:59'),(4,28,14,'2023-01-22 20:27:35'),(5,28,16,'2023-01-22 20:27:49');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论人',
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='留言表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (34,'1','1','2023-02-05 21:19:30'),(35,'1','admin','2023-02-05 21:19:34'),(36,'a','admin','2023-02-05 21:42:06'),(37,'aa','admin','2023-02-05 21:42:43'),(38,'aaa','admin','2023-02-05 21:42:54'),(39,'1','admin','2023-02-05 23:07:18'),(40,'1','admin','2023-02-05 23:08:18'),(41,'1','admin','2023-02-05 23:09:45'),(42,'1','admin','2023-02-05 23:11:30'),(43,'1','admin','2023-02-05 23:15:08'),(44,'1','admin','2023-02-05 23:16:20');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `context` varchar(1000) DEFAULT NULL,
  `created` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (5,'通知1','12123123','2023-01-23');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源路径',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'Home','/home','主页','el-icon-house'),(9,'User','/user','用户管理','el-icon-user'),(10,'Permission','/permisssion','权限菜单','el-icon-menu'),(11,'Role','/role','角色管理','el-icon-s-custom'),(13,'Person','/person','个人信息',''),(14,'Password','/password','修改密码',NULL),(41,'Record','/Record','商品设置',NULL),(42,'RecordList','/RecordList','列表',NULL),(43,'MyRecord','/MyRecord','我的订单',NULL),(44,'RecordApplyList','/RecordApplyList','订单列表',NULL),(45,'Index','/Index','首页',NULL),(46,'Cart','/Cart','购物车',NULL),(47,'Like','/Like','收藏',NULL),(48,'RecordDetail','/RecordDetail','详情',NULL),(49,'Comment','/Comment','评价管理',NULL),(50,'Im','/Im','聊天',NULL),(51,'StoreRecord','/StoreRecord','商家商品设置',NULL),(52,'StoreRecordApply','/StoreRecordApply','商家订单',NULL),(53,'Notice','/Notice','公告',NULL),(55,'CheckCode','/CheckCode','验证码',NULL),(56,'Message','/Message','聊天记录',NULL),(57,'Word','/Word','敏感词',NULL);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `views` int DEFAULT '0' COMMENT '浏览次数',
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `status` int DEFAULT '0' COMMENT '0 上架 1 下架',
  `remark` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `record_no` varchar(20) DEFAULT NULL,
  `images` varchar(500) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `diff` decimal(10,2) DEFAULT NULL,
  `hots` int DEFAULT '0' COMMENT '热度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
INSERT INTO `record` VALUES (13,19,30,'产品1',0,'只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依','2022-12-22 00:00:00',NULL,'http://localhost:9091/files/92cd0adb84e3473c82e7bd6ce2b0422e_WechatIMG21.png',6.00,NULL,0.90,21),(14,13,30,'产品1',0,'只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依','2022-12-22 00:00:00',NULL,'http://localhost:9091/files/a0f5f590b62b4444ac870e6b2bbb1cd2_WechatIMG22.png',4.00,NULL,0.50,19),(16,1,31,'产品3',0,'只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依','2022-12-28 00:00:00',NULL,'http://localhost:9091/files/20f400cc364e4e3b861b7e54c8f2506f_WechatIMG23.png',2.00,NULL,0.30,6),(17,0,30,'产品4',0,'只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依','2023-01-22 00:00:00',NULL,'http://localhost:9091/files/a49b082797664f9fb50940c73b7145d4_WechatIMG24.png',1.00,NULL,0.50,0),(18,0,31,'产品5',0,'只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依只要把border设置成0就可以了,其实挺简单的,但是我搜了很久,有的用的很复杂的方法,有的方法对我来说根本没有用 然后是这篇文章对我来说真正有价值的部分: 就是在度娘无法快速给出有价值答案的时候,针对前端这一部分一种一定程度上比较可行的解决问题的方法: F12查看el-card元素: 侧面提供了相当多可操控的属性 其中就有需要的border 问题不难,解决方法也不难 重要的是“不全部依靠度娘”的思想 再再进一步就是,摆脱路径依','2023-01-22 00:00:00',NULL,'http://localhost:9091/files/9ee09558c7c349fdb2cb119d9ae4620b_WechatIMG25.png',12.00,NULL,0.30,0);
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record_apply`
--

DROP TABLE IF EXISTS `record_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record_apply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `apply_id` int DEFAULT NULL,
  `apply_time` date DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '0 待审批 1通过2 拒绝 3 归还',
  `reject_msg` varchar(255) DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `type` int DEFAULT NULL COMMENT '1 线上 2线下',
  `pay_amt` decimal(10,2) DEFAULT NULL,
  `pay_type` varchar(10) DEFAULT NULL,
  `pay_price` decimal(10,2) DEFAULT NULL,
  `pay_diff` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record_apply`
--

LOCK TABLES `record_apply` WRITE;
/*!40000 ALTER TABLE `record_apply` DISABLE KEYS */;
INSERT INTO `record_apply` VALUES (25,27,NULL,'2023-01-22 15:05:38',NULL,0,NULL,14,NULL,2.00,'支付宝',4.00,NULL),(26,27,NULL,'2023-01-22 15:07:13',NULL,0,NULL,14,NULL,2.00,'微信',4.00,0.50),(27,27,NULL,'2023-01-22 15:13:01',NULL,0,NULL,14,NULL,2.00,'支付宝',4.00,0.50),(31,27,NULL,'2023-01-22 15:19:37',NULL,0,NULL,14,NULL,2.00,'支付宝',4.00,0.50),(32,27,NULL,'2023-01-22 15:19:44',NULL,0,NULL,13,NULL,5.40,'支付宝',6.00,0.90),(33,27,NULL,'2023-01-22 15:21:21',NULL,0,NULL,16,NULL,0.60,'微信',2.00,0.30),(34,27,NULL,'2023-01-21 15:34:09',NULL,0,NULL,13,NULL,5.40,'支付宝',6.00,0.90),(35,28,NULL,'2023-01-22 20:26:01',NULL,0,NULL,16,NULL,0.60,'支付宝',2.00,0.30),(36,27,NULL,'2023-01-22 21:56:49',NULL,0,NULL,16,NULL,0.60,'支付宝',2.00,0.30);
/*!40000 ALTER TABLE `record_apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin','管理员'),(2,'用户','用户'),(6,'卖家','卖家');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `role_id` int NOT NULL COMMENT '角色id',
  `permission_id` int NOT NULL COMMENT '资源id',
  PRIMARY KEY (`role_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,1),(1,9),(1,10),(1,11),(1,13),(1,14),(1,41),(1,44),(1,49),(1,50),(1,53),(1,56),(1,57),(2,13),(2,14),(2,43),(2,45),(2,46),(2,47),(2,48),(2,50),(3,1),(3,13),(3,14),(6,1),(6,50),(6,51),(6,52);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `age` int DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `account` decimal(10,2) DEFAULT '0.00' COMMENT '账户余额',
  `driver_id` int DEFAULT NULL,
  `place_id` int DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$.cxJ637DYA1PRSzfPmBO0efS1W2eTQefS51b83Nr5xgRNAW0ffgjO','管理员',32,'男','火星','http://localhost:9090/files/preview/1.png',100000.00,NULL,NULL,'103370344@qq.com'),(27,'1','$2a$10$GR258rnZ1uJQtiNxT7S3BeQuKUKd.AvDI2VXSJ3atVtSXg9m/N9Du','1',33,'男',NULL,NULL,0.00,NULL,3,NULL),(28,'2','$2a$10$Jm39aE6FSCIf8ADE6HhjiuBxgLGjDVIMHXthDVd5g3rDM9LaScyA2','2',22,'男',NULL,NULL,0.00,7,NULL,NULL),(30,'卖家1','$2a$10$GR258rnZ1uJQtiNxT7S3BeQuKUKd.AvDI2VXSJ3atVtSXg9m/N9Du','卖家1',1,'男',NULL,NULL,0.00,NULL,NULL,NULL),(31,'卖家2','$2a$10$GR258rnZ1uJQtiNxT7S3BeQuKUKd.AvDI2VXSJ3atVtSXg9m/N9Du','卖家2',11,'男',NULL,NULL,0.00,NULL,NULL,NULL),(33,'22','$2a$10$8eo0vc.PNUYyQ/xv9QHgcu8WuO8ftsCX34UBow0frxu8y1V0iw/V6','用户22',NULL,NULL,NULL,NULL,0.00,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1),(16,2),(18,3),(19,2),(20,2),(21,2),(24,3),(25,2),(26,3),(27,2),(28,2),(30,6),(31,6),(33,2);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `id` int NOT NULL AUTO_INCREMENT,
  `word` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (1,'aa'),(2,'1');
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-06 14:39:19
