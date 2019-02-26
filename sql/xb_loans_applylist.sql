/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_applylist`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_applylist`;
CREATE TABLE `xb_loans_applylist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '申请人ID',
  `ApplyTime` datetime NOT NULL COMMENT '申请时间',
  `OrderSn` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `LoanNo` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '申请号(订单申请和续借公用)',
  `ApplyMoney` decimal(10,2) DEFAULT '0.00' COMMENT '申请金额',
  `AdoptMoney` decimal(10,2) DEFAULT '0.00' COMMENT '实际金额(快速申请费)',
  `FJMoney` decimal(10,2) DEFAULT '0.00' COMMENT '撮合费(用户管理费)',
  `Interest` decimal(10,2) DEFAULT '0.00' COMMENT '息费',
  `ApplyDay` int(11) DEFAULT NULL COMMENT '申请天数',
  `ProductID` int(11) DEFAULT NULL COMMENT '商品ID',
  `CouponID` int(11) DEFAULT '0' COMMENT '优惠劵id',
  `CoMoney` decimal(10,2) DEFAULT '0.00' COMMENT '优惠劵金额',
  `OpenM` decimal(10,2) DEFAULT '0.00' COMMENT '放款金额',
  `BackM` decimal(10,2) DEFAULT '0.00' COMMENT '到期应还',
  `LoanType` tinyint(4) unsigned DEFAULT '0' COMMENT '申请类型 0普通 1续借 2分期',
  `LoanStatus` int(11) DEFAULT '0' COMMENT '订单状态 0申请中 1放款中 2已放款 3已完成 4已取消 5已拒绝',
  `SqAdminID` int(11) DEFAULT NULL COMMENT '申请专属客服',
  `ServiceID` int(11) DEFAULT NULL COMMENT '申请审核员编号',
  `ShTime` datetime DEFAULT NULL COMMENT '审核时间',
  `Status` int(11) DEFAULT '0' COMMENT '审核状态 0待审核 1审核成功 2审核失败',
  `LoanSum` int(11) DEFAULT NULL COMMENT '订单次数',
  `RongDay` int(11) DEFAULT NULL COMMENT '容时期期限',
  `RongP` decimal(10,2) DEFAULT '0.00' COMMENT '容时期利率',
  `OverdueDay` int(11) DEFAULT NULL COMMENT '逾时期天数',
  `OverdueP` decimal(10,2) DEFAULT '0.00' COMMENT '逾时期利率',
  `FKadminID` int(11) DEFAULT NULL COMMENT '放款专属客服',
  `FkServiceID` int(11) DEFAULT NULL COMMENT '放款人编号',
  `OpenTime` datetime DEFAULT NULL COMMENT '放款时间',
  `YyFkTime` datetime DEFAULT NULL COMMENT '预约还款时间',
  `ReplaymentType` int(11) DEFAULT '0' COMMENT '打款方式0未打款 1支付宝 2微信 3银联 4代付',
  `RepaymentAccount` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '打款账号',
  `TradeNum` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '交易号-付款生存的单号，手动填写',
  `UserAccount` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会员账号',
  `Remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `IsYQ` tinyint(4) unsigned DEFAULT '0' COMMENT '是否逾期  0未逾期 1已逾期',
  `CsadminID` int(11) DEFAULT NULL COMMENT '催收专属客服',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `LoanNo` (`LoanNo`),
  KEY `LoanType` (`LoanType`),
  KEY `LoanStatus` (`LoanStatus`),
  KEY `ReplaymentType` (`ReplaymentType`),
  KEY `IsYQ` (`IsYQ`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='借款申请表';

-- ----------------------------
-- Records of xb_loans_applylist
-- ----------------------------
INSERT INTO `xb_loans_applylist` VALUES ('1', '1', '2018-08-18 11:35:34', '1808137140310439', '1808137140310439', '500.00', '60.00', '60.00', '10.00', '10', '2', '0', '0.00', '380.00', '510.00', '0', '2', null, '2', '2018-08-18 13:25:22', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-18 13:48:25', '2018-08-28 13:48:25', '1', '13024073830', '1', '撒', null, '0', null, '0', '2', '2018-08-18 13:48:25');
INSERT INTO `xb_loans_applylist` VALUES ('2', '8', '2018-08-21 11:48:35', '1808211114835813', '1808211114835813', '1000.00', '110.00', '110.00', '15.00', '10', '3', '14', '10.00', '780.00', '1005.00', '0', '3', '38', '2', '2018-08-21 11:54:04', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 11:54:27', '2018-08-31 11:54:27', '1', '13024073830', 'q', 'q', null, '0', null, '0', '2', '2018-08-21 11:54:27');
INSERT INTO `xb_loans_applylist` VALUES ('3', '9', '2018-08-21 13:31:29', '1808218133129124', '1808218133129124', '2000.00', '220.00', '220.00', '30.00', '20', '5', '62', '20.00', '1560.00', '2010.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('4', '9', '2018-08-21 14:21:50', '1808216142150118', '1808216142150118', '2000.00', '220.00', '220.00', '30.00', '20', '5', '58', '5.00', '1560.00', '2025.00', '0', '3', '38', '2', '2018-08-21 14:22:25', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 14:23:05', '2018-09-10 14:23:05', '1', '13024073830', '322222222', null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('5', '9', '2018-08-21 14:55:03', '1808216145503919', '1808216145503919', '2000.00', '210.00', '210.00', '25.00', '10', '5', '0', '0.00', '1580.00', '2025.00', '0', '3', '38', '2', '2018-08-21 14:55:12', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 14:55:19', '2018-08-31 14:55:19', '1', '13024073830', '555555555', null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('6', '9', '2018-08-21 14:57:23', '1808214145723579', '1808214145723579', '1500.00', '170.00', '170.00', '25.00', '20', '4', '0', '0.00', '1160.00', '1525.00', '0', '3', '38', '2', '2018-08-21 14:57:44', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 14:57:55', '2018-09-10 14:57:55', '1', '13024073830', '555555', null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('7', '9', '2018-08-21 15:16:06', '1808211151606936', '1808211151606936', '2000.00', '220.00', '220.00', '30.00', '20', '5', '0', '0.00', '1560.00', '2030.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('8', '9', '2018-08-21 15:17:30', '1808212151730447', '1808212151730447', '2000.00', '220.00', '220.00', '30.00', '20', '5', '0', '0.00', '1560.00', '2030.00', '0', '3', '38', '2', '2018-08-21 15:17:43', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 15:17:51', '2018-09-10 15:17:51', '1', '13024073830', '1111111111', null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('9', '9', '2018-08-21 16:54:30', '1808216165430722', '1808212151730447', '2000.00', '220.00', '220.00', '30.00', '20', '5', '0', '0.00', '1560.00', '2030.00', '1', '3', '38', '2', '2018-08-21 15:17:43', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 16:54:30', '2018-09-30 15:17:51', '0', null, null, null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('10', '9', '2018-08-21 17:22:24', '1808213172224348', '1808213172224348', '2000.00', '220.00', '220.00', '30.00', '20', '5', '0', '0.00', '1560.00', '2030.00', '0', '5', '38', '2', '2018-08-21 17:42:08', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, 'd', '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('11', '8', '2018-08-21 17:30:09', '1808215173009415', '1808215173009415', '2000.00', '220.00', '220.00', '30.00', '20', '5', '16', '20.00', '1560.00', '2010.00', '0', '3', '38', '2', '2018-08-21 17:30:50', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 17:31:12', '2018-09-10 17:31:12', '1', '13024073830', 'qqq', 'qqq', null, '0', null, '0', '2', '2018-08-21 17:31:12');
INSERT INTO `xb_loans_applylist` VALUES ('12', '8', '2018-08-21 17:37:36', '1808212173736488', '1808212173736488', '1000.00', '120.00', '120.00', '20.00', '20', '3', '0', '0.00', '760.00', '1020.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('13', '8', '2018-08-21 18:33:20', '1808213183320748', '1808213183320748', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('14', '8', '2018-08-21 18:34:38', '1808216183438698', '1808216183438698', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('15', '8', '2018-08-21 18:35:41', '1808214183541212', '1808214183541212', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '5', '38', '2', '2018-08-21 18:46:03', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, 'qqqq', '0', null, '0', '2', '2018-08-21 18:46:03');
INSERT INTO `xb_loans_applylist` VALUES ('16', '9', '2018-08-21 18:48:31', '1808217184831321', '1808217184831321', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '3', '38', '2', '2018-08-21 18:48:50', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 18:49:08', '2018-09-04 18:49:08', '1', '13024073830', '1111', null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('17', '8', '2018-08-21 18:54:29', '1808212185429498', '1808212185429498', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '5', '38', '2', '2018-08-21 18:54:48', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, 'qqqq', '0', null, '0', '2', '2018-08-21 18:54:48');
INSERT INTO `xb_loans_applylist` VALUES ('18', '10', '2018-08-21 19:17:45', '1808213191745390', '1808213191745390', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '3', '38', '2', '2018-08-21 19:18:07', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 19:19:48', '2018-08-28 19:19:48', '1', '13024073830', '1111111', null, null, '0', null, '0', '2', '2018-08-21 19:19:48');
INSERT INTO `xb_loans_applylist` VALUES ('19', '10', '2018-08-21 19:36:39', '1808211193639931', '1808211193639931', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('20', '9', '2018-08-21 19:37:35', '1808214193735462', '1808214193735462', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '5', '38', '2', '2018-08-21 19:44:18', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '5555', '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('21', '8', '2018-08-21 19:49:33', '1808211194933320', '1808211194933320', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('22', '10', '2018-08-21 19:50:32', '1808213195032790', '1808213195032790', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '0', '5', '35', '2', '2018-08-21 19:53:17', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-21 19:53:17');
INSERT INTO `xb_loans_applylist` VALUES ('23', '10', '2018-08-21 19:53:59', '1808217195359702', '1808217195359702', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '5', '35', '2', '2018-08-21 19:54:07', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-21 19:54:07');
INSERT INTO `xb_loans_applylist` VALUES ('24', '10', '2018-08-21 19:55:53', '1808211195553563', '1808211195553563', '1000.00', '120.00', '120.00', '20.00', '14', '3', '0', '0.00', '760.00', '1020.00', '0', '5', '35', '2', '2018-08-21 19:56:18', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-21 19:56:18');
INSERT INTO `xb_loans_applylist` VALUES ('25', '10', '2018-08-06 19:59:52', '1808218195918880', '1808218195918880', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '3', '35', '2', '2018-08-06 19:59:52', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-06 19:59:52', '2018-08-13 19:59:52', '1', '13024073830', '11111111', null, null, '1', null, '0', '2', '2018-08-06 19:59:52');
INSERT INTO `xb_loans_applylist` VALUES ('28', '10', '2018-08-21 20:29:43', '1808212202943595', '1808212202943595', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '0', '3', '35', '2', '2018-08-21 20:30:27', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 20:32:24', '2018-09-04 20:32:24', '1', '13024073830', '11111111111', null, null, '0', null, '0', '2', '2018-08-21 20:32:24');
INSERT INTO `xb_loans_applylist` VALUES ('29', '8', '2018-08-21 20:40:36', '1808217204036599', '1808217204036599', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '0', '3', '38', '2', '2018-08-21 20:40:53', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 20:41:02', '2018-09-04 20:41:02', '1', '13024073830', '121', '121', null, '0', null, '0', '2', '2018-08-21 20:41:02');
INSERT INTO `xb_loans_applylist` VALUES ('30', '10', '2018-08-21 20:43:46', '1808218204346724', '1808212202943595', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '1', '3', '35', '2', '2018-08-21 20:30:27', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 20:43:46', '2018-09-18 20:32:24', '0', null, null, null, null, '0', null, '0', '2', '2018-08-21 20:43:46');
INSERT INTO `xb_loans_applylist` VALUES ('31', '10', '2018-08-21 20:52:41', '1808213205241277', '1808212202943595', '500.00', '70.00', '70.00', '15.00', '7', '2', '0', '0.00', '360.00', '515.00', '1', '3', '35', '2', '2018-08-21 20:30:27', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 20:52:41', '2018-09-25 20:32:24', '0', null, null, null, null, '0', null, '0', '2', '2018-08-21 20:52:41');
INSERT INTO `xb_loans_applylist` VALUES ('32', '10', '2018-08-21 20:55:59', '1808219205559496', '1808212202943595', '500.00', '70.00', '70.00', '15.00', '7', '2', '0', '0.00', '360.00', '515.00', '1', '3', '35', '2', '2018-08-21 20:30:27', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 20:55:59', '2018-10-02 20:32:24', '0', null, null, null, null, '0', null, '0', '2', '2018-08-21 20:55:59');
INSERT INTO `xb_loans_applylist` VALUES ('36', '10', '2018-08-21 21:05:35', '1808219210535632', '1808219210535632', '1000.00', '120.00', '120.00', '20.00', '14', '3', '0', '0.00', '760.00', '1020.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('38', '10', '2018-08-21 21:07:41', '1808218210741904', '1808218210741904', '1000.00', '120.00', '120.00', '20.00', '14', '3', '0', '0.00', '760.00', '1020.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('39', '10', '2018-08-21 21:20:05', '1808216212005675', '1808216212005675', '1000.00', '120.00', '120.00', '20.00', '14', '3', '63', '10.00', '760.00', '1010.00', '0', '3', '38', '2', '2018-08-21 21:20:18', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 21:20:43', '2018-09-04 21:20:43', '1', '13024073830', '1111111', null, null, '0', null, '0', '2', '2018-08-21 21:20:43');
INSERT INTO `xb_loans_applylist` VALUES ('42', '10', '2018-08-21 21:21:41', '1808212212141404', '1808216212005675', '1000.00', '120.00', '120.00', '20.00', '14', '3', '63', '10.00', '760.00', '1010.00', '1', '3', '38', '2', '2018-08-21 21:20:18', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-21 21:21:41', '2018-09-18 21:20:43', '0', null, null, null, null, '0', null, '0', '2', '2018-08-21 21:21:41');
INSERT INTO `xb_loans_applylist` VALUES ('44', '10', '2018-08-21 21:25:51', '1808212212551600', '1808212212551600', '1000.00', '120.00', '120.00', '20.00', '14', '3', '0', '0.00', '760.00', '1020.00', '0', '5', '38', '2', '2018-08-21 21:26:04', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-21 21:26:04');
INSERT INTO `xb_loans_applylist` VALUES ('45', '10', '2018-08-10 21:40:05', '1808212213924545', '1808212213924545', '1000.00', '120.00', '120.00', '20.00', '14', '3', '0', '0.00', '760.00', '1020.00', '0', '3', '38', '2', '2018-08-10 21:40:05', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-10 21:40:05', '2018-08-24 21:40:05', '1', '13024073830', '11111', '111', null, '0', null, '0', '2', '2018-08-10 21:40:05');
INSERT INTO `xb_loans_applylist` VALUES ('48', '10', '2018-08-02 21:41:15', '1808212214054287', '1808212214054287', '1000.00', '110.00', '110.00', '15.00', '7', '3', '0', '0.00', '780.00', '1015.00', '0', '3', '35', '2', '2018-08-02 21:41:15', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-02 21:41:15', '2018-08-09 21:41:15', '1', '13024073830', '111111', null, null, '1', null, '0', '2', '2018-08-02 21:41:15');
INSERT INTO `xb_loans_applylist` VALUES ('50', '10', '2018-08-21 21:49:41', '1808212214941481', '1808212214941481', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '3', '35', '2', '2018-08-21 21:49:53', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-21 21:50:06', '2018-08-28 21:50:06', '1', '13024073830', '111111', '10', null, '0', null, '0', '2', '2018-08-21 21:50:06');
INSERT INTO `xb_loans_applylist` VALUES ('51', '10', '2018-08-11 21:51:03', '1808211215049912', '1808211215049912', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '3', '38', '2', '2018-08-11 21:51:03', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-11 21:51:03', '2018-08-18 21:51:03', '1', '13024073830', '11111', null, null, '1', null, '0', '2', '2018-08-11 21:51:03');
INSERT INTO `xb_loans_applylist` VALUES ('52', '19', '2018-08-22 10:58:05', '1808221105805541', '1808221105805541', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '0', '5', '38', '2', '2018-08-23 14:09:28', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-23 14:09:28');
INSERT INTO `xb_loans_applylist` VALUES ('53', '16', '2018-08-22 11:06:57', '1808224110657723', '1808224110657723', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '0', '4', '35', null, null, '0', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('54', '16', '2018-08-22 11:12:24', '1808224111224187', '1808224111224187', '500.00', '70.00', '70.00', '15.00', '14', '2', '0', '0.00', '360.00', '515.00', '0', '0', '35', null, null, '0', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, null, '0', null, '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('55', '10', '2018-08-22 11:17:25', '1808222111725873', '1808222111725873', '1000.00', '110.00', '110.00', '15.00', '7', '3', '0', '0.00', '780.00', '1015.00', '0', '3', '38', '2', '2018-08-22 11:18:11', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-22 11:20:08', '2018-08-29 11:20:08', '2', 'weixin123', '1111', null, null, '0', null, '0', '2', '2018-08-22 11:20:08');
INSERT INTO `xb_loans_applylist` VALUES ('57', '14', '2018-08-22 11:20:34', '1808222112034763', '1808222112034763', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '2', '38', '2', '2018-08-22 15:07:08', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-22 15:12:48', '2018-08-29 15:12:48', '1', '13024073830', '123456', null, null, '0', null, '0', '2', '2018-08-22 15:12:48');
INSERT INTO `xb_loans_applylist` VALUES ('58', '10', '2018-08-22 11:23:17', '1808228112317691', '1808228112317691', '1000.00', '110.00', '110.00', '15.00', '7', '3', '0', '0.00', '780.00', '1015.00', '0', '5', '35', '2', '2018-08-22 11:23:30', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-22 11:23:30');
INSERT INTO `xb_loans_applylist` VALUES ('59', '10', '2018-08-22 11:35:56', '1808223113556915', '1808223113556915', '1000.00', '110.00', '110.00', '15.00', '7', '3', '0', '0.00', '780.00', '1015.00', '0', '5', '35', '2', '2018-08-22 11:36:08', '2', null, '10', '8.00', '20', '12.00', '36', null, null, null, '0', null, null, null, '1', '0', null, '0', '2', '2018-08-22 11:36:08');
INSERT INTO `xb_loans_applylist` VALUES ('60', '10', '2018-08-14 14:17:13', '1808223141439639', '1808223141439639', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '3', '41', '2', '2018-08-14 14:17:13', '1', null, '10', '8.00', '20', '12.00', '36', '2', '2018-08-14 14:17:13', '2018-08-21 14:17:13', '1', '13024073830', '11111', null, null, '1', '42', '0', '2', '2018-08-14 14:17:13');
INSERT INTO `xb_loans_applylist` VALUES ('66', '9', '2018-08-22 21:35:05', '1808227213505920', '1808227213505920', '500.00', '60.00', '60.00', '10.00', '7', '2', '0', '0.00', '380.00', '510.00', '0', '4', '38', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', '43', '0', null, '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('67', '9', '2018-08-22 21:42:16', '1808226214216827', '1808226214216827', '1500.00', '160.00', '160.00', '20.00', '7', '4', '0', '0.00', '1180.00', '1520.00', '0', '3', '38', '2', '2018-08-22 21:42:24', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-22 21:42:52', '2018-08-29 21:42:52', '1', '13024073830', '222222', null, null, '0', '43', '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('68', '9', '2018-08-22 21:44:47', '1808225214447586', '1808226214216827', '1500.00', '160.00', '160.00', '20.00', '7', '4', '0', '0.00', '1180.00', '1520.00', '1', '3', '38', '2', '2018-08-22 21:42:24', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-22 21:44:47', '2018-09-05 21:42:52', '0', null, null, null, null, '0', null, '0', '2', '2018-08-23 11:12:05');
INSERT INTO `xb_loans_applylist` VALUES ('69', '8', '2018-08-23 13:38:21', '1808235133821422', '1808217204036599', '2000.00', '220.00', '220.00', '30.00', '14', '5', '0', '0.00', '1560.00', '2030.00', '1', '3', '38', '2', '2018-08-21 20:40:53', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-23 13:38:21', '2018-09-18 20:41:02', '0', null, null, null, null, '0', null, '0', '2', '2018-08-23 13:38:21');
INSERT INTO `xb_loans_applylist` VALUES ('70', '8', '2018-08-23 14:03:20', '1808235140320875', '1808235140320875', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('71', '21', '2018-08-23 14:11:08', '1808233141108876', '1808233141108876', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '41', '2018-08-23 14:26:47', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '1', '0', '43', '0', '41', '2018-08-23 14:26:47');
INSERT INTO `xb_loans_applylist` VALUES ('72', '21', '2018-08-23 14:27:09', '1808237142709459', '1808237142709459', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '41', '2018-08-23 14:28:00', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '2', '0', '43', '0', '41', '2018-08-23 14:28:00');
INSERT INTO `xb_loans_applylist` VALUES ('73', '21', '2018-08-23 14:29:37', '1808239142937212', '1808239142937212', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '41', '2018-08-23 14:30:23', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '3', '0', '43', '0', '41', '2018-08-23 14:30:23');
INSERT INTO `xb_loans_applylist` VALUES ('74', '10', '2018-08-23 15:00:01', '1808234150001674', '1808234150001674', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '2', '2018-08-23 15:00:10', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '1', '0', '43', '0', '2', '2018-08-23 15:00:10');
INSERT INTO `xb_loans_applylist` VALUES ('75', '10', '2018-08-23 15:00:39', '1808237150039209', '1808237150039209', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '2', '2018-08-23 15:00:45', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '1', '0', '43', '0', '2', '2018-08-23 15:00:45');
INSERT INTO `xb_loans_applylist` VALUES ('76', '8', '2018-08-23 15:06:29', '1808232150629578', '1808232150629578', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '5', '41', '2', '2018-08-23 15:06:47', '2', null, '10', '8.00', '20', '12.00', '37', null, null, null, '0', null, null, null, '去去去', '0', '43', '0', '2', '2018-08-23 15:06:47');
INSERT INTO `xb_loans_applylist` VALUES ('77', '8', '2018-08-23 19:05:05', '1808239190505688', '1808239190505688', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '41', '2', '2018-08-23 19:05:23', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-23 19:06:00', '2018-08-29 19:06:00', '1', '13024073830', '3434', '344', null, '0', '43', '0', '2', '2018-08-23 19:06:00');
INSERT INTO `xb_loans_applylist` VALUES ('78', '8', '2018-08-16 19:10:04', '1808235190918710', '1808235190918710', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '41', '2', '2018-08-16 19:10:04', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-16 19:10:04', '2018-08-22 19:10:04', '1', '13024073830', '4546', 'dfgf', null, '1', '43', '0', '2', '2018-08-16 19:10:04');
INSERT INTO `xb_loans_applylist` VALUES ('80', '10', '2018-08-25 11:26:17', '1808258112617856', '1808258112617856', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '41', '41', '2018-08-25 11:27:26', '1', null, '10', '8.00', '20', '12.00', '37', '41', '2018-08-25 11:27:40', '2018-08-31 11:27:40', '1', '13024073830', '11111111', null, null, '0', '42', '0', '41', '2018-08-25 11:27:40');
INSERT INTO `xb_loans_applylist` VALUES ('81', '10', '2018-08-25 11:29:08', '1808258112908338', '1808258112617856', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '1', '3', '41', '41', '2018-08-25 11:27:26', '1', null, '10', '8.00', '20', '12.00', '37', '41', '2018-08-25 11:29:08', '2018-09-07 11:27:40', '0', null, null, null, null, '0', null, '0', '41', '2018-08-25 11:29:08');
INSERT INTO `xb_loans_applylist` VALUES ('82', '9', '2018-08-25 11:32:11', '1808256113211774', '1808256113211774', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '38', '2', '2018-08-25 11:32:38', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-25 11:32:45', '2018-08-31 11:32:45', '1', '13024073830', '111111', null, null, '0', '42', '0', '2', '2018-08-25 11:32:45');
INSERT INTO `xb_loans_applylist` VALUES ('83', '9', '2018-08-25 11:33:18', '1808255113318950', '1808256113211774', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '1', '3', '38', '2', '2018-08-25 11:32:38', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-25 11:33:18', '2018-09-07 11:32:45', '0', null, null, null, null, '0', null, '0', '2', '2018-08-25 11:33:18');
INSERT INTO `xb_loans_applylist` VALUES ('84', '10', '2018-08-25 11:42:24', '1808252114224127', '1808252114224127', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '41', '2', '2018-08-25 11:42:35', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-25 11:42:40', '2018-08-31 11:42:40', '1', '13024073830', '11111', null, null, '0', '42', '0', '2', '2018-08-25 11:42:40');
INSERT INTO `xb_loans_applylist` VALUES ('85', '9', '2018-08-25 14:46:10', '1808259144610183', '1808259144610183', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '38', '2', '2018-08-25 14:46:28', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-25 14:46:42', '2018-08-31 14:46:42', '1', '13024073830', '11111测试', null, null, '0', '42', '0', '2', '2018-08-25 14:46:42');
INSERT INTO `xb_loans_applylist` VALUES ('86', '8', '2018-08-25 16:16:42', '1808255161642916', '1808255161642916', '500.00', '210.00', '210.00', '25.00', '7', '6', '0', '0.00', '80.00', '525.00', '0', '3', '41', '2', '2018-08-25 16:16:55', '1', null, '10', '8.00', '20', '12.00', '37', '2', '2018-08-25 16:17:01', '2018-08-31 16:17:01', '1', '13024073830', '111', '11', null, '0', '43', '0', '2', '2018-08-25 16:17:01');
INSERT INTO `xb_loans_applylist` VALUES ('87', '9', '2018-08-27 08:55:47', '1808278085547951', '1808278085547951', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '3', '38', '2', '2018-08-27 08:56:05', '1', null, '10', '8.00', '20', '12.00', '46', '2', '2018-08-27 08:57:20', '2018-09-02 08:57:20', '2', 'weixin123', '1111111111', null, null, '0', '43', '0', '2', '2018-08-27 08:57:20');
INSERT INTO `xb_loans_applylist` VALUES ('88', '8', '2018-08-27 08:57:49', '1808279085749517', '1808279085749517', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '42', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('89', '9', '2018-08-27 08:58:11', '1808278085811777', '1808278085547951', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '1', '3', '38', '2', '2018-08-27 08:56:05', '1', null, '10', '8.00', '20', '12.00', '46', '2', '2018-08-27 08:58:11', '2018-09-09 08:57:20', '0', null, null, null, null, '0', null, '0', '2', '2018-08-27 08:58:11');
INSERT INTO `xb_loans_applylist` VALUES ('90', '9', '2018-08-27 09:13:11', '1808273091311848', '1808273091311848', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '3', '38', '2', '2018-08-27 09:13:25', '1', null, '10', '8.00', '20', '12.00', '46', '2', '2018-08-27 09:13:36', '2018-09-02 09:13:36', '1', '13024073830', '1231321213321231', null, null, '0', '43', '0', '2', '2018-08-27 09:13:36');
INSERT INTO `xb_loans_applylist` VALUES ('91', '10', '2018-08-27 16:43:23', '1808271164323889', '1808271164323889', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('92', '8', '2018-08-28 14:09:24', '1808282140924562', '1808282140924562', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('93', '8', '2018-08-28 14:12:11', '1808289141211119', '1808289141211119', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('94', '8', '2018-08-28 14:42:55', '1808284144255780', '1808284144255780', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
INSERT INTO `xb_loans_applylist` VALUES ('95', '8', '2018-08-28 14:55:39', '1808281145539980', '1808281145539980', '4000.00', '210.00', '210.00', '25.00', '7', '7', '0', '0.00', '3580.00', '4025.00', '0', '4', '41', null, null, '0', null, '10', '8.00', '20', '12.00', '46', null, null, null, '0', null, null, null, null, '0', '43', '0', null, null);
