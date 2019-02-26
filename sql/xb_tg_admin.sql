/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:22:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_tg_admin`
-- ----------------------------
DROP TABLE IF EXISTS `xb_tg_admin`;
CREATE TABLE `xb_tg_admin` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `UserName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名(对应后台管理员表中的登录名)',
  `Kouliang` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '扣量比例%',
  `Remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `Sort` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1启用 0禁用',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='推广渠道管理';

-- ----------------------------
-- Records of xb_tg_admin
-- ----------------------------
INSERT INTO `xb_tg_admin` VALUES ('1', '马兔金融', 'matujinrong', '0.00', '18351959254', '999', '1', '0', '2', '2018-06-20 16:33:59');
INSERT INTO `xb_tg_admin` VALUES ('2', '北京汇信科技有限公司', 'huixinkeji', '86.00', '闵茂华', '999', '1', '0', '2', '2018-07-19 15:07:22');
INSERT INTO `xb_tg_admin` VALUES ('3', '同人文', 'trestrds', '0.00', 'fdsafdsa', '999', '0', '0', '2', '2018-08-26 11:26:11');
