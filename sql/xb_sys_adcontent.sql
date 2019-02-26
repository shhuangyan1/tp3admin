/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_adcontent`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_adcontent`;
CREATE TABLE `xb_sys_adcontent` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '广告名称',
  `Pic` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '广告图片',
  `Url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '广告跳转地址',
  `AdvertisingID` int(11) DEFAULT NULL COMMENT '广告位ID',
  `Status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `Sort` int(11) DEFAULT NULL COMMENT '排序',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_adcontent
-- ----------------------------
INSERT INTO `xb_sys_adcontent` VALUES ('3', 'banner1', '/Upload/image/2018-08-18/5b77709ca062a.png', '#', '1', '1', '0', '2', '2018-08-26 17:05:40');
INSERT INTO `xb_sys_adcontent` VALUES ('4', '乐享', '/Upload/image/2018-08-18/5b77709ca062a.png', '#', '1', '1', '0', '2', '2017-10-19 21:47:44');
INSERT INTO `xb_sys_adcontent` VALUES ('5', '茶悦', '/Upload/image/2018-08-18/5b77709ca062a.png', '#', '1', '1', '0', '2', '2017-10-19 21:47:46');
INSERT INTO `xb_sys_adcontent` VALUES ('6', 'banner', '/Upload/image/2018-08-24/5b7fbca6466e4.png', '#', '1', '1', '0', '2', '2018-08-24 16:07:04');
