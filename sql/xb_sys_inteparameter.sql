/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_inteparameter`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_inteparameter`;
CREATE TABLE `xb_sys_inteparameter` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '参数名称',
  `IntegrateID` int(11) DEFAULT NULL COMMENT '平台ID',
  `ParaName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '参数名',
  `ParaValue` text COLLATE utf8_bin COMMENT '参数值',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作人',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_inteparameter
-- ----------------------------
INSERT INTO `xb_sys_inteparameter` VALUES ('1', 'AppKey', '1', 'AppKey', 0x3265323431396433613131303761366638656563376361633862333365346163, '2', '2018-08-22 17:40:49');
INSERT INTO `xb_sys_inteparameter` VALUES ('2', '短信签名', '1', 'SignAture', 0xE4BA94E69697E7B1B3, '2', '2018-08-22 17:40:49');
INSERT INTO `xb_sys_inteparameter` VALUES ('3', 'AppKey', '5', 'AppKey', '', '31', '2017-08-02 18:35:10');
INSERT INTO `xb_sys_inteparameter` VALUES ('4', 'AppScript', '5', 'AppScript', '', '31', '2017-08-02 18:35:10');
INSERT INTO `xb_sys_inteparameter` VALUES ('5', 'AppKey', '6', 'AccessKey', 0x62643259334271375A7A6E41554A486F5F6F446F4D677277334B365158377157624757344C376B77, '2', '2017-11-02 18:25:51');
INSERT INTO `xb_sys_inteparameter` VALUES ('6', 'SecretKey', '6', 'SecretKey', 0x734773666239637766676E546C6E6334352D33434A52715448655577704C67416E34443757796576, '2', '2017-11-02 18:25:51');
INSERT INTO `xb_sys_inteparameter` VALUES ('7', '空间名称', '6', 'Bucket', 0x746171752D696D616765, '2', '2017-11-02 18:25:51');
INSERT INTO `xb_sys_inteparameter` VALUES ('8', '空间地址', '6', 'Domain', 0x6F6D346E65727673752E626B742E636C6F7564646E2E636F6D, '2', '2017-11-02 18:25:51');
INSERT INTO `xb_sys_inteparameter` VALUES ('9', '文件大小', '6', 'Size', 0x31303030303030, '2', '2017-11-02 18:25:51');
INSERT INTO `xb_sys_inteparameter` VALUES ('10', '应用ID', '7', 'app_id', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('11', '商户密钥', '7', 'merchant_private_key', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('12', '异步通知', '7', 'notify_url', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('13', '同步跳转', '7', 'return_url', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('14', '编码格式', '7', 'charset', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('15', '签名方式', '7', 'sign_type', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('16', '网关', '7', 'gatewayUrl', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('17', '公钥', '7', 'alipay_public_key', '', '31', '2017-08-02 18:34:52');
INSERT INTO `xb_sys_inteparameter` VALUES ('18', '应用ID', '8', 'APPID', '', '31', '2017-08-02 18:35:03');
INSERT INTO `xb_sys_inteparameter` VALUES ('19', '商户号', '8', 'MCHID', '', '31', '2017-08-02 18:35:03');
INSERT INTO `xb_sys_inteparameter` VALUES ('20', '微信支付KEY', '8', 'KEY', '', '31', '2017-08-02 18:35:03');
INSERT INTO `xb_sys_inteparameter` VALUES ('21', '公共帐号密钥', '8', 'APPSECRET', '', '31', '2017-08-02 18:35:03');
INSERT INTO `xb_sys_inteparameter` VALUES ('22', '异步通知URL', '8', 'NOTIFY_URL', '', '31', '2017-08-02 18:35:03');
INSERT INTO `xb_sys_inteparameter` VALUES ('23', 'api_key', '9', 'api_key', 0x39646635303735312D336165362D343630352D616439662D666539303131333434313266, '2', '2018-08-20 15:19:45');
INSERT INTO `xb_sys_inteparameter` VALUES ('24', 'security_key', '9', 'security_key', 0x64623361623830332D393264622D346261662D383962612D306362373965636537343038, '2', '2018-08-20 15:19:45');
INSERT INTO `xb_sys_inteparameter` VALUES ('25', '请求地址', '10', 'url', 0x68747470733A2F2F6F70656E2E7368756A756D6F68652E636F6D2F626F782F797973, '2', '2018-08-20 14:52:43');
INSERT INTO `xb_sys_inteparameter` VALUES ('26', 'token', '10', 'token', 0x4132383235343630443030413432443639433044304536423242424343333037, '2', '2018-08-20 14:52:43');
INSERT INTO `xb_sys_inteparameter` VALUES ('27', 'partner_code', '10', 'partner_code', 0x77646D5F6D6F6865, '2', '2018-08-20 14:52:43');
INSERT INTO `xb_sys_inteparameter` VALUES ('28', 'partner_key', '10', 'partner_key', 0x6331376336653861626666613438653838656163326564613462353366323539, '2', '2018-08-20 14:52:43');
INSERT INTO `xb_sys_inteparameter` VALUES ('29', '商户号ID', '11', 'merchant_id', null, null, null);
INSERT INTO `xb_sys_inteparameter` VALUES ('30', '商户邮箱', '11', 'seller_email', null, null, null);
INSERT INTO `xb_sys_inteparameter` VALUES ('31', 'apiKey', '11', 'apiKey', null, null, null);
INSERT INTO `xb_sys_inteparameter` VALUES ('32', 'url', '11', 'url', null, null, null);
INSERT INTO `xb_sys_inteparameter` VALUES ('33', '创蓝API账号', '12', 'account', 0x4E3434, '2', '2018-08-20 11:57:53');
INSERT INTO `xb_sys_inteparameter` VALUES ('34', '创蓝API密码', '12', 'password', 0x3132, '2', '2018-08-20 11:57:53');
INSERT INTO `xb_sys_inteparameter` VALUES ('35', '运营商签名', '12', 'SignAture', 0x323533E4BA91E9809AE8AEAF, '2', '2018-08-20 11:57:53');
INSERT INTO `xb_sys_inteparameter` VALUES ('36', '商户代码', '13', 'mchntCd', 0x303030333133304631373239303539, '2', '2018-08-25 15:37:39');
INSERT INTO `xb_sys_inteparameter` VALUES ('37', '商户密钥', '13', 'key', 0x386A317735316778796D377865336672676A376D366B696B3937683676617936, '2', '2018-08-25 15:37:39');
