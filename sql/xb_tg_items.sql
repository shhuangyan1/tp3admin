/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:22:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_tg_items`
-- ----------------------------
DROP TABLE IF EXISTS `xb_tg_items`;
CREATE TABLE `xb_tg_items` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `Intro` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '简单描述',
  `Logurl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'logo图',
  `Url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '跳转外部地址',
  `IsTui` tinyint(3) DEFAULT '0' COMMENT '是否推荐，1推荐  0不推荐',
  `Sort` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态1启用 0禁用',
  `IsDel` tinyint(1) unsigned DEFAULT '0' COMMENT '逻辑删除标记  0未删除 1已删除',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='推广项目';

-- ----------------------------
-- Records of xb_tg_items
-- ----------------------------
INSERT INTO `xb_tg_items` VALUES ('1', '纳米工厂', '最新口子，放水审核，闪电放款', '/Upload/image/2018-08-20/5b7a9fbc3f163.jpg', 'http://www.baidu.com', '1', '999', '1', '0', '2', '2018-08-21 17:38:06');
INSERT INTO `xb_tg_items` VALUES ('2', '面包工厂', '快来啊快来啊快来啊快来啊快来啊快来啊', '/Upload/image/2018-08-21/5b7bf34144dbf.png', 'http://www.taobao.com', '1', '999', '1', '0', '2', '2018-08-21 19:11:13');
