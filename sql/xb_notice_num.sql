/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_notice_num`
-- ----------------------------
DROP TABLE IF EXISTS `xb_notice_num`;
CREATE TABLE `xb_notice_num` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UID` int(11) DEFAULT NULL COMMENT '会员id',
  `Type` tinyint(1) DEFAULT '0' COMMENT '1通知 2私信 3评论（同xb_notice_message的type类型。其中手机不需要统计）',
  `Num` int(11) DEFAULT '0' COMMENT '未读数量',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xb_notice_num
-- ----------------------------
INSERT INTO `xb_notice_num` VALUES ('1', '10', '1', '6', '2018-08-21 20:17:07');
INSERT INTO `xb_notice_num` VALUES ('3', '8', '1', '0', '2018-08-21 20:40:53');
INSERT INTO `xb_notice_num` VALUES ('4', '12', '1', '0', '2018-08-21 21:58:12');
INSERT INTO `xb_notice_num` VALUES ('5', '13', '1', '1', '2018-08-22 09:24:38');
INSERT INTO `xb_notice_num` VALUES ('6', '14', '1', '4', '2018-08-22 09:41:02');
INSERT INTO `xb_notice_num` VALUES ('7', '15', '1', '1', '2018-08-22 10:24:33');
INSERT INTO `xb_notice_num` VALUES ('8', '16', '1', '1', '2018-08-22 10:36:04');
INSERT INTO `xb_notice_num` VALUES ('11', '19', '1', '4', '2018-08-22 10:43:13');
INSERT INTO `xb_notice_num` VALUES ('13', '9', '1', '0', '2018-08-22 21:42:25');
INSERT INTO `xb_notice_num` VALUES ('14', '21', '1', '5', '2018-08-23 12:06:17');
INSERT INTO `xb_notice_num` VALUES ('15', '22', '1', '2', '2018-08-26 16:31:30');
INSERT INTO `xb_notice_num` VALUES ('16', '23', '1', '1', '2018-08-27 15:55:10');
