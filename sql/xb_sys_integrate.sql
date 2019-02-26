/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_integrate`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_integrate`;
CREATE TABLE `xb_sys_integrate` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '平台名称',
  `EName` varchar(255) COLLATE utf8_bin NOT NULL,
  `Intro` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '平台介绍',
  `Type` int(11) DEFAULT '0' COMMENT '平台类别 0 短信平台 1 支付平台 2 第三方登录平台 3存储接口 4认证接口',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `IsDefault` int(11) DEFAULT '0' COMMENT '是否默认 0  否 1  是',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_integrate
-- ----------------------------
INSERT INTO `xb_sys_integrate` VALUES ('1', '螺丝帽', 'luosimao', '一家上海的短信平台，短信模板不需要审核', '0', '1', '1', '2', '2018-08-20 11:58:04');
INSERT INTO `xb_sys_integrate` VALUES ('5', 'QQ互联', 'qqconect', 'QQ互联', '2', '1', '1', '31', '2017-09-27 15:29:06');
INSERT INTO `xb_sys_integrate` VALUES ('6', '七牛云存储接口', 'qiniu', '一家云存储提供商', '3', '1', '1', '31', '2017-09-27 15:29:41');
INSERT INTO `xb_sys_integrate` VALUES ('7', '支付宝', 'alipayjsapi', '支付宝jsapi支付', '1', '0', '0', '2', '2018-08-01 19:20:59');
INSERT INTO `xb_sys_integrate` VALUES ('8', '微信支付', 'weixinjsapi', '微信jsapi支付接口', '1', '0', '0', '2', '2018-08-01 19:21:10');
INSERT INTO `xb_sys_integrate` VALUES ('9', '身份认证(有盾)', 'card', '也是人脸识别', '4', '1', '0', '2', '2018-07-04 08:37:34');
INSERT INTO `xb_sys_integrate` VALUES ('10', '手机认证', 'mobile', '数聚魔盒', '4', '1', '0', '2', '2018-07-12 08:26:31');
INSERT INTO `xb_sys_integrate` VALUES ('11', '融宝支付', 'rongbao', '第三方支付', '1', '0', '0', '2', '2018-08-20 15:58:16');
INSERT INTO `xb_sys_integrate` VALUES ('12', '253云通讯', 'yuntongxun', '短信平台', '0', '0', '0', '2', '2018-08-20 11:57:41');
INSERT INTO `xb_sys_integrate` VALUES ('13', '富友支付', 'fuyou', '第三方支付公司', '1', '1', '1', '2', '2018-08-20 15:58:07');
