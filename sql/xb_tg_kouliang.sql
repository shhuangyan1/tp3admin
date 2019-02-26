/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:22:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_tg_kouliang`
-- ----------------------------
DROP TABLE IF EXISTS `xb_tg_kouliang`;
CREATE TABLE `xb_tg_kouliang` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Tgadmin` int(11) DEFAULT NULL COMMENT '渠道id',
  `Kouliang` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT '扣量比例%',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1启用 0禁用',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `AddTime` int(11) DEFAULT NULL COMMENT '创建时间',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Tgadmin` (`Tgadmin`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='扣量管理';

-- ----------------------------
-- Records of xb_tg_kouliang
-- ----------------------------
INSERT INTO `xb_tg_kouliang` VALUES ('1', '1', '100.00', '1', '0', '1529483617', '2', '2018-06-20 16:33:37');
INSERT INTO `xb_tg_kouliang` VALUES ('2', '2', '50.00', '1', '0', '1529477593', '2', '2018-06-20 14:53:13');
