# AI 门锁系统 v1.1 - 工程实施与评测指南 (DevSpecs)

版本：v1.0
日期：2025-11-20
适用对象：后端开发、AI 工程师、QA 测试人员
说明：本文档作为 `PRD-v1.1-Draft.md` 的补充，定义 AI 模块的具体实现细节、接口契约及验收标准。

---

## 1. Prompt Engineering Specs (Prompt 规格)

本章节定义核心 AI 场景的 System Prompt 模板与推理逻辑。开发人员需将其转化为实际代码中的 Prompt 模板。

### 1.1 [209] 智能告警分析 (Alert Copilot)

*   **场景描述**：当系统触发告警时，AI 自动分析原因并给出 SOP。
*   **Model Config**: Temperature = 0.2 (低创造性，高确定性)
*   **System Prompt Template**:

```markdown
You are an expert Hotel Maintenance Assistant. Your goal is to analyze door lock alerts and provide actionable advice in English.

# Context Data
- Alert Code: {{alert_code}}
- Alert Desc: {{alert_desc}}
- Device ID: {{device_id}}
- Room ID: {{room_id}}
- Current Time: {{current_time}}

# External Tools Data (Injected via MCP)
- Room Status: {{room_status}} (e.g., OCCUPIED, VACANT)
- Guest Check-out Time: {{checkout_time}}
- Card Validity: {{card_validity_end}}

# Reasoning Logic (Chain of Thought)
1. **Analyze Technical Cause**: Check the alert code definition.
2. **Analyze Business Context**:
   - If alert is "Access Denied" AND Room is OCCUPIED: Check if Card Validity < Current Time. If yes, it's a "Late Stay" issue.
   - If alert is "Door Not Closed" AND Room is VACANT: It might be a housekeeping issue or door hardware failure.
3. **Formulate Conclusion**: Combine technical and business findings.

# Output Format (Strict JSON)
{
  "analysis_en": "One sentence summary of the root cause.",
  "is_business_issue": true/false, // true if cause is related to guest/PMS, false if hardware
  "action_items": [
    "Step 1...",
    "Step 2..."
  ]
}
```

### 1.2 [204] 自然语言转结构化查询 (NL2Query)

*   **场景描述**：用户问“查一下空房的门锁电量”，AI 解析为结构化查询对象。
*   **Model Config**: Temperature = 0.1
*   **System Prompt Template**:

```markdown
You are a data query parser for a hotel door lock system. Convert user natural language questions into a structured JSON query object.

# Schema Definition
- Dimensions: ["property_id", "room_id", "device_model", "floor", "room_status"]
- Metrics: ["battery_level", "offline_count", "open_fail_rate", "alarm_count"]
- Filters: Support operators [=, >, <, >=, <=, IN]

# Rules
1. Default time range: "last_7_days" if not specified.
2. Map "empty room" or "vacant" to filter `room_status = 'VACANT'`.
3. Map "low battery" to filter `battery_level < 20`.

# User Input
{{user_query}}

# Output Format (Strict JSON)
{
  "intent": "DATA_QUERY",
  "query": {
    "time_range": "...",
    "dimensions": ["..."],
    "metrics": ["..."],
    "filters": [
      { "field": "...", "operator": "...", "value": "..." }
    ]
  }
}
```

---

## 2. MCP Tool Definitions (接口契约)

本章节定义后端需实现的 MCP 工具接口（JSON Schema）。

### 2.1 房态与入住 (PMS Integration)

**Tool Name**: `get_room_occupancy`
*   **Description**: 获取指定房间当前的入住状态和时间信息。
*   **Input Schema**:
    ```json
    {
      "type": "object",
      "properties": {
        "room_id": { "type": "string", "description": "Room Number, e.g., '301'" }
      },
      "required": ["room_id"]
    }
    ```
*   **Output Schema**:
    ```json
    {
      "room_id": "301",
      "status": "OCCUPIED", // Enum: VACANT, OCCUPIED, DIRTY, OOO (Out of Order)
      "check_in_time": "2025-11-19T14:00:00Z",
      "check_out_time": "2025-11-20T12:00:00Z", // 关键字段：用于判断是否延住
      "guest_count": 2
    }
    ```

