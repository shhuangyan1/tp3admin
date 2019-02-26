/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:18:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_renzen_alipay`
-- ----------------------------
DROP TABLE IF EXISTS `xb_renzen_alipay`;
CREATE TABLE `xb_renzen_alipay` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '会员ID',
  `TaskID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '淘宝认证',
  `ZFBMobile` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '绑定号码',
  `BankSum` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '银行卡数量',
  `Email` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱账号',
  `Balance` decimal(10,2) DEFAULT '0.00' COMMENT '支付宝额度',
  `HuabeiLimit` decimal(10,2) DEFAULT '0.00' COMMENT '花呗额度',
  `HuabeiRet` decimal(10,2) DEFAULT '0.00' COMMENT '花呗还款额度',
  `HuabeiBalance` decimal(10,2) DEFAULT '0.00' COMMENT '花呗可用额度',
  `TaobaoName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '淘宝会员名',
  `Status` tinyint(4) DEFAULT '0' COMMENT '状态:0待审核 1已认证 2认证失败',
  `RenzTime` datetime DEFAULT NULL COMMENT '认证时间',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `UserID` (`UserID`),
  KEY `IsDel` (`IsDel`),
  KEY `TaskID` (`TaskID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='支付宝认证表';

-- ----------------------------
-- Records of xb_renzen_alipay
-- ----------------------------
INSERT INTO `xb_renzen_alipay` VALUES ('1', '8', 'TASKDS000004201808210854391201880149', '183******92', '3', '18365266892@163.com', '0.00', '0.00', '0.00', '0.00', '孤独的小川0', '1', '2018-08-21 08:54:55', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('2', '9', 'TASKDS000004201808211113251201770092', '', '1', null, '0.00', '0.00', '0.00', '0.00', null, '1', '2018-08-21 11:16:21', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('3', '10', 'TASKDS000004201808211857440072260268', '158******03', '2', '15856966203@163.com', '0.00', '0.00', '0.00', '0.00', '蜗牛1782303444', '1', '2018-08-21 18:59:38', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('5', '16', 'TASKDS000004201808221048281201930287', '189******23', '3', '664531526@qq.com', '0.00', '0.00', '0.00', '0.00', '抽不出孤独感', '1', '2018-08-22 10:50:31', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('6', '19', 'TASKDS000004201808221051171332080314', '188******84', '3', '583325465@qq.com', '0.00', '0.00', '0.00', '0.00', 'a甘正传', '1', '2018-08-22 10:53:02', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('7', '14', 'TASKDS000004201808221115031201780109', '135******72', '3', null, '0.00', '0.00', '0.00', '0.00', '林良庚', '1', '2018-08-22 11:16:52', '0', null, null);
INSERT INTO `xb_renzen_alipay` VALUES ('8', '21', 'TASKDS000004201808231210261201770067', '138******42', '10', '13619001916@163.com', '0.00', '0.00', '0.00', '0.00', 'tb4464991_2012', '1', '2018-08-23 12:10:39', '0', null, null);
