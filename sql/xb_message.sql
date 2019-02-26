/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_message`
-- ----------------------------
DROP TABLE IF EXISTS `xb_message`;
CREATE TABLE `xb_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Uid` int(11) DEFAULT '0',
  `Pic` text COLLATE utf8_bin COMMENT '图片',
  `Lead` text COLLATE utf8_bin,
  `Addtime` varchar(100) COLLATE utf8_bin DEFAULT '',
  `States` int(1) DEFAULT '0' COMMENT '查看状态 0未读 1已读',
  `StatesDes` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '处理描述',
  `UpdateTime` datetime DEFAULT NULL COMMENT '查看时间',
  `OperatorID` int(11) DEFAULT '0' COMMENT '查看人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_message
-- ----------------------------
INSERT INTO `xb_message` VALUES ('1', '1', 0x2F55706C6F61642F696D6167652F32303137303831382F313530333031353734323430333337392E6A70672C2F55706C6F61642F696D6167652F32303137303831382F313530333031393036393130323039372E6A7067, 0xE6849FE8A789E4B88DE6808EE4B988E5A5BD, '2018-06-15 14:26:09', '1', null, '2018-06-15 14:30:35', '2');
INSERT INTO `xb_message` VALUES ('2', '9', null, 0x3371, '2018-08-21 10:04:16', '0', null, null, '0');
INSERT INTO `xb_message` VALUES ('3', '10', null, 0xE6B58BE8AF953A20E6898BE69CBAE58FB7E7A081202031353820303030302030303030, '2018-08-21 19:34:18', '1', '工作', '2018-08-21 19:35:53', '2');
INSERT INTO `xb_message` VALUES ('4', '12', null, 0xE5B9B2E595A5E8AEBEE5A487, '2018-08-26 17:44:18', '1', 'fhtfj ', '2018-08-26 17:44:38', '2');
