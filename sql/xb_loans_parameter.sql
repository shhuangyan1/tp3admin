/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_parameter`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_parameter`;
CREATE TABLE `xb_loans_parameter` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RongDay` int(11) DEFAULT NULL COMMENT '容时期期限',
  `RongP` decimal(10,2) DEFAULT '0.00' COMMENT '容时期利率',
  `OverdueDay` int(11) DEFAULT NULL COMMENT '逾时期天数',
  `OverdueP` decimal(10,2) DEFAULT '0.00' COMMENT '逾时期利率',
  `MaxRenewSum` int(11) DEFAULT NULL COMMENT '最大续借次数',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='贷款参数设置';

-- ----------------------------
-- Records of xb_loans_parameter
-- ----------------------------
INSERT INTO `xb_loans_parameter` VALUES ('1', '10', '8.00', '20', '12.00', '3', '2', '2018-08-21 20:51:53');
