/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_dictionary`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_dictionary`;
CREATE TABLE `xb_sys_dictionary` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DictType` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '字典类型',
  `DictName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '字典名',
  `DictValue` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '字典值',
  `IsFixed` int(11) NOT NULL DEFAULT '0' COMMENT '是否是固定，默认0不固定 1 固定',
  `Status` int(11) NOT NULL DEFAULT '1' COMMENT '1默认启用，0不启用',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序字典，越小越靠前',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人  管理员ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_dictionary
-- ----------------------------
INSERT INTO `xb_sys_dictionary` VALUES ('1', '1', '正常', '1', '1', '1', '999', '2', '2017-10-19 21:47:00');
INSERT INTO `xb_sys_dictionary` VALUES ('2', '1', '隐藏', '0', '1', '1', '999', '2', '2017-10-19 21:47:03');
INSERT INTO `xb_sys_dictionary` VALUES ('3', '2', '启用', '1', '1', '1', '999', '2', '2017-10-19 21:47:06');
INSERT INTO `xb_sys_dictionary` VALUES ('4', '2', '禁用', '0', '1', '1', '999', '2', '2017-10-19 21:47:08');
INSERT INTO `xb_sys_dictionary` VALUES ('5', '4', '未发送', '0', '1', '1', '999', '2', '2017-10-19 21:47:11');
INSERT INTO `xb_sys_dictionary` VALUES ('6', '4', '已发送', '1', '1', '1', '999', '2', '2017-10-19 21:47:14');
INSERT INTO `xb_sys_dictionary` VALUES ('7', '4', '发送失败', '2', '1', '1', '999', '2', '2017-10-19 21:47:16');
INSERT INTO `xb_sys_dictionary` VALUES ('8', '5', '系统发送', '0', '1', '1', '999', '2', '2017-10-19 21:47:19');
INSERT INTO `xb_sys_dictionary` VALUES ('9', '5', '手工发送', '1', '1', '1', '999', '2', '2017-10-19 21:47:21');
INSERT INTO `xb_sys_dictionary` VALUES ('11', '6', '内部消息', '0', '1', '1', '999', '2', '2017-10-19 21:47:27');
INSERT INTO `xb_sys_dictionary` VALUES ('12', '6', '手机短信', '1', '1', '1', '999', '2', '2017-10-19 21:47:29');
INSERT INTO `xb_sys_dictionary` VALUES ('13', '6', '短信&amp;amp;消息', '2', '1', '1', '999', '2', '2017-10-19 21:47:31');
