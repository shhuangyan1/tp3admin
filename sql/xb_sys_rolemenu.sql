/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_rolemenu`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_rolemenu`;
CREATE TABLE `xb_sys_rolemenu` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `RoleID` int(11) DEFAULT NULL COMMENT '角色id',
  `MenuID` int(11) DEFAULT NULL,
  `ParentID` int(11) DEFAULT NULL COMMENT '父级id',
  `ButtonID` varchar(120) COLLATE utf8_bin DEFAULT '' COMMENT '按钮id',
  `val` int(11) DEFAULT '0' COMMENT '权限值',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者ID',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9616 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_rolemenu
-- ----------------------------
INSERT INTO `xb_sys_rolemenu` VALUES ('2385', '1', '1', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2386', '1', '15', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2387', '1', '16', '1', ',2,1,7,9,4,1,30,31', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2388', '1', '17', '1', ',2,1,7,9,4,13', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2389', '1', '62', '1', ',2,1,16,17,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2390', '1', '23', '1', ',2,1,7', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2391', '1', '26', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2392', '1', '20', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2393', '1', '22', '1', ',2,1,14', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2394', '1', '27', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2395', '1', '28', '27', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2396', '1', '29', '27', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2397', '1', '18', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2398', '1', '83', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2399', '1', '3', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2400', '1', '2', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2401', '1', '41', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2402', '1', '42', '41', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2403', '1', '43', '41', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2404', '1', '30', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2405', '1', '88', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2406', '1', '31', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2407', '1', '32', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2408', '1', '89', '30', ',2,1,7,4,9,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2958', '4', '1', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2959', '4', '15', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('2960', '4', '16', '1', ',2,1,7,9,4,1,30,31,32', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('7270', '9', '145', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('7271', '9', '140', '145', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('7272', '9', '142', '140', ',2,1,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('7273', '9', '143', '140', ',2', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9490', '11', '1', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9491', '11', '16', '1', ',2,1,7,9,4,1,30,31,32', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9492', '11', '120', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9493', '11', '133', '120', ',2,1,20,14,15,41,46,47', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9494', '11', '134', '120', ',2,1,43,14,15,41,44', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9495', '11', '150', '120', ',2,1,20,14,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9496', '11', '137', '120', ',2,1,14,15,45,41,48', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9511', '2', '1', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9512', '2', '15', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9513', '2', '16', '1', ',2,1,7,9,4,1,30,31', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9514', '2', '17', '1', ',2,1,7,9,4,13', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9515', '2', '62', '1', ',2,1,16,17,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9516', '2', '26', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9517', '2', '20', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9518', '2', '22', '1', ',2,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9519', '2', '27', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9520', '2', '28', '27', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9521', '2', '29', '27', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9522', '2', '18', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9523', '2', '3', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9524', '2', '2', '1', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9525', '2', '126', '1', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9526', '2', '127', '126', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9527', '2', '128', '126', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9528', '2', '135', '126', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9529', '2', '132', '126', ',1,2,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9530', '2', '90', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9531', '2', '91', '90', ',2,1,4,9,14,15,49', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9532', '2', '131', '90', ',1,2,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9533', '2', '97', '90', ',1,2,14,4,42', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9534', '2', '23', '90', ',2,1,7', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9535', '2', '101', '90', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9536', '2', '148', '101', ',2,1,9', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9537', '2', '103', '101', ',1,2,7,9,4,40', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9538', '2', '104', '101', ',2,1,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9539', '2', '41', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9540', '2', '42', '41', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9541', '2', '43', '41', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9542', '2', '151', '41', ',2,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9543', '2', '30', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9544', '2', '88', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9545', '2', '31', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9546', '2', '125', '30', ',2,1,7,9,4,38', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9547', '2', '107', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9548', '2', '108', '107', ',2,1,7,9', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9549', '2', '111', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9550', '2', '119', '107', ',2,1,14,20,46,47', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9551', '2', '115', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9552', '2', '116', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9553', '2', '139', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9554', '2', '117', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9555', '2', '118', '107', ',2,1,14,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9556', '2', '112', '107', ',2,1,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9557', '2', '120', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9558', '2', '114', '120', ',1,2,7,9,4,14', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9559', '2', '121', '120', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9560', '2', '122', '121', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9561', '2', '123', '121', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9562', '2', '124', '121', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9563', '2', '133', '120', ',2,1,20,14,15,41,46,47', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9564', '2', '134', '120', ',2,1,43,14,15,41,44', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9565', '2', '136', '120', ',2,1,20,14,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9566', '2', '150', '120', ',2,1,20,14,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9567', '2', '137', '120', ',2,1,14,15,45,41,48', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9568', '2', '138', '120', ',2,1,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9569', '2', '145', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9570', '2', '146', '145', ',2,1,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9571', '2', '149', '145', ',2', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9572', '2', '140', '145', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9573', '2', '141', '140', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9574', '2', '142', '140', ',2,1,15', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9575', '2', '143', '140', ',2', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9576', '2', '144', '140', ',2,1,7,9,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9577', '2', '94', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9578', '2', '96', '94', ',2,7,9,1,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9579', '2', '95', '94', ',2,7,9,1,14,1,4,1,39', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9580', '2', '98', '94', ',2,7,9,1,4', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9594', '7', '1', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9595', '7', '22', '1', ',2', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9596', '7', '120', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9597', '7', '133', '120', ',2,1,20,14,46,47', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9609', '8', '120', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9610', '8', '134', '120', ',2,1,43,44', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9611', '8', '136', '120', ',2,1,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9612', '8', '150', '120', ',2,1,20', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9613', '8', '138', '120', ',2,1', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9614', '10', '120', '0', '', '0', null, null);
INSERT INTO `xb_sys_rolemenu` VALUES ('9615', '10', '137', '120', ',2,1,14,45,48', '0', null, null);
