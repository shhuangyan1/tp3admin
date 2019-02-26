/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_paylist`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_paylist`;
CREATE TABLE `xb_loans_paylist` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '会员ID',
  `OrderSn` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '订单编号',
  `LoanNo` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '申请号',
  `TradeNo` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '交易流水号',
  `TradeType` int(11) DEFAULT '1' COMMENT '类型 1续借 2还款 3放款 4购买商品',
  `OrderAmount` decimal(10,2) DEFAULT '0.00' COMMENT '金额',
  `PayType` int(1) DEFAULT '0' COMMENT '付款方式  未付款 1支付宝 2微信 3银联 4代付',
  `PayStatus` tinyint(4) unsigned DEFAULT '0' COMMENT '支付状态 0待支付 1已支付',
  `Description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '变更描述',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='支付记录表';

-- ----------------------------
-- Records of xb_loans_paylist
-- ----------------------------
INSERT INTO `xb_loans_paylist` VALUES ('1', '9', '1808218145332445', '1808216142150118', null, '2', '2025.00', '1', '1', '客户还款', '0', '2', '2018-08-21 14:54:34');
INSERT INTO `xb_loans_paylist` VALUES ('2', '9', '1808219145539982', '1808216145503919', null, '2', '2025.00', '2', '1', '客户还款', '0', '2', '2018-08-21 14:55:49');
INSERT INTO `xb_loans_paylist` VALUES ('3', '9', '1808211151531559', '1808214145723579', null, '2', '1525.00', '1', '1', '客户还款', '0', '2', '2018-08-21 15:15:48');
INSERT INTO `xb_loans_paylist` VALUES ('4', '8', '1808211155737169', '1808211114835813', null, '2', '1005.00', '2', '1', '客户还款', '0', '2', '2018-08-21 17:20:57');
INSERT INTO `xb_loans_paylist` VALUES ('5', '9', '1808211172133504', '1808212151730447', null, '2', '2030.00', '1', '1', '客户还款', '0', '2', '2018-08-21 17:22:11');
INSERT INTO `xb_loans_paylist` VALUES ('6', '8', '1808215173130277', '1808215173009415', null, '2', '2010.00', '1', '1', '客户还款', '0', '2', '2018-08-21 17:31:39');
INSERT INTO `xb_loans_paylist` VALUES ('7', '9', '1808219185011773', '1808217184831321', null, '2', '2030.00', '1', '1', '客户还款', '0', '2', '2018-08-21 18:50:34');
INSERT INTO `xb_loans_paylist` VALUES ('8', '10', '1808219192521134', '1808213191745390', null, '2', '510.00', '2', '1', '客户还款', '0', '2', '2018-08-21 19:33:41');
INSERT INTO `xb_loans_paylist` VALUES ('9', '10', '1808218201545606', '1808218195918880', null, '2', '830.00', '2', '1', '客户还款', '0', '2', '2018-08-21 20:17:06');
INSERT INTO `xb_loans_paylist` VALUES ('10', '10', '1808211205625978', '1808212202943595', null, '2', '515.00', '2', '1', '客户还款', '0', '2', '2018-08-21 20:56:31');
INSERT INTO `xb_loans_paylist` VALUES ('12', '10', '1808213212325556', '1808216212005675', null, '2', '1010.00', '1', '1', '客户还款', '0', '2', '2018-08-21 21:23:38');
INSERT INTO `xb_loans_paylist` VALUES ('14', '10', '1808213214027977', '1808212213924545', null, '2', '1020.00', '1', '1', '客户还款', '0', '2', '2018-08-21 21:40:33');
INSERT INTO `xb_loans_paylist` VALUES ('17', '10', '1808212214227727', '1808212214054287', null, '2', '2055.00', '1', '1', '客户还款', '0', '2', '2018-08-21 21:42:46');
INSERT INTO `xb_loans_paylist` VALUES ('18', '10', '1808217215032291', '1808212214941481', null, '2', '510.00', '1', '1', '客户还款', '0', '2', '2018-08-21 21:50:37');
INSERT INTO `xb_loans_paylist` VALUES ('19', '10', '1808227105734453', '1808211215049912', null, '2', '670.00', '1', '1', '客户还款', '0', '2', '2018-08-22 10:57:46');
INSERT INTO `xb_loans_paylist` VALUES ('21', '10', '1808227112259140', '1808222111725873', null, '2', '1015.00', '2', '1', '客户还款', '0', '2', '2018-08-22 11:23:08');
INSERT INTO `xb_loans_paylist` VALUES ('27', '9', '1808227214500276', '1808226214216827', null, '2', '1520.00', '1', '1', '客户还款', '0', '2', '2018-08-22 21:45:20');
INSERT INTO `xb_loans_paylist` VALUES ('29', '8', '1808239133841926', '1808217204036599', null, '2', '2030.00', '1', '1', '客户还款', '0', '2', '2018-08-23 13:38:49');
INSERT INTO `xb_loans_paylist` VALUES ('30', '10', '1808235134806651', '1808223141439639', null, '2', '590.00', '1', '1', '客户还款', '0', '2', '2018-08-23 13:48:45');
INSERT INTO `xb_loans_paylist` VALUES ('31', '8', '1808233190752416', '1808239190505688', null, '2', '525.00', '1', '1', '客户还款', '0', '2', '2018-08-23 19:08:06');
INSERT INTO `xb_loans_paylist` VALUES ('32', '8', '1808231191127466', '1808235190918710', null, '2', '565.00', '1', '1', '客户还款', '0', '2', '2018-08-23 19:11:42');
INSERT INTO `xb_loans_paylist` VALUES ('33', '10', '1808259113018637', '1808258112617856', null, '2', '525.00', '1', '1', '客户还款', '0', '41', '2018-08-25 11:30:25');
INSERT INTO `xb_loans_paylist` VALUES ('34', '9', '1808256113326990', '1808256113211774', null, '2', '525.00', '1', '1', '客户还款', '0', '2', '2018-08-25 11:33:32');
INSERT INTO `xb_loans_paylist` VALUES ('35', '10', '1808258114249337', '1808252114224127', null, '2', '525.00', '1', '1', '客户还款', '0', '2', '2018-08-25 11:42:56');
INSERT INTO `xb_loans_paylist` VALUES ('36', '9', '1808259182112687', '1808259144610183', null, '2', '525.00', '1', '1', '客户还款', '0', '2', '2018-08-25 18:21:40');
INSERT INTO `xb_loans_paylist` VALUES ('37', '8', '1808278085216832', '1808255161642916', null, '2', '525.00', '1', '1', '客户还款', '0', '2', '2018-08-27 08:52:27');
INSERT INTO `xb_loans_paylist` VALUES ('38', '9', '1808277085906990', '1808278085547951', null, '2', '4025.00', '1', '1', '客户还款', '0', '2', '2018-08-27 08:59:22');
INSERT INTO `xb_loans_paylist` VALUES ('39', '9', '1808278092409152', '1808273091311848', null, '2', '4025.00', '1', '1', '客户还款', '0', '2', '2018-08-27 09:24:19');
