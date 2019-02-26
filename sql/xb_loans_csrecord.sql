/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_loans_csrecord`
-- ----------------------------
DROP TABLE IF EXISTS `xb_loans_csrecord`;
CREATE TABLE `xb_loans_csrecord` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ApplyID` int(11) NOT NULL COMMENT '申请记录id',
  `ImgUrl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `Status` tinyint(4) DEFAULT '1' COMMENT '结果 1承诺订单 2跳票 3失联 4拒绝订单 5斡旋 6继续跟进',
  `Remark` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除 0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `ApplyID` (`ApplyID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='催收记录表';

-- ----------------------------
-- Records of xb_loans_csrecord
-- ----------------------------
INSERT INTO `xb_loans_csrecord` VALUES ('1', '2', null, '5', '说是现在没钱', '0', '2', '2018-07-26 16:53:46');
INSERT INTO `xb_loans_csrecord` VALUES ('2', '2', '/Upload/image/2018-07-26/5b59909bb4904.jpg', '5', '66', '0', '2', '2018-07-26 17:13:02');
INSERT INTO `xb_loans_csrecord` VALUES ('3', '62', null, '3', '用户已失联', '0', '42', '2018-08-22 14:22:26');
INSERT INTO `xb_loans_csrecord` VALUES ('4', '62', null, '4', '客户拒绝还款', '0', '42', '2018-08-22 14:50:53');
INSERT INTO `xb_loans_csrecord` VALUES ('5', '62', '/Upload/image/2018-08-22/5b7d07df00a45.jpg', '5', '周旋中', '0', '42', '2018-08-22 14:51:18');
