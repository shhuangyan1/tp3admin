/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_accounts`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_accounts`;
CREATE TABLE `xb_sys_accounts` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '账号名称',
  `Types` tinyint(4) DEFAULT '1' COMMENT '类型 1支付宝 2微信 3银联',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(4) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账号设置表';

-- ----------------------------
-- Records of xb_sys_accounts
-- ----------------------------
INSERT INTO `xb_sys_accounts` VALUES ('1', '6217001640009656048', '3', '999', '1', '0', '2', '2018-07-10 16:28:18');
INSERT INTO `xb_sys_accounts` VALUES ('2', '13024073830', '1', '999', '1', '0', '2', '2018-07-10 16:28:29');
INSERT INTO `xb_sys_accounts` VALUES ('3', 'weixin123', '2', '999', '1', '0', '2', '2018-07-10 16:28:40');
