/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:16:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_juan_sendsets`
-- ----------------------------
DROP TABLE IF EXISTS `xb_juan_sendsets`;
CREATE TABLE `xb_juan_sendsets` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL COMMENT '送券名称',
  `Money` int(11) DEFAULT NULL COMMENT '优惠劵金额',
  `StartMoney` int(11) DEFAULT NULL COMMENT '使用条件,必须大于这个金额才能用',
  `StartTime` datetime DEFAULT NULL COMMENT '有效期开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '有效期结束时间',
  `Nunbs` int(11) DEFAULT '0' COMMENT '送券个数',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1启用 0关闭',
  `Sort` int(11) DEFAULT '999' COMMENT '排序  0-999越小越靠前',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否删除 1 是 0 否',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='送券设置表';

-- ----------------------------
-- Records of xb_juan_sendsets
-- ----------------------------
INSERT INTO `xb_juan_sendsets` VALUES ('1', '注册成功立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '0', '999', '0', '2', '2018-08-26 17:59:23');
INSERT INTO `xb_juan_sendsets` VALUES ('2', '完成所有认证立送', '20', '1200', '2018-07-06 00:00:00', '2018-09-07 00:00:00', '1', '1', '999', '0', '2', '2018-07-30 10:30:31');
INSERT INTO `xb_juan_sendsets` VALUES ('3', '每邀请1名好友注册立送', '10', '1000', '2018-07-30 00:00:00', '2018-08-31 00:00:00', '1', '1', '999', '0', '2', '2018-07-30 10:47:14');
INSERT INTO `xb_juan_sendsets` VALUES ('4', '邀请的好友认证成功立送', '20', '1200', '2018-07-31 00:00:00', '2018-08-31 00:00:00', '1', '1', '999', '0', '2', '2018-07-30 10:29:09');
INSERT INTO `xb_juan_sendsets` VALUES ('5', '邀请的好友申请专卖成功立送', '10', '1000', '2018-08-01 00:00:00', '2018-08-04 00:00:00', '1', '1', '999', '0', '2', '2018-07-30 10:28:37');