**Tool Name**: `get_card_validity`
*   **Description**: 查询特定卡片（或最近一次刷卡卡片）的权限信息。
*   **Input Schema**:
    ```json
    {
      "type": "object",
      "properties": {
        "card_id": { "type": "string", "description": "Card UID from event log" }
      },
      "required": ["card_id"]
    }
    ```
*   **Output Schema**:
    ```json
    {
      "card_type": "GUEST", // Enum: GUEST, STAFF, MASTER
      "valid_from": "2025-11-19T14:00:00Z",
      "valid_to": "2025-11-20T12:00:00Z",
      "is_blacklisted": false
    }
    ```

### 2.2 设备与事件 (Device & Event)

**Tool Name**: `get_device_status`
*   **Description**: 获取设备实时状态。
*   **Output Schema**:
    ```json
    {
      "device_id": "lock_301",
      "online_status": "ONLINE",
      "battery_level": 85,
      "last_heartbeat": "2025-11-20T10:00:00Z",
      "firmware_version": "v2.1.0"
    }
    ```

---

## 3. Evaluation Dataset (评测金标准)

QA 团队需基于此结构构建至少 50 条测试用例（Golden Dataset），用于自动化回归测试。

### 3.1 测试用例结构表 (Excel/CSV)

| Case ID | Category | Input (User Query / Alert Context) | Expected Tool Calls | Expected Keywords / Logic | Pass Criteria |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **TC-001** | Alert Analysis | **Alert**: Access Denied (0x05)<br>**Context**: Room 301, Time 13:00, Checkout 12:00 | `get_room_occupancy`<br>`get_card_validity` | "expired", "late stay", "extend" | 1. 必须调用上述 2 个工具<br>2. 结论必须包含“过期”或“延住” |
| **TC-002** | Alert Analysis | **Alert**: Door Not Closed<br>**Context**: Room 502, Status VACANT | `get_room_occupancy` | "housekeeping", "check door" | 1. 识别为空房<br>2. 建议检查门锁硬件或客房打扫情况 |
| **TC-003** | Data Query | "Show me low battery locks in occupied rooms" | N/A (NL2Query) | `filters`: [`battery < 20`, `room_status = 'OCCUPIED'`] | JSON 解析出的 filter 必须完全匹配 |
| **TC-004** | Data Query | "List offline devices on 5th floor" | N/A (NL2Query) | `filters`: [`status = 'OFFLINE'`, `floor = '5'`] | JSON 解析正确 |
| **TC-005** | SOP Retrieval | "How to change battery for Model X?" | RAG Retrieval | "Model X", "Battery", "Step 1" | 引用来源必须包含《Model X Maintenance Manual》 |

### 3.2 验收标准 (Pass/Fail Criteria)

1.  **工具调用准确率 (Tool Call Accuracy)**: > 95%
    *   *定义*：对于需要查房态的场景，AI 必须发起 `get_room_occupancy` 调用。
2.  **JSON 格式合规率 (Format Compliance)**: 100%
    *   *定义*：输出的 JSON 必须能被后端 Parser 成功解析，无语法错误。
3.  **业务逻辑正确性 (Business Logic)**: > 90% (人工抽检)
    *   *定义*：对于“卡过期”场景，不能瞎说是“门锁坏了”。
4.  **响应延迟 (Latency)**:
    *   告警分析 (Alert Copilot): < 2s (端到端)
    *   数据查询 (Data Query): < 3s

---

## 4. 附录：错误码映射表 (部分)

开发需将此表注入到 Prompt 或 RAG 知识库中。

| Error Code | Description | Potential Business Cause | Potential Technical Cause |
| :--- | :--- | :--- | :--- |
| 0x00 | Success | N/A | N/A |
| 0x05 | Invalid Card / Expired | Guest late stay; Wrong room; Card demagnetized | Clock unsync |
| 0x08 | Battery Low | N/A | Battery depleted |
| 0x12 | Door Not Closed | Door propped open; Latch failure | Sensor malfunction |
