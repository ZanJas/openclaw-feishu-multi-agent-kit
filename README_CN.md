# OpenClaw Feishu Multi-Agent Kit

一个面向 OpenClaw + 飞书的多角色协作 starter kit，目标是把“一个 bot 什么都做”升级成“一个协调者 + 多个专职角色”的稳定协作模式。

它提供两层能力：

- 运行时层：OpenClaw、Feishu、多 workspace、多 agent 路由
- 方法层：吸收 BMAD 的高价值部分，用共享文档链、架构约束和 story 驱动执行减少多 agent 冲突

英文说明见：[README.md](README.md)

## 适合谁

适合这些场景：

- 想在飞书群里跑 OpenClaw
- 想让 OpenClaw 以小团队方式协作，而不是只有一个全能 bot
- 想把规划、架构、执行、审查拆成不同角色
- 想把群聊里的任务沉淀成可持续执行的工程资产

不太适合这些场景：

- 只需要一个简单的个人助理 bot
- 只想做自由聊天式多 bot 角色扮演
- 只需要桌面自动化本身，不需要多角色工程协作

## 核心思路

先做一个可见 bot，而不是一开始就做很多 bot。

推荐落地方式：

- `main` 是唯一默认对外发言者
- `architect`、`research`、`executor`、`operator`、`reviewer` 在内部协作
- 共享文档先定义规则，再让多个 agent 执行

稳定后，再考虑把 `executor` 和 `reviewer` 做成可见 bot。

## 角色

| 角色 | 职责 |
| --- | --- |
| `main` | 统筹、派工、汇总、最终答复 |
| `architect` | 架构、边界、ADR、冲突治理 |
| `research` | 资料、文档、方案对比 |
| `executor` | 代码、配置、部署、命令执行 |
| `operator` | 浏览器、UI、桌面、前台交互 |
| `reviewer` | 验证、审查、回归、风险检查 |

## 架构阶段

### Phase 1

推荐的第一版：

- 一个可见 Feishu bot：`main`
- 内部角色：`architect`、`research`、`executor`、`operator`、`reviewer`
- 显式派工
- `maxPingPongTurns = 0`

### Phase 2

稳定后再升级：

- 可见 `main`
- 可见 `executor`
- 可见 `reviewer`
- `architect`、`research`、`operator` 继续保持内部角色

## 共享文档链

这是整套方案里最关键的非运行时部分：

1. `PROJECT_CONTEXT.md`
2. `PRD.md`
3. `ARCHITECTURE.md`
4. `adr/ADR-xxxx-*.md`
5. `epics/EPIC-*.md`
6. `stories/STORY-*.md`

作用：

- `PROJECT_CONTEXT.md`
  让所有角色先站在同一套规则上
- `PRD.md`
  定义做什么
- `ARCHITECTURE.md`
  定义怎么做
- `ADR`
  固化关键取舍
- `story`
  让执行和审查围绕同一张任务卡工作

## 仓库结构

```text
.
├── config/
├── docs/
├── examples/
├── project-docs/
├── protocols/
├── workspaces/
├── README.md
├── README_CN.md
└── LICENSE
```

## 快速开始

1. 准备好 OpenClaw gateway 和 Feishu 通道
2. 合并 `config/phase-1-single-visible-main.json5` 到你的 `openclaw.json`
3. 为每个角色创建独立 workspace 和 `agentDir`
4. 用 `project-docs/templates/` 初始化共享文档
5. 在飞书群里先只让 `main` 对外
6. 跑稳以后，再升级到 `phase-2`

## 公开项目下一步建议

如果你打算继续把这个仓库打磨成公共项目，最值得继续补的是：

1. 配置合并脚本
2. 初始化脚本
3. `examples/` 下的完整示例
4. Feishu 路由和角色协作的 smoke test

## 相关文档

- [README.md](README.md)
- [docs/BMAD_TO_OPENCLAW.md](docs/BMAD_TO_OPENCLAW.md)
- [project-docs/README.md](project-docs/README.md)
- [protocols/FEISHU_GROUP_PROTOCOL.md](protocols/FEISHU_GROUP_PROTOCOL.md)
