/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_term`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_term`;
CREATE TABLE `xb_loans_term` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NumDays` int(11) DEFAULT NULL COMMENT '订单期限',
  `Applyfee` decimal(10,2) DEFAULT '0.00' COMMENT '期限费用(利息)',
  `Fastmoney` decimal(10,2) DEFAULT '0.00' COMMENT '快速申请费',
  `GuanliCost` decimal(10,2) DEFAULT '0.00' COMMENT '用户管理费',
  `ServiceCost` decimal(10,2) DEFAULT '0.00' COMMENT '续借服务费',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='借款期限';

-- ----------------------------
-- Records of xb_loans_term
-- ----------------------------
INSERT INTO `xb_loans_term` VALUES ('1', '7', '5.00', '10.00', '10.00', '10.00', '1', '1', '0', '2', '2018-08-22 11:16:32');
INSERT INTO `xb_loans_term` VALUES ('2', '14', '10.00', '20.00', '20.00', '20.00', '999', '1', '1', '2', '2018-08-21 17:37:37');
