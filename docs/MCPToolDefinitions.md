# MCP Tool Definitions for Hotel Lock AI System

> **定义约定**: 本文档按照"做法B"——PM定义业务语义Contract，开发负责JSON Schema实现和数据映射

---

## 1. get_room_occupancy_status

**业务用途**: 查询房间的当前入住状态，用于AI诊断"卡片无效"时判断是否因客人已退房

### 输入参数

- `room_name` (必填): 房间名称，如 "2101" 或 "3F-205"

### 输出字段

- `room_name`: 房间名称
- `occupancy_status`: 房态枚举，可选值：
  - `vacant_clean` - 空净
  - `occupied` - 在住
  - `under_repair` - 维修中
  - `dirty` - 脏房
  - `reserved` - 已预订
- `check_in_date`: 实际入住时间（ISO 8601格式，可为空）
- `planned_checkout_date`: 计划退房时间（ISO 8601格式，可为空）
- `is_late_checkout`: 是否超时续住（布尔值，必填）
- `guest_name`: 当前宾客姓名（可为空）
- `bill_no`: 关联账单号（可为空）

### 数据来源提示（给开发）

- 从 `room_info` 表查询 `status_code` 字段，映射规则：0→vacant_clean, 1→occupied, 2→under_repair, 3→dirty
- `is_late_checkout` 计算逻辑：`NOW() > check_out_date`
- 宾客姓名从 `bill_info` 表通过 `bill_no` 字段JOIN查询

---

## 2. get_card_validity_info

**业务用途**: 检查门卡的有效性，判断卡片是否过期/挂失/被终止，用于AI诊断开门失败原因

### 输入参数

- `card_code` (必填): 门卡物理编号（16位十六进制字符串），示例: "1234567890ABCDEF"

### 输出字段

- `card_code`: 门卡编号
- `card_type`: 卡类型文字描述（如: "宾客卡" / "总卡" / "楼层卡" / "应急卡"）
- `is_valid`: 卡片是否有效（布尔值，未过期且未挂失）
- `validity_start`: 有效期开始时间（ISO 8601格式，可为空）
- `validity_end`: 有效期结束时间（ISO 8601格式，可为空）
- `is_expired`: 是否已过期（布尔值）
- `is_lost`: 是否已挂失（布尔值）
- `is_terminated`: 是否已终止/被顶替（布尔值）
- `associated_room`: 关联房间名称（可为空，仅宾客卡有值）
- `guest_name`: 持卡人姓名（可为空，仅宾客卡有值）

### 数据来源提示（给开发）

- 从 `guest_make_card_record` 或 `other_make_card_record` 根据 `card_code` 查询
- `is_expired` 计算逻辑: `NOW() > check_out_date`
- `is_lost` 判断: `lost_card_date IS NOT NULL`
- `is_terminated` 判断: `disable_date IS NOT NULL`
- 卡类型从 `card_type` 字段直接读取

---

## 3. get_device_status

**业务用途**: 查询门锁设备的在线状态、电量、网络连接，用于AI诊断设备故障

### 输入参数

- `room_name` (必填): 房间名称，示例: "2101"

### 输出字段

- `room_name`: 房间名称
- `lock_no`: 锁具编号（可为空）
- `device_status`: 设备状态枚举，可选值:
  - `online` - 在线正常
  - `offline` - 完全离线
  - `zigbee_offline` - Zigbee网络离线
  - `low_battery` - 低电量报警
- `battery_level`: 电池电量百分比（0-100整数，可为空）
- `signal_strength`: Zigbee信号强度（RSSI值，如 "-45dBm"，可为空）
- `last_active_time`: 最后活跃时间（ISO 8601格式，可为空）
- `firmware_version`: 固件版本号（可为空）

### 数据来源提示（给开发）

- 从 `room_info` 表通过 `room_name` 查询 `lock_no` 和 `mac_id`
- 从 `gw_sub_device` 表通过 `device_id` (对应 `lock_no`) 查询 `rssi_value` 和 `last_active_date`
- `device_status` 映射逻辑: `room_info.status_code` = 4 → zigbee_offline, 5 → low_battery
- 电池电量可能需要从扩展字段 `attribute1-3` 解析

---

## 4. get_recent_lock_events

**业务用途**: 查询门锁近期的开门记录和异常事件,用于AI分析故障原因和异常模式

### 输入参数

