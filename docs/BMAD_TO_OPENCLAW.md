# BMAD to OpenClaw Mapping

这份文档说明这套仓库借了 BMAD 什么，以及为什么没有直接把 BMAD 当成运行时。

## 核心判断

BMAD 很强，但它更像：

- 开发方法论
- IDE/CLI 技能体系
- 结构化软件交付流程

它不是：

- Feishu 多 bot 运行时
- OpenClaw Gateway 替代品
- 桌面控制和浏览器控制框架

所以这里采用的策略是：

- 保留 OpenClaw 做运行时和渠道层
- 借 BMAD 做角色、文档链、阶段流和冲突治理

## 角色映射

| BMAD | 本仓库 |
| --- | --- |
| PM / Master | `main` |
| Architect | `architect` |
| Analyst | `research` |
| Developer | `executor` |
| QA | `reviewer` |
| UX / Operator-like execution | `operator` |

## 工作流映射

| BMAD 阶段 | 本仓库做法 |
| --- | --- |
| Analysis | `research` 产出调研与问题定义 |
| Planning | `main` + `research` 产出 `PRD.md` |
| Solutioning | `architect` 产出 `ARCHITECTURE.md` 和 ADR |
| Implementation | `executor` / `operator` 按 story 执行 |
| Review | `reviewer` 回写 findings 和验收结论 |

## 为什么这对你有用

你现在的问题不是“没有多 agent”。
你现在真正的问题是：

- 多角色开始协作后，怎么不串台
- 多角色怎么围绕同一套规则干活
- 同一个需求，怎么不被不同角色做成不同风格
- 怎么把飞书群里的讨论变成可继续执行的工程资产

BMAD 最值得借的正是这部分。

## 这套仓库借了哪些 BMAD 思路

### 1. 共享工程上下文

通过 `project-docs/PROJECT_CONTEXT.md` 把这些内容写死：

- 技术栈
- 路由和身份规则
- 命名约定
- 安全边界
- 测试策略
- 运维约束

### 2. 架构先行

通过 `project-docs/ARCHITECTURE.md` 和 `project-docs/adr/` 固化：

- Agent 拓扑
- Feishu 路由方式
- OpenClaw bindings 设计
- session / memory / tools 边界
- 为什么这么选

### 3. Story 驱动执行

不是让执行角色“收到一句话就开工”，而是让它围绕 `stories/STORY-*.md` 工作。

story 至少要有：

- 目标
- 约束
- 接受标准
- 影响文件或服务
- 验证方式

### 4. 审查回写

`reviewer` 不只是说“行不行”，而是把结果写回 story：

- findings
- residual risk
- verification

## 明确不照搬的部分

这里没有直接照搬 BMAD 的：

- 安装器
- 全量 skill 体系
- 以 IDE 为中心的触发命令
- 单会话 party mode 机制

原因很简单：你的主战场不是 IDE，而是：

- OpenClaw runtime
- Feishu 群聊
- VM / 本地机
- 桌面和浏览器操作

## 推荐实践

### 先做

- `main` + 内部角色
- `PROJECT_CONTEXT.md`
- `ARCHITECTURE.md`
- 最少 1 条 ADR
- story 模板化

### 后做

- 多可见 bot 同群发言
- 更复杂的心跳和自动巡检
- 角色自发协作

## 一句话总结

BMAD 适合当你的“工程操作系统”，
OpenClaw 适合当你的“运行时和渠道底座”。

把两者叠起来，才是最适合你现在路线的方案。
