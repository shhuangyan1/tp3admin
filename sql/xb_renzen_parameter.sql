/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_renzen_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `xb_renzen_parameter`;
CREATE TABLE `xb_renzen_parameter` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `Codes` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '代码',
  `ImgUrl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '已认证图标',
  `ImgUrl1` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '未认证图标',
  `IsShow` tinyint(4) unsigned DEFAULT '0' COMMENT '是否显示 0不显示 1显示',
  `IsMust` tinyint(4) unsigned DEFAULT '0' COMMENT '是否必备 0不必备 1必备',
  `Sort` int(11) DEFAULT '999' COMMENT '排序',
  `Intro` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Codes` (`Codes`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='认证参数表';

-- ----------------------------
-- Records of xb_renzen_parameter
-- ----------------------------
INSERT INTO `xb_renzen_parameter` VALUES ('1', '身份认证', 'card', '/Upload/image/2018-08-21/5b7becd5b90f0.png', '/Upload/image/2018-08-21/5b7becdd472a5.png', '1', '1', '1', '啊', '0', '2', '2018-08-21 18:43:43');
INSERT INTO `xb_renzen_parameter` VALUES ('2', '手机认证', 'mobile', '/Upload/image/2018-08-21/5b7bede64f9c4.png', '/Upload/image/2018-08-21/5b7bedebc47ca.png', '1', '1', '999', '', '0', '2', '2018-08-21 18:48:12');
INSERT INTO `xb_renzen_parameter` VALUES ('3', '支付宝认证', 'alipay', '/Upload/image/2018-08-21/5b7bfa3e68f19.png', '/Upload/image/2018-08-21/5b7bfa420d6cc.png', '1', '1', '999', '', '0', '2', '2018-08-21 19:40:50');
INSERT INTO `xb_renzen_parameter` VALUES ('4', '淘宝认证', 'taobao', '/Upload/image/2018-08-21/5b7bee0e3a0cd.png', '/Upload/image/2018-08-21/5b7bee151434a.png', '1', '1', '999', '', '0', '2', '2018-08-21 18:48:54');
INSERT INTO `xb_renzen_parameter` VALUES ('5', '基本信息认证', 'memberinfo', '/Upload/image/2018-08-21/5b7bed6beaa0a.png', '/Upload/image/2018-08-21/5b7bed6f7ee54.png', '1', '1', '999', '', '0', '2', '2018-08-21 18:46:08');
INSERT INTO `xb_renzen_parameter` VALUES ('6', '社交认证', 'social', '/Upload/image/2018-08-20/5b7a914a6b847.png', '/Upload/image/2018-08-20/5b7a9157ab71d.png', '1', '1', '999', '', '0', '2', '2018-08-21 08:46:44');
INSERT INTO `xb_renzen_parameter` VALUES ('7', '银行卡认证', 'bank', '/Upload/image/2018-08-21/5b7bed855df5d.png', '/Upload/image/2018-08-21/5b7bed892abc6.png', '1', '0', '999', '', '0', '2', '2018-08-21 18:46:33');
