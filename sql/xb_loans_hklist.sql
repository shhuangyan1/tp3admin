/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_hklist`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_hklist`;
CREATE TABLE `xb_loans_hklist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '申请人ID',
  `ApplyID` int(11) DEFAULT NULL COMMENT '申请记录ID',
  `OrderSn` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `LoanNo` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '申请号',
  `TotalMoney` decimal(10,2) DEFAULT '0.00' COMMENT '还款总金额',
  `HkTime` datetime DEFAULT NULL COMMENT '还款时间',
  `CostPayable` decimal(10,2) DEFAULT '0.00' COMMENT '应还本金',
  `RatePayable` decimal(10,2) DEFAULT '0.00' COMMENT '应还本息',
  `SeviceCostPayable` decimal(10,2) DEFAULT '0.00' COMMENT '应还服务费',
  `FinePayable` decimal(10,2) DEFAULT '0.00' COMMENT '应还罚金',
  `TradeRemark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '交易备注信息',
  `Accounts` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '收款账号',
  `TradeNo` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '交易流水号',
  `PayType` int(11) DEFAULT '1' COMMENT '还款类型 0未付款 1支付宝 2微信 3银联 4代付',
  `PayStatus` tinyint(4) unsigned DEFAULT '0' COMMENT '支付状态 0待支付 1已支付',
  `PayTime` datetime DEFAULT NULL COMMENT '支付时间',
  `AdminID` int(11) DEFAULT NULL COMMENT '审核员编号',
  `ShTime` datetime DEFAULT NULL COMMENT '审核时间',
  `Status` int(11) DEFAULT '0' COMMENT '审核状态 0待审核 1审核成功 2审核失败',
  `Remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '审核备注信息',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `ApplyID` (`ApplyID`),
  KEY `LoanNo` (`LoanNo`),
  KEY `PayType` (`PayType`),
  KEY `PayStatus` (`PayStatus`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='还款记录表';

-- ----------------------------
-- Records of xb_loans_hklist
-- ----------------------------
INSERT INTO `xb_loans_hklist` VALUES ('1', '9', '4', '1808218145332445', '1808216142150118', '2025.00', '2018-08-21 14:53:32', '1995.00', '30.00', '0.00', '0.00', '支付宝还款', '183559658741', null, '1', '1', null, '2', '2018-08-21 14:54:34', '1', '', '0', '2', '2018-08-21 14:54:34');
INSERT INTO `xb_loans_hklist` VALUES ('2', '9', '5', '1808219145539982', '1808216145503919', '2025.00', '2018-08-21 14:55:39', '2000.00', '25.00', '0.00', '0.00', '微信还款', 'wx559658741', null, '2', '1', null, '2', '2018-08-21 14:55:49', '1', '', '0', '2', '2018-08-21 14:55:49');
INSERT INTO `xb_loans_hklist` VALUES ('3', '9', '6', '1808219151523877', '1808214145723579', '1525.00', '2018-08-21 15:15:23', '1500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-21 15:15:31', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('4', '9', '6', '1808211151531559', '1808214145723579', '1525.00', '2018-08-21 15:15:31', '1500.00', '25.00', '0.00', '0.00', '1111', '183559658741', null, '1', '1', null, '2', '2018-08-21 15:15:48', '1', '', '0', '2', '2018-08-21 15:15:48');
INSERT INTO `xb_loans_hklist` VALUES ('5', '8', '2', '1808211155737169', '1808211114835813', '1005.00', '2018-08-21 15:57:37', '990.00', '15.00', '0.00', '0.00', '1222', 'wx559658741', null, '2', '1', null, '2', '2018-08-21 17:20:57', '1', 'qqqq', '0', '2', '2018-08-21 17:20:57');
INSERT INTO `xb_loans_hklist` VALUES ('6', '9', '8', '1808215162844218', '1808212151730447', '2030.00', '2018-08-21 16:28:44', '2000.00', '30.00', '0.00', '0.00', '12111', 'wx559658741', null, '2', '0', null, '2', '2018-08-21 16:44:56', '2', 'dsaf', '0', '2', '2018-08-21 16:44:56');
INSERT INTO `xb_loans_hklist` VALUES ('7', '9', '8', '1808212164759885', '1808212151730447', '2030.00', '2018-08-21 16:47:59', '2000.00', '30.00', '0.00', '0.00', '5566', '183559658741', null, '1', '0', null, '2', '2018-08-21 16:49:05', '2', 'fd', '0', '2', '2018-08-21 16:49:05');
INSERT INTO `xb_loans_hklist` VALUES ('8', '9', '9', '1808211172133504', '1808212151730447', '2030.00', '2018-08-21 17:21:33', '2000.00', '30.00', '0.00', '0.00', 'hhh', '183559658741', null, '1', '1', null, '2', '2018-08-21 17:22:11', '1', '14444', '0', '2', '2018-08-21 17:22:11');
INSERT INTO `xb_loans_hklist` VALUES ('9', '8', '11', '1808215173130277', '1808215173009415', '2010.00', '2018-08-21 17:31:30', '1980.00', '30.00', '0.00', '0.00', 'Www', '183559658741', null, '1', '1', null, '2', '2018-08-21 17:31:39', '1', 'qqq', '0', '2', '2018-08-21 17:31:39');
INSERT INTO `xb_loans_hklist` VALUES ('10', '9', '16', '1808219185011773', '1808217184831321', '2030.00', '2018-08-21 18:50:11', '2000.00', '30.00', '0.00', '0.00', 'ffg', '183559658741', null, '1', '1', null, '2', '2018-08-21 18:50:34', '1', '', '0', '2', '2018-08-21 18:50:34');
INSERT INTO `xb_loans_hklist` VALUES ('11', '10', '18', '1808216192329390', '1808213191745390', '510.00', '2018-08-21 19:23:29', '500.00', '10.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-21 19:25:21', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('12', '10', '18', '1808219192521134', '1808213191745390', '510.00', '2018-08-21 19:25:21', '500.00', '10.00', '0.00', '0.00', '123456', 'wx559658741', null, '2', '1', null, '2', '2018-08-21 19:33:41', '1', '', '0', '2', '2018-08-21 19:33:41');
INSERT INTO `xb_loans_hklist` VALUES ('13', '10', '25', '1808218201545606', '1808218195918880', '830.00', '2018-08-21 20:15:45', '500.00', '10.00', '0.00', '320.00', '123456', 'wx559658741', null, '2', '1', null, '2', '2018-08-21 20:17:06', '1', '', '0', '2', '2018-08-21 20:17:06');
INSERT INTO `xb_loans_hklist` VALUES ('14', '10', '32', '1808211205625978', '1808212202943595', '515.00', '2018-08-21 20:56:25', '500.00', '15.00', '0.00', '0.00', '11', 'wx559658741', null, '2', '1', null, '2', '2018-08-21 20:56:31', '1', '', '0', '2', '2018-08-21 20:56:31');
INSERT INTO `xb_loans_hklist` VALUES ('17', '10', '42', '1808213212325556', '1808216212005675', '1010.00', '2018-08-21 21:23:25', '990.00', '20.00', '0.00', '0.00', '123', '183559658741', null, '1', '1', null, '2', '2018-08-21 21:23:38', '1', '', '0', '2', '2018-08-21 21:23:38');
INSERT INTO `xb_loans_hklist` VALUES ('19', '10', '45', '1808213214027977', '1808212213924545', '1020.00', '2018-08-21 21:40:27', '1000.00', '20.00', '0.00', '0.00', '11', '183559658741', null, '1', '1', null, '2', '2018-08-21 21:40:33', '1', '', '0', '2', '2018-08-21 21:40:33');
INSERT INTO `xb_loans_hklist` VALUES ('20', '10', '48', '1808212214227727', '1808212214054287', '2055.00', '2018-08-21 21:42:27', '1000.00', '15.00', '0.00', '1040.00', '1册', '183559658741', null, '1', '1', null, '2', '2018-08-21 21:42:46', '1', '', '0', '2', '2018-08-21 21:42:46');
INSERT INTO `xb_loans_hklist` VALUES ('22', '10', '50', '1808217215032291', '1808212214941481', '510.00', '2018-08-21 21:50:32', '500.00', '10.00', '0.00', '0.00', '111', '183559658741', null, '1', '1', null, '2', '2018-08-21 21:50:37', '1', '', '0', '2', '2018-08-21 21:50:37');
INSERT INTO `xb_loans_hklist` VALUES ('23', '10', '51', '1808227105734453', '1808211215049912', '670.00', '2018-08-22 10:57:34', '500.00', '10.00', '0.00', '160.00', '122', '183559658741', null, '1', '1', null, '2', '2018-08-22 10:57:46', '1', '', '0', '2', '2018-08-22 10:57:46');
INSERT INTO `xb_loans_hklist` VALUES ('25', '10', '55', '1808227112259140', '1808222111725873', '1015.00', '2018-08-22 11:22:59', '1000.00', '15.00', '0.00', '0.00', '12345', 'wx559658741', null, '2', '1', null, '2', '2018-08-22 11:23:08', '1', '', '0', '2', '2018-08-22 11:23:08');
INSERT INTO `xb_loans_hklist` VALUES ('31', '14', '57', '1808221164343634', '1808222112034763', '510.00', '2018-08-22 16:43:43', '500.00', '10.00', '0.00', '0.00', '林', '183559658741', null, '1', '0', null, '2', '2018-08-22 16:46:03', '2', '1', '0', '2', '2018-08-22 16:46:03');
INSERT INTO `xb_loans_hklist` VALUES ('32', '14', '57', '1808222164853540', '1808222112034763', '510.00', '2018-08-22 16:48:53', '500.00', '10.00', '0.00', '0.00', 'llg', '183559658741', null, '1', '0', null, '2', '2018-08-23 14:06:44', '2', '没收到转账', '0', '2', '2018-08-23 14:06:44');
INSERT INTO `xb_loans_hklist` VALUES ('33', '9', '68', '1808227214500276', '1808226214216827', '1520.00', '2018-08-22 21:45:00', '1500.00', '20.00', '0.00', '0.00', '支付宝', '183559658741', null, '1', '1', null, '2', '2018-08-22 21:45:20', '1', '', '0', '2', '2018-08-22 21:45:20');
INSERT INTO `xb_loans_hklist` VALUES ('35', '8', '69', '1808239133841926', '1808217204036599', '2030.00', '2018-08-23 13:38:41', '2000.00', '30.00', '0.00', '0.00', '1233', '183559658741', null, '1', '1', null, '2', '2018-08-23 13:38:49', '1', '111', '0', '2', '2018-08-23 13:38:49');
INSERT INTO `xb_loans_hklist` VALUES ('36', '10', '60', '1808235134806651', '1808223141439639', '590.00', '2018-08-23 13:48:06', '500.00', '10.00', '0.00', '80.00', '123', '183559658741', null, '1', '1', null, '2', '2018-08-23 13:48:45', '1', '1', '0', '2', '2018-08-23 13:48:45');
INSERT INTO `xb_loans_hklist` VALUES ('37', '8', '77', '1808233190752416', '1808239190505688', '525.00', '2018-08-23 19:07:52', '500.00', '25.00', '0.00', '0.00', 'P', '183559658741', null, '1', '1', null, '2', '2018-08-23 19:08:06', '1', '3', '0', '2', '2018-08-23 19:08:06');
INSERT INTO `xb_loans_hklist` VALUES ('38', '8', '78', '1808231191127466', '1808235190918710', '565.00', '2018-08-23 19:11:27', '500.00', '25.00', '0.00', '40.00', 'I', '183559658741', null, '1', '1', null, '2', '2018-08-23 19:11:42', '1', '', '0', '2', '2018-08-23 19:11:42');
INSERT INTO `xb_loans_hklist` VALUES ('39', '10', '81', '1808259113018637', '1808258112617856', '525.00', '2018-08-25 11:30:18', '500.00', '25.00', '0.00', '0.00', '11', '183559658741', null, '1', '1', null, '41', '2018-08-25 11:30:25', '1', '', '0', '41', '2018-08-25 11:30:25');
INSERT INTO `xb_loans_hklist` VALUES ('40', '9', '83', '1808256113326990', '1808256113211774', '525.00', '2018-08-25 11:33:26', '500.00', '25.00', '0.00', '0.00', '11', '183559658741', null, '1', '1', null, '2', '2018-08-25 11:33:32', '1', '', '0', '2', '2018-08-25 11:33:32');
INSERT INTO `xb_loans_hklist` VALUES ('41', '10', '84', '1808258114249337', '1808252114224127', '525.00', '2018-08-25 11:42:49', '500.00', '25.00', '0.00', '0.00', '11', '183559658741', null, '1', '1', null, '2', '2018-08-25 11:42:56', '1', '', '0', '2', '2018-08-25 11:42:56');
INSERT INTO `xb_loans_hklist` VALUES ('42', '9', '85', '1808252144655445', '1808259144610183', '525.00', '2018-08-25 14:46:55', '500.00', '25.00', '0.00', '0.00', '支付宝', '183559658741', null, '1', '0', null, '2', '2018-08-25 14:47:04', '2', 'dd', '0', '2', '2018-08-25 14:47:04');
INSERT INTO `xb_loans_hklist` VALUES ('43', '9', '85', '1808252144725451', '1808259144610183', '525.00', '2018-08-25 14:47:25', '500.00', '25.00', '0.00', '0.00', '支付宝', '183559658741', null, '1', '0', null, '2', '2018-08-25 14:51:14', '2', 'dd', '0', '2', '2018-08-25 14:51:14');
INSERT INTO `xb_loans_hklist` VALUES ('44', '9', '85', '1808258145124507', '1808259144610183', '525.00', '2018-08-25 14:51:24', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, '2', '2018-08-25 14:52:09', '2', '测试', '0', '2', '2018-08-25 14:52:09');
INSERT INTO `xb_loans_hklist` VALUES ('45', '9', '85', '1808259151338175', '1808259144610183', '525.00', '2018-08-25 15:13:38', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:42', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('46', '9', '85', '1808251151342345', '1808259144610183', '525.00', '2018-08-25 15:13:42', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:44', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('47', '9', '85', '1808255151344731', '1808259144610183', '525.00', '2018-08-25 15:13:44', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:44', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('48', '9', '85', '1808259151344869', '1808259144610183', '525.00', '2018-08-25 15:13:44', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('49', '9', '85', '1808259151348584', '1808259144610183', '525.00', '2018-08-25 15:13:48', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('50', '9', '85', '1808258151348669', '1808259144610183', '525.00', '2018-08-25 15:13:48', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('51', '9', '85', '1808254151348534', '1808259144610183', '525.00', '2018-08-25 15:13:48', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('52', '9', '85', '1808251151348142', '1808259144610183', '525.00', '2018-08-25 15:13:48', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('53', '9', '85', '1808257151348611', '1808259144610183', '525.00', '2018-08-25 15:13:48', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:49', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('54', '9', '85', '1808259151349424', '1808259144610183', '525.00', '2018-08-25 15:13:49', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:49', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('55', '9', '85', '1808255151349151', '1808259144610183', '525.00', '2018-08-25 15:13:49', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:49', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('56', '9', '85', '1808253151349741', '1808259144610183', '525.00', '2018-08-25 15:13:49', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:49', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('57', '9', '85', '1808257151349877', '1808259144610183', '525.00', '2018-08-25 15:13:49', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:13:50', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('58', '9', '85', '1808253151350620', '1808259144610183', '525.00', '2018-08-25 15:13:50', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:14:06', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('59', '9', '85', '1808257151406361', '1808259144610183', '525.00', '2018-08-25 15:14:06', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:14:28', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('60', '9', '85', '1808259151428765', '1808259144610183', '525.00', '2018-08-25 15:14:28', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:15:32', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('61', '9', '85', '1808255151532375', '1808259144610183', '525.00', '2018-08-25 15:15:32', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:16:28', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('62', '9', '85', '1808257151628517', '1808259144610183', '525.00', '2018-08-25 15:16:28', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:16:42', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('63', '9', '85', '1808255151642216', '1808259144610183', '525.00', '2018-08-25 15:16:42', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:22:06', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('64', '9', '85', '1808259152206599', '1808259144610183', '525.00', '2018-08-25 15:22:06', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:31:04', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('65', '9', '85', '1808255153104132', '1808259144610183', '525.00', '2018-08-25 15:31:04', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:36:18', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('66', '9', '85', '1808259153618491', '1808259144610183', '525.00', '2018-08-25 15:36:18', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:37:46', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('67', '9', '85', '1808252153746594', '1808259144610183', '525.00', '2018-08-25 15:37:46', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:40:36', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('68', '9', '85', '1808253154036296', '1808259144610183', '525.00', '2018-08-25 15:40:36', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:49:35', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('69', '9', '85', '1808259154935699', '1808259144610183', '525.00', '2018-08-25 15:49:35', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 15:58:27', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('70', '9', '85', '1808251155827592', '1808259144610183', '525.00', '2018-08-25 15:58:27', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:17:27', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('71', '8', '86', '1808251161715394', '1808255161642916', '525.00', '2018-08-25 16:17:15', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, '2', '2018-08-25 16:19:27', '2', 'qqq', '0', '2', '2018-08-25 16:19:27');
INSERT INTO `xb_loans_hklist` VALUES ('72', '9', '85', '1808251161727581', '1808259144610183', '525.00', '2018-08-25 16:17:27', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:27:57', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('73', '8', '86', '1808251162030241', '1808255161642916', '525.00', '2018-08-25 16:20:30', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:21:42', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('74', '8', '86', '1808252162142778', '1808255161642916', '525.00', '2018-08-25 16:21:42', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:22:04', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('75', '8', '86', '1808253162204746', '1808255161642916', '525.00', '2018-08-25 16:22:04', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:23:02', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('76', '8', '86', '1808251162302808', '1808255161642916', '525.00', '2018-08-25 16:23:02', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:28:33', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('77', '9', '85', '1808254162757431', '1808259144610183', '525.00', '2018-08-25 16:27:57', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:28:32', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('78', '9', '85', '1808252162832288', '1808259144610183', '525.00', '2018-08-25 16:28:32', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:29:45', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('79', '8', '86', '1808256162833561', '1808255161642916', '525.00', '2018-08-25 16:28:33', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:31:43', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('80', '9', '85', '1808255162945333', '1808259144610183', '525.00', '2018-08-25 16:29:45', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:35:25', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('81', '8', '86', '1808252163143448', '1808255161642916', '525.00', '2018-08-25 16:31:43', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:32:03', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('82', '8', '86', '1808258163203156', '1808255161642916', '525.00', '2018-08-25 16:32:03', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:39:09', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('83', '9', '85', '1808253163525783', '1808259144610183', '525.00', '2018-08-25 16:35:25', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:54:06', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('84', '8', '86', '1808252163909315', '1808255161642916', '525.00', '2018-08-25 16:39:09', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:44:25', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('85', '8', '86', '1808255164425475', '1808255161642916', '525.00', '2018-08-25 16:44:25', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 16:51:18', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('86', '8', '86', '1808257165118391', '1808255161642916', '525.00', '2018-08-25 16:51:18', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:08:44', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('87', '9', '85', '1808254165406216', '1808259144610183', '525.00', '2018-08-25 16:54:06', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:11:04', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('88', '8', '86', '1808253170844113', '1808255161642916', '525.00', '2018-08-25 17:08:44', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 08:52:16', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('89', '9', '85', '1808252171104794', '1808259144610183', '525.00', '2018-08-25 17:11:04', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:27:46', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('90', '9', '85', '1808257172746249', '1808259144610183', '525.00', '2018-08-25 17:27:46', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:30:02', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('91', '9', '85', '1808258173002849', '1808259144610183', '525.00', '2018-08-25 17:30:02', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:32:35', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('92', '9', '85', '1808256173235251', '1808259144610183', '525.00', '2018-08-25 17:32:35', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 17:42:45', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('93', '9', '85', '1808259174245732', '1808259144610183', '525.00', '2018-08-25 17:42:45', '500.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-25 18:21:12', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('94', '9', '85', '1808259182112687', '1808259144610183', '525.00', '2018-08-25 18:21:12', '500.00', '25.00', '0.00', '0.00', '支付宝测试', '183559658741', null, '1', '1', null, '2', '2018-08-25 18:21:40', '1', '测试', '0', '2', '2018-08-25 18:21:40');
INSERT INTO `xb_loans_hklist` VALUES ('95', '8', '86', '1808278085216832', '1808255161642916', '525.00', '2018-08-27 08:52:16', '500.00', '25.00', '0.00', '0.00', '停停停', '183559658741', null, '1', '1', null, '2', '2018-08-27 08:52:27', '1', '111', '0', '2', '2018-08-27 08:52:27');
INSERT INTO `xb_loans_hklist` VALUES ('96', '9', '89', '1808273085827619', '1808278085547951', '4025.00', '2018-08-27 08:58:27', '4000.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 08:59:06', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('97', '9', '89', '1808277085906990', '1808278085547951', '4025.00', '2018-08-27 08:59:06', '4000.00', '25.00', '0.00', '0.00', '123', '183559658741', null, '1', '1', null, '2', '2018-08-27 08:59:22', '1', '测试', '0', '2', '2018-08-27 08:59:22');
INSERT INTO `xb_loans_hklist` VALUES ('98', '9', '90', '1808272091343516', '1808273091311848', '4025.00', '2018-08-27 09:13:43', '4000.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 09:14:05', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('99', '9', '90', '1808274091405318', '1808273091311848', '4025.00', '2018-08-27 09:14:05', '4000.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 09:16:00', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('100', '9', '90', '1808276091600780', '1808273091311848', '4025.00', '2018-08-27 09:16:00', '4000.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 09:22:48', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('101', '9', '90', '1808279092248470', '1808273091311848', '4025.00', '2018-08-27 09:22:48', '4000.00', '25.00', '0.00', '0.00', null, null, null, '3', '0', null, null, '2018-08-27 09:23:26', '2', null, '0', null, null);
INSERT INTO `xb_loans_hklist` VALUES ('102', '9', '90', '1808278092409152', '1808273091311848', '4025.00', '2018-08-27 09:24:09', '4000.00', '25.00', '0.00', '0.00', '测试', '183559658741', null, '1', '1', null, '2', '2018-08-27 09:24:19', '1', '', '0', '2', '2018-08-27 09:24:19');
