/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_administrator`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_administrator`;
CREATE TABLE `xb_sys_administrator` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `UserName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `Password` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '密码',
  `TrueName` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '真实姓名',
  `RoleID` int(11) NOT NULL COMMENT '角色ID',
  `LoginCount` int(11) DEFAULT '0' COMMENT '登录次数',
  `ErrorCount` int(11) DEFAULT '0' COMMENT '密码错误次数',
  `ErrorTime` datetime DEFAULT NULL COMMENT '最后一次错误时间',
  `LoginTime` datetime DEFAULT NULL COMMENT '最后登录时间',
  `LoginIP` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '最后登录ip',
  `LoginMAC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '登录MAC地址',
  `BindIP` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '绑定IP地址',
  `BindMAC` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '绑定MAC地址',
  `Status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用0停用 1启用',
  `IsDel` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 1删除 0不删除',
  `IpCity` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'IP所在城市',
  `OperatorID` int(11) DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_administrator
-- ----------------------------
INSERT INTO `xb_sys_administrator` VALUES ('1', 'xbadmin', '7fef6171469e80d32c0559f88b377245', 'xbadmin', '1', '96', '2', '2018-08-18 14:23:26', '2018-08-18 14:21:02', '60.168.54.35', '00-E0-70-08-F0-E3', '192.168.1.103', '', '1', '0', '', '31', '2017-06-07 09:41:55');
INSERT INTO `xb_sys_administrator` VALUES ('2', 'admin', '21232f297a57a5a743894a0e4a801fc3', '超级管理员', '2', '545', '0', '2018-08-23 09:00:09', '2018-08-28 14:08:14', '60.168.222.127', '1C-1B-0D-95-E8-00', '0.0.0.0', '1C-1B-0D-95-E8-00', '1', '0', '安徽省合肥市电信', '31', '2017-10-19 15:03:03');
INSERT INTO `xb_sys_administrator` VALUES ('14', 'diaohq', '14e1b600b1fd579f47433b88e8d85291', '刁洪强', '2', '0', '10', '2017-08-17 09:39:50', null, null, null, null, null, '1', '1', null, '1', '2017-05-20 10:47:16');
INSERT INTO `xb_sys_administrator` VALUES ('22', 'test', 'e10adc3949ba59abbe56e057f20f883e', 'tsfdsfs', '4', '1', '0', '2017-05-20 12:24:52', '2017-05-20 12:25:33', '0.0.0.0', '', null, null, '1', '1', '   ', '31', '2017-06-07 09:43:06');
INSERT INTO `xb_sys_administrator` VALUES ('24', 'cc1', 'cbb3586665ebdbc6ebadd796e3ba5bcf', 'cc', '2', '0', '0', null, null, null, null, null, null, '1', '1', null, '22', '2017-05-20 12:29:13');
INSERT INTO `xb_sys_administrator` VALUES ('25', 'ccc2', '069a5dccefea1206d0a6cb426dede833', 'cccc', '3', '0', '0', null, null, null, null, null, null, '1', '1', null, '22', '2017-05-20 12:35:07');
INSERT INTO `xb_sys_administrator` VALUES ('26', 'cc3', '21232f297a57a5a743894a0e4a801fc3', 'cc', '4', '0', '0', null, null, null, null, null, null, '1', '1', null, '31', '2017-06-13 09:38:57');
INSERT INTO `xb_sys_administrator` VALUES ('27', 'c4', 'e10adc3949ba59abbe56e057f20f883e', '123456', '2', '0', '0', null, null, null, null, null, null, '1', '1', null, '22', '2017-05-20 12:52:18');
INSERT INTO `xb_sys_administrator` VALUES ('28', 'c5', 'e10adc3949ba59abbe56e057f20f883e', 'c5', '2', '0', '0', null, null, null, null, null, null, '1', '1', null, '31', '2017-06-13 09:36:12');
INSERT INTO `xb_sys_administrator` VALUES ('29', 'c6', 'e10adc3949ba59abbe56e057f20f883e', 'c6', '2', '0', '0', null, null, null, null, null, null, '1', '1', null, '22', '2017-05-20 13:05:43');
INSERT INTO `xb_sys_administrator` VALUES ('30', '111', '698d51a19d8a121ce581499d7b701668', '111', '2', '0', '11', null, null, null, null, null, null, '1', '1', null, '1', '2017-06-02 14:00:04');
INSERT INTO `xb_sys_administrator` VALUES ('32', 'fdsfs12', '13bbf54a6850c393fb8d1b2b3bba997b', 'fds', '4', '0', '0', null, null, null, null, null, null, '1', '1', null, '31', '2017-06-07 09:44:01');
INSERT INTO `xb_sys_administrator` VALUES ('33', 'test111', 'e10adc3949ba59abbe56e057f20f883e', '12', '4', '1', '0', null, '2017-08-16 08:31:10', '0.0.0.0', null, null, null, '1', '1', null, '31', '2017-08-16 08:30:59');
INSERT INTO `xb_sys_administrator` VALUES ('34', 'diaohq', 'e10adc3949ba59abbe56e057f20f883e', '刁洪强', '6', '1', '0', null, '2017-08-17 09:47:15', '0.0.0.0', null, null, null, '1', '1', null, '31', '2017-08-17 09:53:26');
INSERT INTO `xb_sys_administrator` VALUES ('35', 'hanpanpan', 'e10adc3949ba59abbe56e057f20f883e', '韩盼盼', '7', '17', '0', null, '2017-10-19 16:35:07', '192.168.1.103', null, null, null, '1', '0', '', '2', '2018-07-09 16:46:07');
INSERT INTO `xb_sys_administrator` VALUES ('36', 'chengyanan', 'e10adc3949ba59abbe56e057f20f883e', '程雅楠', '8', '13', '0', null, '2017-12-19 17:45:15', '192.168.1.254', null, null, null, '1', '0', '', '2', '2018-07-09 16:46:32');
INSERT INTO `xb_sys_administrator` VALUES ('37', 'wangtingting', 'e10adc3949ba59abbe56e057f20f883e', '王婷婷', '8', '0', '0', null, null, null, null, null, null, '1', '0', null, '2', '2018-07-09 16:48:00');
INSERT INTO `xb_sys_administrator` VALUES ('38', 'zhanghong', 'e10adc3949ba59abbe56e057f20f883e', '张红', '7', '0', '0', null, null, null, null, null, null, '1', '0', null, '2', '2018-07-09 16:48:19');
INSERT INTO `xb_sys_administrator` VALUES ('39', 'huixinkeji', 'e10adc3949ba59abbe56e057f20f883e', '北京汇信科技有限公司', '9', '1', '0', null, '2018-07-19 18:07:39', '0.0.0.0', null, null, null, '1', '0', '', '2', '2018-07-19 15:06:19');
INSERT INTO `xb_sys_administrator` VALUES ('40', 'matujinrong', 'e10adc3949ba59abbe56e057f20f883e', '马兔金融', '9', '0', '0', null, null, null, null, null, null, '1', '0', null, '2', '2018-07-19 15:06:55');
INSERT INTO `xb_sys_administrator` VALUES ('41', 'xianglang', 'e10adc3949ba59abbe56e057f20f883e', '向浪', '7', '11', '0', null, '2018-08-26 18:36:49', '121.230.143.138', null, null, null, '1', '0', '江苏省泰州市电信', '2', '2018-08-22 13:54:25');
INSERT INTO `xb_sys_administrator` VALUES ('42', 'cuishou', 'e10adc3949ba59abbe56e057f20f883e', 'cuishou', '10', '1', '0', null, '2018-08-22 14:12:51', '60.168.54.35', null, null, null, '1', '0', '安徽省合肥市电信', '2', '2018-08-22 14:12:21');
INSERT INTO `xb_sys_administrator` VALUES ('43', 'xiexiaoyan', 'e10adc3949ba59abbe56e057f20f883e', '谢晓燕', '10', '2', '0', null, '2018-08-26 18:32:16', '121.230.143.138', null, null, null, '1', '0', '江苏省泰州市电信', '2', '2018-08-22 15:01:16');
INSERT INTO `xb_sys_administrator` VALUES ('44', 'test', 'e10adc3949ba59abbe56e057f20f883e', 'test', '11', '3', '0', null, '2018-08-22 16:41:48', '60.168.54.35', null, null, null, '1', '0', '安徽省合肥市电信', '2', '2018-08-22 16:07:08');
INSERT INTO `xb_sys_administrator` VALUES ('45', '财务测试', 'e10adc3949ba59abbe56e057f20f883e', '1', '8', '0', '0', null, null, null, null, null, null, '1', '1', null, '2', '2018-08-26 17:30:54');
INSERT INTO `xb_sys_administrator` VALUES ('46', 'liaoxiyu', 'e10adc3949ba59abbe56e057f20f883e', '廖姐', '8', '3', '0', null, '2018-08-26 18:37:20', '121.230.143.138', null, null, null, '1', '0', '江苏省泰州市电信', '2', '2018-08-26 17:32:42');
