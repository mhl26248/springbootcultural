/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : trip

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 22/01/2023 20:37:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `nums` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
INSERT INTO `cart` (`id`, `user_id`, `record_id`, `created`, `nums`) VALUES (1, 27, 13, NULL, NULL);
INSERT INTO `cart` (`id`, `user_id`, `record_id`, `created`, `nums`) VALUES (4, 27, 14, '2023-01-22 14:33:51', NULL);
INSERT INTO `cart` (`id`, `user_id`, `record_id`, `created`, `nums`) VALUES (5, 27, 16, '2023-01-22 16:00:16', NULL);
INSERT INTO `cart` (`id`, `user_id`, `record_id`, `created`, `nums`) VALUES (6, 27, 17, '2023-01-22 19:48:02', NULL);
INSERT INTO `cart` (`id`, `user_id`, `record_id`, `created`, `nums`) VALUES (8, 28, 16, '2023-01-22 20:27:39', NULL);
COMMIT;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `record_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `score` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of comments
-- ----------------------------
BEGIN;
INSERT INTO `comments` (`id`, `record_id`, `user_id`, `remark`, `score`, `created`) VALUES (1, 34, 27, '1', '2', NULL);
INSERT INTO `comments` (`id`, `record_id`, `user_id`, `remark`, `score`, `created`) VALUES (3, 35, 28, '112313213', '2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `record_id` int DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Records of likes
-- ----------------------------
BEGIN;
INSERT INTO `likes` (`id`, `user_id`, `record_id`, `created`) VALUES (1, 27, 14, '2023-01-22 14:08:24');
INSERT INTO `likes` (`id`, `user_id`, `record_id`, `created`) VALUES (3, 27, 16, '2023-01-22 15:13:59');
INSERT INTO `likes` (`id`, `user_id`, `record_id`, `created`) VALUES (4, 28, 14, '2023-01-22 20:27:35');
INSERT INTO `likes` (`id`, `user_id`, `record_id`, `created`) VALUES (5, 28, 16, '2023-01-22 20:27:49');
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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (1, 'Home', '/home', '主页', 'el-icon-house');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (9, 'User', '/user', '用户管理', 'el-icon-user');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (10, 'Permission', '/permisssion', '权限菜单', 'el-icon-menu');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (11, 'Role', '/role', '角色管理', 'el-icon-s-custom');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (13, 'Person', '/person', '个人信息', '');
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (14, 'Password', '/password', '修改密码', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (41, 'Record', '/Record', '商品设置', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (42, 'RecordList', '/RecordList', '列表', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (43, 'MyRecord', '/MyRecord', '我的订单', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (44, 'RecordApplyList', '/RecordApplyList', '订单列表', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (45, 'Index', '/Index', '首页', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (46, 'Cart', '/Cart', '购物车', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (47, 'Like', '/Like', '收藏', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (48, 'RecordDetail', '/RecordDetail', '详情', NULL);
INSERT INTO `permission` (`id`, `name`, `path`, `comment`, `icon`) VALUES (49, 'Comment', '/Comment', '评价管理', NULL);
COMMIT;

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `status` int DEFAULT '0' COMMENT '0 上架 1 下架',
  `remark` varchar(255) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `record_no` varchar(20) DEFAULT NULL,
  `images` varchar(500) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `diff` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of record
-- ----------------------------
BEGIN;
INSERT INTO `record` (`id`, `user_id`, `title`, `status`, `remark`, `created`, `record_no`, `images`, `price`, `detail`, `diff`) VALUES (13, 27, '商品 1', 1, '景点 1景点 1景点 1景点 1景点 11', '2022-12-22 00:00:00', NULL, 'http://localhost:9091/files/f6e960bedabc4638b43e704393626d0b_WechatIMG19.jpeg', 6.00, NULL, 0.90);
INSERT INTO `record` (`id`, `user_id`, `title`, `status`, `remark`, `created`, `record_no`, `images`, `price`, `detail`, `diff`) VALUES (14, 27, '商品 2', 0, '11111', '2022-12-22 00:00:00', NULL, 'http://localhost:9091/files/8e741b8cde2f4928acf5140f7135d3f0_1672044831114.jpg', 4.00, NULL, 0.50);
INSERT INTO `record` (`id`, `user_id`, `title`, `status`, `remark`, `created`, `record_no`, `images`, `price`, `detail`, `diff`) VALUES (16, NULL, '111', 0, NULL, '2022-12-28 00:00:00', NULL, 'http://localhost:9091/files/bf2d55e1dcf94b17b52fa44ce61e09c0_1.png', 2.00, NULL, 0.30);
INSERT INTO `record` (`id`, `user_id`, `title`, `status`, `remark`, `created`, `record_no`, `images`, `price`, `detail`, `diff`) VALUES (17, NULL, '1', 0, '12312321321321321313', '2023-01-22 10:36:48', NULL, 'http://localhost:9091/files/fb725b9d928f40c8b242e9b1a9588988_1.jpg', 1.00, NULL, 0.50);
INSERT INTO `record` (`id`, `user_id`, `title`, `status`, `remark`, `created`, `record_no`, `images`, `price`, `detail`, `diff`) VALUES (18, NULL, 'asdb', 0, 'asdbasdbasdbasdbasdbasdbasdb\nasdbasdbasdbasdb\n\nasdb\n\nasdb\nasdb', '2023-01-22 14:46:30', NULL, 'http://localhost:9091/files/0ec1fd77415b49c2aecb9b8ca7e99f5f_1.jpg', 12.00, NULL, 0.30);
COMMIT;

-- ----------------------------
-- Table structure for record_apply
-- ----------------------------
DROP TABLE IF EXISTS `record_apply`;
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of record_apply
-- ----------------------------
BEGIN;
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (25, 27, NULL, '2023-01-22 15:05:38', NULL, 0, NULL, 14, NULL, 2.00, '支付宝', 4.00, NULL);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (26, 27, NULL, '2023-01-22 15:07:13', NULL, 0, NULL, 14, NULL, 2.00, '微信', 4.00, 0.50);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (27, 27, NULL, '2023-01-22 15:13:01', NULL, 0, NULL, 14, NULL, 2.00, '支付宝', 4.00, 0.50);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (31, 27, NULL, '2023-01-22 15:19:37', NULL, 0, NULL, 14, NULL, 2.00, '支付宝', 4.00, 0.50);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (32, 27, NULL, '2023-01-22 15:19:44', NULL, 0, NULL, 13, NULL, 5.40, '支付宝', 6.00, 0.90);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (33, 27, NULL, '2023-01-22 15:21:21', NULL, 0, NULL, 16, NULL, 0.60, '微信', 2.00, 0.30);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (34, 27, NULL, '2023-01-21 15:34:09', NULL, 0, NULL, 13, NULL, 5.40, '支付宝', 6.00, 0.90);
INSERT INTO `record_apply` (`id`, `apply_id`, `apply_time`, `created`, `updated`, `status`, `reject_msg`, `record_id`, `type`, `pay_amt`, `pay_type`, `pay_price`, `pay_diff`) VALUES (35, 28, NULL, '2023-01-22 20:26:01', NULL, 0, NULL, 16, NULL, 0.60, '支付宝', 2.00, 0.30);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` (`id`, `name`, `comment`) VALUES (1, 'admin', '管理员');
INSERT INTO `role` (`id`, `name`, `comment`) VALUES (2, '用户', '用户');
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
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 41);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 44);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (1, 49);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 13);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 14);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 43);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 45);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 46);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 47);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (2, 48);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 1);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 13);
INSERT INTO `role_permission` (`role_id`, `permission_id`) VALUES (3, 14);
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (1, 'admin', '$2a$10$.cxJ637DYA1PRSzfPmBO0efS1W2eTQefS51b83Nr5xgRNAW0ffgjO', '管理员', 32, '男', '火星', 'http://localhost:9090/files/preview/1.png', 100000.00, NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (27, '1', '$2a$10$GR258rnZ1uJQtiNxT7S3BeQuKUKd.AvDI2VXSJ3atVtSXg9m/N9Du', '1', 33, '男', NULL, NULL, 0.00, NULL, 3);
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (28, '2', '$2a$10$Jm39aE6FSCIf8ADE6HhjiuBxgLGjDVIMHXthDVd5g3rDM9LaScyA2', '2', 22, '男', NULL, NULL, 0.00, 7, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `nick_name`, `age`, `sex`, `address`, `avatar`, `account`, `driver_id`, `place_id`) VALUES (29, '王五', '$2a$10$.cxJ637DYA1PRSzfPmBO0efS1W2eTQefS51b83Nr5xgRNAW0ffgjO', '王五', NULL, NULL, NULL, NULL, 0.00, NULL, NULL);
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
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (28, 2);
INSERT INTO `user_role` (`user_id`, `role_id`) VALUES (29, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
