/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_mem_bank`
-- ----------------------------
DROP TABLE IF EXISTS `xb_mem_bank`;
CREATE TABLE `xb_mem_bank` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `BankCode` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '银行卡号',
  `BankType` int(11) NOT NULL COMMENT '银行卡类型 与BankType表关联',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `UserID` int(11) NOT NULL COMMENT '添加人，与会员表关联',
  `OperaterID` tinyint(4) DEFAULT NULL COMMENT '审核人，与后台管理员表关联',
  `AuditTime` datetime DEFAULT NULL COMMENT '审核时间',
  `AuditStatus` int(11) DEFAULT '0' COMMENT '审核状态 0未审核 1审核通过 2审核失败',
  `Remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '审核备注内容',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 0未删除 1已删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='会员银行卡管理表';

-- ----------------------------
-- Records of xb_mem_bank
-- ----------------------------
INSERT INTO `xb_mem_bank` VALUES ('1', '87965465465323', '1', '2018-07-04 16:34:19', '2', '2', '2018-07-04 17:02:34', '1', null, '0');
INSERT INTO `xb_mem_bank` VALUES ('2', '123456789', '2', null, '2', '2', null, '1', null, '0');
