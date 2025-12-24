# 报表口径与计算规范（v1.0）

日期：2025-11-13  
依赖：`docs/DataModel.md`

> 说明：所有时间统计均以门店本地时区为准（见 `property.timezone`），存储统一 UTC。除非特别说明，统计范围默认过滤 `event_type in ('open_attempt','open','fail')`。

## 统一维度与过滤
- 时间维度：日/周/月；`local_date` 与 `event_time_utc`（窗口聚合时使用）。
- 组织维度：租户/门店/楼层/房间/设备型号。
- 过滤：时间范围、门店集合、房型、设备状态、卡类型/来源。
- 去重规则：基于 `event_id` 去重；同秒多次上报以首次为准（按 `event_time_utc` 最小）。

## 统一定义
- 开门尝试（attempt）：`event_type = 'open_attempt'`，或 `event_type in ('open','fail')` 的上游记录。
- 成功：`result = 'success'`；失败：`result = 'fail'`。
- 低电判定：`alert_type = 'low_battery'`，或事件中 `battery_level < 20`（阈值可配，默认 20）。
- 异常开门：`event_type in ('tamper','manual_override')`，或在非授权时段/超授权范围的开门成功。
- 未关门超时：开门后 T 分钟（默认 3-5 分钟，可配）未出现 `close` 事件。

---

## R1 开门成功率趋势
- 目的：观察一段时间内开门成功率变化。
- 指标：
  - `attempts`：开门尝试次数
  - `successes`：成功次数
  - `success_rate = successes / nullif(attempts,0)`
- 维度：日/周/门店/设备型号/房型。
- 过滤：时间、门店、设备状态。
- 边界：无尝试时返回空或 0/0 → `NULL`；失败原因分类见 R4。
- 示例 SQL（PostgreSQL）：
```sql
WITH raw AS (
  SELECT property_id, date_trunc('day', (event_time_utc AT TIME ZONE prop.timezone)) AS d,
         (result='success')::int AS is_success
  FROM door_event e
  JOIN property prop USING(property_id)
  WHERE event_type IN ('open','fail')
    AND event_time_utc BETWEEN $start_utc AND $end_utc
)
SELECT property_id, d::date AS local_date,
       COUNT(*) AS attempts,
       SUM(is_success) AS successes,
       CASE WHEN COUNT(*)=0 THEN NULL ELSE SUM(is_success)::decimal/COUNT(*) END AS success_rate
FROM raw GROUP BY 1,2 ORDER BY 2;
```
- 图表：折线（成功率），附柱状（尝试数）。

## R2 异常开门分布
- 定义：`event_type in ('tamper','manual_override')` 或授权校验失败情况下出现的 `open`。
- 指标：次数、按原因分布（越界时段、黑名单卡、强制开门等）。
- 维度：门店/房间/时段（小时）。
- 示例：
```sql
SELECT property_id, date_trunc('hour', event_time_utc AT TIME ZONE prop.timezone) AS hour,
       reason_code, COUNT(*) AS cnt
FROM door_event e JOIN property prop USING(property_id)
WHERE (event_type IN ('tamper','manual_override')
    OR (event_type='open' AND reason_code IN ('policy_violation','outside_schedule')))
  AND event_time_utc BETWEEN $start_utc AND $end_utc
GROUP BY 1,2,3;
```
- 图表：堆叠柱状/热力图。

## R3 低电池告警趋势
- 定义：`alert_type='low_battery'`，或事件维度 `battery_level < 20`。
- 指标：低电设备数（日去重）、触发次数。
- 维度：日/门店/设备型号。
- 去重：同设备同日计 1 台。
- 图表：双轴折线（设备数 vs 次数）。

## R4 设备故障率
- 定义：`fail_rate = fail_count / attempts`，失败包含通信失败、机械阻塞等。
- 维度：门店/设备型号/房间。
- 失败原因：按 `reason_code` 分类统计 Top N。
- 图表：条形（Top N 故障设备），饼图（原因占比）。

## R5 未关门超时统计
- 判定：开门后 T 分钟无 `close`，记 1 次（同一开门序列仅记一次）。
- 实现：按设备有序窗口匹配 open→close，超时则计数；跨日界以本地时区判断。
- 指标：超时次数、平均超时时长（若有传感时长）。
- 图表：柱状（次数），箱线（时长分布）。

## R6 门卡使用分析
- 维度：`card_type`（guest/staff/service/master）、来源 `source`（card/mobile/staff）。
- 指标：使用次数、唯一卡数、失败率。
- 图表：堆叠柱状 + 折线（失败率）。

## R7 保洁时段通行
- 定义：可配保洁时段（默认 09:00-17:00，本地时区）。
- 维度：门店/楼层/房型；过滤 `card_type in ('staff','service')`。
- 指标：开门次数/房间天；异常打开（非保洁时段）。
- 图表：面积图 + 房型对比条形。

## R8 房态与门锁一致性
- 定义：PMS 房态与门锁事件推断状态的对齐度（仅聚合，不落客史）。
- 推断：通过开/关门序列与入住窗口比对（仅使用不可识别的时间窗标记）。
- 指标：一致率、不一致明细条数（不展示客人信息）。
- 风险：严格脱敏；如无法保证合规，则仅给出聚合一致率。

## R9 通行高峰时段
- 维度：小时/周几；过滤 `result='success'`。
- 指标：次数、占比；
- 图表：热力图/玫瑰图。

## R10 门店对比排行榜
- 定义：按成功率、失败率、低电设备占比、超时率等综合指标排名。
- 维度：门店；可切换指标与时间范围。
- 指标示例：
  - 成功率：见 R1
  - 低电占比：`low_battery_devices / total_devices`
  - 超时率：`door_ajar_count / open_sequences`
- 图表：条形（Top/Bot 10），可附雷达图。

---

## 边界与统一规则
- 空值：分母为 0 时返回 `NULL`；前端展示为 `—`。
- 取整与小数：率类保留两位（四舍五入）；导出保留四位。
- 异常清洗：重复/乱序事件按 `event_id` 去重；时间回拨按最早时间计。
- 设备状态：统计时默认过滤 `device.status in ('active','online')`。

## 图表规范
- 颜色：成功（绿色）、失败（红色）、警告（橙色）。
- 置信区间：可选显示（按样本量自动开关）。
- 导出：PNG 1080p、CSV UTF-8，无 BOM。

## 示例指标快照表（可选实现）
- `device_metrics_daily(property_id, device_id, local_date, attempts, successes, fail_count, low_battery_flag, door_ajar_count, updated_at_utc)`
- 每日离线计算，前端查询优先命中快照，失败回源明细。