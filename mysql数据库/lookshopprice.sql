/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : lookshopprice

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-18 18:52:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '我想买戴尔电脑', '这里有戴尔成就笔记本电脑吗？', 'user1', '2018-03-31 10:50:15', '有的哈！', '2018-03-31 10:50:17');
INSERT INTO `t_leaveword` VALUES ('2', '这里还可以买手机吗', '我女朋友喜欢手机，这里有手机没有？', 'user1', '2018-04-06 14:49:59', '必须的啊！', '2018-04-06 17:38:39');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '商品比价网成立了', '<p>这里发布最新各种商品，多个商家价格一目了然，选择你中意的商家购买宝贝哦！</p>', '2018-03-31 10:51:35');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL auto_increment COMMENT '商品id',
  `productClassObj` int(11) NOT NULL COMMENT '商品类别',
  `productName` varchar(50) NOT NULL COMMENT '商品名称',
  `mainPhoto` varchar(60) NOT NULL COMMENT '商品主图',
  `price` float NOT NULL COMMENT '市场价格',
  `productDesc` varchar(5000) NOT NULL COMMENT '商品描述',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`productId`),
  KEY `productClassObj` (`productClassObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`productClassObj`) REFERENCES `t_productclass` (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '1', 'Dell/戴尔 灵越15(3568) 笔记本电脑', 'upload/c95d9ef6-ccaa-4507-bf5b-dc9982068cf1.jpg', '3899', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>证书编号：2014010902740177</p></li><li><p>证书状态：有效</p></li><li><p>申请人名称：纬创资通股份有限公司</p></li><li><p>制造商名称：戴尔(中国)有限公司</p></li><li><p>产品名称：便携式计算机</p></li><li><p>3C产品型号：P47F; Inspiron 15-3551; Inspiron 15-3558 输入: 19.5V...</p></li><li><p>3C规格型号：Inspiron 15-3568，P47F; Inspiron 15-3551; Inspiron ...</p></li><li><p>产品名称：Dell/戴尔 灵越15(3568)...</p></li><li><p>品牌:&nbsp;Dell/戴尔</p></li><li><p>型号:&nbsp;Ins15E-3725</p></li><li><p>屏幕尺寸:&nbsp;15.6英寸</p></li><li><p>CPU:&nbsp;英特尔 酷睿 i7-7500U</p></li><li><p>显卡类型:&nbsp;AMD R5 M315</p></li><li><p>显存容量:&nbsp;2GB</p></li><li><p>机械硬盘容量:&nbsp;1TB</p></li><li><p>内存容量:&nbsp;4GB</p></li><li><p>操作系统:&nbsp;windows 10</p></li></ul><p><br/></p>', '2018-03-31 10:49:33');
INSERT INTO `t_product` VALUES ('2', '2', '苹果iPhone 8 Plus 64G全网通手机', 'upload/513b2ae5-85c5-43af-87fc-6c56b239f49e.jpg', '6688', '<ul style=\"list-style-type: none;\" class=\" list-paddingleft-2\"><li><p>证书编号：2017011606002397</p></li><li><p>证书状态：有效</p></li><li><p>产品名称：TD-LTE 数字移动电话机</p></li><li><p>3C规格型号：A1864(电源适配器可选：A1443 输出：5.0VDC 1A)</p></li><li><p>产品名称：Apple/苹果 iPhone 8 Plu...</p></li><li><p>Apple型号:&nbsp;iPhone 8 Plus</p></li><li><p>机身颜色:&nbsp;金色&nbsp;深空灰色&nbsp;银色</p></li><li><p>存储容量:&nbsp;64GB</p></li></ul><p><br/></p>', '2018-04-06 20:57:17');

-- ----------------------------
-- Table structure for `t_productclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_productclass`;
CREATE TABLE `t_productclass` (
  `classId` int(11) NOT NULL auto_increment COMMENT '类别id',
  `className` varchar(40) NOT NULL COMMENT '类别名称',
  `classDesc` varchar(500) NOT NULL COMMENT '类别描述',
  PRIMARY KEY  (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productclass
-- ----------------------------
INSERT INTO `t_productclass` VALUES ('1', '笔记本电脑', '笔记本电脑产品');
INSERT INTO `t_productclass` VALUES ('2', '智能手机', '时尚手机类');

-- ----------------------------
-- Table structure for `t_productcomment`
-- ----------------------------
DROP TABLE IF EXISTS `t_productcomment`;
CREATE TABLE `t_productcomment` (
  `commentId` int(11) NOT NULL auto_increment COMMENT '评论id',
  `productObj` int(11) NOT NULL COMMENT '被评商品',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`commentId`),
  KEY `productObj` (`productObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_productcomment_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_productcomment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productcomment
-- ----------------------------
INSERT INTO `t_productcomment` VALUES ('1', '1', '这个电脑漂亮', 'user1', '2018-03-31 10:49:42');
INSERT INTO `t_productcomment` VALUES ('2', '1', '我喜欢这个电脑！', 'user1', '2018-04-06 15:42:57');
INSERT INTO `t_productcomment` VALUES ('4', '2', '喜欢这个手机，流畅', 'user1', '2018-04-06 21:03:10');
INSERT INTO `t_productcomment` VALUES ('5', '2', '嗯 我也喜欢这手机', 'user2', '2018-04-06 21:04:32');

-- ----------------------------
-- Table structure for `t_seller`
-- ----------------------------
DROP TABLE IF EXISTS `t_seller`;
CREATE TABLE `t_seller` (
  `sellerId` int(11) NOT NULL auto_increment COMMENT '商家id',
  `sellerName` varchar(20) NOT NULL COMMENT '商家名称',
  `sellerLogo` varchar(60) NOT NULL COMMENT '商家logo',
  `sellerDesc` varchar(800) NOT NULL COMMENT '商家介绍',
  `sellerTelephone` varchar(20) NOT NULL COMMENT '商家电话',
  `sellerAddress` varchar(80) NOT NULL COMMENT '商家地址',
  `sellerSite` varchar(60) NOT NULL COMMENT '商家网站',
  PRIMARY KEY  (`sellerId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_seller
-- ----------------------------
INSERT INTO `t_seller` VALUES ('1', '苏宁易购商城', 'upload/edbcd537-7878-4f3c-b2e2-649ad03d5a57.jpg', '10年电脑以及配件批发中心', '028-89398592', '四川成都市一环路南二段', 'http://www.xxx.com');
INSERT INTO `t_seller` VALUES ('2', '京东商城', 'upload/be5b48ab-423a-40e0-939a-25187e7a685f.jpg', '数码通讯、电脑、家居百货、服装服饰、母婴、图书、食品、在线旅游等12大类数万个品牌百万种优质商品。京东在2012年的中国自营B2C市场占据49%的份额，凭借全供应链继续扩大在中国电子商务市场的优势。京东已经建立华北、华东、华南、西南、华中、东北六大物流中心', '010-83982984', '北京市朝阳区北辰西路8号北辰世纪中心A座', 'https://www.jd.com/');

-- ----------------------------
-- Table structure for `t_sellerprice`
-- ----------------------------
DROP TABLE IF EXISTS `t_sellerprice`;
CREATE TABLE `t_sellerprice` (
  `priceId` int(11) NOT NULL auto_increment COMMENT '价格id',
  `productObj` int(11) NOT NULL COMMENT '商品信息',
  `price` float NOT NULL COMMENT '商品报价',
  `sellerObj` int(11) NOT NULL COMMENT '报价商家',
  `priceDate` varchar(20) default NULL COMMENT '报价日期',
  `buyAddress` varchar(500) NOT NULL COMMENT '购买链接',
  `priceMemo` varchar(800) default NULL COMMENT '备注信息',
  PRIMARY KEY  (`priceId`),
  KEY `productObj` (`productObj`),
  KEY `sellerObj` (`sellerObj`),
  CONSTRAINT `t_sellerprice_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_sellerprice_ibfk_2` FOREIGN KEY (`sellerObj`) REFERENCES `t_seller` (`sellerId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_sellerprice
-- ----------------------------
INSERT INTO `t_sellerprice` VALUES ('1', '1', '3299', '1', '2018-03-30', 'https://detail.tmall.com/item.htm?spm=a230r.1.14.6.7e193ab5wsKz0Z&id=542717467328&cm_id=140105335569ed55e27b&abbucket=11&sku_properties=5919063:6536025', 'test');
INSERT INTO `t_sellerprice` VALUES ('2', '1', '3499', '2', '2018-04-01', 'https://item.jd.com/10400117949.html', '京东价格');
INSERT INTO `t_sellerprice` VALUES ('3', '2', '6588', '1', '2018-04-01', 'https://detail.tmall.com/item.htm?spm=a230r.1.14.1.25181b35ryPnDM&id=558760911386&ns=1&abbucket=11&sku_properties=10004:709990523;5919063:6536025;12304035:3222911', '测试连接');
INSERT INTO `t_sellerprice` VALUES ('4', '2', '5745', '2', '2018-04-03', 'https://item.jd.com/16580586466.html', '京东好货淘');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '李明文', '男', '2018-03-22', 'upload/dbd8536a-19b2-4a40-8d2a-0df43eb2cba3.jpg', '13980803952', 'mingwen@163.com', '四川成都红星路13号', '2018-03-31 10:49:18');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张晓芬', '女', '2018-04-05', 'upload/959546e5-2258-4eeb-b772-b747708bbcd9.jpg', '15892083942', 'xiaofen@163.com', '四川德阳航海路10号', '2018-04-06 21:02:10');
