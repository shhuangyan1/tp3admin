/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_notice_read`
-- ----------------------------
DROP TABLE IF EXISTS `xb_notice_read`;
CREATE TABLE `xb_notice_read` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `MID` int(10) NOT NULL COMMENT '发送的内部消息ID',
  `UID` int(10) NOT NULL COMMENT '用户ID',
  `Time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_notice_read
-- ----------------------------
INSERT INTO `xb_notice_read` VALUES ('1', '1', '10', '2018-08-21 20:20:47');
INSERT INTO `xb_notice_read` VALUES ('3', '3', '10', '2018-08-21 20:31:55');
INSERT INTO `xb_notice_read` VALUES ('5', '5', '10', '2018-08-21 20:32:44');
INSERT INTO `xb_notice_read` VALUES ('6', '12', '10', '2018-08-21 20:56:36');
INSERT INTO `xb_notice_read` VALUES ('7', '11', '10', '2018-08-21 20:56:38');
INSERT INTO `xb_notice_read` VALUES ('8', '10', '10', '2018-08-21 20:56:39');
INSERT INTO `xb_notice_read` VALUES ('9', '9', '10', '2018-08-21 20:56:41');
INSERT INTO `xb_notice_read` VALUES ('14', '8', '8', '2018-08-21 21:11:26');
INSERT INTO `xb_notice_read` VALUES ('15', '7', '8', '2018-08-21 21:11:34');
INSERT INTO `xb_notice_read` VALUES ('16', '22', '10', '2018-08-21 21:22:01');
INSERT INTO `xb_notice_read` VALUES ('17', '20', '10', '2018-08-21 21:22:03');
INSERT INTO `xb_notice_read` VALUES ('18', '18', '10', '2018-08-21 21:22:04');
INSERT INTO `xb_notice_read` VALUES ('19', '23', '10', '2018-08-21 21:24:41');
INSERT INTO `xb_notice_read` VALUES ('21', '25', '10', '2018-08-21 21:26:18');
INSERT INTO `xb_notice_read` VALUES ('22', '38', '10', '2018-08-21 21:42:53');
INSERT INTO `xb_notice_read` VALUES ('23', '35', '10', '2018-08-21 21:42:55');
INSERT INTO `xb_notice_read` VALUES ('24', '33', '10', '2018-08-21 21:42:57');
INSERT INTO `xb_notice_read` VALUES ('25', '31', '10', '2018-08-21 21:42:58');
INSERT INTO `xb_notice_read` VALUES ('26', '30', '10', '2018-08-21 21:43:00');
INSERT INTO `xb_notice_read` VALUES ('27', '28', '10', '2018-08-21 21:43:02');
INSERT INTO `xb_notice_read` VALUES ('29', '66', '10', '2018-08-22 10:59:52');
INSERT INTO `xb_notice_read` VALUES ('30', '45', '10', '2018-08-22 10:59:54');
INSERT INTO `xb_notice_read` VALUES ('31', '44', '10', '2018-08-22 10:59:56');
INSERT INTO `xb_notice_read` VALUES ('32', '43', '10', '2018-08-22 10:59:57');
INSERT INTO `xb_notice_read` VALUES ('33', '41', '10', '2018-08-22 10:59:59');
INSERT INTO `xb_notice_read` VALUES ('34', '39', '10', '2018-08-22 11:00:01');
INSERT INTO `xb_notice_read` VALUES ('35', '64', '16', '2018-08-22 11:07:11');
INSERT INTO `xb_notice_read` VALUES ('36', '75', '10', '2018-08-22 11:39:57');
INSERT INTO `xb_notice_read` VALUES ('37', '74', '10', '2018-08-22 11:39:59');
INSERT INTO `xb_notice_read` VALUES ('38', '73', '10', '2018-08-22 11:41:25');
INSERT INTO `xb_notice_read` VALUES ('39', '72', '10', '2018-08-22 11:41:27');
INSERT INTO `xb_notice_read` VALUES ('40', '69', '10', '2018-08-22 11:41:28');
INSERT INTO `xb_notice_read` VALUES ('43', '97', '14', '2018-08-22 20:10:08');
INSERT INTO `xb_notice_read` VALUES ('44', '98', '9', '2018-08-22 21:45:28');
INSERT INTO `xb_notice_read` VALUES ('45', '99', '9', '2018-08-22 21:45:29');
INSERT INTO `xb_notice_read` VALUES ('46', '100', '9', '2018-08-22 21:45:30');
INSERT INTO `xb_notice_read` VALUES ('47', '101', '9', '2018-08-22 21:45:37');
INSERT INTO `xb_notice_read` VALUES ('48', '47', '12', '2018-08-23 15:04:56');
INSERT INTO `xb_notice_read` VALUES ('49', '110', '14', '2018-08-23 15:22:57');
INSERT INTO `xb_notice_read` VALUES ('53', '116', '10', '2018-08-25 11:25:29');
INSERT INTO `xb_notice_read` VALUES ('54', '115', '10', '2018-08-25 11:25:32');
INSERT INTO `xb_notice_read` VALUES ('55', '109', '10', '2018-08-25 11:25:34');
INSERT INTO `xb_notice_read` VALUES ('56', '80', '10', '2018-08-25 11:25:36');
INSERT INTO `xb_notice_read` VALUES ('57', '76', '10', '2018-08-25 11:25:37');
INSERT INTO `xb_notice_read` VALUES ('58', '130', '9', '2018-08-25 11:36:15');
INSERT INTO `xb_notice_read` VALUES ('59', '131', '9', '2018-08-25 11:36:18');
INSERT INTO `xb_notice_read` VALUES ('60', '132', '9', '2018-08-25 11:38:41');
INSERT INTO `xb_notice_read` VALUES ('61', '133', '9', '2018-08-25 11:38:43');
INSERT INTO `xb_notice_read` VALUES ('62', '129', '10', '2018-08-25 11:41:28');
INSERT INTO `xb_notice_read` VALUES ('63', '107', '8', '2018-08-27 08:54:22');
INSERT INTO `xb_notice_read` VALUES ('64', '108', '8', '2018-08-27 08:54:27');
INSERT INTO `xb_notice_read` VALUES ('65', '123', '8', '2018-08-27 08:54:28');
INSERT INTO `xb_notice_read` VALUES ('66', '142', '8', '2018-08-27 08:54:30');
INSERT INTO `xb_notice_read` VALUES ('67', '143', '8', '2018-08-27 08:54:32');
INSERT INTO `xb_notice_read` VALUES ('68', '144', '8', '2018-08-27 08:54:34');
INSERT INTO `xb_notice_read` VALUES ('69', '137', '9', '2018-08-27 08:58:41');
INSERT INTO `xb_notice_read` VALUES ('70', '138', '9', '2018-08-27 08:58:42');
INSERT INTO `xb_notice_read` VALUES ('71', '139', '9', '2018-08-27 08:58:44');
INSERT INTO `xb_notice_read` VALUES ('72', '140', '9', '2018-08-27 08:58:46');
INSERT INTO `xb_notice_read` VALUES ('73', '141', '9', '2018-08-27 08:58:47');
INSERT INTO `xb_notice_read` VALUES ('74', '145', '9', '2018-08-27 08:58:49');
INSERT INTO `xb_notice_read` VALUES ('75', '150', '9', '2018-08-27 08:58:51');
INSERT INTO `xb_notice_read` VALUES ('76', '151', '9', '2018-08-27 08:58:52');
INSERT INTO `xb_notice_read` VALUES ('77', '152', '9', '2018-08-27 08:58:54');
INSERT INTO `xb_notice_read` VALUES ('78', '153', '9', '2018-08-27 08:59:56');
INSERT INTO `xb_notice_read` VALUES ('79', '154', '9', '2018-08-27 09:24:37');
INSERT INTO `xb_notice_read` VALUES ('80', '155', '9', '2018-08-27 09:24:38');
INSERT INTO `xb_notice_read` VALUES ('81', '156', '9', '2018-08-27 09:24:39');
INSERT INTO `xb_notice_read` VALUES ('82', '149', '8', '2018-08-28 14:57:37');
INSERT INTO `xb_notice_read` VALUES ('83', '117', '8', '2018-08-28 14:57:45');
INSERT INTO `xb_notice_read` VALUES ('84', '120', '8', '2018-08-28 14:57:48');
INSERT INTO `xb_notice_read` VALUES ('85', '122', '8', '2018-08-28 14:57:51');
INSERT INTO `xb_notice_read` VALUES ('86', '121', '8', '2018-08-28 14:57:53');
INSERT INTO `xb_notice_read` VALUES ('87', '119', '8', '2018-08-28 14:57:56');
INSERT INTO `xb_notice_read` VALUES ('88', '118', '8', '2018-08-28 14:58:00');
