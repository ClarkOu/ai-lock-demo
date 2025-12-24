
CREATE database if NOT EXISTS `hotellock` default character set utf8mb4 collate utf8mb4_unicode_ci;
USE `hotellock`;

/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.7
 Source Server Type    : MySQL
 Source Server Version : 50738 (5.7.38)
 Source Host           : 127.0.0.1:3306
 Source Schema         : gcslock

 Target Server Type    : MySQL
 Target Server Version : 50738 (5.7.38)
 File Encoding         : 65001

 Date: 31/03/2025 16:10:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- ----------------------------
-- Table structure for sys_var_define
-- ----------------------------

CREATE TABLE IF NOT EXISTS `sys_var_define` (
                                  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                  `category` varchar(50) DEFAULT NULL COMMENT '类别',
                                  `param_key` varchar(255) NOT NULL COMMENT '参数键，唯一标识参数',
                                  `param_value` varchar(255) NOT NULL COMMENT '参数值',
                                  `description` varchar(255) DEFAULT NULL COMMENT '参数描述',
                                  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                  `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `sys_paramters_unique` (`category`,`param_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统参数表';

INSERT INTO `sys_var_define` (category, param_key, param_value, description, remark) VALUES
    ('System','CompanyNameChinese', '公司名称', '软件标题名称_中文', null), #softName
    ('System','CompanyNameEnglish', 'Company Name', '软件标题名称_英文', null), #softName
    ('System','SoftwareNameChinese', '智能门锁管理系统', '单位名称_中文', null), #companyName
    ('System','SoftwareNameEnglish', 'GCS Hotel Locking System', '单位名称_英文', null), #companyName
    ('System','DelayTimeToEmpty', '30', '退房后自动转空净房间时间0-65535分钟？', null), #delayTimeToEmpty
    ('System','DelayTimeToLogout', '10', '无操作时自动登出时间', null), #delayTimeToLogout
    ('System','GuestCardOpenExtRooms', '1', '宾客卡可开亲属房1:true 0:false', null), #guestCardOpenExtRooms
    ('System','CanLostGuestCard', '0', '可以挂失宾客卡（建议仅用于门禁）0:false 1:ture', null), #canLostGuestCard
    ('System','EnableUserModifyCheckInTime', '0', '允许修改散客+全天房+非预定的入住时间，0:false 1:true', null), #enableUserModifyCheckInTime
    ('System','GuestCardsOverInBatches', '0', '批量制卡时可以覆盖写宾客卡 0:false 1:true', null), #guestCardsOverInBatches
    ('System','WorkstationCount', '5', '登录工作站数量限制', null), #workstationCount
    ('System','SysLanguage', '1', '当前语言 2:中文 1:英文', null), ##TODO sysLanguage
    ('System','DefStayDay', '1', '默认入住天数', null), #defStayDay
    ('System','DefMakeCardNums', '3', '默认制卡数，范围0-254', null), #defMakeCardNums
    ('System','DefOutTime', '12:05', '退房时间', null), # defOutTime
    ('System', 'EnableAutoCheckOut', '0', '启用自动退房 0否 1是', null), # enableAutoCheckOut
    ('System','ReIssueAbortOld', '1', '补卡时终止前卡 0:否 1:是', null), #reIssueAbortOld
    ('System','GuestCardCanOpenDBLock', '0', '宾客可开反锁 0:否 1:是', null), #guestCardCanOpenDBLock
    ('System','UseArea', '0', '宾客卡启用区域功能 0:否 1:是', null), #useArea
    ('System','UseElevator', '0', '启用电梯楼层控制0:否 1:是', null), #useElevator
    ('System','KeycardSound', '1', '刷卡提示音 0:否 1:是', null), #keycardSound
    ('System','HandsetOperationSound', '1', '手机操作提示音 0:否 1:是', null), #handsetOperationSound
    ('System','LowBatteryAlarm', '1', '低电量报警声 0:否 1:是', null), # lowBatteryAlarm
    ('System','DoorAlarm', '1', '门未关报警声 0:否 1:是', null), # doorAlarm
    ('System','AutoTimes', '1', '设备配置完成后自动校准时间 0:否 1:是', null), #autoTimes
    ('System','DaylightTime', '0', '设置夏令时（自动调快和调慢一小时） 0:否 1:是', null), #daylightTime
    ('System','DaylightStartTime', '4_1_1_0', '设置夏令时开始时间', null), #daylightStartTime
    ('System','DaylightEndtime', '十月_最后一个_周日_23', '设置夏令时结束时间', null), # daylightEndtime

    ('System','OpenDoorByPhone', '1', '启用手机开门功能', null), # openDoorByPhone
    ('System','GeographicArea', '中东地区', '地理区域', null), # geographicArea
    ('System','HotelName', 'Test GCS', '酒店名称', null), # hotelName

    ('System','MqttHost', '192.168.1.172', 'MQTT地址', null), # mqttHost
    ('System','MqttPort', '1883', 'MQTT端口', null), # mqttPort

#     ('System', 'AbortOldGuestCard', '0', '中止旧宾客卡 0:否 1:是', null), ##TODO
#     ('System', 'AuthorKey0', '', '授权密钥 0', null),
    ('System', 'EnableZigbee', '1', '是否启用zigbee 0:否 1:是', null),
    ('System', 'EnableMobileKey', '1', '是否开启手机密钥 0:否 1:是', null),
    ('System', 'HandsetAdjustTime', '1', '是否自动匹配手持机时间 0:否 1:是', null),
    ('System', 'AuthorKey1', 'BA6FF47A890C3591C96B8D0B807E4395','授权密钥', '042D3002C01A90'),
#     ('System', 'AuthorKey5', '', '授权密钥 5', null),
#     ('System', 'AuthorKeyBak', '', '授权密钥备份', null),
#     ('System', 'AutoRoomCodeLen', '3', '自动房间代码长度', null),
#     ('System', 'AutoSwichCheckIn', '1', '自动 Swich 值机 0:否 1:是', null),
#     ('System', 'AutoSwichCheckInTime', '60', '自动 Swich 登机时间', null),
#     ('System', 'BuildingCodeLen', '1', '建筑代码长度', null),
#     ('System', 'CanCheckInNoCard', '0', '可以无卡入住0:否 1:是', null),
#     ('System', 'CanMakeMutiDoorCard', '0', '可以制作多门卡', null),
#     ('System', 'DBVersion', '2023.07.21', 'DB Version' , null),
#     ('System', 'DefCalcPriceType', '1', '默认计算价格类型', null),
#     ('System', 'DefStayHour', '2', '默认入住小时', null),
    ('System', 'DelayedPoweroffSeconds', '30', '延迟关机秒数', null),
    ('System', 'EmployeeCardPowerOnMinutes', '65535', '员工卡开机分钟数', null),
#     ('System', 'EnablePMSOrder', '0', '启用 PMS 订单 0否 1是', null),
#     ('System', 'IDDateSepTime', '06:00', '', null),
#     ('System', 'LayerCodeLen', '1', '图层代码长度', null),
#     ('System', 'MaxStayHour', '24', '最长停留时间', null),
#     ('System', 'NoonNightRoomEnd', '06:00', '中午晚上 房间结束', null),
#     ('System', 'NoonNighCheckOut', '18:00', '中午临近退房', null),
#     ('System', 'NoonNightRoomStart', '02:00',  '中午晚上房间开始', null),
#     ('System', 'OpenLockIncMinute', '15', '锁打开的限定时间', null),
#     ('System', 'RoomCodeLen', '2','房间代码长度', null),
#     ('System', 'ShowReplaceNo', '0','显示替换否，0否 1是', null),
#     ('System', 'SubRoomCodeLen', '1','子房间代码长度', null),
#     ('HSJCloud', 'RefreshDelay', '5', '刷新延迟', null),
#     ('DB', 'LastBackupTime', '','最后一次备份时间', null),
#     ('DB', 'LastBackupfile', '','最后一次备份文件', null),
    ('DB', 'ShowBakDlgOnClose', '0','关闭时显示 Bak DLG ,0否 1是', null),
    ('DB', 'AutoBackupTime', '12:00', '自动备份时间', null),
    ('DB', 'BackupFileCount', '10', '备份文件计数', null),
    ('DB', 'BackupFileFoder', '', '备份文件 foder', null)
#     ('RoomStatus', 'CheckinedRoomColor', '7124694', '入住房间颜色', null),
#     ('RoomStatus', 'DirtyRoomColor', '1784798', '肮脏的房间颜色', null),
#     ('RoomStatus', 'EmptyRoomColor', '38504', '空房间颜色', null),
#     ('RoomStatus', 'RepairingRoomColor', '14145495','修复房间颜色', null),
#     ('RoomStatus', 'ReservedRoomColor', '40937','预留房间颜色', null),
#     ('RoomStatus', 'VIPRoomColor', '7124694','贵宾室颜色', null),
#     ('RoomStatus', 'RefreshDelay', '3','刷新延迟', null),
#     ('RoomStatus', 'UpdateBy', 'DESKTOP-E7LAO4D', '此字段应该是前端程序安装时调用后端接口插入', '2025-04-02 15:41:49')
ON DUPLICATE KEY UPDATE id = id;
;

-- ----------------------------
-- Table structure for employees
-- ----------------------------

CREATE TABLE IF NOT EXISTS `employees` (
    `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    `emp_id` varchar(8) NOT NULL UNIQUE COMMENT '员工ID',
    `sys_id` int(11) DEFAULT NULL COMMENT '系统ID',
    `username` varchar(50) NOT NULL COMMENT '员工姓名',
    `password` varchar(255) DEFAULT NULL COMMENT '密码',
    `salt` varchar(50) DEFAULT NULL COMMENT '密码盐',
    `is_operator` tinyint(4) DEFAULT NULL COMMENT '是否操作者',
    `remark` varchar(255) DEFAULT NULL COMMENT '备注',
    `position_id` int(11) DEFAULT NULL COMMENT '职位ID',
    `disabled_date` datetime DEFAULT NULL COMMENT '禁用日期',
    `last_login_date` datetime DEFAULT NULL COMMENT '最后登录日期',
    `handset_emp_id` int(11) DEFAULT NULL COMMENT '手持机ID',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = DYNAMIC;

INSERT INTO `employees` (emp_id, username,password, salt, is_operator, handset_emp_id, enabled,status, create_by, create_time) VALUES
                            ('0', 'Admin','999cf209ac60b0f9391d4fe538b7e9c9','JwZXtXszTQYpjoBI', 1, 1, 1, 1, 'GCSTIMES', NOW() )
ON DUPLICATE KEY UPDATE id = id;
-- ----------------------------
-- Table structure for sys_position
-- ----------------------------e

CREATE TABLE IF NOT EXISTS `sys_position` (
    `id` int(11) AUTO_INCREMENT PRIMARY KEY  COMMENT '主键',
    `position_id` int(11) NOT NULL UNIQUE COMMENT '职位id',
    `position_name` varchar(40) NOT NULL COMMENT '职位名称',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '系统职位表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_position_power
-- ----------------------------

CREATE TABLE IF NOT EXISTS `sys_position_power` (
    `position_id` int(11) NOT NULL COMMENT '职位id',
    `func_id` int(11) NOT NULL COMMENT '功能id',
    `remark` varchar(255) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`position_id`,`func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '系统职位权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------

CREATE TABLE IF NOT EXISTS `sys_log`  (
    `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `log_type` int(3) NULL DEFAULT NULL COMMENT '日志类型（1登录日志，2操作日志）',
    `log_content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志内容',
    `operate_type` int(2) NULL DEFAULT NULL COMMENT '操作类型',
    `userid` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户账号',
    `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作用户名称',
    `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
    `method` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求java方法',
    `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求路径',
    `request_param` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
    `request_type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求类型',
    `cost_time` bigint(20) NULL DEFAULT NULL COMMENT '耗时',
    `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
#     `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新人',
#     `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `client_type` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户端类型 pc:电脑端 app:手机端 h5:移动网页端',
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `idx_sl_userid`(`userid`) USING BTREE,
    INDEX `idx_sl_log_type`(`log_type`) USING BTREE,
    INDEX `idx_sl_operate_type`(`operate_type`) USING BTREE,
    INDEX `idx_sl_create_time`(`create_time`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for sys_functions_group
-- ----------------------------

CREATE TABLE IF NOT EXISTS `sys_functions_group` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `group_id` tinyint(4) NOT NULL COMMENT '组id',
   `language` varchar(10) DEFAULT NULL COMMENT '语言',
    `group_name` varchar(50) DEFAULT NULL COMMENT '组名称',
    `sort_id` int(11) DEFAULT NULL COMMENT '排序id',
    PRIMARY KEY (`id`),
   UNIQUE KEY unique_code_language (group_id, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '系统功能组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_functions_group
-- ----------------------------
INSERT INTO sys_functions_group(group_id, language, group_name, sort_id) values
                                     ('0','zh', '主页&入住管理', '1'),
                                     ('0','en', 'Home & Check In', '1'),
                                     ('1','zh', '卡片管理', '2'),
                                     ('1','en', 'Cards', '2'),
                                    ('2','zh', '查询报表', '3'),
                                    ('2','en', 'Reports', '3'),
                                    ('3','zh', '门锁设置', '4'),
                                    ('3','en', 'Room', '4'),
                                    ('4','zh', '系统维护', '5'),
                                    ('4','en', 'System', '5'),
                                    ('5','zh', '手持机', '6'),
                                    ('5','en', 'Handset', '6'),
                                    ('6','zh', '计次消费', '7'),
                                    ('6','en', 'Times Consumption', '7'),
                                    ('7','zh', '电梯', '8'),
                                    ('7','en', 'Elevator', '8')
ON DUPLICATE KEY UPDATE id = id;

#                                      ('0','zh', '卡片管理', '4'),
#                                      ('0','en', 'Cards Management', '4'),
#                                      ('1','zh', '查询报表', '5'),
#                                      ('1','en', 'Query Report', '5'),
#                                     ('2','zh', '门锁设置', '2'),
#                                     ('2','en', 'Lock Setting', '2'),
#                                     ('3','zh', '系统维护', '1'),
#                                     ('3','en', 'System Maintenance', '1'),
#                                     ('4','zh', '入住管理', '3'),
#                                     ('4','en', 'Check in Management', '3'),
#                                     ('5','zh', '计次消费', '6'),
#                                     ('5','en', 'Times Consumption', '6'),
#                                     ('6','zh', '挂失与取消挂失', '7'),
#                                     ('6','en', 'Lost or cancel lost status', '7'),
#                                     ('7','zh', '数据维护', '8'),
#                                     ('7','en', 'Data Maintenance', '8'),
#                                     ('8','zh', '手持机', '9'),
#                                     ('8','en', 'Handset', '9');
#                                     ('9','zh', '电梯', '10'),
#                                     ('9','en', 'Elevator', '10');

-- ----------------------------
-- Table structure for sys_functions
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_functions` (
     `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `func_id` int(11) NOT NULL COMMENT '功能ID',
    `language` varchar(10) DEFAULT NULL COMMENT '语言',
    `func_name` varchar(50) DEFAULT NULL COMMENT '功能名称',
    `enabled` tinyint(4) DEFAULT NULL COMMENT '启用',
    `group_id` tinyint(4) DEFAULT NULL COMMENT '组 ID',
    `sort_id` int(11) DEFAULT NULL COMMENT '排序 ID',
    PRIMARY KEY (`id`),
     UNIQUE KEY unique_code_language (func_id, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '系统功能表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_functions
-- ----------------------------
INSERT INTO sys_functions(func_id, language, func_name, enabled, group_id, sort_id) VALUES
                                    ('90', 'zh', '显示主页模块', '1', '0', '1'),
                                    ('90', 'en', 'Show Home Page Module', '1', '0', '1'),
                                    ('93', 'zh', '显示Check In模块', '1', '0', '2'),
                                    ('93', 'en', 'Show Check In Module', '1', '0', '2'),
                                    ('44', 'zh', '房态显示设置', '1', '0', '3'),
                                    ('44', 'en', 'Room State Setting', '1', '0', '3'),
                                    ('85', 'zh', 'VIP房间', '1', '0', '4'),
                                    ('85', 'en', 'VIP Room', '1', '0', '4'),
                                    ('12', 'zh', '入住发卡', '1', '0', '5'),
                                    ('12', 'en', 'Check in', '1', '0', '5'),
                                    ('14', 'zh', '续住', '1', '0', '6'),
                                    ('14', 'en', 'Overstay', '1', '0', '6'),
                                    ('15', 'zh', '更换客房', '1', '0', '7'),
                                    ('15', 'en', 'Change Room', '1', '0', '7'),
                                    ('43', 'zh', '加房', '1', '0', '8'),
                                    ('43', 'en', 'Add Room', '1', '0', '8'),
                                    ('42', 'zh', '补卡', '1', '0', '9'),
                                    ('42', 'en', 'Reissue', '1', '0', '9'),
                                    ('39', 'zh', '退房（回收卡片）', '1', '0', '10'),
                                    ('39', 'en', 'Checkout', '1', '0', '10'),
                                    ('13', 'zh', '无卡退房', '1', '0', '11'),
                                    ('13', 'en', 'Checkout without Card', '1', '0', '11'),
                                    ('41', 'zh', '预订入住 ', '1', '0', '12'),
                                    ('41', 'en', 'Reservation', '1', '0', '12'),
                                    ('40', 'zh', '更改房态', '1', '0', '13'),
                                    ('40', 'en', 'Change Room State', '1', '0', '13'),
                                    ('53', 'zh', '客单查看', '1', '0', '14'),
                                    ('53', 'en', 'Guest Bill', '1', '0', '14'),
                                    ('59', 'zh', '查看历史单据', '1', '0', '15'),
                                    ('59', 'en', 'Check Bill History', '1', '0', '15'),

                                    ('57', 'zh', '显示智能卡模块', '1', '1', '1'),
                                    ('57', 'en', 'Show Cards Module', '1', '1', '1'),
                                    ('75', 'zh', '电梯卡', '1', '1', '2'),
                                    ('75', 'en', 'Elevator Card', '1', '1', '2'),
                                    ('91', 'zh', '一次开门卡', '1', '1', '3'),
                                    ('91', 'en', 'One Time Card', '1', '1', '3'),
                                    ('36', 'zh', '后备宾客卡', '1', '1', '4'),
                                    ('36', 'en', 'Backup Guest Card', '1', '1', '4'),
                                    ('18', 'zh', '总卡', '1', '1', '5'),
                                    ('18', 'en', 'Master Card', '1', '1', '5'),
                                    ('19', 'zh', '楼栋卡', '1', '1', '6'),
                                    ('19', 'en', 'Building Card', '0', '1', '6'),
                                    ('20', 'zh', '楼层卡', '1', '1', '7'),
                                    ('20', 'en', 'Floor Card', '1', '1', '7'),
                                    ('38', 'zh', '多门卡', '1', '1', '8'),
                                    ('38', 'en', 'Multi-door Card', '1', '1', '8'),
                                    ('21', 'zh', '应急卡', '1', '1', '9'),
                                    ('21', 'en', 'Emergency Card', '1', '1', '9'),
                                    ('28', 'zh', '数据卡', '1', '1', '10'),
                                    ('28', 'en', 'Data Card', '1', '1', '10'),
                                    ('16', 'zh', '卡片挂失', '1', '1', '11'),
                                    ('16', 'en', 'Report Lost Card', '1', '1', '11'),
                                    ('17', 'zh', '取消卡片挂失', '1', '1', '12'),
                                    ('17', 'en', 'Cancel Lost Card', '1', '1', '12'),
                                    ('23', 'zh', '区域设置卡', '1', '1', '13'),
                                    ('23', 'en', 'Area Card', '1', '1', '13'),
                                    ('24', 'zh', '取消区域卡', '1', '1', '14'),
                                    ('24', 'en', 'Clear Area Card', '1', '1', '14'),
                                    ('37', 'zh', '宾客终止卡', '1', '1', '15'),
                                    ('37', 'en', 'Guest Stop', '1', '1', '15'),
                                    ('92', 'zh', '重置卡', '1', '1', '16'),
                                    ('92', 'en', 'SysReset Card', '1', '1', '16'),
                                    ('22', 'zh', '房间设置卡', '1', '1', '17'),
                                    ('22', 'en', 'Room Setting Card', '1', '1', '17'),
                                    ('94', 'zh', '权限设置卡', '1', '1', '18'), ####
                                    ('94', 'en', 'Access Setting', '1', '1', '18'),
                                    ('25', 'zh', '房间清除卡', '1', '1', '19'),
                                    ('25', 'en', 'Clear Setting Card', '1', '1', '19'),
                                    ('27', 'zh', '校时卡', '1', '1', '21'), ##
                                    ('27', 'en', 'Adjust Time Card', '1', '1', '21'),
                                    ('26', 'zh', '锁体设置卡', '1', '1', '22'),
                                    ('26', 'en', 'Mortise Setting Card', '1', '1', '22'),

                                    ('61', 'zh', '显示报表模块', '1', '2', '1'),
                                    ('61', 'en', 'Show Reports Module', '1', '2', '1'),
                                    ('31', 'zh', '在住客人查询', '1', '2', '2'),
                                    ('31', 'en', 'Staying Guest Query', '1', '2', '2'),
                                    ('34', 'zh', '发卡记录', '1', '2', '3'),
                                    ('34', 'en', 'Card Records', '1', '2', '3'),
                                    ('89', 'zh', '手持机发卡记录', '1', '2', '4'),
                                    ('89', 'en', 'Handset Card Records', '1', '2', '4'),
                                    ('33', 'zh', '退房记录', '1', '2', '5'),
                                    ('33', 'en', 'Checkout Report', '1', '2', '5'),
                                    ('29', 'zh', '制特殊卡记录', '1', '2', '6'),
                                    ('29', 'en', 'Special Card Record', '1', '2', '6'),
                                    ('30', 'zh', '片卡使用情况', '1', '2', '7'), ##
                                    ('30', 'en', 'Card State', '1', '2', '7'),
                                    ('86', 'zh', '用户权限记录', '1', '2', '8'),
                                    ('86', 'en', 'User Permission Record', '1', '2', '8'),
                                    ('95', 'zh', '公区设备', '1', '2', '9'), ##
                                    ('95', 'en', 'Device Event Report', '1', '2', '9'),

                                    ('63', 'zh', '显示房间模块', '1', '3', '1'),
                                    ('63', 'en', 'Show Room Module', '1', '3', '1'),
                                    ('9', 'zh', '楼栋信息', '1', '3', '2'),
                                    ('9', 'en', 'Building', '1', '3', '2'),
                                    ('54', 'zh', '楼层信息', '1', '3', '3'),
                                    ('54', 'en', 'Floor Information', '1', '3', '3'),
                                    ('10', 'zh', '区域信息', '1', '3', '4'),
                                    ('10', 'en', 'Area', '1', '3', '4'),
                                    ('96', 'zh', 'Access', '1', '3', '5'), ####
                                    ('96', 'en', 'Access', '1', '3', '5'),
                                    ('8', 'zh', '客房类别', '1', '3', '6'),
                                    ('8', 'en', 'Room Type', '1', '3', '6'),
                                    ('11', 'zh', '客房信息', '1', '3', '7'),
                                    ('11', 'en', 'Room Information', '1', '3', '7'),

                                    ('62', 'zh', '显示系统模块', '1', '4', '1'),
                                    ('62', 'en', 'Show System Module', '1', '4', '1'),
                                    ('4', 'zh', '系统设置', '1', '4', '2'),
                                    ('4', 'en', 'System Setting', '1', '4', '2'),
                                    ('97', 'zh', '注册发卡器', '1', '4', '3'),
                                    ('97', 'en', 'Register Encoder', '1', '4', '3'),
                                    ('98', 'zh', '读取授权码', '1', '4', '4'),
                                    ('98', 'en', 'Read Licence Card', '1', '4', '4'),
                                    ('99', 'zh', '固件管理', '1', '4', '5'),
                                    ('99', 'en', 'Firmware Management', '1', '4', '5'),
                                    ('3', 'zh', '操作员管理', '1', '4', '6'),
                                    ('3', 'en', 'Operator Management', '1', '4', '6'),
                                    ('5', 'zh', '数据备份', '1', '4', '7'),
                                    ('5', 'en', 'Backup Database', '1', '4', '7'),
                                    ('6', 'zh', '数据还原', '1', '4', '8'),
                                    ('6', 'en', 'Restore Database', '1', '4', '8'),
                                    ('45', 'zh', '自动备份设置', '1', '4', '9'),
                                    ('45', 'en', 'Auto Backup Setting', '1', '4', '9'),
                                    ('1', 'zh', '更改用户密码', '1', '4', '10'),
                                    ('1', 'en', 'Password', '1', '4', '10'),
                                    ('67', 'zh', 'FIAS服务管理', '1', '4', '11'),
                                    ('67', 'en', 'FIAS Management', '1', '4', '11'),

                                    ('88', 'zh', '管理手持机权限', '1', '5', '1'),
                                    ('88', 'en', 'Manage handset permissions', '1', '5', '1'),
                                    ('58', 'zh', '读取信息记录', '1', '5', '2'),
                                    ('58', 'en', 'Read Info Records', '1', '5', '2'),
                                    ('35', 'zh', '读取事件记录', '1', '5', '3'),
                                    ('35', 'en', 'Read Event Records', '1', '5', '3'),
                                    ('87', 'zh', '同步手持机发卡记录', '1', '5', '4'),
                                    ('87', 'en', 'Sync Handset Card Records', '1', '5', '4'),
                                    ('60', 'zh', '下载所有设置项', '1', '5', '5'),
                                    ('60', 'en', 'Download All Settings', '1', '5', '5'),

                                    ('56', 'zh', '打开计次消费主窗口', '1', '6', '1'),
                                    ('56', 'en', 'Consumption Window', '1', '6', '1'),
                                    ('52', 'zh', '消费类别定义', '1', '6', '2'),
                                    ('52', 'en', 'Consumption Type', '1', '6', '2'),
                                    ('48', 'zh', '入住登记增加计次消费', '1', '6', '3'),
                                    ('48', 'en', 'Check in with External Consumption Times', '1', '6', '3'),
                                    ('49', 'zh', '消费登记减少剩余次数', '1', '6', '4'),
                                    ('49', 'en', 'Read Card to Consume', '1', '6', '4'),
                                    ('51', 'zh', '消费记录查询', '1', '6', '5'),
                                    ('51', 'en', 'Query Consumption Record', '1', '6', '5'),
                                    ('50', 'zh', '计次消费卡管理', '1', '6', '6'),
                                    ('50', 'en', 'Consumption Management', '1', '6', '6'),

                                    ('100', 'zh', '客梯', '1', '7', '1'),
                                    ('100', 'en', 'Passenger Elevator', '1', '7', '1'),
                                    ('101', 'zh', '员工梯', '1', '7', '2'),
                                    ('101', 'en', 'Service Elevator', '1', '7', '2'),
                                    ('102', 'zh', '货梯', '1', '7', '3'),
                                    ('102', 'en', 'Freight Elevator', '1', '7', '3'),
                                    ('103', 'zh', '贵宾梯', '1', '7', '4'),
                                    ('103', 'en', 'Executive Elevator', '1', '7', '4'),
                                    ('104', 'zh', '消防梯', '1', '7', '5'),
                                    ('104', 'en', 'Firefighter Elevator', '1', '7', '5'),
                                    ('105', 'zh', '预留电梯1', '1', '7', '6'),
                                    ('105', 'en', 'Reserved Elevator 1', '1', '7', '6'),
                                    ('106', 'zh', '预留电梯2', '1', '7', '7'),
                                    ('106', 'en', 'Reserved Elevator 2', '1', '7', '7'),
                                    ('107', 'zh', '预留电梯3', '1', '7', '8'),
                                    ('107', 'en', 'Reserved Elevator 3', '1', '7', '8')
ON DUPLICATE KEY UPDATE id = id;


CREATE TABLE IF NOT EXISTS buildings (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '楼栋唯一标识符',
    building_code varchar(3) NOT NULL UNIQUE COMMENT '建筑编码',
    building_name VARCHAR(100) NOT NULL COMMENT '楼栋名称',
    building_address VARCHAR(200) DEFAULT NULL COMMENT '楼栋地址',
    building_uses VARCHAR(100) DEFAULT NULL COMMENT '楼栋用途',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    `lay_quantity` smallint(6) DEFAULT NULL COMMENT '楼层数量默认254',
    `building_replace_no` varchar(10) DEFAULT NULL COMMENT '建筑更换编号（英文BCD...）'
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '建筑楼栋表' ROW_FORMAT = DYNAMIC;


CREATE TABLE IF NOT EXISTS floors (
    id INT AUTO_INCREMENT PRIMARY KEY  COMMENT '楼层唯一标识符',
    floor_code INT NOT NULL UNIQUE COMMENT '楼层编号（正数为地上，负数为地下）',
    floor_name VARCHAR(50) DEFAULT NULL COMMENT '楼层名称（如“1楼”、“B1”）',
    floor_uses VARCHAR(100) DEFAULT NULL COMMENT '楼层用途（如“办公”、“停车场”）',
	`actual_code` int DEFAULT NULL COMMENT '实际楼层编号',
	`hard_code` varchar(3) DEFAULT NULL COMMENT '楼层硬件编号',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
	UNIQUE KEY(`floor_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '建筑楼层表' ROW_FORMAT = DYNAMIC;


CREATE TABLE IF NOT EXISTS areas (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '区域唯一标识符',
    area_code VARCHAR(100) NOT NULL UNIQUE COMMENT '区域编码',
    area_name VARCHAR(100) DEFAULT NULL COMMENT '区域名称',
    area_uses VARCHAR(100)  DEFAULT NULL  COMMENT '区域用途（如“会议室”、“办公室”）',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '区域表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for elevatorinfo
-- ----------------------------

CREATE TABLE IF NOT EXISTS `elevator_info` (
    id INT AUTO_INCREMENT primary key COMMENT '唯一标识符',
    `elevator_id` int(11) NOT NULL unique COMMENT '设备ID',
    `elevator_name` varchar(50) NOT NULL COMMENT '设备名称',
    `elevator_type` tinyint(4) DEFAULT NULL COMMENT '设备类型（0-门锁控制器，1-电梯读卡器，2-门禁控制器）',
    `elevator_mode` tinyint(4) DEFAULT NULL COMMENT '设备模式（1-自由模式，2-楼层模式|管控模式，3-楼层+时间模式）',
    `floor_mode` tinyint(4) DEFAULT NULL COMMENT '门类别（0-酒店大门，1-楼栋门，2-楼层门，3-区域门 TODO ?新增字段）',
    `building_code` varchar(3) DEFAULT NULL COMMENT '建筑代码',
    `initial_floor` smallint(6) NOT NULL COMMENT '初始楼层',
    `stop_floor` smallint(6) DEFAULT NULL COMMENT '终止楼层',
    `auto_light` tinyint(4) DEFAULT NULL COMMENT '自动点亮',
    `replace_previous` tinyint(4) DEFAULT NULL COMMENT '是否顶替前卡',
    `remark` varchar(250) DEFAULT NULL COMMENT '备注',
    `time_section1` varchar(15) DEFAULT NULL COMMENT '时间部分 1',
    `time_section2` varchar(15) DEFAULT NULL COMMENT '时间部分 2',
    `time_section3` varchar(15) DEFAULT NULL COMMENT '时间部分 3',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    `disabled_date` datetime DEFAULT NULL COMMENT '禁用日期',
    `area_list` varchar(100) DEFAULT NULL COMMENT '区域列表',
    `mac_id` varchar(36) DEFAULT NULL COMMENT 'Mac 身份证',
    `elevator_settings` tinyint(4) DEFAULT NULL COMMENT '电梯类型（1-客梯，2-员工梯，4-货梯，8-贵宾梯，16-消防梯，32-预留电梯1，64-预留电梯2，128-预留电梯3）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '门禁设备表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for firmware_info
-- ----------------------------

CREATE TABLE IF NOT EXISTS `firmware_info` (
    `id` int AUTO_INCREMENT COMMENT '主键',
    `product_id` int(11) NOT NULL COMMENT '产品 ID',
    `product_type` varchar(50) NOT NULL COMMENT '产品类型',
    `product_model` varchar(50) NOT NULL COMMENT '产品型号',
    `firmware_version` varchar(30) NOT NULL COMMENT '固件版本',
    `firmware_name` varchar(50) DEFAULT NULL COMMENT '固件名称',
    `firmware_file_md5` varchar(32) DEFAULT NULL COMMENT '固件文件 md 5',
    `firmware_file` varchar(255) DEFAULT NULL COMMENT '固件文件',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    `disabled_date` datetime DEFAULT NULL COMMENT '禁用日期',
    PRIMARY KEY (`id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '固件信息表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for card_state
-- ----------------------------

CREATE TABLE IF NOT EXISTS `card_state` (
    `id` int AUTO_INCREMENT primary key  COMMENT '主键',
    `card_code` varchar(16) NOT NULL unique COMMENT '卡代码',
    `last_make_card_auto_code` int(11) DEFAULT NULL COMMENT '最后制卡自动编码',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '卡状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bill_info
-- ----------------------------

CREATE TABLE IF NOT EXISTS `bill_info` (
     `id` INT AUTO_INCREMENT primary key COMMENT '唯一标识符',
     `bill_no` varchar(20) NOT NULL unique COMMENT '账单编号',
     `check_in_type_code` tinyint(4) DEFAULT NULL COMMENT '签入类型代码',
     `locked` tinyint(4) DEFAULT NULL COMMENT '锁定',
     `lock_time` datetime DEFAULT NULL COMMENT '锁定时间',
     `lock_host` varchar(20) DEFAULT NULL COMMENT '锁定主机',
     `lock_user_name` varchar(20) DEFAULT NULL COMMENT '锁定用户名',
     `bill_state` tinyint(4) DEFAULT NULL COMMENT '账单状态',
     `bill_type` tinyint(4) DEFAULT NULL COMMENT '账单类型',
     `guest_no` varchar(10) DEFAULT NULL COMMENT '客人编号',
     `guest_name` varchar(100) DEFAULT NULL COMMENT '客人姓名',
     `id_type` varchar(20) DEFAULT NULL COMMENT 'ID 类型',
     `id_code` varchar(100) DEFAULT NULL COMMENT 'ID 代码',
     `in_date` datetime DEFAULT NULL COMMENT '入住日期',
     `plan_out_date` datetime DEFAULT NULL COMMENT '计划退住日期',
     `real_out_date` datetime DEFAULT NULL COMMENT '真实退住日期',
     `bill_date` int(11) DEFAULT NULL COMMENT '账单日期',
     `calc_price_type` int(11) DEFAULT NULL COMMENT '计算价格类型',
     `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
     `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
     `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
     `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
     `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
     `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
     `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
     `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '账单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for bill_rooms
-- ----------------------------

CREATE TABLE IF NOT EXISTS `bill_rooms` (
    `id` INT AUTO_INCREMENT COMMENT '唯一标识符',
    `bill_no` varchar(20) NOT NULL COMMENT '账单编号',
    `building_code` varchar(3) NOT NULL COMMENT '建筑编码',
    `floor_code` INT NOT NULL COMMENT '图层编码',
    `room_code` varchar(10) NOT NULL COMMENT '房间编码',
    `sub_room_code` varchar(3) NOT NULL COMMENT '子房间编码',
    `room_name` varchar(20) NOT NULL COMMENT '房间名称',
    `room_type` varchar(20) DEFAULT NULL COMMENT '房间类型',
    `operator` varchar(50) DEFAULT NULL COMMENT '操作员',
    `price` decimal(19,4) DEFAULT NULL COMMENT '价格',
    `in_date` datetime DEFAULT NULL COMMENT '入住日期',
    `plan_out_date` datetime DEFAULT NULL COMMENT '计划退房日期',
    `real_out_date` datetime DEFAULT NULL COMMENT '真实退房日期',
    `make_card_count` tinyint(4) DEFAULT NULL COMMENT '制卡数量',
    `return_card_count` tinyint(4) DEFAULT NULL COMMENT '退卡数量',
    `check_in_type_code` tinyint(4) DEFAULT NULL COMMENT '入住类型代码',
    `calc_price_type` tinyint(4) DEFAULT NULL COMMENT '计算价格类型',
    `area1` tinyint(4) DEFAULT NULL COMMENT '区域1',
    `area2` tinyint(4) DEFAULT NULL COMMENT '区域2',
    `check_out_with_out_card` int(11) DEFAULT NULL COMMENT '无卡结帐',
    `check_in_with_out_card` int(11) DEFAULT NULL COMMENT '无卡入住',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `ext_rooms` varchar(120) DEFAULT NULL COMMENT 'EXT 客房',
    `floor_list` text COMMENT '楼层列表',
    `pms_line_id` int(11) DEFAULT NULL COMMENT 'PMS 线路 ID',
    `we_chat_code_url` varchar(255) DEFAULT NULL COMMENT 'Wechat 代码 url',
    `phone_number` varchar(50) DEFAULT NULL COMMENT '电话号码',
    `open_pwd` varchar(30) DEFAULT NULL COMMENT '打开 PWD',
    `new_phone_number` varchar(50) DEFAULT NULL COMMENT '新电话号码',
    `area_list` text COMMENT '区域列表',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 0	已入住
                                                    1	已退部分
                                                    2	已退房
                                                    3	预订
                                                    4	未定义',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '客房账单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for last_bill_no
-- ----------------------------

CREATE TABLE IF NOT EXISTS `last_bill_no` (
    `header` varchar(3) NOT NULL COMMENT '表头',
    `id_date` int(11) NOT NULL COMMENT 'id日期',
    `last_bill_no` int(11) DEFAULT NULL COMMENT '最后账单编号',
    PRIMARY KEY (`header`,`id_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '最后账单编号表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS `room_info` (
    `id` int AUTO_INCREMENT COMMENT '主键id',
    `building_code` varchar(3) NOT NULL COMMENT '建筑编码',
    `floor_code` INT NOT NULL COMMENT '楼层编码',
    `room_code` varchar(10) NOT NULL COMMENT '房间编码',
    `sub_room_code` varchar(3) NOT NULL COMMENT '子房间编码',
    `room_name` varchar(20) DEFAULT NULL COMMENT '房间名称',
    `room_type` varchar(20) DEFAULT NULL COMMENT '房间类型',
    `status_code` tinyint(4) DEFAULT NULL COMMENT '状态代码 0-空净 1-在住 2-待维修 3-脏房 4-Zigbee离线 5-低电压',
    `room_price` decimal(19,4) DEFAULT NULL COMMENT '房间价格',
    `curr_card_count` int(11) DEFAULT NULL COMMENT '当前卡数',
    `max_card_count` int(11) DEFAULT NULL COMMENT '最大卡数65535',
    `is_gate` tinyint(4) DEFAULT NULL COMMENT '是否 是门',
    `area1` int(11) DEFAULT NULL COMMENT '区域 1',
    `area2` int(11) DEFAULT NULL COMMENT '区域 2',
    `check_in_date` datetime DEFAULT NULL COMMENT '入住日期',
    `check_out_date` datetime DEFAULT NULL COMMENT '退房日期',
    `last_check_out_date` datetime DEFAULT NULL COMMENT '上次退房日期',
    `in_used` tinyint(4) DEFAULT NULL COMMENT '使用中',
    `lock_time` datetime DEFAULT NULL COMMENT '锁的时间',
    `lock_type` tinyint(4) DEFAULT NULL COMMENT '锁的类型 0非套房 1套房',
    `lock_no` varchar(20) DEFAULT NULL COMMENT '锁的编码',
    `is_chanel_mode` tinyint(4) DEFAULT NULL COMMENT '设为常开模式（通道门模式）1-开启，0-不开启',
    `plan_check_in_date` datetime DEFAULT NULL COMMENT '计划入住日期',
    `plan_check_out_date` datetime DEFAULT NULL COMMENT '计划退房日期',
    `check_in_type_code` tinyint(4) DEFAULT NULL COMMENT '签入类型代码 0散客 1团队',
    `calc_price_type` tinyint(4) DEFAULT NULL COMMENT '计算价格类型 0全天房 1钟点房 2午夜房',
    `plan_make_card_count` int(11) DEFAULT NULL COMMENT '计划制卡数量',
    `start_repair_date` datetime DEFAULT NULL COMMENT '开始维修日期',
    `area3` int(11) DEFAULT NULL COMMENT '区域 3',
    `area4` int(11) DEFAULT NULL COMMENT '区域 4',
    `bill_no` varchar(20) DEFAULT NULL COMMENT '账单编号',
    `start_clean_date` datetime DEFAULT NULL COMMENT '开始清洁日期',
    `start_opened_date` datetime DEFAULT NULL COMMENT '开始开业日期',
    `building_replace_no` varchar(1) DEFAULT NULL COMMENT '建筑更换否',
    `lock_by` varchar(50) DEFAULT NULL COMMENT '锁定方式',
    `lock_host` varchar(50) DEFAULT NULL COMMENT '锁定主机',
    `second_lock_no` varchar(20) DEFAULT NULL COMMENT '第二把锁编码',
    `layer_sn` smallint(6) DEFAULT NULL COMMENT '楼层sn',
    `lock_abort_time` datetime DEFAULT NULL COMMENT '锁定中止时间',
    `room_version` varchar(3) DEFAULT NULL COMMENT '客房版本',
    `users_list` varchar(100) DEFAULT NULL COMMENT '用户列表',
    `open_pwd` varchar(30) DEFAULT NULL COMMENT '开锁密码',
    `area_list` text COMMENT '区域列表',
    `mac_id` varchar(36) DEFAULT NULL COMMENT 'Mac 身份证',
    `remark` Int DEFAULT NULL COMMENT '备注 -1 没有备注
                                            0-Quiet 安静
                                            1-Window 有窗
                                            2-Quiet and Window 安静有窗
                                            3-Window near Garden 窗朝向花园
                                            4-Internet 有电脑
                                            5-A/C 有空调
                                            6-A/C and Internet 有电脑、有空调
                                            7-Without windows 无窗',
    `lock_replace_no1` tinyint(4) DEFAULT NULL COMMENT '替换锁1 ',
    `lock_replace_no2` tinyint(4) DEFAULT NULL COMMENT '替换锁2 ',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    PRIMARY KEY (`id`),
    UNIQUE KEY `IX_RoomInfo_Attribute` (`building_code`,`floor_code`,`room_code`,`sub_room_code`),
    UNIQUE KEY `IX_RoomInfo` (`room_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '客房信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for room_card_code_list
-- ----------------------------
CREATE TABLE IF NOT EXISTS `room_card_code_list` (
    `id` int AUTO_INCREMENT COMMENT '主键id',
    `building_code` varchar(3) NOT NULL COMMENT '建筑编码',
    `floor_code` INT NOT NULL COMMENT '楼层编码',
    `room_code` varchar(10) NOT NULL COMMENT '房间编码',
    `sub_room_code` varchar(3) NOT NULL COMMENT '子房间编码',
    `card_code` varchar(16) NOT NULL COMMENT '卡代码',
    `card_type` INT DEFAULT NULL COMMENT '卡类型',
    `user_name` varchar(100) DEFAULT NULL COMMENT '用户名',
    `id_type` varchar(20) DEFAULT NULL COMMENT 'ID 类型',
    `id_code` varchar(100) DEFAULT NULL COMMENT 'ID 代码',
    `show_name_on_room_picture` tinyint(4) DEFAULT NULL COMMENT '在房间图片上显示名称',
    `bill_no` varchar(20) DEFAULT NULL COMMENT '账单编号',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    PRIMARY KEY (`id`, `building_code`,`floor_code`,`room_code`,`sub_room_code`,`card_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '房卡代码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
CREATE TABLE IF NOT EXISTS `room_type` (
    `id` int AUTO_INCREMENT primary key COMMENT '主键id',
    `room_type` varchar(20) NOT NULL unique COMMENT '房间类型',
    `max_card_count` int(11) DEFAULT NULL COMMENT '最大卡数',
    `room_price` decimal(19,4) DEFAULT NULL COMMENT '房间价格',
    `default_make_card` int(11) DEFAULT NULL COMMENT '默认制卡',
    `area_list` varchar(200) DEFAULT NULL COMMENT '区域列表',
    `vip_flag` tinyint(4) DEFAULT NULL COMMENT 'VIP 标志',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `enabled` tinyint(4)  DEFAULT NULL COMMENT '是否启用  0否 1是',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '房间类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for paper_type
-- ----------------------------
CREATE TABLE IF NOT EXISTS `paper_type` (
    `type_name` varchar(30) NOT NULL COMMENT '类型名称',
    `remark` varchar(50) DEFAULT NULL COMMENT '备注',
    PRIMARY KEY (`type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '证件类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of papertype
-- ----------------------------
# INSERT INTO paper_type VALUES ('其它', null);
# INSERT INTO paper_type VALUES ('军官证', null);
# INSERT INTO paper_type VALUES ('回乡证', null);
# INSERT INTO paper_type VALUES ('士兵证', null);
# INSERT INTO paper_type VALUES ('学生证', null);
# INSERT INTO paper_type VALUES ('导游证', null);
# INSERT INTO paper_type VALUES ('护照', null);
# INSERT INTO paper_type VALUES ('身份证', null);
# INSERT INTO paper_type VALUES ('驾驶证', null);

-- ----------------------------
-- Table structure for operator_power_record
-- ----------------------------
CREATE TABLE IF NOT EXISTS `operator_power_record` (
    `id` INT AUTO_INCREMENT  COMMENT '唯一标识符',
    `emp_id` varchar(8) NOT NULL COMMENT '员工id',
    `emp_name` varchar(50) NOT NULL COMMENT '员工姓名',
    `position_id` int(11) DEFAULT NULL COMMENT '职位ID',
    `position_name` varchar(40) DEFAULT NULL COMMENT '职位名称',
    `func_id` text COMMENT '函数 ID',
    `func_name` text COMMENT 'func 名称',
    `operator` varchar(50) DEFAULT NULL COMMENT '操作员',
    `operated_date` datetime DEFAULT NULL COMMENT '运行日期',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '操作员权限记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for guest_make_card_record
-- ----------------------------
CREATE TABLE IF NOT EXISTS `guest_make_card_record` (
    `auto_code` INT AUTO_INCREMENT COMMENT '自动编码',
    `card_code` varchar(16) DEFAULT NULL COMMENT '卡代码',
    `card_type` varchar(50) DEFAULT NULL COMMENT '卡类型',
    `card_type_code` INT DEFAULT NULL COMMENT '卡类型代码',
    `user_name` varchar(100) DEFAULT NULL COMMENT '用户名',
    `building_code` varchar(30) DEFAULT NULL COMMENT '建筑编码',
    `floor_list` text COMMENT '楼层列表',
    `room_code` varchar(10) DEFAULT NULL COMMENT '房间代码',
    `sub_room_code` varchar(3) DEFAULT NULL COMMENT '子房间代码',
    `room_name` varchar(3000) COMMENT '房间名称',
    `operator` varchar(50) DEFAULT NULL COMMENT '操作员',
    `make_card_date` datetime DEFAULT NULL COMMENT '制作卡片日期',
    `return_card_date` datetime DEFAULT NULL COMMENT '退卡日期',
    `disable_date` datetime DEFAULT NULL COMMENT '禁用日期',
    `check_in_date` datetime DEFAULT NULL COMMENT '入住日期',
    `check_out_date` datetime DEFAULT NULL COMMENT '退房日期',
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `area_list` varchar(120) DEFAULT NULL COMMENT '区域列表',  -- 宾客有 非宾客无
    `lock_no_list` text COMMENT '锁定列表',
    `is_plan_order` tinyint(4) DEFAULT NULL COMMENT '是否计划顺序',
    `check_in_type_code` tinyint(4) DEFAULT NULL COMMENT '签入类型代码',
    `bill_no` varchar(20) DEFAULT NULL COMMENT '账单编号', -- 宾客有 非宾客无
    `make_from` varchar(30) DEFAULT NULL COMMENT '生成自',
    `make_device` varchar(100) DEFAULT NULL COMMENT '制作设备 Handset',
    `make_desc` INT DEFAULT NULL COMMENT '制作描述', -- 宾客有 非宾客无
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    `lost_card_code` varchar(20) DEFAULT NULL COMMENT '丢失卡代码',
    `user_id` varchar(20) DEFAULT NULL COMMENT '用户 ID',
#    `id_type` varchar(20) DEFAULT NULL COMMENT 'ID 类型',
#    `id_code` varchar(100) DEFAULT NULL COMMENT 'ID 代码',
#    `into_room_sum_day` int(11) DEFAULT NULL COMMENT '入住天数',
    `room_type` varchar(50) DEFAULT NULL COMMENT '房间类型',
    `building` varchar(30) DEFAULT NULL COMMENT '建筑',
    `lost_order_date` datetime DEFAULT NULL COMMENT '丢失的订单日期',
    `lost_card_date` datetime DEFAULT NULL COMMENT '丢失卡日期',
    `replace_no` tinyint(4) DEFAULT NULL COMMENT '替换否', -- 宾客无 非宾客有
    `ext_floor_list` text DEFAULT NULL COMMENT 'ext ',
    `can_open_db_lock` tinyint(4) DEFAULT NULL COMMENT '可以打开 DB 锁', -- 宾客无 非宾客有
    `chanel_mode` tinyint(4) DEFAULT NULL COMMENT '香奈儿模式', -- 宾客无 非宾客有
    `lock_type` int(11) DEFAULT NULL COMMENT '锁类型',
#    `time_section1` varchar(15) DEFAULT NULL COMMENT '时间部分 1',
#    `time_section2` varchar(15) DEFAULT NULL COMMENT '时间部分 2',
#    `time_section3` varchar(15) DEFAULT NULL COMMENT '时间部分 3',
#    `has_consume_orders` tinyint(4) DEFAULT NULL COMMENT '有消费订单',
#    `key_coder` tinyint(4) DEFAULT NULL COMMENT '密钥编码器',
#    `id_date` int(11) DEFAULT NULL COMMENT 'ID 日期',
    `ext_rooms` varchar(120) DEFAULT NULL COMMENT 'EXT 客房',
    `replace_previous` tinyint(4) DEFAULT NULL COMMENT '替换上一个',
    `reservation_no` varchar(16) DEFAULT NULL COMMENT '预订编号',
    `mobile_key` varchar(100) DEFAULT NULL COMMENT '手机钥匙',
    `lock_replace_no1` tinyint(4) DEFAULT NULL COMMENT '替换锁1 ',
    `lock_replace_no2` tinyint(4) DEFAULT NULL COMMENT '替换锁2 ',
#     `mac_id` varchar(36) DEFAULT NULL COMMENT 'Mac 身份证',
    PRIMARY KEY (`auto_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '宾客入住发卡记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for other_make_card_record
-- ----------------------------
CREATE TABLE IF NOT EXISTS `other_make_card_record` (
    `auto_code` INT AUTO_INCREMENT COMMENT '自动编码',
    `card_code` varchar(16) DEFAULT NULL COMMENT '卡代码',
    `card_type` varchar(50) DEFAULT NULL COMMENT '卡类型',
    `card_type_code` INT DEFAULT NULL COMMENT '卡类型代码',
    `user_name` varchar(100) DEFAULT NULL COMMENT '用户名',
    `building_code` varchar(30) DEFAULT NULL COMMENT '建筑编码',
    `floor_list` text COMMENT '楼层列表',
    `room_code` varchar(10) DEFAULT NULL COMMENT '房间代码',
    `sub_room_code` varchar(3) DEFAULT NULL COMMENT '子房间代码',
    `room_name` varchar(3000) COMMENT '房间名称',
    `operator` varchar(50) DEFAULT NULL COMMENT '操作员',
    `make_card_date` datetime DEFAULT NULL COMMENT '制作卡片日期',
    `return_card_date` datetime DEFAULT NULL COMMENT '退卡日期',
    `disable_date` datetime DEFAULT NULL COMMENT '禁用日期',
    `check_in_date` datetime DEFAULT NULL COMMENT '入住日期',
    `check_out_date` datetime DEFAULT NULL COMMENT '退房日期',
    `replace_no` tinyint(4) DEFAULT NULL COMMENT '替换否', -- 宾客无 非宾客有
    `remark` varchar(500) DEFAULT NULL COMMENT '备注',
    `chanel_mode` tinyint(4) DEFAULT NULL COMMENT '香奈儿模式', -- 宾客无 非宾客有
    `can_open_db_lock` tinyint(4) DEFAULT NULL COMMENT '可以打开 DB 锁', -- 宾客无 非宾客有
    `lock_no_list` text COMMENT '锁定列表',
    `is_plan_order` tinyint(4) DEFAULT NULL COMMENT '是否计划顺序',
    `check_in_type_code` tinyint(4) DEFAULT NULL COMMENT '签入类型代码',
    `make_from` varchar(30) DEFAULT NULL COMMENT '生成自',
    `make_device` varchar(100) DEFAULT NULL COMMENT '制作设备 Handset',
    `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    `lost_card_code` varchar(20) DEFAULT NULL COMMENT '丢失卡代码',
     `user_id` varchar(20) DEFAULT NULL COMMENT '用户 ID',
#     `id_type` varchar(20) DEFAULT NULL COMMENT 'ID 类型',
#     `id_code` varchar(100) DEFAULT NULL COMMENT 'ID 代码',
#     `into_room_sum_day` int(11) DEFAULT NULL COMMENT '入住天数',
#     `room_type` varchar(50) DEFAULT NULL COMMENT '房间类型',
     `building` varchar(30) DEFAULT NULL COMMENT '建筑',
     `lost_order_date` datetime DEFAULT NULL COMMENT '丢失的订单日期',
     `lost_card_date` datetime DEFAULT NULL COMMENT '丢失卡日期',
     `area_list` text DEFAULT NULL COMMENT '区域列表',  -- 宾客有 非宾客无
     `ext_floor_list` text DEFAULT NULL COMMENT 'ext ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `lock_type` int(11) DEFAULT NULL COMMENT '锁类型',
     `time_section1` varchar(15) DEFAULT NULL COMMENT '时间部分 1',
     `time_section2` varchar(15) DEFAULT NULL COMMENT '时间部分 2',
     `time_section3` varchar(15) DEFAULT NULL COMMENT '时间部分 3',
#     `has_consume_orders` tinyint(4) DEFAULT NULL COMMENT '有消费订单',
#     `key_coder` tinyint(4) DEFAULT NULL COMMENT '密钥编码器',
#     `id_date` int(11) DEFAULT NULL COMMENT 'ID 日期',
     `ext_rooms` text DEFAULT NULL COMMENT 'EXT 客房',
    `lock_replace_no1` tinyint(4) DEFAULT NULL COMMENT '替换锁1 ',
    `lock_replace_no2` tinyint(4) DEFAULT NULL COMMENT '替换锁2 ',
#     `bill_no` varchar(20) DEFAULT NULL COMMENT '账单编号', -- 宾客有 非宾客无
    `make_desc` varchar(100) DEFAULT NULL COMMENT '制作描述', -- 宾客有 非宾客无
#     `replace_previous` tinyint(4) DEFAULT NULL COMMENT '替换上一个',
#     `reservation_no` varchar(16) DEFAULT NULL COMMENT '预订编号',
#     `mobile_key` varchar(100) DEFAULT NULL COMMENT '手机钥匙',
#      `mac_id` varchar(36) DEFAULT NULL COMMENT 'Mac 身份证',
                                    PRIMARY KEY (`auto_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '非宾客入住发卡记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cloud_service_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS `cloud_service_info` (
                                         `row_id` varchar(36) not null COMMENT '唯一标识符',
                                         `service_name` varchar(100) DEFAULT NULL COMMENT '服务名称',
                                         `service_address` varchar(255) DEFAULT NULL COMMENT '服务地址',
                                         `service_port` int(11) DEFAULT NULL COMMENT '服务端口',
                                         `account_id` varchar(50) DEFAULT NULL COMMENT '账户id',
                                         `account_pwd` varchar(50) COMMENT '账户密码',
                                         `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                         `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
                                         `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                         `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                         `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                         `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                         `disabled_date` datetime DEFAULT NULL COMMENT '禁用日期',
                                         PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '云服务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cloud_service_registration
-- ----------------------------
CREATE TABLE IF NOT EXISTS `cloud_service_registration` (
                                      `row_id` varchar(36) not null COMMENT '唯一标识符',
                                      `licence_key` varchar(100) DEFAULT NULL COMMENT '许可证密钥',
                                      `hotel_name` varchar(255) DEFAULT NULL COMMENT '酒店名称',
                                      `hotel_registration_id` varchar(50) DEFAULT NULL COMMENT '酒店注册 ID',
                                      `remark` varchar(500) DEFAULT NULL COMMENT '备注',
                                      `status` tinyint(4) DEFAULT NULL COMMENT '状态 ',
                                      `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                      `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                      `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                      `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                      `disabled_date` datetime DEFAULT NULL COMMENT '禁用日期',
                                      PRIMARY KEY (`row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '云服务注册表' ROW_FORMAT = DYNAMIC;


-- ----------------------------
-- Table structure for sys_quartz_job
-- ----------------------------
CREATE TABLE IF NOT EXISTS `sys_quartz_job`  (
                                   `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                                   `create_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
                                   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                   `del_flag` int(1) NULL DEFAULT NULL COMMENT '删除状态',
                                   `update_by` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
                                   `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
                                   `job_class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务类名',
                                   `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
                                   `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
                                   `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
                                   `status` int(1) NULL DEFAULT NULL COMMENT '状态 0正常 -1停止',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_quartz_job
-- ----------------------------
# INSERT INTO `sys_quartz_job` VALUES ('5b3d2c087ad41aa755fc4f89697b01e7', 'admin', '2019-04-11 19:04:21', 0, 'admin', '2024-03-18 14:21:35', 'org.lock.modules.message.job.SendMsgJob', '0/50 * * * * ? *', NULL, NULL, -1);
# INSERT INTO `sys_quartz_job` VALUES ('a253cdfc811d69fa0efc70d052bc8128', 'admin', '2019-03-30 12:44:48', 0, 'admin', '2020-05-02 15:48:49', 'org.lock.modules.quartz.job.SampleJob', '0/1 * * * * ?', NULL, NULL, -1);
# INSERT INTO `sys_quartz_job` VALUES ('df26ecacf0f75d219d746750fe84bbee', NULL, '2021-06-30 16:03:09', 0, 'admin', '2020-05-02 15:40:35', 'org.lock.modules.quartz.job.SampleParamJob', '0/1 * * * * ?', 'scott', '带参测试 后台将每隔1秒执行输出日志', -1);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_blob_triggers`  (
                                       `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `BLOB_DATA` blob NULL,
                                       PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
                                       CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_calendars`  (
                                   `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                   `CALENDAR` blob NOT NULL,
                                   PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_cron_triggers`  (
                                       `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `CRON_EXPRESSION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                       `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                       PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
                                       CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_fired_triggers`  (
                                        `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `FIRED_TIME` bigint(13) NOT NULL,
                                        `SCHED_TIME` bigint(13) NOT NULL,
                                        `PRIORITY` int(11) NOT NULL,
                                        `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                        `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                        PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_job_details`  (
                                     `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                     `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                     `JOB_DATA` blob NULL,
                                     PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_locks`  (
                               `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                               PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
# INSERT INTO `qrtz_locks` VALUES ('MyScheduler', 'STATE_ACCESS');
# INSERT INTO `qrtz_locks` VALUES ('MyScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_paused_trigger_grps`  (
                                             `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                             PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_scheduler_state`  (
                                         `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
                                         `CHECKIN_INTERVAL` bigint(13) NOT NULL,
                                         PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
# INSERT INTO `qrtz_scheduler_state` VALUES ('MyScheduler', 'qin1743402291198', 1743404113136, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_simple_triggers`  (
                                         `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                         `REPEAT_COUNT` bigint(7) NOT NULL,
                                         `REPEAT_INTERVAL` bigint(12) NOT NULL,
                                         `TIMES_TRIGGERED` bigint(10) NOT NULL,
                                         PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
                                         CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_simprop_triggers`  (
                                          `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                          `STR_PROP_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `STR_PROP_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `STR_PROP_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `INT_PROP_1` int(11) NULL DEFAULT NULL,
                                          `INT_PROP_2` int(11) NULL DEFAULT NULL,
                                          `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
                                          `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
                                          `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
                                          `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
                                          `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                          PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
                                          CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
CREATE TABLE IF NOT EXISTS `qrtz_triggers`  (
                                  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
                                  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
                                  `PRIORITY` int(11) NULL DEFAULT NULL,
                                  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                  `START_TIME` bigint(13) NOT NULL,
                                  `END_TIME` bigint(13) NULL DEFAULT NULL,
                                  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
                                  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
                                  `JOB_DATA` blob NULL,
                                  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
                                  INDEX `SCHED_NAME`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
                                  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

CREATE TABLE IF NOT EXISTS `mysql_backups` (
   `id` INT ( 11 ) NOT NULL AUTO_INCREMENT COMMENT '主键 id',
   `mysql_ip` VARCHAR ( 15 ) DEFAULT NULL COMMENT '数据库 IP',
   `mysql_port` VARCHAR ( 5 ) DEFAULT NULL COMMENT '数据库端口',
   `mysql_cmd` VARCHAR ( 230 ) DEFAULT NULL COMMENT '备份命令',
   `mysql_back_cmd` VARCHAR ( 230 ) DEFAULT NULL COMMENT '恢复命令',
   `database_name` VARCHAR ( 20 ) DEFAULT NULL COMMENT '数据库名称',
   `backups_path` VARCHAR ( 50 ) DEFAULT NULL COMMENT '备份数据地址',
   `backups_name` VARCHAR ( 50 ) DEFAULT NULL COMMENT '备份文件名称',
   `operation` INT ( 11 ) DEFAULT NULL COMMENT '操作次数',
   `status` INT ( 1 ) DEFAULT NULL COMMENT '数据状态（1 正常，-1 删除）',
   `recovery_time` DATETIME DEFAULT NULL COMMENT '恢复时间',
   `create_time` DATETIME DEFAULT NULL COMMENT '备份时间',
   PRIMARY KEY ( `id` ),
   INDEX baskups_index ( mysql_ip, mysql_port, backups_path, database_name,backups_name) USING BTREE COMMENT '索引'
) ENGINE = INNODB AUTO_INCREMENT = 1 CHARSET = UTF8 ROW_FORMAT = COMPACT COMMENT = 'MySQL 数据备份表';


CREATE TABLE IF NOT EXISTS `sys_event` (
 `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
 `event_type` tinyint(4) DEFAULT NULL COMMENT '事件种类 0：锁事件 1：手持机事件 2：手机APP事件 3：Zigbee事件',
 `event_way_code` int(11) DEFAULT NULL COMMENT '事件方式编码',
 `event_way_name_cn` varchar(255) DEFAULT NULL COMMENT '事件方式 中文',
 `event_way_name_en` varchar(255) NOT NULL COMMENT '事件方式 英文',
 `event_code` int(11) DEFAULT NULL COMMENT '事件编码',
 `event_name_cn` varchar(255) DEFAULT NULL COMMENT '事件 中文',
 `event_name_en` varchar(255) DEFAULT NULL COMMENT '事件 英文',
 `event_type_code` int(11) DEFAULT NULL COMMENT '事件类型编码',
 `event_type_name_en` varchar(255) DEFAULT NULL COMMENT '事件类型名称 英文',
 `event_type_name_cn` varchar(255)  DEFAULT NULL COMMENT '事件类型名称 中文',
 `show_enabled` BOOLEAN  DEFAULT true COMMENT '是否展示 ',
 `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
 `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
 `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
 `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
 `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
 `attribute3` text DEFAULT NULL COMMENT '扩展字段3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE = utf8_general_ci COMMENT = '事件表' ROW_FORMAT = DYNAMIC;

# LOCK TABLES `sys_event` WRITE;
# /*!40000 ALTER TABLE `sys_event` DISABLE KEYS */;
# INSERT INTO hotellock.sys_event (event_type,event_way_code,event_way_name_cn,event_way_name_en,event_code,event_name_cn,event_name_en,event_type_code,event_type_name_en,event_type_name_cn,show_enabled,create_by,create_time,update_by,update_time,attribute1,attribute2,attribute3) VALUES
#                                                                                                                                                                                                                                                                                            (0,138,'机械钥匙','Mechanical Key',0,'机械钥匙开门','Mechanical key opens the door',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,138,'机械钥匙','Mechanical Key',21,'设备进入复位状态','Device enters reset state',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,139,'内部开门','Open Inside',0,'房间内开门','Open the door in the room',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,140,'通道门模式','Passage Mode',0,'通道门模式开门','Open the door in Passage mode',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,15,'传感器状态','Sensor Status',31,'低电量报警','Low Battery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,15,'传感器状态','Sensor Status',32,'门未关报警','Door ajar alarm',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,15,'传感器状态','Sensor Status',52,'门反锁','Turn the deadbolt',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,15,'传感器状态','Sensor Status',53,'门取消反锁','Turn off the deadbolt',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',64,'软件重启','Software reboot',3,'Error events','错误事件',0,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',65,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',66,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',67,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',68,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',69,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',70,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,20,'系统重启','System Reboot',71,'异常重启，已自恢复','Abnormal restart, self-recovery',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,21,'生产测试卡','Production Test Card',7,'失败，设备已激活','Failed, device is already activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,136,'工厂卡','Factory Card',7,'失败，设备已激活','Failed, device is already activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,136,'工厂卡','Factory Card',20,'失败，设备已激活','Failed, device is already activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',0,'设备进入设置状态','Device enters setup state',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,1,'授权卡','License Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,2,'房间设置卡','Room Setting Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,3,'清除设置卡','Clear Setting Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,4,'校时卡','Adjust Time Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,5,'锁体设置卡','Mortise Setting Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,6,'区域设置卡','Area Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,7,'取消区域设置卡','Cancel Area Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,8,'宾客终止卡','Guest Stop Card',13,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',0,'读取成功','Read successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,9,'数据卡','Data Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:08',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,10,'挂失卡','Lost Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,11,'取消挂失卡','Cancel Lost Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,12,'访问设置卡','Access Setting Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,16,'系统重置卡','SysReset Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,17,'ZigBee设置卡','ZigBee Configure Card',35,'失败，设备未完成初始化设置','Failed, device has not completed the initialization setting',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,17,'ZigBee设置卡','ZigBee Configure Card',36,'失败，设备已完成配网','Failed, device has already completed network configuration',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,17,'ZigBee设置卡','ZigBee Configure Card',37,'设备进入ZigBee配网状态','The device has entered ZigBee network configuration mode',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,19,'取电开关设置卡','Energy Saving Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',0,'设置成功','Setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',9,'失败，未刷授权卡','Failed, no authorization card was swiped',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,18,'储物柜设置卡','Electronic Locker Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',57,'员工卡已超时，自动断电','Employee card timed out, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,129,'总卡','Master Card',19,'失败，设备电量过低','Failed, device battery is too low',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',56,'宾客卡已失效，自动断电','Guest card expired, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',14,'失败，卡片被终止或被顶替','Failure, card is terminated or replaced',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,130,'宾客卡','Guest Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',57,'员工卡已超时，自动断电','Employee card timed out, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,131,'楼栋卡','Building Card',19,'失败，设备电量过低','Failed, device battery is too low',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',57,'员工卡已超时，自动断电','Employee card timed out, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,132,'楼层卡','Floor Card',19,'失败，设备电量过低','Failed, device battery is too low',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',57,'员工卡已超时，自动断电','Employee card timed out, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,133,'多门卡','Multi-door Card',19,'失败，设备电量过低','Failed, device battery is too low',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',54,'通电成功','Power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',55,'移除卡片，自动断电','Card removed, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',56,'宾客卡已失效，自动断电','Guest card expired, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,134,'后备宾客卡','Backup Guest Card',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',58,'进入应急状态，保持通电','Entering emergency mode, power maintained',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',59,'退出应急状态，自动断电','Exiting emergency mode, automatic power-off',2,'Status events','状态事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',12,'失败，卡片已挂失','Failed, the card has been reported lost',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,135,'应急卡','Emergency Card',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,137,'电梯卡','Elevator Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',1,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',2,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',3,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',5,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',6,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',10,'失败，不支持的卡类型','Failed, unsupported card type',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (0,142,'一次性开门卡','One Time Card',16,'失败，卡片与设备不匹配','Failed, card information does not match device',3,'Error events','错误事件',1,NULL,'2025-07-25 16:10:09',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',22,'设备进入手持机连接状态','Device enters the handset connection state',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',0,'手持机连接成功','Handset connection successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',1,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',2,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',3,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',4,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',5,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',6,'失败，手持机鉴权错误','Failed, handset authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',23,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',24,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',25,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',26,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',27,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',28,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',29,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,13,'手持机','Handset',30,'','',3,'Error events','错误事件',0,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,2,'手持机','Handset',0,'设备设置成功','Device setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,12,'手持机','Handset',0,'设备设置成功','Device setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,18,'手持机','Handset',0,'设备设置成功','Device setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,19,'手持机','Handset',0,'设备设置成功','Device setup successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,4,'手持机','Handset',0,'设备校时成功','Device adjust time successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,8,'手持机','Handset',0,'退房成功','Checkout successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,129,'手持机','Handset',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,129,'手持机','Handset',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,9,'手持机','Handset',0,'读取信息成功','Read information successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (1,14,'手持机','Handset',0,'程序升级成功','Program upgrade successfully',2,'Status events','状态事件',1,NULL,'2025-07-25 16:12:03',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',0,'开锁成功','Unlocked successfully',1,'Access events','访问事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',60,'手机APP通电成功','Mobile APP power-on successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',61,'手机APP开锁成功，联动通电','Unlock successful via mobile app, power-on linkage activated',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',62,'手机APP断电成功','Mobile APP power-off successful',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',63,'手机APP断电失败，当前已插入卡片','Mobile APP power-off failed, card currently inserted',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',4,'失败，卡片鉴权错误','Failed, card authentication error',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',8,'失败，设备未激活','Failed, device is not activated',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',11,'失败，卡片已失效','Failed, card has expired',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',14,'失败，卡片被终止或被顶替','Failure, card is terminated or replaced',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',15,'失败，卡片类型被封禁','Failed, card type is banned',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (2,141,'手机APP','Mobile APP',17,'失败，设备已反锁','Failed, the device has been locked',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:16',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',33,'设备ZigBee网络离线','Device ZigBee network offline',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',34,'设备ZigBee网络在线','Device ZigBee network online',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',38,'ZigBee配网失败','ZigBee network provisioning fails',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',39,'ZigBee配网超时','ZigBee network provisioning timeout',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',40,'ZigBee配网成功','ZigBee network provisioning succeeded',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',41,'ZigBee信息同步失败','ZigBee information synchronization failed',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',42,'ZigBee信息同步超时','ZigBee information synchronization timed out',3,'Error events','错误事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',43,'ZigBee信息同步成功','ZigBee information synchronization succeeded',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,2,'ZigBee','ZigBee',51,'在线修改设备功能','Online modify device function',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,12,'ZigBee','ZigBee',51,'在线修改设备功能','Online modify device function',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,18,'ZigBee','ZigBee',51,'在线修改设备功能','Online modify device function',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,19,'ZigBee','ZigBee',51,'在线修改设备功能','Online modify device function',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,130,'ZigBee','ZigBee',45,'在线办理续住','Renew your stay online',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,130,'ZigBee','ZigBee',46,'在线办理转房，新增卡片权限','Online room transfer, add card access rights',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,130,'ZigBee','ZigBee',47,'在线办理转房，更新卡片权限','Online room transfer, update card access rights',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,130,'ZigBee','ZigBee',50,'在线删除设备','Online delete device',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,8,'ZigBee','ZigBee',48,'在线办理转房，取消卡片权限','Online room transfer, cancel card access rights',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,8,'ZigBee','ZigBee',49,'在线办理退房','Online Check-Out',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,9,'ZigBee','ZigBee',74,'在线读取设备信息','Online read  data',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,10,'ZigBee','ZigBee',72,'在线挂失卡','Online lost card',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,11,'ZigBee','ZigBee',73,'在线取消挂失卡','Online cancel lost card',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',50,'在线删除设备','Online delete device',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','',''),
#                                                                                                                                                                                                                                                                                            (3,17,'ZigBee','ZigBee',51,'在线修改设备功能','Online modify device function',2,'Status events','状态事件',1,NULL,'2025-07-25 16:13:44',NULL,NULL,'','','')
#                                                                                                                                                                                                                                                                                        ON DUPLICATE KEY UPDATE id = id;
#
#
# /*!40000 ALTER TABLE `sys_event` ENABLE KEYS */;
# UNLOCK TABLES;





-- ----------------------------
-- ----------------------------
-- Table structure for make_card_client
-- ----------------------------
CREATE TABLE IF NOT EXISTS `fias_make_card_client` (
                                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                         `ip` varchar(50) DEFAULT NULL COMMENT '制卡器IP',
                                         `port` varchar(255) DEFAULT NULL COMMENT '制卡器端口',
                                         `state` smallint DEFAULT NULL COMMENT '状态 是否在线 0否 1是',
                                         `comm_pswd` varchar(255) DEFAULT NULL COMMENT '连接密码',
                                         `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                         `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                         `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                         `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                         `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                         PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='制卡器终端表';

CREATE TABLE IF NOT EXISTS `fias_pms_link_client` (
                                        `id` int(11)  AUTO_INCREMENT PRIMARY KEY COMMENT '主键' ,
                                        `ip` varchar(50) DEFAULT NULL COMMENT '制卡器IP',
                                        `port` varchar(255) DEFAULT NULL COMMENT '制卡器端口',
                                        `state` smallint DEFAULT NULL COMMENT '状态 是否在线 0否 1是',
                                        `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                        `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                        `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                        `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                        `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='pms终端表';
-- 设置自增主键列的初始值
ALTER TABLE fias_pms_link_client AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fias_interface_setting` (
                                          `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                          `check_online_mode` smallint DEFAULT NULL COMMENT '0 -Reconnect after disconnecting
                                                                                       1 -Send LS command detection
                                                                                        2 -Auto',
                                          `comm_mode` smallint NOT NULL COMMENT '0 - TCP/IP , 1 - RS232',
                                          `start_service` smallint NOT NULL COMMENT '0否 1是',
                                          `enable_kd` smallint NOT NULL COMMENT '0否 1是',
                                          `enable_km` smallint NOT NULL COMMENT '0否 1是',
                                          `enable_ko` smallint NOT NULL COMMENT '0否 1是',
                                          `recycle_card` smallint NOT NULL COMMENT '0否 1是',
                                          `save_log` smallint NOT NULL COMMENT '0否 1是',
                                          `update_mode` smallint NOT NULL COMMENT '0否 1是',
                                          `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                          `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                          `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                          `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                          `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                          PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='pms连接参数设置表';

INSERT INTO `fias_interface_setting` (check_online_mode, comm_mode, start_service, enable_kd, enable_km,
                                      enable_ko,recycle_card,save_log,update_mode) VALUES
    (2,0, 1, 1, 0,0,0,1,1) ON DUPLICATE KEY UPDATE id = id;

CREATE TABLE IF NOT EXISTS `fias_kr_command` (
                                   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `key_id` varchar(255) DEFAULT NULL COMMENT '标记唯一',
                                   `command` varchar(500) NOT NULL COMMENT '指令内容',
                                   `command_type` varchar(10) NOT NULL COMMENT '指令类别',
                                   `is_used` smallint NOT NULL COMMENT '是否已完成 0否 1是',
                                   `address` varchar(15) NOT NULL COMMENT '发送至地址',
                                   `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                   `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
                                   `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                   `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                   `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='kr指令表';


-- ----------------------------
-- Table structure for gateway_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS gateway_info (
          row_id varchar(36) NOT NULL,
          building_code varchar(3) DEFAULT NULL,
          floor_code varchar(3) DEFAULT NULL,
          gateway_name varchar(100) DEFAULT NULL,
          mac_addr varchar(20) DEFAULT NULL,
          ip_addr varchar(20) DEFAULT NULL,
          client_id varchar(32) DEFAULT NULL,
          client_user_name varchar(20) DEFAULT NULL,
          client_password varchar(20) DEFAULT NULL,
          enabled tinyint(4) DEFAULT NULL,
          status smallint(6) DEFAULT NULL,
          `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
          `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
          `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
          `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
          last_active_date datetime DEFAULT NULL,
          PRIMARY KEY (row_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网关信息表';

-- ----------------------------
-- Table structure for gwsubdevice
-- ----------------------------
CREATE TABLE IF NOT EXISTS gw_sub_device (
         row_id varchar(36) NOT NULL,
         device_id varchar(32) DEFAULT NULL,
         device_type_id smallint(6) DEFAULT NULL,
         device_type_name varchar(100) DEFAULT NULL,
         mac_addr varchar(20) DEFAULT NULL,
         gateway_id varchar(32) DEFAULT NULL,
         join_network_date datetime DEFAULT NULL,
         leave_network_date datetime DEFAULT NULL,
         enabled tinyint(4) DEFAULT NULL,
         status smallint(6) DEFAULT NULL,
         `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
         `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
         `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
         `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
         rssi_value varchar(10) DEFAULT NULL,
         last_active_date datetime DEFAULT NULL,
         `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
         `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
         `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
         PRIMARY KEY (row_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子网关设备表';

-- ----------------------------
-- Table structure for sub_device_alarm
-- ----------------------------
CREATE TABLE IF NOT EXISTS sub_device_alarm (
            row_id varchar(36) NOT NULL,
            device_id varchar(32) DEFAULT NULL,
            alarm_type smallint(6) DEFAULT NULL,
            alarm_desc varchar(100) DEFAULT NULL,
            read_status smallint(6) DEFAULT NULL,
            alarm_date datetime DEFAULT NULL,
            creation_date datetime DEFAULT NULL,
            PRIMARY KEY (row_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子设备闹钟表';

-- ----------------------------
-- Table structure for sub_device_mapping
-- ----------------------------
CREATE TABLE IF NOT EXISTS sub_device_mapping (
              device_id varchar(32) NOT NULL,
              parent_id smallint(6) NOT NULL,
              system_update_status smallint(6) DEFAULT NULL,
              room_upate_status smallint(6) DEFAULT NULL,
              enabled tinyint(4) DEFAULT NULL,
              `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
              `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
              `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
              `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
              system_update_time datetime DEFAULT NULL,
              PRIMARY KEY (device_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子设备映射表';


-- ----------------------------
-- Table structure for zb_network_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS zb_network_info (
           row_id varchar(36) NOT NULL,
           gateway_id varchar(32) DEFAULT NULL,
           payload text,
           status smallint(6) DEFAULT NULL,
           `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
           `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
           `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
           `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
           last_active_date datetime DEFAULT NULL,
           PRIMARY KEY (row_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='zb网络表';


-- ----------------------------
-- Table structure for ZB_Task_Queue
-- ----------------------------
CREATE TABLE IF NOT EXISTS ZB_Task_Queue (
    row_id varchar(36)  not null ,
    gateway_id varchar(32) DEFAULT NULL,
    device_id varchar(32) DEFAULT NULL,
    parent_id smallint DEFAULT NULL,
    card_code varchar(16) DEFAULT NULL,
    cmd_pkg_seq varchar(16) DEFAULT NULL,
    cmd_user_id varchar(16) DEFAULT NULL,
    action_type smallint DEFAULT NULL,
    task_command varchar(2048) DEFAULT NULL,
    status tinyint(4) DEFAULT NULL COMMENT '状态 ',
    `create_by` varchar(32)  DEFAULT NULL COMMENT '创建人',
    `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
    `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
    `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
    `attribute1` varchar(100) DEFAULT NULL COMMENT '扩展字段1',
    `attribute2` varchar(100) DEFAULT NULL COMMENT '扩展字段2',
    `attribute3` text DEFAULT NULL COMMENT '扩展字段3',
    last_send_date datetime DEFAULT NULL,
    PRIMARY KEY (row_id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='子设备映射表';

-- ----------------------------
-- Table structure for mqtt_config
-- ----------------------------
CREATE TABLE IF NOT EXISTS mqtt_config (
     id INT AUTO_INCREMENT PRIMARY KEY,
     broker_url VARCHAR(255) NOT NULL,
     client_id VARCHAR(255) NOT NULL,
     username VARCHAR(255) default NULL,
     password VARCHAR(255) default NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='mqtt配置表';

-- INSERT INTO mqtt_config (broker_url, client_id, username, password) VALUES ('192.168.0.132:1883', 'spring-boot-client', 'admin', 'public');

-- ----------------------------
-- Table structure for family_room_mapping
-- ----------------------------
CREATE TABLE IF NOT EXISTS family_room_mapping (
        row_id                 varchar(36)     NOT NULL        COMMENT '主键ID',
        building_code          varchar(3)      DEFAULT NULL    COMMENT '主房楼栋号',
        floor_code             varchar(3)      DEFAULT NULL    COMMENT '主房楼层号',
        room_code              varchar(10)     DEFAULT NULL    COMMENT '主房房间号',
        room_name              varchar(20)     NOT NULL        COMMENT '主房名称',
        lock_no                varchar(20)     NOT NULL        COMMENT '主房锁号',
        bill_no                varchar(20)     NOT NULL        COMMENT '主房订单号',
        family_building_code   varchar(3)      DEFAULT NULL    COMMENT '亲友房楼栋号',
        family_floor_code      varchar(3)      DEFAULT NULL    COMMENT '亲友房楼层号',
        family_room_code       varchar(10)     DEFAULT NULL    COMMENT '亲友房房间号',
        family_room_name       varchar(20)     NOT NULL        COMMENT '亲友房房间名称',
        family_lock_no         varchar(20)     NOT NULL        COMMENT '亲友房房间锁号',
        lock_replace_no1       int             NOT NULL        COMMENT '主替代号',
        status                 smallint(6)     DEFAULT 1       COMMENT '状态（0：停用 1：启用）',
        enabled                tinyint(4)      DEFAULT 1       COMMENT '是否可用（0：否 1：是）',
        `create_by`            varchar(32)     DEFAULT NULL    COMMENT '创建人',
        `create_time`          datetime        DEFAULT NULL    COMMENT '创建时间',
        `update_by`            varchar(32)     DEFAULT NULL    COMMENT '更新人',
        `update_time`          datetime        DEFAULT NULL    COMMENT '更新时间',
        `attribute1`           varchar(100)    DEFAULT NULL    COMMENT '扩展字段1',
        `attribute2`           varchar(100)    DEFAULT NULL    COMMENT '扩展字段2',
        `attribute3`           text            DEFAULT NULL    COMMENT '扩展字段3',
        PRIMARY KEY (row_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='亲友房绑定关系表';

-- ----------------------------
-- Table structure for encoder_info
-- ----------------------------
CREATE TABLE IF NOT EXISTS encoder_info (
        encoder_id          varchar(36)        NOT NULL            COMMENT '主键ID',
        encoder_code        tinyint(4)         DEFAULT 1           COMMENT '制卡器编号',
        encoder_name        varchar(60)         DEFAULT NULL        COMMENT '制卡器名称',
        encoder_type        smallint(6)        DEFAULT 0           COMMENT '状态（0：USB 1：虚拟网口 2：网口）',
        encoder_ip          varchar(20)        DEFAULT NULL        COMMENT '制卡器IP',
        encoder_port        int                DEFAULT NULL        COMMENT '制卡器端口',
        encoder_url         varchar(200)       DEFAULT NULL        COMMENT '制卡器URL',
        status              smallint(6)        DEFAULT 1           COMMENT '状态（0：停用 1：启用）',
        enabled             tinyint(4)         DEFAULT 1           COMMENT '是否可用（0：否 1：是）',
        `create_by`         varchar(32)        DEFAULT NULL        COMMENT '创建人',
        `create_time`       datetime           DEFAULT NULL        COMMENT '创建时间',
        `update_by`         varchar(32)        DEFAULT NULL        COMMENT '更新人',
        `update_time`       datetime           DEFAULT NULL        COMMENT '更新时间',
        `attribute1`        varchar(100)       DEFAULT NULL        COMMENT '扩展字段1',
        `attribute2`        varchar(100)       DEFAULT NULL        COMMENT '扩展字段2',
        `attribute3`        text               DEFAULT NULL        COMMENT '扩展字段3',
        PRIMARY KEY (encoder_id),
        KEY(encoder_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='制卡器信息表';

-- ----------------------------
-- Table structure for sys_attributes
-- ----------------------------
CREATE TABLE `sys_attributes` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `attr1` varchar(500) DEFAULT NULL,
  `attr2` varchar(500) DEFAULT NULL,
  `attr3` varchar(1000) DEFAULT NULL,
  `attr4` varchar(1000) DEFAULT NULL,
  `attr5` varchar(500) DEFAULT NULL,
  `attr6` varchar(500) DEFAULT NULL,
  `attr7` varchar(500) DEFAULT NULL,
  `attr8` varchar(500) DEFAULT NULL,
  `status` smallint DEFAULT NULL,
  `enabled` smallint DEFAULT NULL,
  `create_by` varchar(50) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(50) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