- `room_name` (必填): 房间名称
- `event_count` (可选): 返回最近N条记录，默认10条，范围1-50
- `event_type_filter` (可选): 事件类型过滤，可选值：
  - `access` - 访问事件
  - `error` - 错误事件
  - `status` - 状态事件
  - 不填则返回全部类型

### 输出字段

- `room_name`: 房间名称
- `events`: 事件列表数组，每个事件包含：
  - `event_time`: 事件发生时间（ISO 8601格式）
  - `event_type`: 事件类型（access/error/status三选一）
  - `event_way`: 开门方式文字描述（如: "宾客卡" / "机械钥匙" / "手机APP"）
  - `event_name`: 事件描述（中英文双语，示例: "开锁成功 / Unlocked successfully"）
  - `event_code`: 事件编码（对应sys_event表）
  - `card_code`: 触发事件的卡号（可为空，仅刷卡事件有值）
  - `success`: 操作是否成功（布尔值）

### 数据来源提示(给开发)

- **事件日志存储位置需确认**:
  1. 如使用 MQTT 推送,可能存储在 `mqtt_message_log` 表(需新建)
  2. 如使用 Zigbee 网关缓存,需从 `ZB_Task_Queue` 的响应字段解析
  3. 临时方案:从 `gw_sub_device.attribute1-3` 字段解析最近事件
- 事件描述从 `sys_event` 表通过 `event_way_code` + `event_code` 匹配翻译
- `success` 判断逻辑: `event_code = 0` 为成功,其他为失败
- **建议开发侧新增 `lock_event_log` 表**,包含字段:
  - `room_name`, `event_time`, `event_way_code`, `event_code`, `card_code`
- 按 `event_time DESC` 排序取最近N条

---

## 5. get_system_check_summary

**业务用途**: 一键健康检查功能,快速扫描酒店所有门锁/网关的异常状态,用于AI生成巡检报告

### 输入参数

- `check_scope` (可选): 检查范围，默认为 `all`，可选值：
  - `all` - 全部检查
  - `devices` - 仅设备状态
  - `cards` - 仅卡片有效性
  - `network` - 仅网络连通性
- `building_code` (可选): 指定楼栋编码，不填则检查全部楼栋

### 输出字段

- `check_time`: 检查执行时间（ISO 8601格式）
- `total_rooms`: 检查的总房间数
- `device_issues`: 设备问题统计对象
  - `offline_count`: 离线设备数量
  - `low_battery_count`: 低电量设备数量
  - `zigbee_offline_count`: Zigbee离线数量
  - `affected_rooms`: 受影响的房间名称列表
- `card_issues`: 卡片问题统计对象
  - `expired_cards`: 过期卡片数量
  - `lost_cards`: 挂失卡片数量
- `network_issues`: 网络问题统计对象
  - `gateway_offline_count`: 离线网关数量
  - `gateway_list`: 网关详情列表，每个网关包含：
    - `gateway_name`: 网关名称
    - `status`: 状态（online/offline）
    - `last_active`: 最后活跃时间（ISO 8601格式，可为空）
- `health_score`: 系统健康分数（0-100整数）

### 数据来源提示（给开发）

- 设备状态从 `room_info.status_code` 聚合统计
- 网关状态从 `gateway_info` 表查询 `status` 字段
- 卡片问题从 `guest_make_card_record` 查询 `check_out_date < NOW()` 和 `lost_card_date IS NOT NULL`
- `health_score` 建议计算公式: `100 - (离线设备占比*40 + 低电量占比*30 + 网关离线占比*30)`

---

## 6. get_guest_checkin_info

**业务用途**: 查询指定房间的宾客入住信息,用于AI回答"这个房间住的是谁"

### 输入参数

- `room_name` (必填): 房间名称

### 输出字段

- `room_name`: 房间名称
- `is_occupied`: 是否有宾客入住（布尔值）
- `guest_name`: 宾客姓名（可为空）
- `id_type`: 证件类型（如: "身份证" / "护照"，可为空）
- `id_code`: 证件号码（脱敏处理: 仅显示前3后4位，可为空）
- `check_in_date`: 入住时间（ISO 8601格式，可为空）
- `planned_checkout_date`: 计划退房时间（ISO 8601格式，可为空）
- `room_type`: 房型（如: "标准间" / "套房"，可为空）
- `bill_no`: 账单编号（可为空）
- `active_cards`: 该房间当前有效的卡片列表（数组），每张卡包含：
  - `card_code`: 卡号（脱敏: 仅显示后4位）
  - `card_type`: 卡类型文字描述
  - `issued_date`: 发卡时间（ISO 8601格式）

