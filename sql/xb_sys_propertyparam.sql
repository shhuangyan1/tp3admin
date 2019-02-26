/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_propertyparam`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_propertyparam`;
CREATE TABLE `xb_sys_propertyparam` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PropertyID` int(11) NOT NULL COMMENT '属性设置id',
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '参数名称',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(4) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `PropertyID` (`PropertyID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='属性参数';

-- ----------------------------
-- Records of xb_sys_propertyparam
-- ----------------------------
INSERT INTO `xb_sys_propertyparam` VALUES ('1', '5', '小学', '999', '1', '0', '2', '2018-07-04 11:05:04');
INSERT INTO `xb_sys_propertyparam` VALUES ('2', '5', '初中', '999', '1', '0', '2', '2018-07-04 11:05:14');
INSERT INTO `xb_sys_propertyparam` VALUES ('3', '5', '高中', '999', '1', '0', '2', '2018-07-04 11:05:23');
INSERT INTO `xb_sys_propertyparam` VALUES ('4', '5', '大专', '999', '1', '0', '2', '2018-07-04 11:05:34');
INSERT INTO `xb_sys_propertyparam` VALUES ('5', '5', '本科', '999', '1', '0', '2', '2018-07-04 11:05:54');
INSERT INTO `xb_sys_propertyparam` VALUES ('6', '1', '工程师', '999', '1', '0', '2', '2018-07-04 11:06:34');
INSERT INTO `xb_sys_propertyparam` VALUES ('7', '1', '设计师', '999', '1', '0', '2', '2018-07-04 11:06:46');
INSERT INTO `xb_sys_propertyparam` VALUES ('8', '1', '教师', '999', '1', '0', '2', '2018-07-04 11:07:02');
INSERT INTO `xb_sys_propertyparam` VALUES ('9', '1', '服务员', '999', '1', '0', '2', '2018-07-04 11:07:11');
INSERT INTO `xb_sys_propertyparam` VALUES ('10', '1', '司机', '999', '1', '0', '2', '2018-07-04 11:07:22');
INSERT INTO `xb_sys_propertyparam` VALUES ('11', '1', '厨师', '999', '1', '0', '2', '2018-07-04 11:07:35');
INSERT INTO `xb_sys_propertyparam` VALUES ('12', '1', '理发师', '999', '1', '0', '2', '2018-07-04 11:07:50');
INSERT INTO `xb_sys_propertyparam` VALUES ('13', '1', '教练', '999', '1', '0', '2', '2018-07-04 11:08:03');
INSERT INTO `xb_sys_propertyparam` VALUES ('14', '1', '文员', '999', '1', '0', '2', '2018-07-04 11:08:25');
INSERT INTO `xb_sys_propertyparam` VALUES ('15', '1', '销售经理', '999', '1', '0', '2', '2018-07-04 11:08:34');
INSERT INTO `xb_sys_propertyparam` VALUES ('16', '1', '客服专员', '999', '1', '0', '2', '2018-07-04 11:08:55');
INSERT INTO `xb_sys_propertyparam` VALUES ('17', '1', '采购员', '999', '1', '0', '2', '2018-07-04 11:09:03');
INSERT INTO `xb_sys_propertyparam` VALUES ('18', '1', '营业员', '999', '1', '0', '2', '2018-07-04 11:09:18');
INSERT INTO `xb_sys_propertyparam` VALUES ('19', '2', '5001-10000', '999', '1', '0', '2', '2018-08-23 14:36:36');
INSERT INTO `xb_sys_propertyparam` VALUES ('20', '2', '3001-5000', '999', '1', '0', '2', '2018-08-23 14:35:47');
INSERT INTO `xb_sys_propertyparam` VALUES ('21', '2', '1000-3000', '999', '1', '0', '2', '2018-07-04 11:10:11');
INSERT INTO `xb_sys_propertyparam` VALUES ('22', '3', '妻子', '999', '1', '0', '2', '2018-07-04 11:10:49');
INSERT INTO `xb_sys_propertyparam` VALUES ('23', '3', '丈夫', '999', '1', '0', '2', '2018-07-04 11:10:58');
INSERT INTO `xb_sys_propertyparam` VALUES ('24', '3', '父亲', '999', '1', '0', '2', '2018-07-04 11:11:09');
INSERT INTO `xb_sys_propertyparam` VALUES ('25', '3', '母亲', '999', '1', '0', '2', '2018-07-04 11:11:18');
INSERT INTO `xb_sys_propertyparam` VALUES ('26', '4', '朋友', '999', '1', '0', '2', '2018-07-04 11:11:35');
INSERT INTO `xb_sys_propertyparam` VALUES ('27', '4', '同学', '999', '1', '0', '2', '2018-07-04 11:11:43');
INSERT INTO `xb_sys_propertyparam` VALUES ('28', '4', '同事', '999', '1', '0', '2', '2018-07-04 11:12:06');
INSERT INTO `xb_sys_propertyparam` VALUES ('29', '2', '5001-10000', '999', '1', '1', '2', '2018-08-23 14:36:06');
