/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_mem_coupans`
-- ----------------------------
DROP TABLE IF EXISTS `xb_mem_coupans`;
CREATE TABLE `xb_mem_coupans` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT '0' COMMENT '会员ID',
  `GetType` tinyint(4) DEFAULT '1' COMMENT '获取类型 1发放 2领取',
  `CoupansID` int(11) DEFAULT NULL COMMENT '优惠劵ID',
  `Title` varchar(255) DEFAULT NULL COMMENT '优惠劵名称',
  `Money` int(11) DEFAULT NULL COMMENT '优惠劵金额',
  `StartMoney` int(11) DEFAULT NULL COMMENT '使用条件,必须大于这个金额才能用',
  `StartTime` datetime DEFAULT NULL COMMENT '有效期开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '有效期结束时间',
  `Isuser` tinyint(4) DEFAULT '1' COMMENT '是否使用:1没使用 2已使用',
  `Oid` int(11) DEFAULT '0' COMMENT '使用的订单ID',
  `Gid` int(11) DEFAULT '0' COMMENT '使用的商品ID',
  `UseTime` datetime DEFAULT NULL COMMENT '使用时间',
  `Status` int(11) DEFAULT '1' COMMENT '状态 0 隐藏 1 正常',
  `IsDel` int(11) DEFAULT '0' COMMENT '逻辑删除 0未删除 1会员已删除 2管理员已删除',
  `AddUserID` int(11) DEFAULT NULL COMMENT '添加人id',
  `AddTime` datetime DEFAULT NULL COMMENT '添加时间',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `Isuser` (`Isuser`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='会员优惠劵表';

-- ----------------------------
-- Records of xb_mem_coupans
-- ----------------------------
INSERT INTO `xb_mem_coupans` VALUES ('2', '1', '1', '1', '5元优惠券', '5', '1000', '2018-06-28 00:00:00', '2018-07-07 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-06-28 14:10:48', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('3', '1', '2', '1', '5元优惠券', '5', '1000', '2018-06-28 00:00:00', '2018-07-07 00:00:00', '1', '0', '0', null, '1', '0', null, '2018-06-28 14:36:24', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('4', '7', '1', '1', '5元优惠券', '5', '1000', '2018-06-28 00:00:00', '2018-07-07 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-02 08:46:21', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('5', '7', '1', '1', '5元优惠券', '5', '1000', '2018-06-28 00:00:00', '2018-07-07 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-02 08:46:21', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('6', '7', '1', '1', '5元优惠券', '5', '1000', '2018-06-28 00:00:00', '2018-07-07 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-02 08:48:02', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('10', '6', '1', '1', '5元优惠券', '5', '10', '2018-07-11 00:00:00', '2018-07-12 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-11 19:15:29', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('11', '6', '1', '1', '5元优惠券', '5', '10', '2018-07-11 00:00:00', '2018-07-12 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-11 19:15:29', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('12', '1', '1', '1', '5元优惠券', '5', '100', '2018-07-17 00:00:00', '2018-07-19 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-17 17:07:07', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('13', '1', '1', '1', '5元优惠券', '5', '100', '2018-07-17 00:00:00', '2018-07-19 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-07-17 17:07:07', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('14', '8', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '2', '2', '3', '2018-08-21 11:48:35', '1', '0', null, null, null, '2018-08-20 13:34:18');
INSERT INTO `xb_mem_coupans` VALUES ('15', '9', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '1', null, null, null, '2018-08-21 10:07:26');
INSERT INTO `xb_mem_coupans` VALUES ('16', '8', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '2', '11', '5', '2018-08-21 17:30:09', '1', '0', null, null, null, '2018-08-21 08:55:57');
INSERT INTO `xb_mem_coupans` VALUES ('17', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('18', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('19', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('20', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('21', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('22', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('23', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('24', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('25', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('26', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('27', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('28', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('29', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('30', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('31', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('32', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('33', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('34', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('35', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('36', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('37', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('38', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('39', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('40', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('41', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('42', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('43', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('44', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('45', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('46', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('47', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('48', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('49', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('50', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('51', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('52', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('53', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('54', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('55', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('56', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('57', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('58', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '2', '4', '5', '2018-08-21 14:21:50', '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('59', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('60', '9', '1', '1', '5元优惠券', '5', '0', '2018-08-21 00:00:00', '2018-08-22 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-21 11:05:05', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('61', '9', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-21 11:19:09');
INSERT INTO `xb_mem_coupans` VALUES ('62', '9', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '2', '3', '5', '2018-08-21 13:31:29', '1', '0', null, null, null, '2018-08-21 11:19:09');
INSERT INTO `xb_mem_coupans` VALUES ('63', '10', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '2', '39', '3', '2018-08-21 21:20:05', '1', '0', null, null, null, '2018-08-21 18:36:00');
INSERT INTO `xb_mem_coupans` VALUES ('64', '10', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-21 18:59:40');
INSERT INTO `xb_mem_coupans` VALUES ('68', '12', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-21 21:58:12');
INSERT INTO `xb_mem_coupans` VALUES ('69', '13', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 09:24:38');
INSERT INTO `xb_mem_coupans` VALUES ('70', '14', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 09:41:02');
INSERT INTO `xb_mem_coupans` VALUES ('71', '15', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 10:24:33');
INSERT INTO `xb_mem_coupans` VALUES ('72', '16', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 10:36:04');
INSERT INTO `xb_mem_coupans` VALUES ('75', '19', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 10:43:13');
INSERT INTO `xb_mem_coupans` VALUES ('77', '16', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 10:55:12');
INSERT INTO `xb_mem_coupans` VALUES ('78', '19', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 10:57:29');
INSERT INTO `xb_mem_coupans` VALUES ('79', '14', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-22 11:18:17');
INSERT INTO `xb_mem_coupans` VALUES ('80', '21', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-23 12:06:17');
INSERT INTO `xb_mem_coupans` VALUES ('81', '21', '1', null, '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-23 12:14:11');
INSERT INTO `xb_mem_coupans` VALUES ('82', '22', '1', null, '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', null, null, null, '2018-08-26 16:31:30');
INSERT INTO `xb_mem_coupans` VALUES ('83', '8', '1', '2', '测试优惠券', '10', '500', '2018-08-27 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-27 09:10:35', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('84', '8', '1', '2', '测试优惠券', '10', '500', '2018-08-27 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '1', '2', '2018-08-27 09:10:35', null, '2018-08-27 09:10:59');
INSERT INTO `xb_mem_coupans` VALUES ('85', '8', '1', '2', '测试优惠券', '10', '500', '2018-08-27 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-27 09:10:35', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('86', '8', '1', '2', '测试优惠券', '10', '500', '2018-08-27 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-27 09:10:35', null, null);
INSERT INTO `xb_mem_coupans` VALUES ('87', '8', '1', '2', '测试优惠券', '10', '500', '2018-08-27 00:00:00', '2018-08-31 00:00:00', '1', '0', '0', null, '1', '0', '2', '2018-08-27 09:10:35', null, null);