### 数据来源提示（给开发）

- 从 `bill_rooms` 表通过 `room_name` 查询 `bill_no`
- 通过 `bill_no` 关联 `bill_info` 获取宾客信息
- 证件号脱敏SQL: `CONCAT(LEFT(id_code, 3), '****', RIGHT(id_code, 4))`
- 有效卡片从 `room_card_code_list` 查询，过滤已退卡记录

---

## 7. get_error_code_explanation

**业务用途**: 将设备事件编码翻译成业务语义说明,用于AI生成用户友好的错误解释

### 输入参数

- `event_way_code` (必填): 事件方式编码（整数，示例: 130=宾客卡）
- `event_code` (必填): 事件结果编码（整数，示例: 0=成功, 11=卡片失效）
- `language` (可选): 返回语言，默认 `en`，可选值：
  - `zh` - 中文
  - `en` - 英文

### 输出字段

- `event_way_name`: 事件方式名称（示例: "Guest Card"）
- `event_name`: 事件结果描述（示例: "Failed, card has expired"）
- `event_type`: 事件分类枚举，可选值：
  - `access` - 访问事件
  - `error` - 错误事件
  - `status` - 状态事件
- `severity`: 严重程度枚举，可选值：
  - `info` - 正常
  - `warning` - 警告
  - `error` - 错误
- `suggested_action`: 建议操作文字描述（业务规则生成，非数据库字段，可为空）

### 数据来源提示（给开发）

- 从 `sys_event` 表查询，匹配条件: `event_way_code` + `event_code` + `language`
- `severity` 映射规则: `event_type_code=1` → info, `=2` → warning, `=3` → error
- `suggested_action` 需PM定义业务规则（示例: event_code=11 → "请前往前台补卡"）

---

## 8. search_rooms_by_criteria

**业务用途**: 多条件搜索房间,用于AI回答"哪些房间正在维修"、"4楼有哪些空房"等查询

### 输入参数

- `building_code` (可选): 楼栋筛选（示例: "1"）
- `floor_code` (可选): 楼层筛选（整数，示例: 4）
- `room_status` (可选): 房态筛选，可选值：
  - `vacant_clean` - 空净
  - `occupied` - 在住
  - `under_repair` - 维修中
  - `dirty` - 脏房
- `room_type` (可选): 房型筛选（示例: "标准间"）
- `max_results` (可选): 最多返回结果数，默认20，范围1-100

### 输出字段

- `total_count`: 符合条件的总数
- `rooms`: 房间列表数组，每个房间包含：
  - `room_name`: 房间名称
  - `building_code`: 楼栋编码
  - `floor_code`: 楼层编号（整数）
  - `room_type`: 房型名称
  - `status`: 房态文字描述
  - `is_occupied`: 是否在住（布尔值）
  - `device_status`: 设备状态，可选值：
    - `online` - 在线
    - `offline` - 离线
    - `low_battery` - 低电量

### 数据来源提示（给开发）

- 从 `room_info` 表执行 WHERE 条件组合查询
- `status_code` 映射枚举: 0=vacant_clean, 1=occupied, 2=under_repair, 3=dirty

---

---

## 9. get_password_authorization

**业务用途**: 查询房间的临时密码/授权码有效性，用于AI诊断"密码开门失败"问题

### 输入参数

- `room_name` (必填): 房间名称

### 输出字段

- `room_name`: 房间名称
- `has_password`: 是否设置了开门密码（布尔值）
- `password_hint`: 密码提示信息（脱敏显示，如 "****56"，可为空）
- `password_valid_until`: 密码有效期截止时间（ISO 8601格式，可为空）
- `is_password_expired`: 密码是否已过期（布尔值）
- `authorization_type`: 授权类型（如: "临时密码" / "长期密码" / "未设置"）
- `last_password_change`: 最后修改密码时间（ISO 8601格式，可为空）

### 数据来源提示（给开发）

- 从 `room_info` 表查询 `open_pwd` 字段
- 如房间当前有宾客入住，从 `bill_info.open_pwd` 查询宾客专用密码
- 密码脱敏显示: `CONCAT('****', RIGHT(open_pwd, 2))`
- `is_password_expired` 判断逻辑: 需根据业务规则定义（如退房后密码自动失效）

