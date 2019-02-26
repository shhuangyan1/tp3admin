/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_propertyset`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_propertyset`;
CREATE TABLE `xb_sys_propertyset` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '属性名称',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(4) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='属性设置';

-- ----------------------------
-- Records of xb_sys_propertyset
-- ----------------------------
INSERT INTO `xb_sys_propertyset` VALUES ('1', '职业', '999', '1', '0', '2', '2018-07-04 10:38:06');
INSERT INTO `xb_sys_propertyset` VALUES ('2', '收入', '999', '1', '0', '2', '2018-07-04 10:38:12');
INSERT INTO `xb_sys_propertyset` VALUES ('3', '亲属关系', '999', '1', '0', '2', '2018-07-04 10:39:35');
INSERT INTO `xb_sys_propertyset` VALUES ('4', '社会关系', '999', '1', '0', '2', '2018-07-04 10:38:40');
INSERT INTO `xb_sys_propertyset` VALUES ('5', '学历', '999', '1', '0', '2', '2018-07-04 10:38:49');
