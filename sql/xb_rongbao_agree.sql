/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:19:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_rongbao_agree`
-- ----------------------------
DROP TABLE IF EXISTS `xb_rongbao_agree`;
CREATE TABLE `xb_rongbao_agree` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL COMMENT '会员ID',
  `Type` tinyint(1) DEFAULT '0' COMMENT '0购买代理时签约    1查询征信时签约(弃用)',
  `OrderSn` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '签约使用的订单号',
  `RealName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '银行开户姓名',
  `CardID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '身份证号',
  `BankCode` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '银行卡号',
  `Mobile` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '银行预留手机号',
  `AgreeNo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '签约协议号',
  `Addtime` datetime DEFAULT NULL COMMENT '协议生成时间',
  `Status` tinyint(3) DEFAULT '0' COMMENT '签约状态   0待签约   1身份验证通过   2身份验未证通过   3签约成功   4签约失败   5协议失效',
  `IsDel` tinyint(3) DEFAULT '0' COMMENT '逻辑删除 0不删除   1删除   （解约时使用）',
  `UpdateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `Status` (`Status`),
  KEY `IsDel` (`IsDel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='签约协议表';

-- ----------------------------
-- Records of xb_rongbao_agree
-- ----------------------------
