/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_xjapplylist`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_xjapplylist`;
CREATE TABLE `xb_loans_xjapplylist` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '申请人ID',
  `ApplyID` int(11) DEFAULT NULL COMMENT '申请记录ID',
  `OrderSn` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `LoanNo` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '申请号',
  `TradeNo` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '交易流水号',
  `LoanDay` int(11) DEFAULT NULL COMMENT '续借期限',
  `TotalMoney` decimal(10,2) DEFAULT '0.00' COMMENT '支付总费用',
  `ServiceCost` decimal(10,2) DEFAULT '0.00' COMMENT '续借服务费',
  `XjTime` datetime DEFAULT NULL COMMENT '续借时间',
  `TradeRemark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '交易备注信息',
  `Accounts` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '收款账号',
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='续借申请表';

-- ----------------------------
-- Records of xb_loans_xjapplylist
-- ----------------------------
INSERT INTO `xb_loans_xjapplylist` VALUES ('1', '9', '8', '1808218165412585', '1808212151730447', null, '20', '61.00', '61.00', '2018-08-21 16:54:12', '123456', 'wx559658741', '2', '1', null, '2', '2018-08-21 16:54:30', '1', '111', '0', '2', '2018-08-21 16:54:30');
INSERT INTO `xb_loans_xjapplylist` VALUES ('2', '10', '28', '1808214203722119', '1808212202943595', null, '14', '31.00', '31.00', '2018-08-21 20:37:22', '12343', 'wx559658741', '2', '1', null, '2', '2018-08-21 20:43:46', '1', '', '0', '2', '2018-08-21 20:43:46');
INSERT INTO `xb_loans_xjapplylist` VALUES ('3', '8', '29', '1808219205031462', '1808217204036599', null, '14', '61.00', '61.00', '2018-08-21 20:50:31', '去问问', '183559658741', '1', '1', null, '2', '2018-08-23 13:38:21', '1', '111', '0', '2', '2018-08-23 13:38:21');
INSERT INTO `xb_loans_xjapplylist` VALUES ('4', '10', '30', '1808212205143209', '1808212202943595', null, '7', '40.00', '40.00', '2018-08-21 20:51:43', '123', 'wx559658741', '2', '1', null, '2', '2018-08-21 20:52:41', '1', '', '0', '2', '2018-08-21 20:52:41');
INSERT INTO `xb_loans_xjapplylist` VALUES ('5', '11', '27', '1808216205337377', '1808211202943425', null, '14', '31.00', '31.00', '2018-08-21 20:53:37', '132', 'wx559658741', '2', '1', null, '2', '2018-08-21 21:00:15', '1', '', '0', '2', '2018-08-21 21:00:15');
INSERT INTO `xb_loans_xjapplylist` VALUES ('6', '10', '31', '1808217205535191', '1808212202943595', null, '7', '40.00', '40.00', '2018-08-21 20:55:35', null, null, '3', '0', null, null, '2018-08-21 20:55:41', '2', null, '0', null, null);
INSERT INTO `xb_loans_xjapplylist` VALUES ('7', '10', '31', '1808213205541542', '1808212202943595', null, '7', '40.00', '40.00', '2018-08-21 20:55:41', '1234', '183559658741', '1', '1', null, '2', '2018-08-21 20:55:59', '1', '', '0', '2', '2018-08-21 20:55:59');
INSERT INTO `xb_loans_xjapplylist` VALUES ('8', '11', '33', '1808219210126648', '1808211202943425', null, '14', '50.00', '50.00', '2018-08-21 21:01:26', '11', 'wx559658741', '2', '1', null, '2', '2018-08-21 21:01:51', '1', '', '0', '2', '2018-08-21 21:01:51');
INSERT INTO `xb_loans_xjapplylist` VALUES ('9', '11', '34', '1808217210305917', '1808211202943425', null, '7', '40.00', '40.00', '2018-08-21 21:03:05', '123', '183559658741', '1', '1', null, '2', '2018-08-21 21:03:42', '1', '', '0', '2', '2018-08-21 21:03:42');
INSERT INTO `xb_loans_xjapplylist` VALUES ('10', '10', '39', '1808211212118732', '1808216212005675', null, '14', '41.00', '41.00', '2018-08-21 21:21:18', '11', '183559658741', '1', '1', null, '2', '2018-08-21 21:21:41', '1', '', '0', '2', '2018-08-21 21:21:41');
INSERT INTO `xb_loans_xjapplylist` VALUES ('11', '11', '40', '1808218212118997', '1808213212005359', null, '14', '41.00', '41.00', '2018-08-21 21:21:18', '11', '183559658741', '1', '1', null, '2', '2018-08-21 21:21:33', '1', '', '0', '2', '2018-08-21 21:21:33');
INSERT INTO `xb_loans_xjapplylist` VALUES ('12', '11', '63', '1808228161432251', '1808226153728991', null, '7', '21.00', '21.00', '2018-08-22 16:14:32', '123', '183559658741', '1', '0', null, '2', '2018-08-22 16:16:33', '2', '1', '0', '2', '2018-08-22 16:16:33');
INSERT INTO `xb_loans_xjapplylist` VALUES ('13', '11', '65', '1808227162834316', '1808227162420501', null, '7', '21.00', '21.00', '2018-08-22 16:28:34', '12', '183559658741', '1', '0', null, '2', '2018-08-23 13:34:20', '2', 'ygtyu', '0', '2', '2018-08-23 13:34:20');
INSERT INTO `xb_loans_xjapplylist` VALUES ('14', '9', '67', '1808223214410196', '1808226214216827', null, '7', '41.00', '41.00', '2018-08-22 21:44:10', '支付宝续借', '183559658741', '1', '1', null, '2', '2018-08-22 21:44:47', '1', '', '0', '2', '2018-08-22 21:44:47');
INSERT INTO `xb_loans_xjapplylist` VALUES ('15', '10', '80', '1808254112844412', '1808258112617856', null, '7', '31.00', '31.00', '2018-08-25 11:28:44', '测试', '183559658741', '1', '1', null, '41', '2018-08-25 11:29:08', '1', '', '0', '41', '2018-08-25 11:29:08');
INSERT INTO `xb_loans_xjapplylist` VALUES ('16', '9', '82', '1808259113300423', '1808256113211774', null, '7', '31.00', '31.00', '2018-08-25 11:33:00', '测试', '183559658741', '1', '1', null, '2', '2018-08-25 11:33:18', '1', '', '0', '2', '2018-08-25 11:33:18');
INSERT INTO `xb_loans_xjapplylist` VALUES ('17', '9', '87', '1808271085756349', '1808278085547951', null, '7', '51.00', '51.00', '2018-08-27 08:57:56', '微信', 'wx559658741', '2', '1', null, '2', '2018-08-27 08:58:11', '1', '测试', '0', '2', '2018-08-27 08:58:11');
INSERT INTO `xb_loans_xjapplylist` VALUES ('18', '9', '90', '1808273092327553', '1808273091311848', null, '7', '51.00', '51.00', '2018-08-27 09:23:27', null, null, '3', '0', null, null, '2018-08-27 09:24:09', '2', null, '0', null, null);
