/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_advertising`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_advertising`;
CREATE TABLE `xb_sys_advertising` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '广告位名称',
  `Status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `IsDel` int(11) DEFAULT '0' COMMENT '逻辑删除 0 未删除 1 已删除',
  `Sort` int(11) DEFAULT '999' COMMENT '排序',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_advertising
-- ----------------------------
INSERT INTO `xb_sys_advertising` VALUES ('1', '首页banner(954X268)', '1', '0', '0', '2', '2018-08-18 09:03:27');
