/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_renzen_shlist`
-- ----------------------------
DROP TABLE IF EXISTS `xb_renzen_shlist`;
CREATE TABLE `xb_renzen_shlist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RenZenID` int(11) NOT NULL COMMENT '认证记录id',
  `Codes` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '代码',
  `UserID` int(11) NOT NULL COMMENT '会员ID',
  `Descs` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `Intro` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Codes` (`Codes`),
  KEY `UserID` (`UserID`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='认证审核记录';

-- ----------------------------
-- Records of xb_renzen_shlist
-- ----------------------------
INSERT INTO `xb_renzen_shlist` VALUES ('1', '2', 'card', '1', '身份证认证失败', 'df', '0', '2', '2018-06-29 10:36:05');
INSERT INTO `xb_renzen_shlist` VALUES ('2', '1', 'alipay', '2', '支付宝认证失败', 'afd', '0', '2', '2018-06-29 10:49:17');
INSERT INTO `xb_renzen_shlist` VALUES ('3', '1', 'taobao', '2', '淘宝认证通过', 'asf', '0', '2', '2018-06-29 11:10:00');
INSERT INTO `xb_renzen_shlist` VALUES ('4', '1', 'taobao', '2', '淘宝认证失败', 'adf', '0', '2', '2018-06-29 11:10:16');
INSERT INTO `xb_renzen_shlist` VALUES ('5', '1', 'memberinfo', '2', '基本信息认证通过', '1', '0', '2', '2018-06-29 13:50:16');
INSERT INTO `xb_renzen_shlist` VALUES ('6', '1', 'memberinfo', '2', '基本信息认证失败', '2', '0', '2', '2018-06-29 13:50:37');
INSERT INTO `xb_renzen_shlist` VALUES ('7', '1', 'social', '2', '社交认证通过', null, '0', '2', '2018-06-29 15:21:10');
INSERT INTO `xb_renzen_shlist` VALUES ('8', '1', 'social', '2', '社交认证失败', 's', '0', '2', '2018-06-29 15:21:21');
INSERT INTO `xb_renzen_shlist` VALUES ('9', '1', 'mobile', '2', '手机认证失败', 'df', '0', '2', '2018-06-29 16:58:54');
INSERT INTO `xb_renzen_shlist` VALUES ('10', '1', 'mobile', '2', '手机认证通过', 'adf', '0', '2', '2018-06-29 16:59:09');
INSERT INTO `xb_renzen_shlist` VALUES ('11', '1', 'bank', '1', '银行卡认证通过', 'saf', '0', '2', '2018-07-19 11:29:22');
INSERT INTO `xb_renzen_shlist` VALUES ('12', '2', 'bank', '2', '银行卡认证通过', 'sd', '0', '2', '2018-07-19 13:49:27');
INSERT INTO `xb_renzen_shlist` VALUES ('13', '2', 'bank', '2', '银行卡认证失败', 'd', '0', '2', '2018-07-19 14:11:57');
INSERT INTO `xb_renzen_shlist` VALUES ('14', '1', 'social', '2', '社交认证通过', null, '0', '2', '2018-07-25 15:25:26');
INSERT INTO `xb_renzen_shlist` VALUES ('15', '1', 'social', '8', '社交认证失败', 'aaa', '0', '2', '2018-08-25 17:57:08');
INSERT INTO `xb_renzen_shlist` VALUES ('16', '1', 'social', '8', '社交认证通过', '11', '0', '2', '2018-08-25 18:25:22');
INSERT INTO `xb_renzen_shlist` VALUES ('17', '3', 'bank', '8', '银行卡认证失败', '111', '0', '2', '2018-08-27 14:27:44');
INSERT INTO `xb_renzen_shlist` VALUES ('18', '3', 'bank', '8', '银行卡认证通过', 'qqq', '0', '2', '2018-08-27 14:30:03');
INSERT INTO `xb_renzen_shlist` VALUES ('19', '3', 'bank', '8', '银行卡认证失败', '11', '0', '2', '2018-08-28 11:53:52');
