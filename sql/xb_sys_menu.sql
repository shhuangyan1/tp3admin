/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_menu`;
CREATE TABLE `xb_sys_menu` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '菜单名称',
  `ParentID` int(11) DEFAULT NULL COMMENT '父及id 0表示最顶级',
  `Url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '菜单地址',
  `Sort` int(11) DEFAULT '999' COMMENT '排序',
  `Icon` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '图标',
  `Status` tinyint(2) DEFAULT '1' COMMENT '状态1表示正常 0不正常',
  `IsDel` varchar(255) COLLATE utf8_bin DEFAULT '0' COMMENT '删除 0 1',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_menu
-- ----------------------------
INSERT INTO `xb_sys_menu` VALUES ('1', '系统管理', '0', '#', '1', 'icon1', '1', '0', '1', '2017-05-05 13:56:38');
INSERT INTO `xb_sys_menu` VALUES ('2', '按钮管理', '1', 'System/Operationbutton/index', '80', 'icon131', '1', '0', '1', '2017-05-15 17:33:12');
INSERT INTO `xb_sys_menu` VALUES ('3', '菜单管理', '1', 'System/Menu/index', '79', 'icon2', '1', '0', '1', '2017-05-15 17:33:30');
INSERT INTO `xb_sys_menu` VALUES ('15', '基本信息', '1', 'System/Basicinfo/index', '1', 'icon279', '1', '0', '1', '2017-05-15 17:33:19');
INSERT INTO `xb_sys_menu` VALUES ('16', '用户管理', '1', 'System/Administrator/index', '3', 'icon51', '1', '0', '1', '2017-05-21 14:23:39');
INSERT INTO `xb_sys_menu` VALUES ('17', '角色管理', '1', 'System/Role/index', '4', 'icon3', '1', '0', '1', '2017-05-15 17:33:49');
INSERT INTO `xb_sys_menu` VALUES ('18', '数字字典', '1', 'System/Dictionary/index', '43', 'icon34', '1', '0', '1', '2017-05-05 14:33:48');
INSERT INTO `xb_sys_menu` VALUES ('20', '区域管理', '1', 'System/Regional/index', '7', 'icon34', '1', '0', '1', '2017-05-15 17:34:16');
INSERT INTO `xb_sys_menu` VALUES ('22', '操作日志', '1', 'System/Log/index', '9', 'icon311', '1', '0', '1', '2017-05-15 17:33:56');
INSERT INTO `xb_sys_menu` VALUES ('23', '消息中心', '90', 'Members/Message/index', '6', 'icon86', '1', '0', '1', '2017-05-25 09:49:19');
INSERT INTO `xb_sys_menu` VALUES ('26', '短信模板', '1', 'System/Templates/index', '6', 'icon112', '1', '0', '1', '2017-05-24 18:20:38');
INSERT INTO `xb_sys_menu` VALUES ('27', '广告位管理', '1', '#', '28', 'icon281', '1', '0', '1', '2017-05-05 14:58:55');
INSERT INTO `xb_sys_menu` VALUES ('28', '广告管理', '27', 'System/Adcontent/index', '43', 'icon167', '1', '0', '1', '2017-05-05 15:00:23');
INSERT INTO `xb_sys_menu` VALUES ('29', '广告位管理', '27', 'System/Advertising/index', '44', 'icon71', '1', '0', '1', '2017-05-05 15:02:00');
INSERT INTO `xb_sys_menu` VALUES ('30', '接口管理', '0', '#', '23', 'icon131', '1', '0', '1', '2017-05-05 15:04:22');
INSERT INTO `xb_sys_menu` VALUES ('31', '支付接口', '30', 'Integrate/PayMent/index', '2', 'icon155', '1', '0', '1', '2017-05-05 15:06:05');
INSERT INTO `xb_sys_menu` VALUES ('32', '登录接口', '30', 'Integrate/Login/index', '3', 'icon128', '0', '0', '1', '2017-05-05 15:09:57');
INSERT INTO `xb_sys_menu` VALUES ('41', '内容管理', '0', '#', '11', 'icon254', '1', '0', '1', '2017-05-05 15:26:18');
INSERT INTO `xb_sys_menu` VALUES ('42', '分类管理', '41', 'System/Contentcategories/index', '22', 'icon81', '1', '0', '1', '2017-05-05 15:28:40');
INSERT INTO `xb_sys_menu` VALUES ('43', '内容管理', '41', 'System/Contentmanagement/index', '49', 'icon255', '1', '0', '1', '2017-05-05 15:30:37');
INSERT INTO `xb_sys_menu` VALUES ('62', '数据备份', '1', 'System/Database/index', '5', 'icon30', '1', '0', '1', '2017-05-26 11:42:58');
INSERT INTO `xb_sys_menu` VALUES ('88', '短信接口', '30', 'Integrate/SMS/index', '1', 'icon295', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('89', '存储接口', '30', 'Integrate/Storage/index', '4', 'icon28', '0', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('90', '会员管理', '0', '#', '2', 'icon51', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('91', '会员信息', '90', 'Members/MemInfo/Index', '1', 'icon50', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('94', 'Api接口', '0', '#', '50', 'icon17', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('95', 'Api接口', '94', 'Api/Api/index', '2', 'icon92', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('96', 'Api分类', '94', 'Api/Categories/index', '1', 'icon290', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('97', '反馈留言', '90', 'Help/Message/index', '5', 'icon29', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('98', '版本管理', '94', 'Api/Version/index', '3', 'icon26', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('101', '优惠券管理', '90', '#', '7', 'icon43', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('103', '优惠券', '101', 'Juan/Coupans/index', '2', 'icon45', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('104', '会员优惠券', '101', 'Juan/Memcoupans/index', '3', 'icon53', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('107', '认证管理', '0', '#', '31', 'icon312', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('108', '认证参数', '107', 'Renzen/Parameter/index', '1', 'icon41', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('111', '身份证认证', '107', 'Renzen/Cards/index', '2', 'icon24', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('112', '认证审核记录', '107', 'Renzen/Shlist/index', '11', 'icon2', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('114', '借款金额', '120', 'Goods/Info/index', '1', 'icon16', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('115', '支付宝认证', '107', 'Renzen/Alipay/index', '4', 'icon95', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('116', '淘宝认证', '107', 'Renzen/Taobao/index', '5', 'icon171', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('117', '基本信息认证', '107', 'Renzen/Memberinfo/index', '7', 'icon51', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('118', '社交认证', '107', 'Renzen/Social/index', '8', 'icon51', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('119', '手机认证', '107', 'Renzen/Mobile/index', '3', 'icon21', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('120', '借款管理', '0', '#', '32', 'icon31', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('121', '贷款设置', '120', '#', '3', 'icon1', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('122', '借款期限', '121', 'Loans/Term/index', '1', 'icon120', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('123', '贷款参数', '121', 'Loans/Parameter/index', '2', 'icon41', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('124', '续借设置', '121', 'Loans/Renewset/index', '3', 'icon8', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('125', '认证接口', '30', 'Integrate/Renzen/index', '5', 'icon20', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('126', '参数管理', '1', '#', '81', 'icon1', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('127', '属性设置', '126', 'System/Propertyset/index', '1', 'icon41', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('128', '属性参数', '126', 'System/Propertyparam/index', '2', 'icon8', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('131', '银行卡管理', '90', 'Bank/Info/index', '4', 'icon7', '0', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('132', '银行管理', '126', 'Bank/Type/index', '99', 'icon154', '0', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('133', '借款申请', '120', 'Loans/Applylist/index', '4', 'icon209', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('134', '放款记录', '120', 'Loans/Fangkuanlist/index', '5', 'icon209', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('135', '账号设置', '126', 'System/Accounts/index', '4', 'icon1', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('136', '还款记录', '120', 'Loans/Hklist/index', '6', 'icon208', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('137', '逾期记录', '120', 'Loans/Yuqilist/index', '8', 'icon240', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('138', '支付记录', '120', 'Loans/Paylist/index', '9', 'icon22', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('139', '银行卡认证', '107', 'Renzen/Bank/index', '6', 'icon22', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('140', '推广渠道', '145', '#', '3', 'icon31', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('141', '推广渠道管理', '140', 'Members/Tgadmin/index', '1', 'icon8', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('142', '推广统计', '140', 'Members/Tuiguangtj/index', '2', 'icon116', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('143', '渠道明细统计', '140', 'Members/Tuiguangrecord/index', '3', 'icon118', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('144', '扣量管理', '140', 'Members/Kouliang/index', '4', 'icon238', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('145', '运营统计', '0', '#', '33', 'icon128', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('146', '统计报表', '145', 'Loans/Loanstongji/index', '1', 'icon116', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('148', '送券设置', '101', 'Juan/Sendsets/index', '1', 'icon233', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('149', '利润统计', '145', 'Loans/Liruntongji/index', '2', 'icon5', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('150', '续借还款', '120', 'Loans/Xjapplylist/index', '7', 'icon22', '1', '0', null, null);
INSERT INTO `xb_sys_menu` VALUES ('151', '推广项目', '41', 'Goods/Items/index', '50', 'icon156', '1', '0', null, null);
