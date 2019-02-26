/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_operationbutton`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_operationbutton`;
CREATE TABLE `xb_sys_operationbutton` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '按钮名称',
  `EName` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '英文名称',
  `Icon` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '图标样式',
  `Sort` int(11) NOT NULL DEFAULT '999' COMMENT '排序',
  `Status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `IsDel` int(11) DEFAULT '0' COMMENT '是否逻辑删除 1 是 0  否',
  `Val` int(11) NOT NULL COMMENT '权限值',
  `IsToken` int(2) NOT NULL DEFAULT '0' COMMENT '是否带令牌',
  `OpenMode` tinyint(2) NOT NULL DEFAULT '0' COMMENT '窗口方式打开',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_operationbutton
-- ----------------------------
INSERT INTO `xb_sys_operationbutton` VALUES ('1', '分割符', 'Separator', '', '1', '1', '0', '0', '0', '0', '1', '2017-05-04 16:41:36');
INSERT INTO `xb_sys_operationbutton` VALUES ('2', '刷新', 'refresh', 'icon6', '4', '1', '0', '4', '0', '1', '1', '2017-06-09 11:16:32');
INSERT INTO `xb_sys_operationbutton` VALUES ('4', '删除', 'del', 'icon9', '6', '1', '0', '6', '0', '1', '1', '2017-05-21 14:20:59');
INSERT INTO `xb_sys_operationbutton` VALUES ('7', '添加', 'add', 'icon7', '8', '1', '0', '8', '0', '0', '1', '2017-05-21 14:21:05');
INSERT INTO `xb_sys_operationbutton` VALUES ('9', '修改', 'edit', 'icon8', '10', '1', '0', '10', '0', '0', '1', '2017-05-21 14:21:15');
INSERT INTO `xb_sys_operationbutton` VALUES ('13', '权限控制', 'rolemenu', 'icon132', '23', '1', '0', '22', '0', '1', '1', '2017-05-05 10:29:25');
INSERT INTO `xb_sys_operationbutton` VALUES ('14', '详情', 'detail', 'icon314', '24', '1', '0', '24', '0', '0', '1', '2017-05-04 16:45:16');
INSERT INTO `xb_sys_operationbutton` VALUES ('15', '导出Excel', 'exportexcel', 'icon13', '123', '1', '0', '25', '0', '6', '1', '2017-05-05 13:45:00');
INSERT INTO `xb_sys_operationbutton` VALUES ('16', '备份', 'Backup', 'icon185', '111', '1', '0', '26', '0', '2', '1', '2017-05-25 16:40:35');
INSERT INTO `xb_sys_operationbutton` VALUES ('17', '下载', 'Download', 'icon123', '112', '1', '0', '27', '0', '5', '1', '2017-05-05 13:47:03');
INSERT INTO `xb_sys_operationbutton` VALUES ('18', '跟进', 'follow', 'icon152', '113', '1', '0', '28', '0', '0', '1', '2017-05-05 13:47:52');
INSERT INTO `xb_sys_operationbutton` VALUES ('19', '发送', 'send', 'icon89', '114', '1', '0', '29', '0', '0', '1', '2017-05-05 13:48:51');
INSERT INTO `xb_sys_operationbutton` VALUES ('20', '审核', 'aduit', 'icon25', '115', '1', '0', '31', '0', '0', '1', '2017-05-05 13:49:36');
INSERT INTO `xb_sys_operationbutton` VALUES ('21', '驳回', 'overrule', 'icon27', '123', '1', '0', '45', '0', '0', '1', '2017-05-05 13:50:18');
INSERT INTO `xb_sys_operationbutton` VALUES ('22', '回复', 'Reply', 'icon229', '1144', '1', '0', '46', '0', '0', '1', '2017-05-05 13:51:01');
INSERT INTO `xb_sys_operationbutton` VALUES ('23', '推荐', 'recommend', 'icon23', '432', '1', '0', '47', '0', '0', '1', '2017-05-05 13:51:42');
INSERT INTO `xb_sys_operationbutton` VALUES ('24', '打印', 'Print', 'icon14', '543', '1', '0', '321', '0', '0', '1', '2017-05-05 13:52:18');
INSERT INTO `xb_sys_operationbutton` VALUES ('25', '撤销删除', 'Revocation', 'icon208', '4332', '1', '0', '66', '0', '3', '1', '2017-05-05 13:53:10');
INSERT INTO `xb_sys_operationbutton` VALUES ('26', '特价', 'Panic', 'icon122', '7777', '1', '0', '666', '0', '0', '31', '2017-09-27 11:39:28');
INSERT INTO `xb_sys_operationbutton` VALUES ('27', '盘点', 'inventory', 'icon134', '999', '1', '0', '79', '0', '0', '1', '2017-05-15 18:16:06');
INSERT INTO `xb_sys_operationbutton` VALUES ('28', '入库', 'instock', 'icon297', '999', '1', '0', '80', '0', '0', '1', '2017-05-15 18:14:40');
INSERT INTO `xb_sys_operationbutton` VALUES ('29', '出库', 'outstock', 'icon298', '999', '1', '0', '81', '0', '0', '1', '2017-05-15 18:15:02');
INSERT INTO `xb_sys_operationbutton` VALUES ('30', '绑定IP', 'BindIP', 'icon288', '999', '1', '0', '3', '0', '0', '1', '2017-05-19 18:11:48');
INSERT INTO `xb_sys_operationbutton` VALUES ('31', '绑定MAC', 'BindMAC', 'icon167', '999', '1', '0', '4', '0', '0', '1', '2017-05-19 18:12:10');
INSERT INTO `xb_sys_operationbutton` VALUES ('32', '发货', 'Deliver', 'icon160', '999', '1', '0', '66', '0', '0', '1', '2017-05-25 09:36:53');
INSERT INTO `xb_sys_operationbutton` VALUES ('33', '恢复', 'Restore', 'icon196', '999', '1', '0', '28', '0', '0', '1', '2017-05-25 20:35:30');
INSERT INTO `xb_sys_operationbutton` VALUES ('34', '一级审核', 'one_aduit', 'icon187', '125', '1', '1', '66', '0', '0', '1', '2017-05-26 10:55:05');
INSERT INTO `xb_sys_operationbutton` VALUES ('35', '二级审核', 'two_aduit', 'icon188', '126', '1', '1', '88', '0', '0', '1', '2017-05-26 10:56:06');
INSERT INTO `xb_sys_operationbutton` VALUES ('36', '11', 'WWW', 'icon106', '1', '1', '1', '2', '0', '0', '1', '2017-06-02 15:51:53');
INSERT INTO `xb_sys_operationbutton` VALUES ('37', '11', '11', 'icon79', '1', '1', '1', '2', '0', '0', '1', '2017-06-02 16:39:53');
INSERT INTO `xb_sys_operationbutton` VALUES ('38', '配置', 'Setting', 'icon268', '1', '1', '0', '100', '0', '0', '1', '2017-06-05 15:44:39');
INSERT INTO `xb_sys_operationbutton` VALUES ('39', '测试', 'examination', 'icon198', '999', '1', '0', '4', '0', '0', '31', '2017-12-12 13:23:16');
INSERT INTO `xb_sys_operationbutton` VALUES ('40', '送券', 'fafangjuan', 'icon45', '999', '1', '0', '128', '0', '0', '2', '2018-06-28 11:59:56');
INSERT INTO `xb_sys_operationbutton` VALUES ('41', '转单', 'zorder', 'icon209', '999', '1', '0', '44', '0', '0', '2', '2018-07-10 14:48:02');
INSERT INTO `xb_sys_operationbutton` VALUES ('42', '处理', 'handle', 'icon41', '999', '1', '0', '128', '0', '0', '2', '2018-07-10 14:10:21');
INSERT INTO `xb_sys_operationbutton` VALUES ('43', '确认放款', 'cofirmloan', 'icon25', '999', '1', '0', '68', '0', '0', '2', '2018-07-10 15:23:02');
INSERT INTO `xb_sys_operationbutton` VALUES ('44', '取消放款', 'cancelloan', 'icon210', '999', '1', '0', '70', '0', '0', '2', '2018-07-10 15:23:52');
INSERT INTO `xb_sys_operationbutton` VALUES ('45', '加入黑名单', 'addhmd', 'icon310', '999', '1', '0', '72', '0', '0', '2', '2018-07-11 11:57:11');
INSERT INTO `xb_sys_operationbutton` VALUES ('46', '匹配通话', 'getpp', 'icon127', '999', '1', '0', '50', '0', '0', '2', '2018-07-25 11:48:34');
INSERT INTO `xb_sys_operationbutton` VALUES ('47', '魔盒报告', 'mohepages', 'icon223', '999', '1', '0', '52', '0', '0', '2', '2018-07-25 17:47:49');
INSERT INTO `xb_sys_operationbutton` VALUES ('48', '催收', 'csrecord', 'icon21', '999', '1', '0', '54', '0', '0', '2', '2018-07-26 16:13:52');
INSERT INTO `xb_sys_operationbutton` VALUES ('49', '设置客服', 'setcustomer', 'icon53', '999', '1', '0', '46', '0', '0', '2', '2018-08-23 10:11:11');
