/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_dictype`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_dictype`;
CREATE TABLE `xb_sys_dictype` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `EName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '英文名称',
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '字典类别名称',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_dictype
-- ----------------------------
INSERT INTO `xb_sys_dictype` VALUES ('1', 'is_normal', '正常隐藏状态');
INSERT INTO `xb_sys_dictype` VALUES ('2', 'is_disable', '启用禁用状态');
INSERT INTO `xb_sys_dictype` VALUES ('3', 'open_type', '窗口打开方式');
INSERT INTO `xb_sys_dictype` VALUES ('4', 'send_status', '短信发送状态');
INSERT INTO `xb_sys_dictype` VALUES ('5', 'send_type', '短信发送类型');
INSERT INTO `xb_sys_dictype` VALUES ('6', 'receive_mode', '消息接收方式');
