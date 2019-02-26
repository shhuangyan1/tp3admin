/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sms_code`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sms_code`;
CREATE TABLE `xb_sms_code` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(126) CHARACTER SET utf8mb4 NOT NULL COMMENT '账号 手机号 邮件',
  `Type` int(2) DEFAULT '0' COMMENT '类型 手机0 邮件1',
  `Code` varchar(20) COLLATE utf8_bin DEFAULT '' COMMENT '验证码',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `AddTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sms_code
-- ----------------------------
INSERT INTO `xb_sms_code` VALUES ('133', '18130046266', '0', '989925', '2017-12-13 10:51:11', null);
INSERT INTO `xb_sms_code` VALUES ('150', '17602186118', '0', '601447', '2017-12-13 11:42:43', null);
INSERT INTO `xb_sms_code` VALUES ('156', '13524311277', '0', '329845', '2017-12-13 13:01:03', null);
INSERT INTO `xb_sms_code` VALUES ('173', '13505609484', '0', '863384', '2017-12-18 16:10:56', null);
INSERT INTO `xb_sms_code` VALUES ('174', '15665697298', '0', '580373', '2017-12-19 16:07:26', null);
INSERT INTO `xb_sms_code` VALUES ('178', '18355195990', '0', '209075', '2018-07-27 08:53:48', null);
INSERT INTO `xb_sms_code` VALUES ('180', '17755122594', '0', '151710', '2018-08-20 13:53:12', null);
INSERT INTO `xb_sms_code` VALUES ('182', '18365266892', '0', '908271', '2018-08-20 14:02:48', null);
INSERT INTO `xb_sms_code` VALUES ('184', '15856966203', '0', '614349', '2018-08-21 18:38:31', null);
INSERT INTO `xb_sms_code` VALUES ('186', '15256553522', '0', '837045', '2018-08-21 20:23:45', null);
INSERT INTO `xb_sms_code` VALUES ('187', '13961089009', '0', '238771', '2018-08-21 21:57:56', null);
INSERT INTO `xb_sms_code` VALUES ('188', '18656474098', '0', '132156', '2018-08-22 09:24:11', null);
INSERT INTO `xb_sms_code` VALUES ('189', '13535316072', '0', '173133', '2018-08-22 09:40:38', null);
INSERT INTO `xb_sms_code` VALUES ('190', '17315670205', '0', '209527', '2018-08-22 10:24:14', null);
INSERT INTO `xb_sms_code` VALUES ('191', '17520074491', '0', '780200', '2018-08-22 10:35:48', null);
INSERT INTO `xb_sms_code` VALUES ('194', '18877310084', '0', '660089', '2018-08-22 10:42:57', null);
INSERT INTO `xb_sms_code` VALUES ('195', '18225901593', '0', '705376', '2018-08-22 10:48:54', null);
INSERT INTO `xb_sms_code` VALUES ('196', '13814454042', '0', '196372', '2018-08-23 12:05:45', null);
INSERT INTO `xb_sms_code` VALUES ('197', '13040164693', '0', '104279', '2018-08-26 16:31:07', null);
INSERT INTO `xb_sms_code` VALUES ('198', '13385607663', '0', '563325', '2018-08-27 15:54:58', null);
