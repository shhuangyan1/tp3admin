/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_links`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_links`;
CREATE TABLE `xb_sys_links` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '友情连接名称',
  `Url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '连接地址',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0表示不正常 1正常',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人，管理员ID',
  `UpdateTime` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_links
-- ----------------------------
INSERT INTO `xb_sys_links` VALUES ('21', '1234511f', 'http://www.baidu.com/', '123', '0', '1', '2017-04-26 17:26:58');
INSERT INTO `xb_sys_links` VALUES ('27', '123', '123', '123', '1', '1', '2017-04-26 17:26:26');
INSERT INTO `xb_sys_links` VALUES ('29', 'fds', 'fd', '0', '1', '1', '2017-04-26 17:26:32');
INSERT INTO `xb_sys_links` VALUES ('30', 'fd', 'fds', '0', '1', '1', '2017-04-26 15:49:57');
INSERT INTO `xb_sys_links` VALUES ('31', '123', '123', '123', '1', '1', '2017-04-27 08:45:31');
INSERT INTO `xb_sys_links` VALUES ('32', 'fd', 'fd', '0', '1', '1', '2017-04-27 09:51:29');
INSERT INTO `xb_sys_links` VALUES ('33', '11', '11', '0', '1', '1', '2017-04-27 09:53:14');
INSERT INTO `xb_sys_links` VALUES ('34', '22', '22', '0', '1', '1', '2017-04-27 09:53:18');
INSERT INTO `xb_sys_links` VALUES ('35', '232', '32', '0', '1', '1', '2017-04-27 09:53:26');
INSERT INTO `xb_sys_links` VALUES ('36', '32', '32', '0', '1', '1', '2017-04-27 09:53:29');
INSERT INTO `xb_sys_links` VALUES ('37', '32', '32', '0', '1', '1', '2017-04-27 09:53:32');
INSERT INTO `xb_sys_links` VALUES ('38', '123', '1321', '0', '1', '1', '2017-04-27 09:53:45');
INSERT INTO `xb_sys_links` VALUES ('39', '12313', '45646', '0', '0', '1', '2017-05-10 09:08:08');
INSERT INTO `xb_sys_links` VALUES ('40', '45456', '456456', '0', '1', '1', '2017-04-27 09:53:58');
INSERT INTO `xb_sys_links` VALUES ('41', '456', '45654', '0', '1', '1', '2017-04-27 09:54:04');
INSERT INTO `xb_sys_links` VALUES ('42', '456', '123', '0', '1', '1', '2017-04-27 09:54:10');
INSERT INTO `xb_sys_links` VALUES ('43', '456', '456', '0', '1', '1', '2017-04-27 09:54:18');
INSERT INTO `xb_sys_links` VALUES ('44', '456', '456', '0', '1', '1', '2017-04-27 09:54:24');
INSERT INTO `xb_sys_links` VALUES ('45', '456', '45645', '0', '1', '1', '2017-04-27 09:54:32');
INSERT INTO `xb_sys_links` VALUES ('46', '45645', '4564', '0', '1', '1', '2017-04-27 09:54:39');
INSERT INTO `xb_sys_links` VALUES ('47', '45656', '456456', '0', '1', '1', '2017-04-27 09:54:46');
INSERT INTO `xb_sys_links` VALUES ('48', '465456', '4564', '0', '1', '1', '2017-04-27 09:54:54');
INSERT INTO `xb_sys_links` VALUES ('49', '4564', '123123', '0', '1', '1', '2017-04-27 09:55:03');
INSERT INTO `xb_sys_links` VALUES ('53', null, '123', '0', '1', null, '0000-00-00 00:00:00');
INSERT INTO `xb_sys_links` VALUES ('55', 'fd', 'f', '999', '1', '1', '2017-05-05 11:48:39');
INSERT INTO `xb_sys_links` VALUES ('56', 'fds', 'fds', '0', '1', '1', '2017-05-11 19:14:11');
INSERT INTO `xb_sys_links` VALUES ('57', 'fds', 'fds', '0', '1', '1', '2017-05-11 19:14:14');
INSERT INTO `xb_sys_links` VALUES ('58', 'fsd', 'fds', '0', '1', '1', '2017-05-11 19:14:19');
