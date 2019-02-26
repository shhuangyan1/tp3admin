/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50634
Source Host           : localhost:3306
Source Database       : wudoumi

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2018-08-28 17:20:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xb_sys_basicinfo`
-- ----------------------------
DROP TABLE IF EXISTS `xb_sys_basicinfo`;
CREATE TABLE `xb_sys_basicinfo` (
  `ID` int(11) NOT NULL DEFAULT '0',
  `SystemName` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '系统名称',
  `SystemDomain` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '系统域名',
  `SEOTitle` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '首页SEO标题',
  `SEOKeyWord` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '首页SEO关键字',
  `SEODes` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '首页SEO描述',
  `Logo` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT 'PC版LOGO',
  `MLogo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '手机版LOGO',
  `PsdErrorCount` int(6) DEFAULT NULL COMMENT '错误密码上限',
  `PsdErrorTime` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '密码错误限制时长',
  `Session` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '登录session有效时长',
  `AppSession` int(11) DEFAULT '4' COMMENT '登录session有效时长',
  `ICP` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '备案号',
  `StatisticsCode` longtext COLLATE utf8_bin COMMENT '统计代码',
  `ServiceCode` longtext COLLATE utf8_bin COMMENT '客服代码',
  `StopWord` longtext COLLATE utf8_bin COMMENT '敏感词,所有敏感词将被替换为*号',
  `CompanyName` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '公司名称',
  `IP` varchar(60) COLLATE utf8_bin DEFAULT '0' COMMENT '是否开启IP验证 0 不开启 1 开启',
  `MAC` varchar(60) COLLATE utf8_bin DEFAULT '0' COMMENT '是否启用MAC验证 0 不开启 1 开启',
  `JdPhone` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '监督电话',
  `QQ` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '客服QQ',
  `Tel` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '客服电话',
  `WeChat` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '微信号',
  `WeChatQR` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '微信二维码',
  `Downurl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'app下载地址',
  `PicSize` int(11) DEFAULT '0' COMMENT '图片大小上限',
  `PicExt` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '允许上传的图片扩展名',
  `IsThumbnail` int(11) DEFAULT '1' COMMENT '主图是否生成缩略图',
  `FileSize` int(11) DEFAULT '0' COMMENT '文件大小上限',
  `FileExt` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '允许上传的文件扩展名',
  `SmtpServer` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'SMTP服务器地址',
  `SmtpPort` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'SMTP端口号',
  `SmtpUser` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'SMTP用户名',
  `SmtpPsd` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'SMTP密码',
  `SmtpNiceName` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '发件人昵称',
  `AppCode` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '用于获取IP地址的阿里云APPCODE',
  `Store` int(2) DEFAULT '0' COMMENT '存储方式  0存储到本地  1存储到七牛云 2存储OSS',
  `MhCode` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '魔盒partner_code',
  `MhKey` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '魔盒partner_key',
  `Gfaccount` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '官方账号(支付宝收款账号)',
  `Gfaccountw` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '微信收款账号',
  `Remarkgs` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT '备注格式',
  `ShowEduNolog` int(11) DEFAULT '0' COMMENT '不登录显示额度',
  `ShowEduNorz` int(11) DEFAULT '0' COMMENT '未认证显示额度',
  `Mlimitbalance` int(11) DEFAULT '0' COMMENT '默认额度(认证全部通过自动给的额度)',
  `Tcstatus` tinyint(4) DEFAULT '1' COMMENT '弹窗状态:1不弹 2h5弹 3app弹 4都弹',
  `TanImg` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '弹窗图',
  `TanUrl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '弹窗链接',
  `Payceshi` tinyint(4) DEFAULT '1' COMMENT '支付测试:1正式 2测试',
  `MaxAges` int(11) DEFAULT '0' COMMENT '最大年龄(借款)',
  `MinAges` int(11) DEFAULT '0' COMMENT '最小年龄(借款)',
  `OperatorID` int(11) DEFAULT NULL COMMENT '操作者',
  `UpdateTime` datetime DEFAULT NULL COMMENT '最后更新时间',
  `Key` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IV` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of xb_sys_basicinfo
-- ----------------------------
INSERT INTO `xb_sys_basicinfo` VALUES ('1', '五斗米管理系统', 'http://www.o2oo.com.cn/', '讯邦信息管理系统，专业的信息管理、分析系统', '讯邦信息管理系统，专业的信息管理、分析系统', '讯邦信息管理系统：最优秀的信息管理系统软件。', 'http://om4nervsu.bkt.clouddn.com/20171102_59facbb06ee37.jpg', '', '30', '1', '9999999999999', '4', '', '', '', 0xE59D8FE89B8B2CE582BBE980BC, '五斗米网络科技有限公司', '0', '0', '0000000000', '1234567', '0551-00000080', '', '/Upload/image/2018-08-21/5b7c01fe229c3.png', 'http://www.baidu.com', '1500', 'gif,jpg,bmp,png', '0', '100000', 'doc,xls,ppt,docx,xlsx,pptx,rar,txt,zip,7z', '', '', '', '', '', '9085786982b5453d9230e874e8fbba94', '0', 'wdm_mohe', 'c17c6e8abffa48e88eac2eda4b53f259', '183559658741', 'wx559658741', '姓名+转账金额', '5000', '5000', '2000', '3', '/Upload/image/2018-08-22/5b7cd9539f69f.png', 'http://47.96.88.25/index.php/index/kouzi', '2', '50', '22', '2', '2018-08-27 08:55:45', 'public_key', 'public_iv');
