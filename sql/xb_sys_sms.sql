/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:21:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_sms`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_sms`;
CREATE TABLE `xb_sys_sms` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ObjectID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '对方手机',
  `Type` int(11) DEFAULT '0' COMMENT '短信发送类型  0 系统发送 1 手工发送',
  `Mode` int(11) DEFAULT '0' COMMENT '消息接收方式 0内部消息 1手机短信 2 短信&消息',
  `SendMess` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '发送的内容',
  `Status` int(11) NOT NULL DEFAULT '1' COMMENT '短信发送状态  0 未发送 1 已发送 2  调用接口异常',
  `SendTime` datetime DEFAULT NULL COMMENT '发送时间',
  `Obj` int(1) DEFAULT '1' COMMENT '发送对象 1所有人发送 2单独发送',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_sms
-- ----------------------------
INSERT INTO `xb_sys_sms` VALUES ('3', '18130046265', '0', '1', '您的手机短信是XXX', '0', '2017-05-24 16:36:00', '1');
INSERT INTO `xb_sys_sms` VALUES ('4', 'shifukang', '1', '2', '通知XXX', '1', '2017-05-24 16:36:00', '1');
INSERT INTO `xb_sys_sms` VALUES ('10', '所有人', '1', '0', '短信温馨提示，注意休息', '1', '2017-06-07 09:48:51', '1');
INSERT INTO `xb_sys_sms` VALUES ('18', '17602186118', '0', '1', '尊敬的用户，您注册的短信验证码是123153，请正确输入并完成后续操作。感谢您的配合！', '2', '2017-06-07 10:49:56', '2');
INSERT INTO `xb_sys_sms` VALUES ('19', '17602186118', '0', '1', '尊敬的用户，您注册的短信验证码是377871，请正确输入并完成后续操作。感谢您的配合！', '1', '2017-06-07 10:50:17', '2');
INSERT INTO `xb_sys_sms` VALUES ('20', 'maki', '1', '0', '您有一条订单消息，请留意下', '1', '2017-06-07 14:25:47', '2');
INSERT INTO `xb_sys_sms` VALUES ('63', '所有人', '1', '0', '这是一条内部测试消息', '1', '2017-06-08 12:45:23', '1');
INSERT INTO `xb_sys_sms` VALUES ('65', 'shifukang', '1', '1', '验证码789655444', '1', '2017-06-08 14:30:51', '2');
INSERT INTO `xb_sys_sms` VALUES ('72', 'shifukang', '1', '1', '这是一条内部消息', '1', '2017-06-08 15:04:49', '2');
INSERT INTO `xb_sys_sms` VALUES ('73', 'shifukang', '1', '2', '验证码98555', '1', '2017-06-08 15:05:22', '2');
INSERT INTO `xb_sys_sms` VALUES ('74', 'shifukang', '1', '2', '这是一条发送给来自内部单独消息', '1', '2017-06-08 18:27:25', '2');
INSERT INTO `xb_sys_sms` VALUES ('75', '18566778565', '1', '1', '尊敬的会员，订单号已发货，请及时留意,申通快递,物流单号:46554665986565', '1', '2018-06-29 11:30:03', '2');
INSERT INTO `xb_sys_sms` VALUES ('76', '18566778565', '1', '1', '尊敬的会员，订单号已发货，请及时留意,申通快递,物流单号:46554665986565', '1', '2018-06-29 11:30:09', '2');
INSERT INTO `xb_sys_sms` VALUES ('77', '18566778565', '1', '1', '尊敬的会员，订单号已发货，请及时留意,申通快递,物流单号:46554665986565', '1', '2018-06-29 11:37:59', '2');
INSERT INTO `xb_sys_sms` VALUES ('78', '18566778565', '1', '1', '尊敬的会员，订单号已发货，请及时留意,圆通快递,物流单号:46554665986565', '1', '2018-06-29 13:35:14', '2');
INSERT INTO `xb_sys_sms` VALUES ('79', '18566778565', '1', '1', '尊敬的会员，订单号已发货，请及时留意,圆通快递,物流单号:46554665986565', '1', '2018-06-29 13:36:26', '2');
INSERT INTO `xb_sys_sms` VALUES ('80', '18566778565', '1', '1', '尊敬的会员，AH987654321订单号已发货，请及时留意,圆通快递,物流单号:46554665986565', '1', '2018-07-03 14:25:20', '2');
INSERT INTO `xb_sys_sms` VALUES ('81', '18566778565', '1', '1', '尊敬的会员，AH987654321订单号已发货，请及时留意,圆通快递,物流单号:46554665986565', '1', '2018-07-03 14:25:27', '2');
INSERT INTO `xb_sys_sms` VALUES ('82', '18566778565', '1', '1', '尊敬的会员，AH654321789订单号已发货，请及时留意,申通快递,物流单号:222', '1', '2018-07-06 17:08:21', '2');
INSERT INTO `xb_sys_sms` VALUES ('83', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:27:55', '2');
INSERT INTO `xb_sys_sms` VALUES ('84', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:28:09', '2');
INSERT INTO `xb_sys_sms` VALUES ('85', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:33:21', '2');
INSERT INTO `xb_sys_sms` VALUES ('86', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:35:24', '2');
INSERT INTO `xb_sys_sms` VALUES ('87', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:37:50', '2');
INSERT INTO `xb_sys_sms` VALUES ('88', 'user_100002', '1', '1', '你好', '1', '2018-07-11 11:38:01', '2');
INSERT INTO `xb_sys_sms` VALUES ('89', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:40:55', '2');
INSERT INTO `xb_sys_sms` VALUES ('90', 'user_100002', '1', '1', '{SMS_验证码}', '1', '2018-07-11 11:41:10', '2');
INSERT INTO `xb_sys_sms` VALUES ('91', 'user_100002', '1', '1', '18225901593', '1', '2018-07-11 11:43:50', '2');
INSERT INTO `xb_sys_sms` VALUES ('92', 'user_100002', '1', '2', '{SMS_验证码}', '1', '2018-07-11 13:38:47', '2');
INSERT INTO `xb_sys_sms` VALUES ('93', '18355195990', '1', '1', '尊敬的用户，您已通过手机验证，验证码：211608', '1', '2018-07-19 17:11:53', '1');
INSERT INTO `xb_sys_sms` VALUES ('94', '18355195990', '1', '1', '尊敬的用户，您已通过手机验证，验证码：541534', '1', '2018-07-19 17:22:30', '1');
INSERT INTO `xb_sys_sms` VALUES ('95', '18355195990', '1', '1', '尊敬的用户，您已通过手机验证，验证码：478637', '1', '2018-07-19 18:05:25', '1');
INSERT INTO `xb_sys_sms` VALUES ('96', '18355195990', '1', '1', '尊敬的用户，您已通过手机验证，验证码：209075', '1', '2018-07-27 08:53:48', '1');
