/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:18:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_renzen_bank`
-- ----------------------------
DROP TABLE IF EXISTS `xb_renzen_bank`;
CREATE TABLE `xb_renzen_bank` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '会员ID',
  `OrderSn` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '订单编号',
  `BankNo` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '银行卡号',
  `YMobile` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '预留手机号码',
  `BankName` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '开户银行',
  `OpenBankName` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '开户行名称',
  `Address` varchar(124) CHARACTER SET utf8 DEFAULT NULL COMMENT '开户行地址',
  `ProvinceID` int(11) DEFAULT '0' COMMENT '省份id',
  `CityID` int(11) DEFAULT '0' COMMENT '城市id',
  `CountyID` int(11) DEFAULT '0' COMMENT '区域id',
  `Status` tinyint(4) DEFAULT '0' COMMENT '状态:0待审核 1已认证 2认证失败',
  `RenzTime` datetime DEFAULT NULL COMMENT '认证时间',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `UserID` (`UserID`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='银行卡认证表';

-- ----------------------------
-- Records of xb_renzen_bank
-- ----------------------------
INSERT INTO `xb_renzen_bank` VALUES ('1', '1', null, '6222021302027935989', '18355195991', '招商', '招商银行', '合肥市瑶海区火车站', '0', '0', '0', '1', null, '0', '2', '2018-07-19 11:29:22');
INSERT INTO `xb_renzen_bank` VALUES ('2', '9', null, '6217001630010900410', '17755122594', null, '建设银行', '北京市市辖区东城区', '2', '3', '4', '1', '2018-08-25 18:18:14', '0', null, '2018-08-25 18:18:14');
INSERT INTO `xb_renzen_bank` VALUES ('3', '8', null, '6222021313005859687', '18365266892', null, '发发发', '北京市市辖区东城区', '2', '3', '4', '2', '2018-08-25 18:44:57', '0', '2', '2018-08-28 11:53:52');
