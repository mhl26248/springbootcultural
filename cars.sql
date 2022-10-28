/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : cars

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 26/10/2022 14:14:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of area
-- ----------------------------
BEGIN;
INSERT INTO `area` (`id`, `label`, `pid`, `value`) VALUES (1, '安徽省', NULL, 'Anhui');
INSERT INTO `area` (`id`, `label`, `pid`, `value`) VALUES (2, '合肥市', 1, 'Hefei');
INSERT INTO `area` (`id`, `label`, `pid`, `value`) VALUES (3, '政务区', 2, 'Zhengwu');
COMMIT;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
  `create_time` datetime DEFAULT NULL COMMENT '出版日期',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '封面地址',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
BEGIN;
INSERT INTO `book` (`id`, `name`, `price`, `author`, `create_time`, `cover`, `user_id`) VALUES (1, '明朝那些事', 60.00, 'xxx', '2010-07-01 00:00:00', 'http://localhost:9090/files/eb7942935c294ca1bc2a07d24b554d36', 13);
COMMIT;

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `car_status` int DEFAULT NULL,
  `car_miles` decimal(10,2) DEFAULT NULL,
  `car_zd` int DEFAULT NULL,
  `car_sj` int DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `brand` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of cars
-- ----------------------------
BEGIN;
INSERT INTO `cars` (`id`, `car_name`, `car_status`, `car_miles`, `car_zd`, `car_sj`, `created`, `updated`, `brand`, `age`) VALUES (1, '大众cc', 1, 1002.01, 2, NULL, '2022-10-20', NULL, '大众', 1);
INSERT INTO `cars` (`id`, `car_name`, `car_status`, `car_miles`, `car_zd`, `car_sj`, `created`, `updated`, `brand`, `age`) VALUES (2, '本田2', 1, 12.99, 2, NULL, '2022-10-25', NULL, '本田', 1);
INSERT INTO `cars` (`id`, `car_name`, `car_status`, `car_miles`, `car_zd`, `car_sj`, `created`, `updated`, `brand`, `age`) VALUES (3, '大众1', 1, 22.00, 1, NULL, '2022-10-25', '2022-10-25', '大众', 2);
INSERT INTO `cars` (`id`, `car_name`, `car_status`, `car_miles`, `car_zd`, `car_sj`, `created`, `updated`, `brand`, `age`) VALUES (4, '大众1', 1, 32.00, NULL, NULL, '2022-10-25', NULL, '大众', 2);
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `pid` int DEFAULT NULL COMMENT '父节点id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (1, '文学', NULL);
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (2, '童书', 1);
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (3, '社会科学', 1);
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (4, '经济学', 1);
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (5, '科普百科', 2);
INSERT INTO `category` (`id`, `name`, `pid`) VALUES (7, '法律', 3);
COMMIT;

-- ----------------------------
-- Table structure for drivers
-- ----------------------------
DROP TABLE IF EXISTS `drivers`;
CREATE TABLE `drivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `driver_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `age` int DEFAULT NULL,
  `work_age` int DEFAULT NULL,
  `place_id` int DEFAULT NULL,
  `car_id` int DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `driver_status` int DEFAULT NULL,
  `apply_status` int DEFAULT NULL,
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of drivers
-- ----------------------------
BEGIN;
INSERT INTO `drivers` (`id`, `driver_name`, `age`, `work_age`, `place_id`, `car_id`, `created`, `updated`, `driver_status`, `apply_status`, `sex`) VALUES (7, '西湖站司机', 22, 0, NULL, NULL, '2022-10-26', NULL, NULL, NULL, '男');
COMMIT;

-- ----------------------------
-- Table structure for drivers_apply
-- ----------------------------
DROP TABLE IF EXISTS `drivers_apply`;
CREATE TABLE `drivers_apply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `drivers_id` int DEFAULT NULL,
  `cars_id` int DEFAULT NULL,
  `apply_status` int DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `apply_type` int DEFAULT NULL,
  `places_id` int DEFAULT NULL,
  `old_places_id` int DEFAULT NULL,
  `old_cars_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of drivers_apply
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '昵称',
  `age` int DEFAULT NULL COMMENT '年龄',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像',
  `account` decimal(10,2) DEFAULT '0.00' COMMENT '账户余额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of member
