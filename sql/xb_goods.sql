/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_goods`
-- ----------------------------
DROP TABLE IF EXISTS `xb_goods`;
CREATE TABLE `xb_goods` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SalePrice` decimal(10,2) DEFAULT '0.00' COMMENT '借款金额',
  `JSMoney` decimal(10,2) DEFAULT '0.00' COMMENT '解锁额度',
  `Interest` decimal(10,2) DEFAULT '0.00' COMMENT '利息',
  `Fastmoney` decimal(10,2) DEFAULT '0.00' COMMENT '快速申请费',
  `GuanliCost` decimal(10,2) DEFAULT '0.00' COMMENT '用户管理费',
  `ServiceCost` decimal(10,2) DEFAULT '0.00' COMMENT '续借服务费',
  `Desname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `CashCoupon` tinyint(4) DEFAULT '1' COMMENT '能否用优惠劵 1能 2不能',
  `IsShelves` int(11) DEFAULT '0' COMMENT '是否上架: 0 未上架 1 已上架',
  `IsDel` int(11) DEFAULT '0' COMMENT '逻辑删除: 0 未删除 1 已删除',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `IsShelves` (`IsShelves`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='借款产品表';

-- ----------------------------
-- Records of xb_goods
-- ----------------------------
INSERT INTO `xb_goods` VALUES ('2', '500.00', '0.00', '5.00', '50.00', '50.00', '10.00', '极速到账', '1', '1', '1', '1', '2', '2018-08-22 14:15:59');
INSERT INTO `xb_goods` VALUES ('3', '1000.00', '0.00', '10.00', '100.00', '100.00', '20.00', '极速到账', '1', '1', '1', '2', '2', '2018-08-22 14:16:04');
INSERT INTO `xb_goods` VALUES ('4', '1500.00', '0.00', '15.00', '150.00', '150.00', '30.00', '极速到账', '1', '1', '1', '3', '2', '2018-08-22 14:16:09');
INSERT INTO `xb_goods` VALUES ('5', '3000.00', '3000.00', '20.00', '200.00', '200.00', '40.00', '极速到账', '1', '1', '0', '999', '2', '2018-08-25 11:34:24');
INSERT INTO `xb_goods` VALUES ('6', '500.00', '0.00', '20.00', '200.00', '200.00', '20.00', '极速到账', '1', '1', '0', '999', '2', '2018-08-23 14:02:51');
INSERT INTO `xb_goods` VALUES ('7', '4000.00', '0.00', '20.00', '200.00', '200.00', '40.00', '极速到账', '1', '1', '0', '999', '2', '2018-08-25 11:37:03');
