/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:18:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_renzen_memberinfo`
-- ----------------------------
DROP TABLE IF EXISTS `xb_renzen_memberinfo`;
CREATE TABLE `xb_renzen_memberinfo` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL COMMENT '会员ID',
  `InCome` varchar(255) COLLATE utf8_bin DEFAULT '0.00' COMMENT '收入',
  `Education` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '学历',
  `ZhiYe` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '职业',
  `JTProvinceID` int(11) DEFAULT '0' COMMENT '省份id(家)',
  `JTCityID` int(11) DEFAULT '0' COMMENT '城市id(家)',
  `JTDisID` int(11) DEFAULT '0' COMMENT '区域id(家)',
  `JAddress` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '家庭地址',
  `JZTime` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '居住时长',
  `CompanyName` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '单位名称',
  `CompanyMobile` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT '单位电话',
  `CompanyAddress` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '单位地址',
  `GZProvinceID` int(11) DEFAULT '0' COMMENT '省份id(单)',
  `GZCityID` int(11) DEFAULT '0' COMMENT '城市id(单)',
  `GZDisID` int(11) DEFAULT '0' COMMENT '区域id(单)',
  `Status` tinyint(4) DEFAULT '0' COMMENT '状态:0待审核 1已认证 2认证失败',
  `RenzTime` datetime DEFAULT NULL COMMENT '认证时间',
  `IsDel` tinyint(4) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `Status` (`Status`),
  KEY `UserID` (`UserID`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='基本信息认证表';

-- ----------------------------
-- Records of xb_renzen_memberinfo
-- ----------------------------
INSERT INTO `xb_renzen_memberinfo` VALUES ('1', '8', '1000-3000', '本科', '营业员', '2', '3', '4', 'Tweeter', 'We’re', 'Queer we’re equal', '1321132', 'Ewqrqwerwe', '2', '3', '4', '1', '2018-08-21 08:53:17', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('2', '9', '1000-3000', '大专', '文员', '2', '3', '4', '图吧', '3', '弄', '1258', '龙虾', '2', '3', '7', '1', '2018-08-21 11:06:39', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('3', '10', '1000-3000', '本科', '营业员', '2', '3', '4', '测试地址', '3', '绿地行', '234698', '测试: 手机号码  158 0000 0000', '2', '3', '4', '1', '2018-08-21 18:55:37', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('5', '14', '1000-3000', '本科', '设计师', '888', '1006', '1008', '金鹰407', '10年\n', '金融中心', '13040165693', '金鹰407', '888', '1006', '1008', '1', '2018-08-22 09:48:30', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('6', '16', '1000-3000', '高中', '文员', '1021', '1037', '1048', '逍林镇', '22', '巨龙电子\n', '635059714', '逍林镇', '1021', '1037', '1048', '1', '2018-08-22 10:45:35', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('7', '19', '1000-3000', '大专', '销售经理', '2', '3', '4', '刚回来老婆哦婆婆', '2255', '回家睡觉PK民', '7272455437676', '哦泼洒记录', '2', '3', '4', '1', '2018-08-22 10:49:08', '0', null, null);
INSERT INTO `xb_renzen_memberinfo` VALUES ('8', '21', '1000-3000', '大专', '销售经理', '888', '1006', '1008', '东进小区', '一年', '姐', '13040164693', '来了', '2', '3', '4', '1', '2018-08-23 12:09:17', '0', null, null);
