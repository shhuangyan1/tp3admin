/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_juan_coupans`
-- ----------------------------
DROP TABLE IF EXISTS `xb_juan_coupans`;
CREATE TABLE `xb_juan_coupans` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL COMMENT '优惠劵名称',
  `Money` int(11) DEFAULT NULL COMMENT '优惠劵金额',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1 正常 0 隐藏',
  `Sort` smallint(7) DEFAULT '999' COMMENT '排序  0-999越小越靠前',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否删除 1 是 0 否',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='优惠劵管理表';

-- ----------------------------
-- Records of xb_juan_coupans
-- ----------------------------
INSERT INTO `xb_juan_coupans` VALUES ('1', '5元优惠券', '5', '1', '999', '0', '2', '2018-07-11 19:11:09');
INSERT INTO `xb_juan_coupans` VALUES ('2', '测试优惠券', '10', '1', '999', '0', '2', '2018-08-21 21:18:44');
