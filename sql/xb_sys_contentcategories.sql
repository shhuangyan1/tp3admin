/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_contentcategories`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_contentcategories`;
CREATE TABLE `xb_sys_contentcategories` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `ParentID` int(11) NOT NULL DEFAULT '0' COMMENT '父级id',
  `Sort` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `IsRec` tinyint(2) DEFAULT '0' COMMENT '是否推荐1推荐 0不推荐',
  `ColumnType` int(11) DEFAULT '1' COMMENT '栏目类型 1 栏目 0 单页',
  `AllowDelete` tinyint(2) DEFAULT NULL COMMENT '允许删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `Ename` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '英文标识  不允许为空',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_contentcategories
-- ----------------------------
INSERT INTO `xb_sys_contentcategories` VALUES ('1', '公司简介', '0', '999', '1', '1', '0', '0', '2', '2018-07-11 09:18:21', 'gsjj');
INSERT INTO `xb_sys_contentcategories` VALUES ('2', '关于我们', '1', '999', '1', '0', '0', '0', '2', '2018-07-11 09:19:22', 'gywm');
INSERT INTO `xb_sys_contentcategories` VALUES ('3', '新闻资讯', '0', '999', '1', '0', '1', '1', '31', '2017-06-06 19:51:38', 'xwzx');
INSERT INTO `xb_sys_contentcategories` VALUES ('4', '发现', '3', '999', '1', '0', '1', '1', '2', '2018-08-18 09:32:07', 'xwlm');
INSERT INTO `xb_sys_contentcategories` VALUES ('8', '注册协议', '1', '999', '1', '0', '0', '0', '2', '2018-07-11 13:46:16', 'lxwm');
INSERT INTO `xb_sys_contentcategories` VALUES ('12', '通知公告', '3', '999', '1', '0', '1', '1', '2', '2018-08-18 16:20:37', '4wfds');
INSERT INTO `xb_sys_contentcategories` VALUES ('14', '常见问题', '16', '999', '1', '0', '1', '0', '2', '2018-08-18 16:21:27', 'problem');
INSERT INTO `xb_sys_contentcategories` VALUES ('16', '帮助中心', '0', '999', '1', '0', '1', '1', '2', '2018-07-11 13:52:10', 'help');
INSERT INTO `xb_sys_contentcategories` VALUES ('18', '借款合同', '0', '999', '1', '0', '0', '0', '2', '2018-08-19 11:47:46', 'sell');
INSERT INTO `xb_sys_contentcategories` VALUES ('19', '借款合同字段说明', '16', '999', '1', '0', '0', '0', '2', '2018-08-19 11:47:58', 'des');
INSERT INTO `xb_sys_contentcategories` VALUES ('20', '版本介绍', '1', '999', '1', '0', '0', '0', '2', '2018-07-17 11:49:04', 'banbendetail');
INSERT INTO `xb_sys_contentcategories` VALUES ('21', '续借协议', '16', '999', '1', '0', '0', '0', '2', '2018-08-06 09:46:51', 'xujiexy');
INSERT INTO `xb_sys_contentcategories` VALUES ('22', '借款协议', '16', '999', '1', '0', '0', '0', '2', '2018-08-19 11:51:39', 'jkxy');
