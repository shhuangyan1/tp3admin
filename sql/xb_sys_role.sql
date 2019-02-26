/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_role`;
CREATE TABLE `xb_sys_role` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '名称',
  `MenuID` int(11) DEFAULT NULL COMMENT '菜单数',
  `Status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态 0 隐藏 1 正常',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_role
-- ----------------------------
INSERT INTO `xb_sys_role` VALUES ('1', '开发角色', '1', '1', '0', '1', '2017-06-08 14:56:21');
INSERT INTO `xb_sys_role` VALUES ('2', '管理员', '1', '1', '0', '31', '2017-10-19 15:02:13');
INSERT INTO `xb_sys_role` VALUES ('4', 'tst', '1', '1', '1', '22', '2017-05-20 14:42:47');
INSERT INTO `xb_sys_role` VALUES ('5', '1', '1', '1', '1', '1', '2017-06-02 14:09:08');
INSERT INTO `xb_sys_role` VALUES ('6', '资料员', '30', '1', '1', '31', '2017-08-17 09:53:06');
INSERT INTO `xb_sys_role` VALUES ('7', '客服专员', '120', '1', '0', '2', '2018-07-09 16:43:45');
INSERT INTO `xb_sys_role` VALUES ('8', '放款专员', '120', '1', '0', '2', '2018-07-09 16:44:54');
INSERT INTO `xb_sys_role` VALUES ('9', '推广渠道管理', '145', '1', '0', '2', '2018-07-20 08:44:44');
INSERT INTO `xb_sys_role` VALUES ('10', '催收专员', '120', '1', '0', '2', '2018-08-07 08:42:54');
INSERT INTO `xb_sys_role` VALUES ('11', '测试', '1', '1', '0', '2', '2018-08-22 16:06:09');
