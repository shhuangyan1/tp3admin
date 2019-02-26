/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:17:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_mem_info`
-- ----------------------------
DROP TABLE IF EXISTS `xb_mem_info`;
CREATE TABLE `xb_mem_info` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MemAccount` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '会员账号(UID_ID)',
  `NickName` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '会员昵称',
  `UserName` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '用户名',
  `Password` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '登录密码',
  `OpenId` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方微信登录获取的ID',
  `QQID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '第三方QQ登录获取的ID',
  `Mobile` varchar(32) CHARACTER SET utf8 NOT NULL COMMENT '手机号码',
  `Email` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '邮箱账号',
  `HeadImg` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用户头像',
  `TrueName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '真实姓名',
  `IDCard` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会员身份证号',
  `Sex` int(11) DEFAULT '0' COMMENT '性别 0 保密 1 男 2 女',
  `BorthDate` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LimitBalcance` decimal(10,2) DEFAULT '0.00' COMMENT '额度',
  `ForbidTime` datetime DEFAULT NULL COMMENT '禁止借款截止时间',
  `Status` int(11) DEFAULT '1' COMMENT '会员状态 1待审核 2审核通过 3禁用 4黑名单',
  `LoginClient` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '本次登录的app(ios或android)',
  `DeviceToken` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '友盟设备的唯一标识',
  `ZsAdminID` int(11) DEFAULT NULL COMMENT '专属客服',
  `Referee` int(11) DEFAULT '0' COMMENT '推荐人',
  `TgadminID` int(11) DEFAULT NULL COMMENT '推广渠道id',
  `Retype` tinyint(4) unsigned DEFAULT '0' COMMENT '注册来源 0网页 1安卓 2苹果',
  `Mtype` tinyint(4) unsigned DEFAULT '0' COMMENT '会员类型 0正常 1测试',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 0 未删除 1 已删除',
  `RegTime` datetime DEFAULT NULL COMMENT '注册时间',
  `LastLoginTime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `LoginTime` datetime DEFAULT NULL COMMENT '登录时间',
  `LastLoginIP` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '上次登录IP',
  `LoginIP` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '登录IP',
  `LastIpCity` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '上次登录城市',
  `IpCity` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '登录城市',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `Token` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '私有token',
  `KEY` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '私有key',
  `IV` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '私有iv',
  PRIMARY KEY (`ID`),
  KEY `Referee` (`Referee`),
  KEY `Mobile` (`Mobile`),
  KEY `Status` (`Status`),
  KEY `TgadminID` (`TgadminID`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_mem_info
-- ----------------------------
INSERT INTO `xb_mem_info` VALUES ('1', 'UID_1', '醉爱玉兰香1', 'user_100001', 'e10adc3949ba59abbe56e057f20f883e', null, null, '17602186118', '89902295@qq.com', '/Upload/Large/Head.png', '任凯', '340881199307025933', '0', '', '1000.00', '2018-08-18 13:25:22', '2', null, null, null, '0', '1', '0', '0', '0', '2018-07-19 11:40:09', '2018-08-19 14:15:22', '2018-08-21 10:55:58', '127.0.0.1', '47.96.88.25', '', null, '2', '2018-08-18 13:25:22', '0B7705BA8BE640729C8D39B22F11B1638A22517D2047A13A1BE315E508B4', 'KEY8BCE83F11644292E409929152B1BF', 'IV0DF7414507BCB5');
INSERT INTO `xb_mem_info` VALUES ('6', '', '13505609484', 'user_100006', '4297f44b13955235245b2497399d7a93', null, null, '13505609484', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '0', '0', '1', '2017-12-18 15:01:26', '2017-12-19 08:54:55', '2017-12-19 13:16:20', '192.168.1.254', '192.168.1.254', '', '', null, '2017-12-18 16:11:42', '46882640c4d7ceb9e59970907e954428c870abdf10726f30beb2c9fd6e00', 'XB882640c4d7ceb9e59970907e9544a2', 'XB4c63db369ac7dd');
INSERT INTO `xb_mem_info` VALUES ('8', 'UID_8', 'guser_7935', '18365266892', 'BAE632067572F819CF7C0', null, null, '18365266892', null, '/Upload/image/2018-08-20/5b7a87cfb2000.png', '王泽川', '340103199308064515', '0', '', '4000.00', '2018-08-27 08:57:32', '2', null, null, '41', '0', null, '2', '0', '0', '2018-08-20 13:34:18', '2018-08-28 14:09:10', '2018-08-28 14:18:40', '60.168.222.127', '60.168.222.127', '安徽省合肥市电信', '安徽省合肥市电信', '2', '2018-08-27 08:57:32', '55624694BCEA9EFE1F9F27AC00AA7460157AC1037F9111088856154A4E03', 'KEYA1639A19B1598344221E4CEC94980', 'IV3510C3CB8B9403');
INSERT INTO `xb_mem_info` VALUES ('9', 'UID_9', 'guser_3772', '17755122594', '914934637F61EDECF6E90', null, null, '17755122594', null, '/Upload/image/2018-08-20/5b7a8cf84ce48.jpg', '徐友根', '342401199510253411', '0', '', '4000.00', '2018-08-27 09:13:25', '2', null, null, '38', '0', null, '1', '0', '0', '2018-08-20 13:53:33', '2018-08-28 08:47:45', '2018-08-28 08:51:44', '60.168.222.127', '60.168.222.127', '安徽省合肥市电信', '安徽省合肥市电信', '2', '2018-08-27 09:13:25', '3D56A97237D925589A9C214BD8B0FABCA1125F864105A39C084F3E577F6E', 'KEY1E97B25F6D03EC11AEA834BF5E283', 'IVB5188B281D6402');
INSERT INTO `xb_mem_info` VALUES ('10', 'UID_10', 'guser_9557', '15856966203', '914934637F61EDECF6E90', null, null, '15856966203', null, '/Upload/image/2018-08-21/5b7bfc12c9d75.jpg', '沈翠宏', '340111199205102021', '0', '', '4000.00', '2018-08-25 11:42:35', '2', null, null, '41', '0', null, '1', '0', '0', '2018-08-21 18:36:00', '2018-08-25 11:24:51', '2018-08-25 11:36:53', '60.168.44.133', '60.168.44.133', '安徽省合肥市电信', '安徽省合肥市电信', '2', '2018-08-25 11:42:56', 'EFFDDF0EF022C0097BBB94EEBFAAAF51C24FE26494E6F42092E7C03AE217', 'KEY28D9D8254B7F2D17BE5B394E8B72F', 'IV7A739AD638C90A');
INSERT INTO `xb_mem_info` VALUES ('12', 'UID_12', 'guser_16663', '13961089009', '914934637F61EDECF6E90', null, null, '13961089009', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '1', '0', '0', '2018-08-21 21:58:12', '2018-08-23 15:02:32', '2018-08-26 17:14:26', '114.233.198.227', '121.230.143.138', '江苏省泰州市电信', '江苏省泰州市电信', null, null, '00867CAB74D6AC335517D75752C12E076DCB6D9393B5D548DC6255F0969A', 'KEYB4FD75A937FE68EE2FD7E41E54BB9', 'IVA8804EAB7DE237');
INSERT INTO `xb_mem_info` VALUES ('13', 'UID_13', 'guser_11731', '18656474098', '914934637F61EDECF6E90', null, null, '18656474098', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '1', '0', '0', '2018-08-22 09:24:38', null, '2018-08-22 09:24:38', null, '60.168.54.35', null, '安徽省合肥市电信', null, null, '', 'KEYD352EAD85FD9340EE6470096A5DA5', '');
INSERT INTO `xb_mem_info` VALUES ('14', 'UID_14', 'guser_25859', '13535316072', '9C0363BA853A215FB156B', null, null, '13535316072', null, null, '林良庚', '441702198403061730', '0', null, '500.00', '2018-08-22 15:07:08', '2', null, null, null, '0', null, '1', '0', '0', '2018-08-22 09:41:02', '2018-08-24 14:54:18', '2018-08-25 21:16:22', '49.85.119.123', '122.96.43.144', '江苏省泰州市电信', '江苏省南京市联通', null, '2018-08-22 15:07:08', '', 'KEY6CFAA5C0E54FD89163D2394BE1268', '');
INSERT INTO `xb_mem_info` VALUES ('15', 'UID_15', 'guser_8230', '17315670205', '9EF501F04E99FBC7E4985', null, null, '17315670205', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '1', '0', '0', '2018-08-22 10:24:33', null, '2018-08-22 10:24:37', null, '106.111.1.76', null, '江苏省泰州市电信', null, null, '7C9D964F1575424A23339C76151DB83CA72DB8723C9DFBF14F2F356DC38F', 'KEYFDB23931D7AF73DB945EF97FA566A', 'IV79BFFCDBA49CC6');
INSERT INTO `xb_mem_info` VALUES ('16', 'UID_16', 'guser_16496', '17520074491', '27AB3E567CC3AFACE0486', null, null, '17520074491', null, null, '王彬', '330282199705084252', '0', null, '500.00', null, '2', null, null, null, '0', null, '1', '0', '0', '2018-08-22 10:36:04', null, '2018-08-22 10:36:27', null, '106.111.1.76', null, '江苏省泰州市电信', null, '2018-08-22 10:41:33', '', 'KEY373E5DEC48BC79562A81BA78EF7F6', '');
INSERT INTO `xb_mem_info` VALUES ('19', 'UID_19', 'guser_26825', '18877310084', 'EA95AC027A3B46C82985B', null, null, '18877310084', null, null, '甘俊才', '450922199404231510', '0', null, '500.00', '2018-08-22 15:29:04', '2', null, null, null, '0', null, '1', '0', '0', '2018-08-22 10:43:13', '2018-08-22 15:34:04', '2018-08-24 12:21:14', '60.168.54.35', '49.85.119.123', '安徽省合肥市电信', '江苏省泰州市电信', null, '2018-08-22 15:29:04', '', 'KEY634F31B12220DC9649A27D1BB9E45', '');
INSERT INTO `xb_mem_info` VALUES ('21', 'UID_21', 'guser_14452', '13814454042', '77D9A11250C5DD68BC85F', null, null, '13814454042', null, null, '彭贤伟', '511028198908270072', '0', null, '500.00', '2018-09-02 14:30:23', '2', null, null, '41', '0', null, '2', '0', '0', '2018-08-23 12:06:17', '2018-08-23 12:06:17', '2018-08-23 12:22:57', '106.111.1.254', '106.111.1.254', '江苏省泰州市电信', '江苏省泰州市电信', null, '2018-08-23 14:30:23', '', 'KEYCD8B49799C450C44C9602A6411E53', '');
INSERT INTO `xb_mem_info` VALUES ('22', 'UID_22', 'guser_19518', '13040164693', '9C0363BA853A215FB156B', null, null, '13040164693', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '1', '0', '0', '2018-08-26 16:31:30', '2018-08-26 16:31:36', '2018-08-26 17:16:50', '114.233.198.133', '114.233.198.133', '江苏省泰州市电信', '江苏省泰州市电信', null, null, '330F858A8F64FA4E19549A4D19E9BF01460FD63ACE2EF81BF12754DB8D88', 'KEY0F1453C64327AB968E1EA0C8032BD', 'IV9BA756CD13EFCE');
INSERT INTO `xb_mem_info` VALUES ('23', 'UID_23', 'guser_21245', '13385607663', '623A7CC4E83B681C3B6B6', null, null, '13385607663', null, null, null, null, '0', null, '0.00', null, '1', null, null, null, '0', null, '1', '0', '0', '2018-08-27 15:55:10', null, '2018-08-27 15:55:10', null, '36.60.159.14', null, '安徽省宿州市电信', null, null, 'DED61B7249FC3512F2B3FD973CE342180E1096849B89D0CCD5CA8606A82F', 'KEYFB006E83EA07A043EFE931ACDD6BD', 'IVE20FB824FBBC5D');
