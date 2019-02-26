/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_menubutton`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_menubutton`;
CREATE TABLE `xb_sys_menubutton` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MenuID` int(11) NOT NULL DEFAULT '0',
  `ButtonID` int(255) NOT NULL DEFAULT '0' COMMENT '按钮id',
  `ButtonURL` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '访问地址',
  `ButtonSaveURL` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '提交地址',
  `Width` varchar(60) COLLATE utf8_bin DEFAULT '0' COMMENT '宽度',
  `Height` varchar(60) COLLATE utf8_bin DEFAULT '0' COMMENT '高度',
  `OpenMode` tinyint(2) DEFAULT '0' COMMENT '打开方式',
  `IsFunction` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '操作后执行函数',
  `Status` int(11) DEFAULT '1' COMMENT '状态 1  正常 0  禁用',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 1 是 0 否',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2028 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_menubutton
-- ----------------------------
INSERT INTO `xb_sys_menubutton` VALUES ('62', '24', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 14:55:27');
INSERT INTO `xb_sys_menubutton` VALUES ('63', '24', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 14:55:27');
INSERT INTO `xb_sys_menubutton` VALUES ('64', '24', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 14:55:27');
INSERT INTO `xb_sys_menubutton` VALUES ('65', '24', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 14:55:27');
INSERT INTO `xb_sys_menubutton` VALUES ('66', '24', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-05-05 14:55:27');
INSERT INTO `xb_sys_menubutton` VALUES ('72', '28', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menubutton` VALUES ('73', '28', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menubutton` VALUES ('74', '28', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menubutton` VALUES ('75', '28', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menubutton` VALUES ('76', '28', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menubutton` VALUES ('77', '29', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menubutton` VALUES ('78', '29', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menubutton` VALUES ('79', '29', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menubutton` VALUES ('80', '29', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menubutton` VALUES ('81', '29', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menubutton` VALUES ('318', '2', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menubutton` VALUES ('319', '2', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menubutton` VALUES ('320', '2', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menubutton` VALUES ('321', '2', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menubutton` VALUES ('322', '2', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menubutton` VALUES ('337', '20', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menubutton` VALUES ('338', '20', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menubutton` VALUES ('339', '20', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menubutton` VALUES ('340', '20', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menubutton` VALUES ('341', '20', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menubutton` VALUES ('841', '3', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-06 18:43:18');
INSERT INTO `xb_sys_menubutton` VALUES ('842', '3', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-06 18:43:18');
INSERT INTO `xb_sys_menubutton` VALUES ('843', '3', '7', '', '', '0', '0', '4', '', '1', '0', null, '2017-06-06 18:43:18');
INSERT INTO `xb_sys_menubutton` VALUES ('844', '3', '9', '', '', '0', '0', '4', '', '1', '0', null, '2017-06-06 18:43:18');
INSERT INTO `xb_sys_menubutton` VALUES ('845', '3', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-06 18:43:18');
INSERT INTO `xb_sys_menubutton` VALUES ('972', '16', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('973', '16', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('974', '16', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('975', '16', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('976', '16', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('977', '16', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('978', '16', '30', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('979', '16', '31', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('980', '16', '32', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-08 20:46:23');
INSERT INTO `xb_sys_menubutton` VALUES ('981', '18', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-09 11:53:41');
INSERT INTO `xb_sys_menubutton` VALUES ('982', '18', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-09 11:53:41');
INSERT INTO `xb_sys_menubutton` VALUES ('983', '18', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-09 11:53:41');
INSERT INTO `xb_sys_menubutton` VALUES ('984', '18', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-09 11:53:41');
INSERT INTO `xb_sys_menubutton` VALUES ('985', '18', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-09 11:53:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1050', '26', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 10:24:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1051', '26', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 10:24:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1052', '26', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 10:24:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1053', '26', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 10:24:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1054', '26', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-17 10:24:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1073', '88', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1074', '88', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1075', '88', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1076', '88', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1077', '88', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1078', '88', '38', 'Integrate/Setting/Edit', 'Integrate/Setting/Save', '0', '0', '0', '', '1', '0', null, '2017-06-17 11:42:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1085', '31', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1086', '31', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1087', '31', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1088', '31', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1089', '31', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1090', '31', '38', 'Integrate/Setting/Edit', 'Integrate/Setting/Save', '0', '0', '0', '', '1', '0', null, '2017-06-17 13:39:11');
INSERT INTO `xb_sys_menubutton` VALUES ('1121', '62', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1122', '62', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1123', '62', '16', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1124', '62', '33', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1125', '62', '17', '', '', '0', '0', '5', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1126', '62', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-08-17 09:35:30');
INSERT INTO `xb_sys_menubutton` VALUES ('1127', '17', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1128', '17', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1129', '17', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1130', '17', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1131', '17', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1132', '17', '13', '', 'System/Role/rolemenusave', '750', '450', '0', '', '1', '0', null, '2017-08-17 18:36:09');
INSERT INTO `xb_sys_menubutton` VALUES ('1138', '43', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 18:36:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1139', '43', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-08-17 18:36:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1140', '43', '7', '', '', '0', '0', '4', '', '1', '0', null, '2017-08-17 18:36:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1141', '43', '9', '', '', '0', '0', '4', '', '1', '0', null, '2017-08-17 18:36:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1142', '43', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-08-17 18:36:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1282', '22', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-10-19 21:40:59');
INSERT INTO `xb_sys_menubutton` VALUES ('1283', '22', '4', '', '', '0', '0', '0', '', '1', '0', null, '2017-10-19 21:40:59');
INSERT INTO `xb_sys_menubutton` VALUES ('1320', '96', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-13 11:15:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1321', '96', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-13 11:15:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1322', '96', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-13 11:15:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1323', '96', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-13 11:15:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1324', '96', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-12-13 11:15:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1334', '42', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-13 14:42:03');
INSERT INTO `xb_sys_menubutton` VALUES ('1335', '42', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-13 14:42:03');
INSERT INTO `xb_sys_menubutton` VALUES ('1336', '42', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-13 14:42:03');
INSERT INTO `xb_sys_menubutton` VALUES ('1337', '42', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-13 14:42:03');
INSERT INTO `xb_sys_menubutton` VALUES ('1338', '42', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-12-13 14:42:03');
INSERT INTO `xb_sys_menubutton` VALUES ('1347', '98', '2', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-18 08:54:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1348', '98', '7', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-18 08:54:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1349', '98', '9', '', '', '0', '0', '0', '', '1', '0', null, '2017-12-18 08:54:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1350', '98', '1', '', '', '0', '0', '2', '', '1', '0', null, '2017-12-18 08:54:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1351', '98', '4', '', '', '0', '0', '3', '', '1', '0', null, '2017-12-18 08:54:24');
INSERT INTO `xb_sys_menubutton` VALUES ('1406', '112', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-28 16:52:14');
INSERT INTO `xb_sys_menubutton` VALUES ('1407', '112', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-28 16:52:14');
INSERT INTO `xb_sys_menubutton` VALUES ('1408', '112', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-06-28 16:52:14');
INSERT INTO `xb_sys_menubutton` VALUES ('1433', '111', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-28 18:09:18');
INSERT INTO `xb_sys_menubutton` VALUES ('1434', '111', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-28 18:09:18');
INSERT INTO `xb_sys_menubutton` VALUES ('1435', '111', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-06-28 18:09:18');
INSERT INTO `xb_sys_menubutton` VALUES ('1436', '111', '20', '', 'Renzen/Cards/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-06-28 18:09:18');
INSERT INTO `xb_sys_menubutton` VALUES ('1445', '115', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-29 09:06:43');
INSERT INTO `xb_sys_menubutton` VALUES ('1446', '115', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-29 09:06:43');
INSERT INTO `xb_sys_menubutton` VALUES ('1447', '115', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-06-29 09:06:43');
INSERT INTO `xb_sys_menubutton` VALUES ('1448', '115', '20', '', 'Renzen/Alipay/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-06-29 09:06:43');
INSERT INTO `xb_sys_menubutton` VALUES ('1453', '116', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-29 10:55:23');
INSERT INTO `xb_sys_menubutton` VALUES ('1454', '116', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-06-29 10:55:23');
INSERT INTO `xb_sys_menubutton` VALUES ('1455', '116', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-06-29 10:55:23');
INSERT INTO `xb_sys_menubutton` VALUES ('1456', '116', '20', '', 'Renzen/Taobao/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-06-29 10:55:23');
INSERT INTO `xb_sys_menubutton` VALUES ('1481', '122', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-02 17:33:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1482', '122', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-02 17:33:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1483', '122', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-02 17:33:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1484', '122', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-02 17:33:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1485', '122', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-02 17:33:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1491', '124', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-02 18:38:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1492', '124', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-02 18:38:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1493', '124', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-02 18:38:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1494', '124', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-02 18:38:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1495', '124', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-02 18:38:42');
INSERT INTO `xb_sys_menubutton` VALUES ('1520', '125', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1521', '125', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1522', '125', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1523', '125', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1524', '125', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1525', '125', '38', 'Integrate/Setting/Edit', 'Integrate/Setting/Save', '0', '0', '0', '', '1', '0', null, '2018-07-04 08:47:37');
INSERT INTO `xb_sys_menubutton` VALUES ('1541', '127', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 10:22:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1542', '127', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 10:22:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1543', '127', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 10:22:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1544', '127', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 10:22:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1545', '127', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-04 10:22:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1546', '128', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 10:41:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1547', '128', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-04 10:41:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1548', '128', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 10:41:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1549', '128', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-04 10:41:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1550', '128', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-04 10:41:28');
INSERT INTO `xb_sys_menubutton` VALUES ('1675', '135', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-10 16:16:19');
INSERT INTO `xb_sys_menubutton` VALUES ('1676', '135', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-10 16:16:19');
INSERT INTO `xb_sys_menubutton` VALUES ('1677', '135', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-10 16:16:19');
INSERT INTO `xb_sys_menubutton` VALUES ('1678', '135', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-10 16:16:19');
INSERT INTO `xb_sys_menubutton` VALUES ('1679', '135', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-10 16:16:19');
INSERT INTO `xb_sys_menubutton` VALUES ('1694', '134', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1695', '134', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1696', '134', '43', '', 'Loans/Fangkuanlist/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1697', '134', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1698', '134', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1699', '134', '41', '', 'Loans/Fangkuanlist/zordersave', '0', '0', '0', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1700', '134', '44', '', 'Loans/Fangkuanlist/cancelsave', '0', '0', '0', '', '1', '0', null, '2018-07-10 18:52:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1711', '136', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-11 11:36:32');
INSERT INTO `xb_sys_menubutton` VALUES ('1712', '136', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-11 11:36:32');
INSERT INTO `xb_sys_menubutton` VALUES ('1713', '136', '20', '', 'Loans/Hklist/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-11 11:36:32');
INSERT INTO `xb_sys_menubutton` VALUES ('1714', '136', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-11 11:36:32');
INSERT INTO `xb_sys_menubutton` VALUES ('1715', '136', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-07-11 11:36:32');
INSERT INTO `xb_sys_menubutton` VALUES ('1749', '95', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1750', '95', '7', '', '', '0', '0', '4', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1751', '95', '9', '', '', '0', '0', '4', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1752', '95', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1753', '95', '14', '', '', '0', '0', '4', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1754', '95', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1755', '95', '4', 'Api/Api/del', '', '0', '0', '3', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1756', '95', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1757', '95', '39', '', '', '0', '0', '4', '', '1', '0', null, '2018-07-14 11:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1766', '23', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-17 09:38:56');
INSERT INTO `xb_sys_menubutton` VALUES ('1767', '23', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-17 09:38:56');
INSERT INTO `xb_sys_menubutton` VALUES ('1768', '23', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-17 09:38:56');
INSERT INTO `xb_sys_menubutton` VALUES ('1773', '117', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:46:16');
INSERT INTO `xb_sys_menubutton` VALUES ('1774', '117', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:46:16');
INSERT INTO `xb_sys_menubutton` VALUES ('1775', '117', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-19 10:46:16');
INSERT INTO `xb_sys_menubutton` VALUES ('1776', '117', '20', '', 'Renzen/Memberinfo/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-19 10:46:16');
INSERT INTO `xb_sys_menubutton` VALUES ('1777', '118', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:46:26');
INSERT INTO `xb_sys_menubutton` VALUES ('1778', '118', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:46:26');
INSERT INTO `xb_sys_menubutton` VALUES ('1779', '118', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-19 10:46:26');
INSERT INTO `xb_sys_menubutton` VALUES ('1780', '118', '20', '', 'Renzen/Social/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-19 10:46:26');
INSERT INTO `xb_sys_menubutton` VALUES ('1781', '139', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:48:12');
INSERT INTO `xb_sys_menubutton` VALUES ('1782', '139', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 10:48:12');
INSERT INTO `xb_sys_menubutton` VALUES ('1783', '139', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-19 10:48:12');
INSERT INTO `xb_sys_menubutton` VALUES ('1784', '139', '20', '', 'Renzen/Bank/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-19 10:48:12');
INSERT INTO `xb_sys_menubutton` VALUES ('1785', '131', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 11:51:00');
INSERT INTO `xb_sys_menubutton` VALUES ('1786', '131', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 11:51:00');
INSERT INTO `xb_sys_menubutton` VALUES ('1787', '131', '20', '', 'Bank/Info/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-19 11:51:00');
INSERT INTO `xb_sys_menubutton` VALUES ('1788', '132', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 11:51:54');
INSERT INTO `xb_sys_menubutton` VALUES ('1789', '132', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 11:51:54');
INSERT INTO `xb_sys_menubutton` VALUES ('1790', '132', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 11:51:54');
INSERT INTO `xb_sys_menubutton` VALUES ('1791', '132', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 11:51:54');
INSERT INTO `xb_sys_menubutton` VALUES ('1792', '132', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-19 11:51:54');
INSERT INTO `xb_sys_menubutton` VALUES ('1793', '141', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:44:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1794', '141', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:44:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1795', '141', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 14:44:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1796', '141', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 14:44:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1797', '141', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-19 14:44:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1801', '142', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1802', '142', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1803', '142', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-07-19 14:46:08');
INSERT INTO `xb_sys_menubutton` VALUES ('1805', '144', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:50:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1806', '144', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:50:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1807', '144', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 14:50:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1808', '144', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-19 14:50:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1809', '144', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-19 14:50:44');
INSERT INTO `xb_sys_menubutton` VALUES ('1810', '143', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-19 14:51:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1811', '146', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-20 09:09:13');
INSERT INTO `xb_sys_menubutton` VALUES ('1812', '146', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-20 09:09:13');
INSERT INTO `xb_sys_menubutton` VALUES ('1813', '146', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-07-20 09:09:13');
INSERT INTO `xb_sys_menubutton` VALUES ('1820', '32', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1821', '32', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1822', '32', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1823', '32', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1824', '32', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1825', '32', '38', 'Integrate/Setting/Edit', 'Integrate/Setting/Save', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:25');
INSERT INTO `xb_sys_menubutton` VALUES ('1826', '89', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1827', '89', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1828', '89', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1829', '89', '4', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1830', '89', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1831', '89', '38', 'Integrate/Setting/Edit', 'Integrate/Setting/Save', '0', '0', '0', '', '1', '0', null, '2018-07-23 15:47:35');
INSERT INTO `xb_sys_menubutton` VALUES ('1903', '119', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1904', '119', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1905', '119', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1906', '119', '20', '', 'Renzen/Mobile/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1907', '119', '46', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1908', '119', '47', '', '', '0', '0', '7', '', '1', '0', null, '2018-07-25 19:05:41');
INSERT INTO `xb_sys_menubutton` VALUES ('1926', '133', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1927', '133', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1928', '133', '20', '', 'Loans/Applylist/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1929', '133', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1930', '133', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1931', '133', '41', '', 'Loans/Applylist/zordersave', '0', '0', '0', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1932', '133', '46', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1933', '133', '47', '', '', '0', '0', '7', '', '1', '0', null, '2018-07-25 19:39:31');
INSERT INTO `xb_sys_menubutton` VALUES ('1934', '108', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-26 11:28:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1935', '108', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-26 11:28:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1936', '108', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-26 11:28:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1937', '108', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-26 11:28:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1956', '97', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-26 18:08:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1957', '97', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-26 18:08:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1958', '97', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-07-26 18:08:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1959', '97', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-26 18:08:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1960', '97', '42', '', 'Help/Message/savehandle', '0', '0', '0', '', '1', '0', null, '2018-07-26 18:08:17');
INSERT INTO `xb_sys_menubutton` VALUES ('1961', '103', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1962', '103', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1963', '103', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1964', '103', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1965', '103', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1966', '103', '40', '', 'Juan/Coupans/sendjuan', '0', '0', '4', '', '1', '0', null, '2018-07-30 10:43:48');
INSERT INTO `xb_sys_menubutton` VALUES ('1967', '104', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:43:57');
INSERT INTO `xb_sys_menubutton` VALUES ('1968', '104', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:43:57');
INSERT INTO `xb_sys_menubutton` VALUES ('1969', '104', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-07-30 10:43:57');
INSERT INTO `xb_sys_menubutton` VALUES ('1970', '148', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:44:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1971', '148', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-07-30 10:44:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1972', '148', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-07-30 10:44:52');
INSERT INTO `xb_sys_menubutton` VALUES ('1973', '149', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-01 18:55:47');
INSERT INTO `xb_sys_menubutton` VALUES ('1980', '138', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-06 16:05:51');
INSERT INTO `xb_sys_menubutton` VALUES ('1981', '138', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-06 16:05:51');
INSERT INTO `xb_sys_menubutton` VALUES ('1982', '138', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-08-06 16:05:51');
INSERT INTO `xb_sys_menubutton` VALUES ('1983', '150', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-06 16:21:06');
INSERT INTO `xb_sys_menubutton` VALUES ('1984', '150', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-06 16:21:06');
INSERT INTO `xb_sys_menubutton` VALUES ('1985', '150', '20', '', 'Loans/Xjapplylist/aduitsave', '0', '0', '0', '', '1', '0', null, '2018-08-06 16:21:06');
INSERT INTO `xb_sys_menubutton` VALUES ('1986', '150', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-08-06 16:21:06');
INSERT INTO `xb_sys_menubutton` VALUES ('1987', '150', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-08-06 16:21:06');
INSERT INTO `xb_sys_menubutton` VALUES ('1988', '137', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1989', '137', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1990', '137', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1991', '137', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1992', '137', '45', '', '', '0', '0', '3', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1993', '137', '41', '', 'Loans/Yuqilist/zordersave', '0', '0', '0', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('1994', '137', '48', '', 'Loans/Yuqilist/csdatasave', '0', '0', '0', '', '1', '0', null, '2018-08-07 10:04:50');
INSERT INTO `xb_sys_menubutton` VALUES ('2007', '114', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2008', '114', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2009', '114', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2010', '114', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2011', '114', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2012', '114', '14', '', '', '0', '0', '1', '', '1', '0', null, '2018-08-18 09:48:44');
INSERT INTO `xb_sys_menubutton` VALUES ('2017', '151', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-20 19:00:19');
INSERT INTO `xb_sys_menubutton` VALUES ('2018', '151', '7', '', '', '0', '0', '0', '', '1', '0', null, '2018-08-20 19:00:19');
INSERT INTO `xb_sys_menubutton` VALUES ('2019', '151', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-08-20 19:00:19');
INSERT INTO `xb_sys_menubutton` VALUES ('2020', '151', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-08-20 19:00:19');
INSERT INTO `xb_sys_menubutton` VALUES ('2021', '91', '2', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2022', '91', '1', '', '', '0', '0', '2', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2023', '91', '4', '', '', '0', '0', '3', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2024', '91', '9', '', '', '0', '0', '0', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2025', '91', '14', '', '', '800', '0', '1', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2026', '91', '15', '', '', '0', '0', '6', '', '1', '0', null, '2018-08-23 11:11:10');
INSERT INTO `xb_sys_menubutton` VALUES ('2027', '91', '49', '', 'Members/MemInfo/zordersave', '0', '0', '0', '', '1', '0', null, '2018-08-23 11:11:10');
