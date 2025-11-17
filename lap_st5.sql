/*
 Navicat Premium Data Transfer

 Source Server         : django
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : lap_st5

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 17/11/2025 12:02:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add product', 7, 'add_product');
INSERT INTO `auth_permission` VALUES (26, 'Can change product', 7, 'change_product');
INSERT INTO `auth_permission` VALUES (27, 'Can delete product', 7, 'delete_product');
INSERT INTO `auth_permission` VALUES (28, 'Can view product', 7, 'view_product');
INSERT INTO `auth_permission` VALUES (29, 'Can add tag', 8, 'add_tag');
INSERT INTO `auth_permission` VALUES (30, 'Can change tag', 8, 'change_tag');
INSERT INTO `auth_permission` VALUES (31, 'Can delete tag', 8, 'delete_tag');
INSERT INTO `auth_permission` VALUES (32, 'Can view tag', 8, 'view_tag');
INSERT INTO `auth_permission` VALUES (33, 'Can add category', 9, 'add_category');
INSERT INTO `auth_permission` VALUES (34, 'Can change category', 9, 'change_category');
INSERT INTO `auth_permission` VALUES (35, 'Can delete category', 9, 'delete_category');
INSERT INTO `auth_permission` VALUES (36, 'Can view category', 9, 'view_category');
INSERT INTO `auth_permission` VALUES (37, 'Can add task', 10, 'add_task');
INSERT INTO `auth_permission` VALUES (38, 'Can change task', 10, 'change_task');
INSERT INTO `auth_permission` VALUES (39, 'Can delete task', 10, 'delete_task');
INSERT INTO `auth_permission` VALUES (40, 'Can view task', 10, 'view_task');
INSERT INTO `auth_permission` VALUES (41, 'Can add task', 11, 'add_task');
INSERT INTO `auth_permission` VALUES (42, 'Can change task', 11, 'change_task');
INSERT INTO `auth_permission` VALUES (43, 'Can delete task', 11, 'delete_task');
INSERT INTO `auth_permission` VALUES (44, 'Can view task', 11, 'view_task');
INSERT INTO `auth_permission` VALUES (45, 'Can add tag', 12, 'add_tag');
INSERT INTO `auth_permission` VALUES (46, 'Can change tag', 12, 'change_tag');
INSERT INTO `auth_permission` VALUES (47, 'Can delete tag', 12, 'delete_tag');
INSERT INTO `auth_permission` VALUES (48, 'Can view tag', 12, 'view_tag');
INSERT INTO `auth_permission` VALUES (49, 'Can add category', 13, 'add_category');
INSERT INTO `auth_permission` VALUES (50, 'Can change category', 13, 'change_category');
INSERT INTO `auth_permission` VALUES (51, 'Can delete category', 13, 'delete_category');
INSERT INTO `auth_permission` VALUES (52, 'Can view category', 13, 'view_category');
INSERT INTO `auth_permission` VALUES (53, 'Can add email otp', 14, 'add_emailotp');
INSERT INTO `auth_permission` VALUES (54, 'Can change email otp', 14, 'change_emailotp');
INSERT INTO `auth_permission` VALUES (55, 'Can delete email otp', 14, 'delete_emailotp');
INSERT INTO `auth_permission` VALUES (56, 'Can view email otp', 14, 'view_emailotp');
INSERT INTO `auth_permission` VALUES (57, 'Can add note', 15, 'add_note');
INSERT INTO `auth_permission` VALUES (58, 'Can change note', 15, 'change_note');
INSERT INTO `auth_permission` VALUES (59, 'Can delete note', 15, 'delete_note');
INSERT INTO `auth_permission` VALUES (60, 'Can view note', 15, 'view_note');
INSERT INTO `auth_permission` VALUES (61, 'Can add profile', 16, 'add_profile');
INSERT INTO `auth_permission` VALUES (62, 'Can change profile', 16, 'change_profile');
INSERT INTO `auth_permission` VALUES (63, 'Can delete profile', 16, 'delete_profile');
INSERT INTO `auth_permission` VALUES (64, 'Can view profile', 16, 'view_profile');
INSERT INTO `auth_permission` VALUES (65, 'Can add profile', 17, 'add_profile');
INSERT INTO `auth_permission` VALUES (66, 'Can change profile', 17, 'change_profile');
INSERT INTO `auth_permission` VALUES (67, 'Can delete profile', 17, 'delete_profile');
INSERT INTO `auth_permission` VALUES (68, 'Can view profile', 17, 'view_profile');
INSERT INTO `auth_permission` VALUES (69, 'Can add task profile', 18, 'add_taskprofile');
INSERT INTO `auth_permission` VALUES (70, 'Can change task profile', 18, 'change_taskprofile');
INSERT INTO `auth_permission` VALUES (71, 'Can delete task profile', 18, 'delete_taskprofile');
INSERT INTO `auth_permission` VALUES (72, 'Can view task profile', 18, 'view_taskprofile');
INSERT INTO `auth_permission` VALUES (73, 'Can add note', 19, 'add_note');
INSERT INTO `auth_permission` VALUES (74, 'Can change note', 19, 'change_note');
INSERT INTO `auth_permission` VALUES (75, 'Can delete note', 19, 'delete_note');
INSERT INTO `auth_permission` VALUES (76, 'Can view note', 19, 'view_note');
INSERT INTO `auth_permission` VALUES (77, 'Can add payment record', 20, 'add_paymentrecord');
INSERT INTO `auth_permission` VALUES (78, 'Can change payment record', 20, 'change_paymentrecord');
INSERT INTO `auth_permission` VALUES (79, 'Can delete payment record', 20, 'delete_paymentrecord');
INSERT INTO `auth_permission` VALUES (80, 'Can view payment record', 20, 'view_paymentrecord');
INSERT INTO `auth_permission` VALUES (81, 'Can add pay pal subscription', 21, 'add_paypalsubscription');
INSERT INTO `auth_permission` VALUES (82, 'Can change pay pal subscription', 21, 'change_paypalsubscription');
INSERT INTO `auth_permission` VALUES (83, 'Can delete pay pal subscription', 21, 'delete_paypalsubscription');
INSERT INTO `auth_permission` VALUES (84, 'Can view pay pal subscription', 21, 'view_paypalsubscription');
INSERT INTO `auth_permission` VALUES (85, 'Can add movie', 22, 'add_movie');
INSERT INTO `auth_permission` VALUES (86, 'Can change movie', 22, 'change_movie');
INSERT INTO `auth_permission` VALUES (87, 'Can delete movie', 22, 'delete_movie');
INSERT INTO `auth_permission` VALUES (88, 'Can view movie', 22, 'view_movie');
INSERT INTO `auth_permission` VALUES (89, 'Can add subscription plan', 23, 'add_subscriptionplan');
INSERT INTO `auth_permission` VALUES (90, 'Can change subscription plan', 23, 'change_subscriptionplan');
INSERT INTO `auth_permission` VALUES (91, 'Can delete subscription plan', 23, 'delete_subscriptionplan');
INSERT INTO `auth_permission` VALUES (92, 'Can view subscription plan', 23, 'view_subscriptionplan');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$1000000$lMP1gLyrQC6GCDBiTVX4P4$VdNmegUPz01BYU5c4g1ayFNKBhy1c54CDBF9JjPi0xs=', '2025-11-16 09:23:48.173832', 1, 'administrator', '', '', 'admin@gmail.com', 1, 1, '2025-04-11 11:36:55.516556');
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$1000000$CopjVdygnjdEKTGeCH73Cp$r1u/7cxgJd9L/gFyeSoRB5IFuSNaOmhCRDSIuCaOrQI=', '2025-11-16 09:34:47.298348', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2025-10-11 12:31:15.037320');
INSERT INTO `auth_user` VALUES (4, 'pbkdf2_sha256$1000000$GLm1bylBP2qc7pyZ3JJw14$2mRIZXvx6VVRTSz5bnCHAWSJbH9nKXERx8Y4vDzuPSQ=', '2025-11-16 09:31:32.151002', 1, 'davi', '', '', '', 1, 1, '2025-11-16 09:25:33.650108');
INSERT INTO `auth_user` VALUES (5, 'pbkdf2_sha256$1000000$fj1Z2F1Haqgr6PSFB1iJCt$XzD9VJXywAPH2GYuqIK71IYuCjau67gazh9ak0bk4lc=', NULL, 1, 'kaka', '', '', '', 1, 1, '2025-11-16 09:35:15.585310');
INSERT INTO `auth_user` VALUES (6, 'pbkdf2_sha256$1000000$g0lUeUFeOJjPppUwRVVMP2$32a+o3KN4oGg4ab1fSQPfP7omXjLhVBiVOfX+Uj+/bk=', '2025-11-16 09:43:37.463642', 1, 'david', '', '', '', 1, 1, '2025-11-16 09:43:09.779151');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2025-04-11 11:38:59.560627', '1', 'Coca Cola', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (2, '2025-04-11 11:39:16.239970', '2', 'Pepsi', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (3, '2025-04-11 11:39:27.975361', '3', 'Fanta', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (4, '2025-04-11 11:39:38.743907', '4', 'Soda', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (5, '2025-04-11 11:39:51.989676', '5', 'Beer', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (6, '2025-04-11 11:39:59.317189', '6', 'WAter', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (7, '2025-06-06 11:32:10.795774', '1', 'New Food', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (8, '2025-06-06 11:32:23.309809', '2', 'SoftDrink', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (9, '2025-06-06 11:42:24.648647', '1', 'New arrival', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (10, '2025-06-06 11:42:31.158438', '2', 'Best Seller', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (11, '2025-06-06 11:42:35.476704', '3', 'Discount', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (12, '2025-06-06 11:42:41.617083', '4', 'Limited Edition', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (13, '2025-06-06 11:42:52.238774', '5', 'Eco-Friendly', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (14, '2025-06-06 11:47:08.739225', '3', 'Apptizer', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (15, '2025-06-06 11:47:19.866991', '4', 'Fresh Meat', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (16, '2025-06-06 11:47:23.752051', '5', 'Fruit Juice', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (17, '2025-06-06 11:47:30.646555', '6', 'Frappe', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (18, '2025-06-06 11:47:33.386684', '7', 'Hot', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (19, '2025-06-06 11:47:37.875626', '8', 'ICED', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (20, '2025-06-06 11:47:59.136077', '6', 'WAter', 2, '[{\"changed\": {\"fields\": [\"Category\", \"Tags\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (21, '2025-06-06 13:32:35.559619', '6', 'WAter', 2, '[{\"changed\": {\"fields\": [\"Price\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (22, '2025-06-06 13:32:55.535570', '5', 'Beer', 2, '[{\"changed\": {\"fields\": [\"Category\", \"Qty\"]}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (23, '2025-06-13 12:59:33.094771', '1', 'Food', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` VALUES (24, '2025-06-13 12:59:45.879991', '2', 'Drink', 1, '[{\"added\": {}}]', 13, 1);
INSERT INTO `django_admin_log` VALUES (25, '2025-06-13 12:59:55.442261', '1', 'LABE', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` VALUES (26, '2025-06-13 12:59:57.512167', '2', 'LANA', 1, '[{\"added\": {}}]', 12, 1);
INSERT INTO `django_admin_log` VALUES (27, '2025-06-13 13:00:23.364599', '1', 'Daily', 1, '[{\"added\": {}}]', 11, 1);
INSERT INTO `django_admin_log` VALUES (28, '2025-11-17 04:11:12.744874', '1', 'Deadpool', 2, '[{\"changed\": {\"fields\": [\"Thumbnail\"]}}]', 22, 6);
INSERT INTO `django_admin_log` VALUES (29, '2025-11-17 04:12:22.794117', '1', 'Deadpool', 2, '[{\"changed\": {\"fields\": [\"Thumbnail\"]}}]', 22, 6);
INSERT INTO `django_admin_log` VALUES (30, '2025-11-17 04:15:01.701685', '2', 'Saka', 2, '[{\"changed\": {\"fields\": [\"Thumbnail\"]}}]', 22, 6);
INSERT INTO `django_admin_log` VALUES (31, '2025-11-17 04:17:49.547115', '1', 'FREE', 2, '[{\"changed\": {\"fields\": [\"Name\", \"Description\"]}}]', 23, 6);
INSERT INTO `django_admin_log` VALUES (32, '2025-11-17 04:18:12.113259', '2', 'Premium', 1, '[{\"added\": {}}]', 23, 6);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (9, 'myapp', 'category');
INSERT INTO `django_content_type` VALUES (14, 'myapp', 'emailotp');
INSERT INTO `django_content_type` VALUES (15, 'myapp', 'note');
INSERT INTO `django_content_type` VALUES (7, 'myapp', 'product');
INSERT INTO `django_content_type` VALUES (16, 'myapp', 'profile');
INSERT INTO `django_content_type` VALUES (8, 'myapp', 'tag');
INSERT INTO `django_content_type` VALUES (10, 'myapp', 'task');
INSERT INTO `django_content_type` VALUES (20, 'paypal', 'paymentrecord');
INSERT INTO `django_content_type` VALUES (21, 'paypal', 'paypalsubscription');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (22, 'subscriptions', 'movie');
INSERT INTO `django_content_type` VALUES (23, 'subscriptions', 'subscriptionplan');
INSERT INTO `django_content_type` VALUES (13, 'task', 'category');
INSERT INTO `django_content_type` VALUES (19, 'task', 'note');
INSERT INTO `django_content_type` VALUES (17, 'task', 'profile');
INSERT INTO `django_content_type` VALUES (12, 'task', 'tag');
INSERT INTO `django_content_type` VALUES (11, 'task', 'task');
INSERT INTO `django_content_type` VALUES (18, 'task', 'taskprofile');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2025-04-11 11:22:47.920636');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2025-04-11 11:22:49.894615');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2025-04-11 11:22:50.872469');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-04-11 11:22:50.887509');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-11 11:22:50.904994');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-04-11 11:22:51.334234');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-04-11 11:22:51.506027');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-04-11 11:22:51.562083');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-04-11 11:22:51.577097');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-04-11 11:22:51.724785');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-04-11 11:22:51.734281');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-04-11 11:22:51.752905');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-04-11 11:22:51.918629');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-04-11 11:22:52.103972');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-04-11 11:22:52.291092');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-04-11 11:22:52.314910');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-04-11 11:22:52.860171');
INSERT INTO `django_migrations` VALUES (18, 'myapp', '0001_initial', '2025-04-11 11:22:52.927259');
INSERT INTO `django_migrations` VALUES (19, 'myapp', '0002_rename_descritption_product_description', '2025-04-11 11:22:52.954889');
INSERT INTO `django_migrations` VALUES (20, 'myapp', '0003_product_name_product_price', '2025-04-11 11:22:53.099129');
INSERT INTO `django_migrations` VALUES (21, 'myapp', '0004_alter_product_name_alter_product_price', '2025-04-11 11:22:53.427387');
INSERT INTO `django_migrations` VALUES (22, 'sessions', '0001_initial', '2025-04-11 11:22:53.547313');
INSERT INTO `django_migrations` VALUES (23, 'myapp', '0005_category_tag_product_category_product_tags', '2025-06-06 11:21:18.273654');
INSERT INTO `django_migrations` VALUES (24, 'myapp', '0006_task', '2025-06-06 12:25:57.364703');
INSERT INTO `django_migrations` VALUES (25, 'myapp', '0007_product_qty', '2025-06-06 13:29:50.356720');
INSERT INTO `django_migrations` VALUES (28, 'myapp', '0005_tag_task', '2025-07-12 11:34:36.030402');
INSERT INTO `django_migrations` VALUES (29, 'myapp', '0002_emailotp', '2025-10-11 12:23:16.332421');
INSERT INTO `django_migrations` VALUES (30, 'paypal', '0001_initial', '2025-11-16 09:27:17.533073');
INSERT INTO `django_migrations` VALUES (31, 'paypal', '0002_paypalsubscription', '2025-11-16 09:27:18.002782');
INSERT INTO `django_migrations` VALUES (32, 'task', '0002_task_user', '2025-11-16 09:27:18.218770');
INSERT INTO `django_migrations` VALUES (33, 'task', '0003_alter_task_user', '2025-11-16 09:27:18.432527');
INSERT INTO `django_migrations` VALUES (34, 'task', '0004_userotp', '2025-11-16 09:27:18.624653');
INSERT INTO `django_migrations` VALUES (35, 'task', '0001_initial', '2025-11-16 09:42:47.200543');
INSERT INTO `django_migrations` VALUES (37, 'paypal', '0003_alter_paypalsubscription_plan_id', '2025-11-17 02:49:24.182770');
INSERT INTO `django_migrations` VALUES (38, 'subscriptions', '0001_initial', '2025-11-17 02:50:34.310384');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('28tz6m2frquwjcrietiewqh2illlrphv', '.eJxVjMsOwiAQRf-FtSG8EZfu_QYyw4BUDSSlXRn_3TbpQrfnnHvfLMK61LiOPMeJ2IVJdvplCOmZ2y7oAe3eeeptmSfke8IPO_itU35dj_bvoMKo2xqT1sJjMaiDKeSKCwjCOiEgwdmDAh8oWQMelZCFpLIKNoZYrE7Sss8X9JI4Rg:1uIoPx:8vq9zdYXGAYcihXbaXpTzLe_mtrLm3n_mWaOahfgqUc', '2025-06-07 12:56:01.480538');
INSERT INTO `django_session` VALUES ('2xm55f8vlwpqgibdtq2uba58gyipk2el', '.eJxVjEEOwiAQRe_C2hCgZRCX7nsGMgyDVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERIE6_W0R6cN1BumO9NUmtrssc5a7Ig3Y5tcTP6-H-HRTs5Vsj2QHJeKfz2Q96dJSBFWjl0ACyycTegFdjUm5AjVFr6yz7lBQyQBbvD9z_N84:1vKZIH:OGZ2xArc1hoy1uu6_gwB27K1t-uTSiUcHaXVP50TzJI', '2025-11-30 09:43:37.477400');
INSERT INTO `django_session` VALUES ('97gti6ty6a6iyba6d8rbb1mcedcpm6q2', 'e30:1vKYz6:iaZrNYWc3ixNRWPMP0jeyekSH7zq2FskSqEOvbLBfP4', '2025-11-30 09:23:48.142358');
INSERT INTO `django_session` VALUES ('a6rtc7mex2nx11rmw6pas1n8t73or4ef', 'e30:1vKZ6a:15_R9IxtTqrGB5Dk0rdTrnEc1NWyOao6YPDnEU_Zk8U', '2025-11-30 09:31:32.142214');
INSERT INTO `django_session` VALUES ('cj0b21jlsl59w02ssnelq0g6go90vtyv', 'e30:1vKZ9j:6sflZW3ZRxRErhDCSfKeC8iayo410xqjgcNj7Lt04l8', '2025-11-30 09:34:47.290881');
INSERT INTO `django_session` VALUES ('i5gtppup05r1vu7hns5cr1eor6uhhkt3', '.eJxVjMsOwiAQRf-FtSG8EZfu_QYyw4BUDSSlXRn_3TbpQrfnnHvfLMK61LiOPMeJ2IVJdvplCOmZ2y7oAe3eeeptmSfke8IPO_itU35dj_bvoMKo2xqT1sJjMaiDKeSKCwjCOiEgwdmDAh8oWQMelZCFpLIKNoZYrE7Sss8X9JI4Rg:1u3CiF:WmH4OYvELdwvUxFKsNIA7kV3DIAqdaf9GakZGMHudek', '2025-04-25 11:38:23.749464');
INSERT INTO `django_session` VALUES ('oyx96z2xjiwjy8x006eangbodo3sknnu', 'e30:1v7Yno:eiH_jP0uESYoDjO3OpRYVxE41ethXaLWr3MVEPB4hHQ', '2025-10-25 12:34:24.221526');
INSERT INTO `django_session` VALUES ('rccwh9r8inye6oungn4zszd8zy3jnw5d', 'e30:1vKZ3g:8mRdt6hciahy9cAO0Rb3ykxbOfa7MNVJh-9b1JRxlTI', '2025-11-30 09:28:32.766814');
INSERT INTO `django_session` VALUES ('t3qognlhrzv4jayhi4fsjejwpvglorof', '.eJxVjMEOwiAQRP-FsyFsKCz16N1vILAsUjWQlPbU-O-2SQ96m8x7M5vwYV2KXzvPfkriKkBcfrsY6MX1AOkZ6qNJanWZpygPRZ60y3tL_L6d7t9BCb3s65idIYhBAZiMhMGwYTugRhoBWVkzDlqDA1JmQNpDyimq5Gy0QFqLzxfVHDc8:1uQ3ya:j2HjyNlBIm3YsdyRergVkWbRWnK7g1DWAUx_nuW0xWg', '2025-06-27 12:57:44.477707');
INSERT INTO `django_session` VALUES ('ubgsgeye05bqj7lqgm0rifs1u6n0a2yj', 'e30:1vKYzC:KmAWaT6vqdsCUbG8ifcSscbGFqT7uYwzbUAFj6g3Kyg', '2025-11-30 09:23:54.103636');
INSERT INTO `django_session` VALUES ('y9giff0q02p6zzzavmoss9d28mtehz9q', 'e30:1v7Yjy:E89HA0PYLaEzPkDYW3vfBaCXvc9WNvVw8YNtCoWBnXw', '2025-10-25 12:30:26.187687');
INSERT INTO `django_session` VALUES ('zgqvs9l7yuxpjfawae4a4pm0qqqlftam', 'e30:1vKZ15:LUBryB6TcZsLI0mmxR_3BczXReRCXs-a7923F_2I8ZU', '2025-11-30 09:25:51.667396');

-- ----------------------------
-- Table structure for myapp_category
-- ----------------------------
DROP TABLE IF EXISTS `myapp_category`;
CREATE TABLE `myapp_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of myapp_category
-- ----------------------------
INSERT INTO `myapp_category` VALUES (3, 'Apptizer');
INSERT INTO `myapp_category` VALUES (6, 'Frappe');
INSERT INTO `myapp_category` VALUES (4, 'Fresh Meat');
INSERT INTO `myapp_category` VALUES (5, 'Fruit Juice');
INSERT INTO `myapp_category` VALUES (7, 'Hot');
INSERT INTO `myapp_category` VALUES (8, 'ICED');
INSERT INTO `myapp_category` VALUES (1, 'New Food');
INSERT INTO `myapp_category` VALUES (2, 'SoftDrink');

-- ----------------------------
-- Table structure for myapp_emailotp
-- ----------------------------
DROP TABLE IF EXISTS `myapp_emailotp`;
CREATE TABLE `myapp_emailotp`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `otp` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `myapp_emailotp_user_id_f3a85d34_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of myapp_emailotp
-- ----------------------------

-- ----------------------------
-- Table structure for myapp_product
-- ----------------------------
DROP TABLE IF EXISTS `myapp_product`;
CREATE TABLE `myapp_product`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of myapp_product
-- ----------------------------
INSERT INTO `myapp_product` VALUES (1, 'Coca ot chnanh te', 'Coca Cola', 1.00);
INSERT INTO `myapp_product` VALUES (2, 'Good for human', 'Pepsi', 2.00);
INSERT INTO `myapp_product` VALUES (3, 'Fantastic', 'Fanta', 2.00);
INSERT INTO `myapp_product` VALUES (4, 'Ot Chnanh', 'Soda', 2.00);
INSERT INTO `myapp_product` VALUES (5, 'Chnanh', 'Beer', 3.00);
INSERT INTO `myapp_product` VALUES (6, 'good', 'WAter', 5.00);

-- ----------------------------
-- Table structure for myapp_task
-- ----------------------------
DROP TABLE IF EXISTS `myapp_task`;
CREATE TABLE `myapp_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `due_date` date NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `note` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of myapp_task
-- ----------------------------
INSERT INTO `myapp_task` VALUES (1, '2025-06-15', '-2032', '-2032');
INSERT INTO `myapp_task` VALUES (2, '2025-06-10', '-2032', '-2032');

-- ----------------------------
-- Table structure for paypal_paymentrecord
-- ----------------------------
DROP TABLE IF EXISTS `paypal_paymentrecord`;
CREATE TABLE `paypal_paymentrecord`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  `currency` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `payer_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `payment_id`(`payment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paypal_paymentrecord
-- ----------------------------
INSERT INTO `paypal_paymentrecord` VALUES (1, 'PAYID-NEM6FDI5HC33223BT382923M', 'created', 9.99, 'USD', NULL, '2025-11-16 14:42:21.176938', '2025-11-16 14:42:21.177027');
INSERT INTO `paypal_paymentrecord` VALUES (2, 'PAYID-NENAN3Q1RK44336TS2303347', 'created', 9.99, 'USD', NULL, '2025-11-16 17:17:33.558190', '2025-11-16 17:17:33.558217');

-- ----------------------------
-- Table structure for paypal_paypalsubscription
-- ----------------------------
DROP TABLE IF EXISTS `paypal_paypalsubscription`;
CREATE TABLE `paypal_paypalsubscription`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `paypal_subscription_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plan_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `start_time` datetime(6) NULL DEFAULT NULL,
  `next_billing_time` datetime(6) NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `paypal_subscription_id`(`paypal_subscription_id` ASC) USING BTREE,
  INDEX `paypal_paypalsubscription_user_id_1b85a310_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  UNIQUE INDEX `paypal_paypalsubscription_plan_id_338be0f8_uniq`(`plan_id` ASC) USING BTREE,
  CONSTRAINT `paypal_paypalsubscription_user_id_1b85a310_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paypal_paypalsubscription
-- ----------------------------
INSERT INTO `paypal_paypalsubscription` VALUES (1, 'I-91VU6936KCT5', 'ACTIVE', 'P-5S0937251P8046054NELS7ZQ', '2025-11-16 09:46:10.000000', '2025-12-16 10:00:00.000000', '2025-11-16 09:47:48.375548', 6);

-- ----------------------------
-- Table structure for subscriptions_movie
-- ----------------------------
DROP TABLE IF EXISTS `subscriptions_movie`;
CREATE TABLE `subscriptions_movie`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `thumbnail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `release_date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subscriptions_movie
-- ----------------------------
INSERT INTO `subscriptions_movie` VALUES (1, 'Deadpool', '123', 'thumbnails/deadpool-1200-1200-675-675-crop-000000.jpg', '2025-11-17');
INSERT INTO `subscriptions_movie` VALUES (2, 'Saka', '123', 'thumbnails/maxresdefault.jpg', '2025-11-03');

-- ----------------------------
-- Table structure for subscriptions_subscriptionplan
-- ----------------------------
DROP TABLE IF EXISTS `subscriptions_subscriptionplan`;
CREATE TABLE `subscriptions_subscriptionplan`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` decimal(6, 2) NOT NULL,
  `duration_days` int NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `paypal_plan_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `subscriptions_subscr_paypal_plan_id_4bd33eaa_fk_paypal_pa`(`paypal_plan_id` ASC) USING BTREE,
  CONSTRAINT `subscriptions_subscr_paypal_plan_id_4bd33eaa_fk_paypal_pa` FOREIGN KEY (`paypal_plan_id`) REFERENCES `paypal_paypalsubscription` (`plan_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subscriptions_subscriptionplan
-- ----------------------------
INSERT INTO `subscriptions_subscriptionplan` VALUES (1, 'FREE', 1.00, 1, 'Free movies With ads', 'P-5S0937251P8046054NELS7ZQ');
INSERT INTO `subscriptions_subscriptionplan` VALUES (2, 'Premium', 10.00, 30, 'No Ads', NULL);

-- ----------------------------
-- Table structure for task_category
-- ----------------------------
DROP TABLE IF EXISTS `task_category`;
CREATE TABLE `task_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `hex_color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `rate` double NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_category
-- ----------------------------

-- ----------------------------
-- Table structure for task_note
-- ----------------------------
DROP TABLE IF EXISTS `task_note`;
CREATE TABLE `task_note`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `task_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_note_task_id_9a9d6477_fk_task_task_id`(`task_id` ASC) USING BTREE,
  CONSTRAINT `task_note_task_id_9a9d6477_fk_task_task_id` FOREIGN KEY (`task_id`) REFERENCES `task_task` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_note
-- ----------------------------

-- ----------------------------
-- Table structure for task_profile
-- ----------------------------
DROP TABLE IF EXISTS `task_profile`;
CREATE TABLE `task_profile`  (
  `user_id` int NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `picture` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `otp` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `task_profile_user_id_24cc7c08_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_profile
-- ----------------------------
INSERT INTO `task_profile` VALUES (6, NULL, NULL, 'profile/default.png', 0, NULL);

-- ----------------------------
-- Table structure for task_tag
-- ----------------------------
DROP TABLE IF EXISTS `task_tag`;
CREATE TABLE `task_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `label` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_tag
-- ----------------------------

-- ----------------------------
-- Table structure for task_task
-- ----------------------------
DROP TABLE IF EXISTS `task_task`;
CREATE TABLE `task_task`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `due_date` date NULL DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `task_task_category_id_7e1a5a3d_fk_task_category_id`(`category_id` ASC) USING BTREE,
  INDEX `task_task_user_id_5330ed4b_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `task_task_category_id_7e1a5a3d_fk_task_category_id` FOREIGN KEY (`category_id`) REFERENCES `task_category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `task_task_user_id_5330ed4b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_task
-- ----------------------------

-- ----------------------------
-- Table structure for task_task_tag
-- ----------------------------
DROP TABLE IF EXISTS `task_task_tag`;
CREATE TABLE `task_task_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `task_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `task_task_tag_task_id_tag_id_90a6b007_uniq`(`task_id` ASC, `tag_id` ASC) USING BTREE,
  INDEX `task_task_tag_tag_id_752d1e8f_fk_task_tag_id`(`tag_id` ASC) USING BTREE,
  CONSTRAINT `task_task_tag_tag_id_752d1e8f_fk_task_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `task_tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `task_task_tag_task_id_1727e6f4_fk_task_task_id` FOREIGN KEY (`task_id`) REFERENCES `task_task` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_task_tag
-- ----------------------------

-- ----------------------------
-- Table structure for task_taskprofile
-- ----------------------------
DROP TABLE IF EXISTS `task_taskprofile`;
CREATE TABLE `task_taskprofile`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_taskprofile
-- ----------------------------

-- ----------------------------
-- Table structure for task_userotp
-- ----------------------------
DROP TABLE IF EXISTS `task_userotp`;
CREATE TABLE `task_userotp`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `otp` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `task_userotp_user_id_4fa0c230_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task_userotp
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
