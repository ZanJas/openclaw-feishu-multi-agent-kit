# Project Docs

这里放的是所有角色共享的工程文档，不属于某一个 workspace。

推荐在 VM 上落到：

`/home/your-user/.openclaw/project-docs`

## 为什么需要这一层

如果没有共享文档，角色会各自理解需求、各自发明规则，最后就会出现：

- 研究和执行理解不一致
- 执行和审查采用不同标准
- 配置和架构越改越散

共享文档层就是为了让所有角色先读同一套规则，再开始工作。

## 推荐文件链

1. `PROJECT_CONTEXT.md`
2. `PRD.md`
3. `ARCHITECTURE.md`
4. `adr/ADR-xxxx-*.md`
5. `epics/EPIC-*.md`
6. `stories/STORY-*.md`

## 谁负责什么

- `main`
  维护需求收口、任务分派、优先级
- `architect`
  维护架构设计、边界和 ADR
- `research`
  为 PRD 和 architecture 提供输入
- `executor`
  基于 story 执行
- `operator`
  基于 story 做 UI 和桌面操作
- `reviewer`
  基于 story 做审查和验收

## 使用顺序

### 项目启动时

先写：

- `PROJECT_CONTEXT.md`
- `ARCHITECTURE.md`

如果需求还不清楚，再补：

- `PRD.md`

### 单个任务开始前

至少先有：

- 一条 ADR 或 architecture 约束
- 一张 story

### 单个任务结束后

回写：

- story 的执行记录
- 验证结果
- 风险或未完成项

## 模板

模板都在 `templates/` 下。
