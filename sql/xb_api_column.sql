/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_api_column`
-- ----------------------------
DROP TABLE IF EXISTS `xb_api_column`;
CREATE TABLE `xb_api_column` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `ParentID` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `Sort` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_api_column
-- ----------------------------
INSERT INTO `xb_api_column` VALUES ('1', '会员中心', '0', '1', '1', '2', '2017-12-13 11:17:25');
INSERT INTO `xb_api_column` VALUES ('2', '短信', '0', '999', '1', '2', '2017-12-13 11:23:05');
INSERT INTO `xb_api_column` VALUES ('3', '登录注册', '0', '999', '1', '2', '2017-12-13 11:21:57');
INSERT INTO `xb_api_column` VALUES ('6', '公共接口', '0', '999', '1', '2', '2017-12-13 11:29:53');
INSERT INTO `xb_api_column` VALUES ('7', '新闻资讯', '0', '999', '1', '2', '2018-06-14 15:11:26');
INSERT INTO `xb_api_column` VALUES ('8', '会员信息', '1', '999', '1', '2', '2018-06-14 15:12:17');
INSERT INTO `xb_api_column` VALUES ('9', '会员消息', '1', '999', '1', '2', '2018-06-14 15:12:32');
INSERT INTO `xb_api_column` VALUES ('10', '认证管理', '0', '999', '1', '2', '2018-07-14 15:36:12');
INSERT INTO `xb_api_column` VALUES ('11', '首页接口', '0', '999', '1', '2', '2018-07-14 18:56:49');
INSERT INTO `xb_api_column` VALUES ('12', '会员中心', '1', '999', '1', '2', '2018-07-16 10:33:44');
INSERT INTO `xb_api_column` VALUES ('13', '订单相关', '1', '999', '1', '2', '2018-07-16 14:00:20');