---

## 10. get_area_access_permissions

**业务用途**: 查询卡片的公区门禁访问权限，用于AI诊断"健身房/泳池刷卡失败"问题

### 输入参数

- `card_code` (必填): 门卡物理编号（16位十六进制字符串）

### 输出字段

- `card_code`: 门卡编号
- `has_area_access`: 是否配置了区域权限（布尔值）
- `accessible_areas`: 可访问区域列表（数组），每个区域包含：
  - `area_code`: 区域编码
  - `area_name`: 区域名称（如: "健身房" / "游泳池" / "会议室A"）
  - `access_time_sections`: 可访问时间段列表（如 ["06:00-22:00"]，可为空表示全天）
- `restricted_areas`: 受限区域列表（仅列出区域名称）
- `area_config_date`: 区域权限配置时间（ISO 8601格式，可为空）

### 数据来源提示(给开发)

- 从 `guest_make_card_record.area_list` 或 `other_make_card_record.area_list` 查询
- `area_list` 字段存储格式:逗号分隔的区域编码(如 "1,3,5")
- **区域名称映射**:JOIN `areas` 表通过 `area_code` 获取 `area_name`
- 时间段从 `guest_make_card_record.time_section1/2/3` 字段解析(仅非宾客卡支持时间段控制)
- 如 `area_list` 为空,返回 `has_area_access = false`

---

## 11. get_operator_audit_log

**业务用途**: 查询操作员的权限变更和操作记录，用于合规审计和AI生成审计报告

### 输入参数

- `emp_id` (可选): 员工ID
- `start_date` (可选): 查询开始日期（ISO 8601格式）
- `end_date` (可选): 查询结束日期（ISO 8601格式）
- `operation_type` (可选): 操作类型过滤（如: "权限变更" / "制卡" / "退房"）
- `max_results` (可选): 最多返回结果数，默认50，范围1-200

### 输出字段

- `total_count`: 符合条件的总记录数
- `audit_records`: 审计记录列表（数组），每条记录包含：
  - `record_id`: 记录ID
  - `emp_id`: 员工ID
  - `emp_name`: 员工姓名
  - `position_name`: 职位名称
  - `operation_time`: 操作时间（ISO 8601格式）
  - `operation_type`: 操作类型
  - `function_name`: 操作功能名称（如: "制宾客卡" / "修改房价"）
  - `affected_resource`: 受影响的资源（如: 房间号、账单号，可为空）
  - `remark`: 备注说明（可为空）

### 数据来源提示（给开发）

- 从 `operator_power_record` 表查询权限变更记录
- 从 `sys_log` 表（DDL中未显示，如存在）查询操作日志
- 如无专用日志表，可从制卡记录表的 `operator` 和 `make_card_date` 字段聚合统计
- 按 `operated_date DESC` 或 `create_time DESC` 排序

---

## 12. get_card_usage_statistics

**业务用途**: 统计卡片使用情况（发卡/退卡/补卡数量），用于AI回答"今天发了多少张卡"

### 输入参数

- `start_date` (可选): 统计开始日期（ISO 8601格式，默认今日00:00）
- `end_date` (可选): 统计结束日期（ISO 8601格式，默认当前时间）
- `card_type` (可选): 卡类型过滤（如: "宾客卡" / "员工卡" / "楼层卡"）
- `building_code` (可选): 楼栋筛选

### 输出字段

- `statistics_period`: 统计时间段
  - `start_time`: 开始时间（ISO 8601格式）
  - `end_time`: 结束时间（ISO 8601格式）
- `card_issuance`: 发卡统计
  - `total_issued`: 总发卡数
  - `guest_cards`: 宾客卡数量
  - `employee_cards`: 员工卡数量
  - `special_cards`: 特殊卡数量（总卡/应急卡/楼层卡等）
- `card_return`: 退卡统计
  - `total_returned`: 总退卡数
  - `normal_checkout`: 正常退房退卡数
  - `lost_reported`: 挂失退卡数
- `card_reissue`: 补卡统计
  - `total_reissued`: 总补卡数
  - `reason_lost`: 因遗失补卡数
  - `reason_damaged`: 因损坏补卡数
- `active_cards_count`: 当前有效卡片总数

### 数据来源提示（给开发）

