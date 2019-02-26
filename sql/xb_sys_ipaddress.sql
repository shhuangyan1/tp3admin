/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_ipaddress`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_ipaddress`;
CREATE TABLE `xb_sys_ipaddress` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Country` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '国家 如中国',
  `CountryID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '国家编号  如CN',
  `Area` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '地区名称  如华东',
  `AreaID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '区域编号 如30000',
  `Region` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '省份名称 如 安徽省',
  `RegionID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '省份的区域编号',
  `City` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '城市名称 如 合肥市',
  `CityID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '城市编号 如340100',
  `County` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '区/县/地级市名称',
  `CountyID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '区/县/地级市的区域编号',
  `IpAddress` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'IP地址',
  `Isp` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '线路服务商 如 电信',
  `IspID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '线路服务商ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_ipaddress
-- ----------------------------
INSERT INTO `xb_sys_ipaddress` VALUES ('23', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.107', '内网IP', 'local', '2018-06-05 15:20:17');
INSERT INTO `xb_sys_ipaddress` VALUES ('24', '未分配或者内网IP', 'IANA', '', '', '', '', '', '', '', '', '192.168.1.78', '', '', '2017-06-15 09:08:42');
INSERT INTO `xb_sys_ipaddress` VALUES ('25', '日本', 'JP', '', '', '', '', '', '', '', '', '60.42.223.88', '', '', '2017-06-15 09:39:00');
INSERT INTO `xb_sys_ipaddress` VALUES ('26', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '127.0.0.1', '内网IP', 'local', '2018-08-15 17:56:34');
INSERT INTO `xb_sys_ipaddress` VALUES ('27', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.254', '内网IP', 'local', '2018-07-03 09:00:23');
INSERT INTO `xb_sys_ipaddress` VALUES ('28', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '61.191.61.226', '电信', '100017', '2018-07-04 17:34:03');
INSERT INTO `xb_sys_ipaddress` VALUES ('29', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.103', '内网IP', 'local', '2017-10-19 15:49:02');
INSERT INTO `xb_sys_ipaddress` VALUES ('30', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.31.35', '内网IP', 'local', '2017-12-02 16:40:44');
INSERT INTO `xb_sys_ipaddress` VALUES ('31', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.44', '内网IP', 'local', '2017-12-21 08:43:43');
INSERT INTO `xb_sys_ipaddress` VALUES ('32', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.253', '内网IP', 'local', '2017-12-13 10:58:21');
INSERT INTO `xb_sys_ipaddress` VALUES ('33', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.31.252', '内网IP', 'local', '2017-12-15 19:47:24');
INSERT INTO `xb_sys_ipaddress` VALUES ('34', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.156', '内网IP', 'local', '2017-12-18 11:49:59');
INSERT INTO `xb_sys_ipaddress` VALUES ('35', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.148', '内网IP', 'local', '2018-05-08 09:50:01');
INSERT INTO `xb_sys_ipaddress` VALUES ('36', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.109', '内网IP', 'local', '2018-07-04 14:35:09');
INSERT INTO `xb_sys_ipaddress` VALUES ('37', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.9', '内网IP', 'local', '2018-06-05 10:00:30');
INSERT INTO `xb_sys_ipaddress` VALUES ('38', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.171', '内网IP', 'local', '2018-06-13 16:18:26');
INSERT INTO `xb_sys_ipaddress` VALUES ('39', '内网IP', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.141', '内网IP', 'local', '2018-06-05 10:02:56');
INSERT INTO `xb_sys_ipaddress` VALUES ('40', null, null, null, null, null, null, '内网IP', 'local', '内网IP', 'local', '0.0.0.0', '内网IP', 'local', '2018-07-04 13:43:13');
INSERT INTO `xb_sys_ipaddress` VALUES ('41', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.168', '内网IP', 'local', '2018-07-04 17:32:54');
INSERT INTO `xb_sys_ipaddress` VALUES ('42', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '60.168.223.7', '电信', '100017', '2018-07-04 17:35:05');
INSERT INTO `xb_sys_ipaddress` VALUES ('43', '', '', '', '', '', '', '内网IP', 'local', '内网IP', 'local', '192.168.1.104', '内网IP', 'local', '2018-07-10 15:26:15');
INSERT INTO `xb_sys_ipaddress` VALUES ('44', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '117.68.228.248', '电信', '100017', '2018-08-20 11:34:19');
INSERT INTO `xb_sys_ipaddress` VALUES ('45', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '36.5.225.254', '电信', '100017', '2018-08-21 19:38:18');
INSERT INTO `xb_sys_ipaddress` VALUES ('46', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '117.136.45.185', '移动', '100025', '2018-08-21 21:58:27');
INSERT INTO `xb_sys_ipaddress` VALUES ('47', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '60.168.54.35', '电信', '100017', '2018-08-22 08:28:43');
INSERT INTO `xb_sys_ipaddress` VALUES ('48', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '106.111.25.25', '电信', '100017', '2018-08-22 09:22:22');
INSERT INTO `xb_sys_ipaddress` VALUES ('49', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '106.111.1.76', '电信', '100017', '2018-08-22 09:41:10');
INSERT INTO `xb_sys_ipaddress` VALUES ('50', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '114.233.198.227', '电信', '100017', '2018-08-22 10:57:51');
INSERT INTO `xb_sys_ipaddress` VALUES ('51', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '106.111.1.254', '电信', '100017', '2018-08-22 11:14:34');
INSERT INTO `xb_sys_ipaddress` VALUES ('52', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '223.104.35.59', '移动', '100025', '2018-08-22 11:43:12');
INSERT INTO `xb_sys_ipaddress` VALUES ('53', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '211.162.9.52', '鹏博士', '1000143', '2018-08-22 21:41:46');
INSERT INTO `xb_sys_ipaddress` VALUES ('54', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '117.136.100.34', '移动', '100025', '2018-08-23 13:31:39');
INSERT INTO `xb_sys_ipaddress` VALUES ('55', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '36.5.230.38', '电信', '100017', '2018-08-23 15:04:52');
INSERT INTO `xb_sys_ipaddress` VALUES ('56', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '60.168.44.133', '电信', '100017', '2018-08-24 08:39:27');
INSERT INTO `xb_sys_ipaddress` VALUES ('57', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '49.85.119.123', '电信', '100017', '2018-08-24 11:29:05');
INSERT INTO `xb_sys_ipaddress` VALUES ('58', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '223.104.34.87', '移动', '100025', '2018-08-24 15:51:06');
INSERT INTO `xb_sys_ipaddress` VALUES ('59', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '114.233.231.27', '电信', '100017', '2018-08-25 15:28:28');
INSERT INTO `xb_sys_ipaddress` VALUES ('60', '中国', 'CN', '华东', '300000', '江苏省', '320000', '南京市', '320100', '', '', '122.96.43.144', '联通', '100026', '2018-08-25 21:16:22');
INSERT INTO `xb_sys_ipaddress` VALUES ('61', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '121.230.143.138', '电信', '100017', '2018-08-26 09:16:48');
INSERT INTO `xb_sys_ipaddress` VALUES ('62', '中国', 'CN', '华东', '300000', '江苏省', '320000', '泰州市', '321200', '', '', '114.233.198.133', '电信', '100017', '2018-08-26 12:33:30');
INSERT INTO `xb_sys_ipaddress` VALUES ('63', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '60.168.222.179', '电信', '100017', '2018-08-27 08:29:41');
INSERT INTO `xb_sys_ipaddress` VALUES ('64', '中国', 'CN', '华东', '300000', '安徽省', '340000', '宿州市', '341300', '', '', '36.60.159.14', '电信', '100017', '2018-08-27 15:55:10');
INSERT INTO `xb_sys_ipaddress` VALUES ('65', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '36.7.142.72', '电信', '100017', '2018-08-27 22:58:17');
INSERT INTO `xb_sys_ipaddress` VALUES ('66', '中国', 'CN', '华东', '300000', '安徽省', '340000', '合肥市', '340100', '', '', '60.168.222.127', '电信', '100017', '2018-08-28 08:35:15');
