/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_mem_banktype`
-- ----------------------------
DROP TABLE IF EXISTS `xb_mem_banktype`;
CREATE TABLE `xb_mem_banktype` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '银行名称',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 0未删除 1已删除',
  `Sort` int(4) DEFAULT '999' COMMENT '排序，0-999越小越靠前',
  `OperaterID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='银行卡类别';

-- ----------------------------
-- Records of xb_mem_banktype
-- ----------------------------
INSERT INTO `xb_mem_banktype` VALUES ('1', '邮政储蓄银行', '1', '0', '998', '2', '2018-07-04 17:12:27');
INSERT INTO `xb_mem_banktype` VALUES ('2', '中国银行', '1', '0', '999', '2', '2018-07-04 16:22:38');