- 发卡数从 `guest_make_card_record` 和 `other_make_card_record` 表按 `make_card_date` 筛选统计
- 退卡数查询 `return_card_date IS NOT NULL` 记录
- 挂失数查询 `lost_card_date IS NOT NULL` 记录
- 补卡数从制卡记录的 `make_desc` 字段或操作类型判断（需业务规则定义）
- 当前有效卡从 `card_state` 表统计

---

## 13. get_room_type_config

**业务用途**: 查询房型的配置参数（最大卡数/默认制卡数/价格），用于AI回答"标准间最多能发几张卡"

### 输入参数

- `room_type` (可选): 房型名称（如: "标准间"）
- `list_all` (可选): 是否列出所有房型，默认false

### 输出字段

- `room_types`: 房型配置列表（数组），每个房型包含：
  - `room_type`: 房型名称
  - `max_card_count`: 最大可发卡数
  - `default_make_card`: 默认制卡数量
  - `room_price`: 房间价格
  - `area_list`: 可访问区域列表（可为空）
  - `is_vip`: 是否VIP房型（布尔值）
  - `is_enabled`: 是否启用（布尔值）
  - `remark`: 备注说明（可为空）

### 数据来源提示（给开发）

- 从 `room_type` 表查询
- 如 `room_type` 参数为空且 `list_all=false`，返回所有启用的房型
- 价格字段为 `decimal(19,4)` 类型，需按货币格式返回

---

## 14. get_system_parameter

**业务用途**: 查询系统配置参数（退房延迟时间/默认入住天数等），用于AI回答系统设置相关问题

### 输入参数

- `param_key` (可选): 参数键名（如: "DefOutTime" / "DelayTimeToEmpty"）
- `category` (可选): 参数类别筛选（如: "System"）

### 输出字段

- `parameters`: 参数列表（数组），每个参数包含：
  - `category`: 类别
  - `param_key`: 参数键名
  - `param_value`: 参数值
  - `description`: 参数描述（中文说明）
  - `remark`: 备注（可为空）
  - `last_update_time`: 最后更新时间（ISO 8601格式，可为空）

### 数据来源提示（给开发）

- 从 `sys_var_define` 表查询
- 如未提供 `param_key`，返回指定 `category` 下所有参数
- 敏感参数需过滤（如: `AuthorKey1` 授权密钥不返回原始值）

---

## 15. get_employee_info

**业务用途**: 查询员工信息和权限，用于AI回答"谁有权限修改房价"等问题

### 输入参数

- `emp_id` (可选): 员工ID
- `username` (可选): 员工姓名（至少提供一个参数）

### 输出字段

- `emp_id`: 员工ID
- `username`: 员工姓名
- `is_operator`: 是否操作员（布尔值）
- `position_name`: 职位名称（可为空）
- `permissions`: 权限列表（数组），每个权限包含：
  - `function_name`: 功能名称（如: "制宾客卡" / "修改房价"）
  - `function_category`: 功能类别（如: "入住管理" / "系统维护"）
- `is_active`: 账号是否激活（布尔值）
- `last_login_time`: 最后登录时间（ISO 8601格式，可为空）
- `remark`: 备注说明（可为空）

### 数据来源提示（给开发）

- 从 `employees` 表查询基本信息
- 权限列表从 `operator_power_record` 表通过 `emp_id` 查询最新记录的 `func_name` 字段
- 密码字段 (`password`, `salt`) 禁止返回
- 最后登录时间需从登录日志表查询（DDL中未显示，如不存在则返回null）

---

## 16. get_gateway_health_status

**业务用途**: 查询网关设备的在线状态和负载，用于AI诊断"整层楼的锁都离线"问题

### 输入参数

- `gateway_mac` (可选): 网关MAC地址
- `building_code` (可选): 楼栋筛选

### 输出字段

- `gateways`: 网关列表（数组），每个网关包含：
  - `gateway_mac`: 网关MAC地址
  - `gateway_name`: 网关名称（可为空）
  - `status`: 在线状态（online/offline）
  - `last_heartbeat`: 最后心跳时间（ISO 8601格式）
  - `connected_devices_count`: 挂载的子设备数量
  - `signal_quality`: 网络信号质量（good/fair/poor）
  - `firmware_version`: 固件版本（可为空）
  - `client_id`: MQTT客户端ID

### 数据来源提示（给开发）

