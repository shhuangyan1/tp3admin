/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_smstemplates`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_smstemplates`;
CREATE TABLE `xb_sys_smstemplates` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '短信标题',
  `EName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '模板英文名称，短信发送时传递的参数',
  `Content` text COLLATE utf8_bin COMMENT '短信内容',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '模板状态 0 禁用 1  启用',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序字段',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 1 删除 0 未删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_smstemplates
-- ----------------------------
INSERT INTO `xb_sys_smstemplates` VALUES ('1', '提醒消息', 'system', 0xE5B08AE695ACE79A84E794A8E688B7EFBC8CE682A8E6B3A8E5868CE79A84E79FADE4BFA1E9AA8CE8AF81E7A081E698AF7B24E9AA8CE8AF81E7A0817DEFBC8CE8AFB7E6ADA3E7A1AEE8BE93E585A5E5B9B6E5AE8CE68890E5908EE7BBADE6938DE4BD9CE38082E6849FE8B0A2E682A8E79A84E9858DE59088EFBC81, '1', '99', '0', '1', '2017-05-24 15:53:03');
INSERT INTO `xb_sys_smstemplates` VALUES ('2', '提醒', 'note', 0xE5B08AE695ACE79A84E794A8E688B7EFBC8CE682A8E6B3A8E5868CE79A84E79FADE4BFA1E9AA8CE8AF81E7A081E698AF7B24E9AA8CE8AF81E7A0817DEFBC8CE8AFB7E6ADA3E7A1AEE8BE93E585A5E5B9B6E5AE8CE68890E5908EE7BBADE6938DE4BD9CE38082E6849FE8B0A2E682A8E79A84E9858DE59088EFBC81, '1', '99', '0', '1', '2017-05-24 15:52:55');
INSERT INTO `xb_sys_smstemplates` VALUES ('3', '提醒f', 'code', 0xE4BDA0E5A5BDEFBC8CE4BDA0E79A84E9AA8CE8AF81E7A081E698AF7B534D535FE9AA8CE8AF81E7A0817D, '1', '999', '1', '1', '2017-05-24 15:52:50');
INSERT INTO `xb_sys_smstemplates` VALUES ('4', '111', 'qqq', 0x64736473, '1', '999', '1', '1', '2017-06-02 14:54:24');
