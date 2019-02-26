/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:18:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_readmessage`
-- ----------------------------
DROP TABLE IF EXISTS `xb_readmessage`;
CREATE TABLE `xb_readmessage` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `MID` int(10) NOT NULL COMMENT '发送的内部消息ID',
  `UID` int(10) NOT NULL COMMENT '用户ID',
  `Time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_readmessage
-- ----------------------------
INSERT INTO `xb_readmessage` VALUES ('5', '73', '1', '2017-06-08 15:10:36');
INSERT INTO `xb_readmessage` VALUES ('6', '10', '2', '2017-06-09 11:07:58');
INSERT INTO `xb_readmessage` VALUES ('7', '63', '2', '2017-06-09 11:08:06');
INSERT INTO `xb_readmessage` VALUES ('8', '10', '1', '2017-10-11 17:26:27');
INSERT INTO `xb_readmessage` VALUES ('9', '10', '6', '2017-10-31 11:23:24');
INSERT INTO `xb_readmessage` VALUES ('10', '63', '6', '2017-10-31 11:23:24');
INSERT INTO `xb_readmessage` VALUES ('11', '10', '5', '2017-11-02 11:48:58');
INSERT INTO `xb_readmessage` VALUES ('12', '63', '5', '2017-11-02 11:48:58');
INSERT INTO `xb_readmessage` VALUES ('13', '10', '11', '2017-11-07 15:22:25');
INSERT INTO `xb_readmessage` VALUES ('14', '63', '11', '2017-11-07 15:22:25');
INSERT INTO `xb_readmessage` VALUES ('15', '75', '11', '2017-11-07 15:24:31');
INSERT INTO `xb_readmessage` VALUES ('16', '10', '13', '2017-11-07 17:02:58');
INSERT INTO `xb_readmessage` VALUES ('17', '63', '13', '2017-11-07 17:02:59');
INSERT INTO `xb_readmessage` VALUES ('18', '75', '13', '2017-11-07 17:02:59');
INSERT INTO `xb_readmessage` VALUES ('19', '76', '13', '2017-11-07 17:20:54');
INSERT INTO `xb_readmessage` VALUES ('20', '77', '13', '2017-11-07 17:24:33');
INSERT INTO `xb_readmessage` VALUES ('21', '78', '13', '2017-11-07 17:24:33');
INSERT INTO `xb_readmessage` VALUES ('22', '79', '13', '2017-11-07 17:24:34');
INSERT INTO `xb_readmessage` VALUES ('23', '10', '7', '2017-11-08 10:49:15');
INSERT INTO `xb_readmessage` VALUES ('24', '63', '7', '2017-11-08 10:49:15');
INSERT INTO `xb_readmessage` VALUES ('25', '75', '7', '2017-11-08 10:49:15');
INSERT INTO `xb_readmessage` VALUES ('26', '10', '16', '2017-11-08 15:50:27');
INSERT INTO `xb_readmessage` VALUES ('27', '63', '16', '2017-11-08 15:50:27');
INSERT INTO `xb_readmessage` VALUES ('28', '75', '16', '2017-11-08 15:50:27');
INSERT INTO `xb_readmessage` VALUES ('29', '80', '16', '2017-11-08 15:52:21');
INSERT INTO `xb_readmessage` VALUES ('30', '80', '11', '2017-11-08 17:07:07');
INSERT INTO `xb_readmessage` VALUES ('31', '75', '5', '2017-11-09 10:45:56');
INSERT INTO `xb_readmessage` VALUES ('32', '80', '5', '2017-11-09 10:45:56');
INSERT INTO `xb_readmessage` VALUES ('33', '10', '12', '2017-11-10 10:20:59');
INSERT INTO `xb_readmessage` VALUES ('34', '63', '12', '2017-11-10 10:20:59');
INSERT INTO `xb_readmessage` VALUES ('35', '75', '12', '2017-11-10 10:20:59');
INSERT INTO `xb_readmessage` VALUES ('36', '80', '12', '2017-11-10 10:20:59');
INSERT INTO `xb_readmessage` VALUES ('37', '10', '23', '2017-11-10 10:52:56');
INSERT INTO `xb_readmessage` VALUES ('38', '63', '23', '2017-11-10 10:52:56');
INSERT INTO `xb_readmessage` VALUES ('39', '75', '23', '2017-11-10 10:52:56');
INSERT INTO `xb_readmessage` VALUES ('40', '80', '23', '2017-11-10 10:52:56');
INSERT INTO `xb_readmessage` VALUES ('41', '75', '6', '2017-11-13 10:23:04');
INSERT INTO `xb_readmessage` VALUES ('42', '80', '6', '2017-11-13 10:23:04');
INSERT INTO `xb_readmessage` VALUES ('43', '10', '15', '2017-11-13 14:24:05');
INSERT INTO `xb_readmessage` VALUES ('44', '63', '15', '2017-11-13 14:24:05');
INSERT INTO `xb_readmessage` VALUES ('45', '75', '15', '2017-11-13 14:24:05');
INSERT INTO `xb_readmessage` VALUES ('46', '80', '15', '2017-11-13 14:24:05');
INSERT INTO `xb_readmessage` VALUES ('47', '80', '25', '2017-11-13 16:49:18');
INSERT INTO `xb_readmessage` VALUES ('48', '75', '25', '2017-11-13 16:49:18');
INSERT INTO `xb_readmessage` VALUES ('49', '63', '25', '2017-11-13 16:49:18');
INSERT INTO `xb_readmessage` VALUES ('50', '10', '25', '2017-11-13 16:49:18');