- 从 `gateway_info` 表查询 `status` 和 `last_active_date`
- 从 `gw_sub_device` 表统计 `COUNT(*)` WHERE `gateway_id` = ...
- 信号质量需根据 `rssi_value` 范围映射：
  - RSSI > -50: good
  - RSSI -50 ~ -70: fair
  - RSSI < -70: poor
- 如未指定 `gateway_mac`，返回全部网关列表

### AI对话示例

**场景1：全局健康检查**
- 用户："检查一下8楼的网关状态。"
- AI：调用工具 → "8楼共有2个网关。网关GW-801（MAC: AA:BB:CC:01）在线正常，挂载25个门锁，信号质量良好；网关GW-802（MAC: AA:BB:CC:02）离线，最后心跳时间为今天03:15，建议工程部检查网络连接。"

**场景2：故障定位**
- 用户："为什么8楼所有房间的锁都显示离线？"
- AI：调用工具 → "问题已定位：负责8楼的网关GW-801已离线2小时，导致该楼层25间客房门锁失联。请立即检查网关电源和网络连接，或联系技术支持更换设备。"

---

## 17. get_pms_sync_status

**业务用途**: 查询与PMS系统的指令同步状态，用于AI诊断"PMS办理入住后门锁未生效"

### 输入参数

- `bill_no` (可选): 账单编号
- `room_name` (可选): 房间名称
- `command_type` (可选): 指令类型（KD/KM/KO）

### 输出字段

- `room_name`: 房间名称（可为空）
- `bill_no`: 账单编号（可为空）
- `pending_commands`: 待发送指令列表（数组）
  - `command_type`: 指令类型（KD/KM/KO）
  - `command_content`: 指令内容（脱敏）
  - `create_time`: 创建时间（ISO 8601格式）
  - `is_sent`: 是否已发送（布尔值）
- `pms_connection_status`: PMS连接状态（connected/disconnected）
- `last_sync_time`: 最后同步时间（ISO 8601格式，可为空）
- `fias_config`: FIAS配置状态
  - `enable_kd`: KD指令是否启用（布尔值）
  - `enable_km`: KM指令是否启用（布尔值）
  - `enable_ko`: KO指令是否启用（布尔值）

### 数据来源提示（给开发）

- 从 `fias_kr_command` 表查询 `is_used = 0` 的记录
- 从 `fias_pms_link_client` 查询 `state` 字段
- FIAS配置从 `fias_interface_setting` 表读取
- 关联 `bill_info` 和 `room_info` 表获取房间信息
- `command_content` 脱敏：仅显示指令类型和房间号，隐藏详细参数

### AI对话示例

**场景1：入住同步问题**
- 用户："前台在PMS里给2101办了入住，但门锁系统还没收到。"
- AI：调用工具 → "已检测到问题：账单号BN20241124001的制卡指令（KM）在队列中等待发送，创建时间为10分钟前。PMS连接状态正常，但指令发送失败。建议检查门锁系统的FIAS服务是否正常运行。"

**场景2：退房通知确认**
- 用户："2101刚退房了，PMS收到通知了吗？"
- AI：调用工具 → "退房指令（KO）已于5分钟前成功发送给PMS，最后同步时间为今天14:35。PMS连接状态正常，房间2101的退房信息应已同步。"

---

## 18. get_zigbee_task_status

**业务用途**: 查询下发给门锁的任务执行状态，用于AI诊断"制卡后门锁没反应"

### 输入参数

- `room_name` (必填): 房间名称
- `task_type` (可选): 任务类型（如: "制卡" / "退房" / "修改配置"）

### 输出字段

- `room_name`: 房间名称
- `pending_tasks`: 待执行任务列表（数组）
  - `task_id`: 任务ID
  - `task_type`: 任务类型
  - `create_time`: 创建时间（ISO 8601格式）
  - `status`: 状态（待发送/已发送/已确认/失败）
  - `retry_count`: 重试次数
  - `error_message`: 错误信息（仅失败任务有值，可为空）
- `last_successful_task`: 最后成功的任务信息
  - `task_type`: 任务类型
  - `completed_time`: 完成时间（ISO 8601格式）
- `device_online_status`: 门锁在线状态（online/offline）

### 数据来源提示（给开发）

- 从 `ZB_Task_Queue` 表查询 `room_name` 相关任务
- `status` 映射：0=待发送, 1=已发送, 2=已确认, -1=失败
- 按 `create_time DESC` 排序
- 从 `gw_sub_device` 关联查询门锁在线状态
- 任务类型从 `action_type` 字段映射为中文描述