-- ----------------------------
BEGIN;
INSERT INTO `member` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`) VALUES (1, '张三', '$2a$10$OaUFMBSLr1zdtp5r.ACJKeykYnaaiT.ZZd/CEu6leoR29Ylmar3CK', '张三', 32, '男', '火星', 'http://localhost:9090/files/preview/1.png', 100000.00);
INSERT INTO `member` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`) VALUES (2, '李四', '$2a$10$OaUFMBSLr1zdtp5r.ACJKeykYnaaiT.ZZd/CEu6leoR29Ylmar3CK', '李四', 22, '男', '地球', 'http://localhost:9090/files/preview/2.jpg', 700.00);
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论人',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '评论时间',
  `parent_id` bigint DEFAULT NULL COMMENT '父ID',
  `foreign_id` bigint DEFAULT '0' COMMENT '关联id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='留言表';

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (20, '哈哈哈', 'admin', '2021-05-22 10:48:55', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (21, '哦豁', 'admin', '2021-05-22 10:49:48', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (22, '老弟', 'admin', '2021-05-22 10:51:07', 21, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (23, '哈哈哈', 'zhang', '2021-05-24 17:13:45', 22, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (24, '我们都爱吃大西瓜', 'zhang', '2021-05-24 17:13:58', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (25, '1232', 'admin', '2021-10-31 16:46:39', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (26, '2345', 'admin', '2021-10-31 16:47:00', 25, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (27, '11111', 'admin', '2021-10-31 16:52:09', 26, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (28, '3333', 'admin', '2021-10-31 16:55:28', 27, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (29, '1', 'test', '2022-10-14 07:39:12', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (30, '1', 'test', '2022-10-14 07:39:15', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (32, 'asddas', 'test', '2022-10-15 20:59:20', NULL, 0);
INSERT INTO `message` (`id`, `content`, `username`, `time`, `parent_id`, `foreign_id`) VALUES (33, '12313', 'test', '2022-10-15 21:00:09', NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '作者',
  `time` datetime DEFAULT NULL COMMENT '发布时间',
  `member_id` int DEFAULT NULL,
  `cat_id` int DEFAULT NULL COMMENT '图片视频',
  `cat_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `member_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int DEFAULT NULL COMMENT '分类id',
  `type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '默认图片',
  `read_counts` int DEFAULT NULL COMMENT '阅读量',
  `news_from` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '来源',
  `news_status` int DEFAULT NULL COMMENT '0 审核中 1已上线 2 下线',
  `desc2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (5, '77777', '<p>7777</p><p><br/></p><p><img src=\"http://localhost:9090/files/preview/1.png\" style=\"max-width:100%;\" contenteditable=\"false\" width=\"388\" height=\"388\"/><br/></p><p>8888</p><p><img src=\"http://localhost:9090/files/337129ec55b44b26b4ba3d876d4f9fcf_WechatIMG14.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', '管理员', '2021-07-17 19:14:14', 1, 2, '视频', 'bbb', 2, '绿色要闻', 'http://localhost:9090/files/1.png', 3210, '保卫处', 1, 'abcsadada');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (8, '11111', '<p>哈哈哈</p><p><br/></p><p><img src=\"http://localhost:9090/files/preview/1.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p><p></p><p></p>', '管理员', '2021-09-29 23:17:27', 2, 3, '文字', 'cccc', 3, '校园动态', 'http://localhost:9090/files/1.png', 1420, '保卫处', 1, 'abcsadada');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (9, '视频1123', '<p><video src=\"http://localhost:9090/files/135a3f19fb4a4383a121df50fb903dc3_aaa.mp4\" controls=\"controls\" style=\"max-width:100%\"></video></p>', 'test', '2022-10-15 11:03:21', 2, 2, '视频', 'asdad', 3, '校园动态', 'http://localhost:9090/files/1.png', 7650, '保卫处', 1, 'abcsadada');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (11, '11', '<p>12313</p><video src=\"http://localhost:9090/files/eed0aba332e141b28a0ae41c91517736_aaa.mp4\" controls=\"controls\" style=\"max-width:100%\"></video>', 'test', '2022-10-15 15:10:42', 1, 3, '文字', '张三', 2, '校园动态', 'http://localhost:9090/files/1bcbad01a45c49fa9dbd53cddaccc554_WechatIMG91.png', 41236, '保卫处', 1, 'abcsadada');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (12, 'asda', '<p>11111</p>', 'test', '2022-10-15 18:03:02', 2, 1, '图片', '张三', 2, '绿色要闻', 'http://localhost:9090/files/1.png', 4212, '保卫处', 1, 'abcsadada');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (14, 'asdads111', '<p><img src=\"http://localhost:9090/files/3fe34a04a3604df4b2fbbe58ef160a0c_WechatIMG14.png\" style=\"max-width:100%;\" contenteditable=\"false\"/></p>', 'test', '2022-10-17 20:28:42', NULL, 1, '图片', '张三', 7, '观点言论', 'http://localhost:9090/files/5f2579ae43fa4c2b9ac8a0c8e8d3d91b_WechatIMG8.png', 0, '外语学院', 1, 'aa212313');
INSERT INTO `news` (`id`, `title`, `content`, `author`, `time`, `member_id`, `cat_id`, `cat_name`, `member_name`, `type`, `type_name`, `default_image`, `read_counts`, `news_from`, `news_status`, `desc2`) VALUES (15, NULL, NULL, '张三', '2022-10-24 07:41:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for news_message
-- ----------------------------
DROP TABLE IF EXISTS `news_message`;
CREATE TABLE `news_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '内容',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评论人',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '评论时间',
  `parent_id` bigint DEFAULT NULL COMMENT '父ID',
  `news_id` bigint DEFAULT '0' COMMENT '关联id',
  `member_id` int DEFAULT NULL,
  `message_status` int DEFAULT NULL COMMENT '0 待审核 1审核通过',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='留言表';

-- ----------------------------
-- Records of news_message
-- ----------------------------
BEGIN;
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (20, '哈哈哈', '张三', '2021-05-22 10:48:55', NULL, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (21, '哦豁', '张三', '2021-05-22 10:49:48', NULL, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (22, '老弟', '李四', '2021-05-22 10:51:07', 21, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (23, '哈哈哈', '李四', '2021-05-24 17:13:45', 22, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (24, '我们都爱吃大西瓜', '张三', '2021-05-24 17:13:58', NULL, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (25, '1232', '张三', '2021-10-31 16:46:39', NULL, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (26, '2345', '李四', '2021-10-31 16:47:00', 25, 12, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (27, '11111', '李四', '2021-10-31 16:52:09', 26, 12, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (28, '3333', '李四', '2021-10-31 16:55:28', 27, 0, NULL, 0);
INSERT INTO `news_message` (`id`, `content`, `username`, `time`, `parent_id`, `news_id`, `member_id`, `message_status`) VALUES (29, 'aaaaa', 'test', '2022-10-15 21:01:16', NULL, 0, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for news_shoucang
-- ----------------------------
DROP TABLE IF EXISTS `news_shoucang`;
CREATE TABLE `news_shoucang` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int DEFAULT NULL,
  `member_id` int DEFAULT NULL,
  `created` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of news_shoucang
-- ----------------------------
BEGIN;
INSERT INTO `news_shoucang` (`id`, `news_id`, `member_id`, `created`) VALUES (1, 4, 2, '2022-10-16');
INSERT INTO `news_shoucang` (`id`, `news_id`, `member_id`, `created`) VALUES (2, 2, NULL, '2022-10-16');
COMMIT;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源路径',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `icon` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (1, 'Home', '/home', '主页', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (2, 'Book', '/book', '书籍管理', 'el-icon-files');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (3, 'Category', '/category', '分类管理', 'el-icon-menu');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (4, 'Order', '/order', '我的订单', 'el-icon-s-order');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (5, 'News', '/news', '新闻管理', 'el-icon-news');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (6, 'Map', '/map', '百度地图', 'el-icon-map-location');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (7, 'Im', '/im', '聊天室', 'el-icon-chat-round');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (8, 'Message', '/message', '在线留言', 'el-icon-message');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (9, 'User', '/user', '用户管理', 'el-icon-user');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (10, 'Permission', '/permisssion', '权限菜单', 'el-icon-menu');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (11, 'Role', '/role', '角色管理', 'el-icon-s-custom');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (12, 'Donate', '/donate', '请作者喝杯咖啡', 'el-icon-coffee');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (13, 'Person', '/person', '个人信息', '');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (14, 'Password', '/password', '修改密码', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (22, 'Cars', '/cars', '车辆管理', 'el-icon-coffee');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (23, 'Places', '/places', '站点管理', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (24, 'Drivers', '/drivers', '司机管理', 'el-icon-news');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (25, 'CarsApply', '/carsApply', '车辆申请审核', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (26, 'PlaceApply', '/placeApply', '站点入驻审核', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (27, 'DriverApply', '/driverApply', '司机入驻审核', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (28, 'CarPlan', '/carPlan', '路线管理', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (29, 'CarLat', '/carLat', '实时位置监控', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (30, 'CarsMap', '/carsMap', '车辆热力图', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (31, 'MyJoinApply', '/myJoinApply', '我的入驻申请', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (32, 'MyPlaceApply', '/myPlaceApply', '我的站点申请', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (33, 'MyCarApply', '/myCarApply', '我的车辆申请', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (34, 'MyCarChange', '/myCarChange', '我的车辆变更', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (35, 'MyPlaceChange', '/myPlaceChange', '我的站点变更', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (36, 'PlaceDriverApply', '/placeDriverApply', '站点司机审核', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (37, 'PlaceCarApply', '/placeCarApply', '站点车辆审核', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (38, 'PlaceCars', '/placeCars', '站点车辆列表', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (39, 'PlaceDrivers', '/placeDrivers', '站点人员列表', NULL);
COMMIT;

-- ----------------------------
-- Table structure for places
-- ----------------------------
DROP TABLE IF EXISTS `places`;
CREATE TABLE `places` (
  `id` int NOT NULL AUTO_INCREMENT,
  `place_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `place_location` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `lat` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `lng` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `area` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `manager_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `work_time` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of places
-- ----------------------------
BEGIN;
INSERT INTO `places` (`id`, `place_name`, `place_location`, `lat`, `lng`, `city`, `area`, `manager_name`, `work_time`, `created`, `updated`, `manager_id`) VALUES (3, '西溪站', '西溪1号', NULL, NULL, '杭州', '西湖区', '西湖站管理员', '8:00-19:01', '2022-10-25', '2022-10-26', 27);
INSERT INTO `places` (`id`, `place_name`, `place_location`, `lat`, `lng`, `city`, `area`, `manager_name`, `work_time`, `created`, `updated`, `manager_id`) VALUES (4, '浦东西区站', '浦东1号', NULL, NULL, '上海', '浦东西区', NULL, '8:00-19:01', '2022-10-25', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` (`id`, `name`, `comment`) VALUES (1, 'admin', '管理员');
INSERT INTO `role` (`id`, `name`, `comment`) VALUES (2, '站点', '站点管理员');
INSERT INTO `role` (`id`, `name`, `comment`) VALUES (3, '司机', '司机');
COMMIT;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` int NOT NULL COMMENT '角色id',
  `permission_id` int NOT NULL COMMENT '资源id',
  PRIMARY KEY (`role_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
BEGIN;
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 1);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 9);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 10);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 11);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 13);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 14);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 22);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 23);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 24);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 25);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 26);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 28);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 29);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 30);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 1);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 13);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 14);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 36);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 37);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 38);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 39);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 1);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 13);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 14);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 32);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 33);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 34);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 35);
COMMIT;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价',
  `pay_price` decimal(10,2) DEFAULT NULL COMMENT '实付款',
  `discount` decimal(10,2) DEFAULT '0.00' COMMENT '优惠金额',
  `transport_price` decimal(10,2) DEFAULT '0.00' COMMENT '运费',
  `order_no` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单编号',
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户账户',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `state` int NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of t_order
-- ----------------------------
BEGIN;
INSERT INTO `t_order` (`id`, `name`, `total_price`, `pay_price`, `discount`, `transport_price`, `order_no`, `user_id`, `username`, `create_time`, `pay_time`, `state`) VALUES (25, '明朝那些事', 60.00, 60.00, 0.00, 0.00, '1451548938265882624', 1, 'admin', '2021-10-22 22:02:12', '2021-10-22 22:02:11', 1);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (1, 'admin', '$2a$10$.cxJ637DYA1PRSzfPmBO0efS1W2eTQefS51b83Nr5xgRNAW0ffgjO', '管理员', 32, '男', '火星', 'http://localhost:9090/files/preview/1.png', 100000.00, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (27, '西湖站管理员', '$2a$10$00EDY52lH9Nwed6Lbzf1/.R35OdO.dpBiIS5VzDjWdlkvr.wnkzLK', '西湖站管理员', 33, '男', NULL, NULL, 0.00, NULL, 3);
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (28, '西湖站司机', '$2a$10$n.IIPQPORYOG5QNd5.pzJOTb31NgWLLblTFByF4Ct1m9thgZzInfm', '西湖站司机', 22, '男', NULL, NULL, 0.00, 7, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `user_id` int NOT NULL COMMENT '用户id',
  `role_id` int NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (16, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (18, 3);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (19, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (20, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (21, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (24, 3);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (25, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (26, 3);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (27, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (28, 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