### AI对话示例

**场景1：制卡任务排查**
- 用户："刚给2101制了卡，但客人说刷不开门。"
- AI：调用工具 → "检测到问题：2101的制卡任务已发送给门锁，但未收到确认（状态：已发送，重试2次）。门锁在线状态正常。可能原因：①门锁忙碌中 ②Zigbee信号干扰。建议：等待30秒后重新制卡，或使用手持机近距离制卡。"

**场景2：任务执行确认**
- 用户："2101的退房指令发下去了吗？"
- AI：调用工具 → "退房指令已成功执行，完成时间为今天14:08。门锁已清空该房间的所有卡片权限，最后一次成功任务为'退房清除授权'。"

**场景3：设备离线诊断**
- 用户："3202的门锁为什么一直收不到指令？"
- AI：调用工具 → "问题定位：3202的门锁当前离线，有3条待发送任务积压（制卡、修改配置、时间同步），最早的任务创建于2小时前。请工程部检查：①门锁电池是否耗尽 ②Zigbee网关是否正常 ③门锁是否被物理拆卸。"

---

## 开发实现注意事项

### 1. 数据安全
- **隐私脱敏**: 证件号码、卡号、密码需按规则脱敏后返回
- **权限控制**: MCP Server需验证调用方权限 (如操作员等级)
- **审计日志**: 记录所有MCP工具调用到 `sys_log` 表
- **敏感参数过滤**: `get_system_parameter` 禁止返回授权密钥等敏感配置

### 2. 性能优化
- **数据库索引**: 确保 `room_name`, `bill_no`, `card_code`, `emp_id`, `gateway_mac` 有索引
- **缓存策略**: `get_system_check_summary`, `get_system_parameter`, `get_gateway_health_status` 建议5分钟缓存
- **查询限制（分层限制）**:
  - **单房间查询类工具**（工具1/2/3/4/6/9）：无需限制（单房间数据量小）
  - **列表查询类工具**（工具8）：最多返回100条，支持分页
  - **统计类工具**（工具5/11/12）：返回聚合结果，不限制原始数据量
  - **审计日志工具**（工具11）：最多返回200条，强制分页
  - **网关/设备列表**（工具16）：最多返回50条
- **分页支持**: 统计类工具（工具11/12）建议支持分页参数

### 3. 错误处理
- **标准错误码**: 统一返回格式 `{"error": "ROOM_NOT_FOUND", "message": "房间不存在"}`
- **超时设置**: 单个MCP调用超时时间5秒
- **降级策略**: 数据库查询失败时返回缓存或空结果,不阻塞AI推理
- **参数验证**: 日期范围不得超过90天，防止大数据量查询

### 4. 时区处理
- **数据库存储**: 所有时间字段统一使用 `datetime` 类型（不带时区）
- **MCP 输出**: 统一转换为 ISO 8601 格式，带酒店时区偏移量
  - 示例：`2025-11-24T14:30:00+08:00`（假设酒店在中国）
- **时区配置**: 从 `sys_var_define` 读取 `TimeZoneOffset` 参数（默认 `+08:00`）
- **跨时区酒店**: 如酒店在多个时区（如国际连锁），需在 `room_info` 表增加 `timezone` 字段

### 5. 业务规则扩展
- **工具9密码验证**: 需PM定义密码失效规则（退房后/修改后/固定时长）
- **工具10区域映射**: 已明确使用 `areas` 表进行映射
- **工具12补卡原因**: 需业务规则定义如何从 `make_desc` 或操作记录判断补卡原因
- **工具17 PMS同步**: 指令内容脱敏规则需PM定义
- **工具18任务重试**: 需定义任务重试策略（最大重试次数、重试间隔）

---

## 版本历史

| 版本 | 日期 | 变更说明 |
|------|------|----------|
| v1.0 | 2025-11-21 | 初版发布,基于 `mysql20250813_update.sql` 定义16个核心MCP工具 |
| v1.1 | 2025-11-24 | 优化版本：<br>1. 修正工具4/10的数据源映射<br>2. 合并工具11到工具6（改名为get_guest_full_info）<br>3. 新增3个高频场景工具（16-18）：网关健康、PMS同步、Zigbee任务<br>4. 优化性能建议和时区处理<br>5. 总工具数：18个 |

