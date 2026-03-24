# OpenClaw Feishu Multi-Agent Kit

这是一套给你当前环境准备的飞书多角色骨架，目标不是一次性做成 5 个 bot 满天飞，而是先做稳。

它分成两层：

- 运行时层：OpenClaw + Feishu + 多 workspace + 多 agent
- 方法层：吸收 BMAD 最适合你的部分，用共享文档链和角色分工减少多 agent 打架

适用前提：

- 现有 OpenClaw Gateway 已跑通
- 飞书通道已可收发消息
- 默认聊天模型继续使用你本地的 `localhost/gpt-5.4`
- 记忆检索继续使用 `nvidia/nv-embed-v1`

## 推荐落地顺序

### Phase 1

一个可见 bot，多个内部 agent。

- 飞书群里只有 `main` 对外说话
- `architect / research / executor / operator / reviewer` 只在内部协作
- 这是最稳的版本，先把任务拆解和协作跑通

### Phase 2

三个可见 bot。

- `main`
- `executor`
- `reviewer`

`architect`、`research` 和 `operator` 继续做内部角色，不建议一开始也放进群里。

## 这套包里有什么

- `config/phase-1-single-visible-main.json5`
- `config/phase-2-main-executor-reviewer.json5`
- `protocols/FEISHU_GROUP_PROTOCOL.md`
- `workspaces/` 下六个角色的模板文件
- `project-docs/` 下 BMAD 风格的共享文档模板
- `docs/BMAD_TO_OPENCLAW.md`

## 你在目标机器上建议的目录布局

```text
/home/your-user/.openclaw/
  openclaw.json
  project-docs/
    PROJECT_CONTEXT.md
    PRD.md
    ARCHITECTURE.md
    adr/
    epics/
    stories/
  workspace/                  # 保留你当前 main 的工作区
  workspaces/
    architect/
    research/
    executor/
    operator/
    reviewer/
  agents/
    main/agent/
    architect/agent/
    research/agent/
    executor/agent/
    operator/agent/
    reviewer/agent/
```

说明：

- `main` 继续沿用你当前的 `/home/your-user/.openclaw/workspace`
- 新角色用独立 workspace
- `agentDir` 绝对不要共用
- 共享工程文档放到 `/home/your-user/.openclaw/project-docs`

## 实施步骤

### 1. 先做 Phase 1

把 `config/phase-1-single-visible-main.json5` 里的相关块合并到你当前的 `~/.openclaw/openclaw.json`。

重点只动这些区域：

- `agents`
- `bindings`
- `session.agentToAgent`
- `channels.feishu`

不要把你现有的：

- `models`
- `gateway`
- `plugins`
- `memorySearch`

整段覆盖掉。

### 2. 创建新角色工作区

把 `workspaces/architect`、`research`、`executor`、`operator`、`reviewer` 下的模板文件拷到 VM 对应目录。

每个 workspace 至少要有：

- `AGENTS.md`
- `SOUL.md`
- `IDENTITY.md`
- `USER.md`
- `MEMORY.md`
- `memory/`

`USER.md` 和 `MEMORY.md` 可以先用 `workspaces/common/` 下的模板。

### 3. 初始化共享文档链

把 `project-docs/templates/` 下的模板拷到：

- `/home/your-user/.openclaw/project-docs/PROJECT_CONTEXT.md`
- `/home/your-user/.openclaw/project-docs/PRD.md`
- `/home/your-user/.openclaw/project-docs/ARCHITECTURE.md`
- `/home/your-user/.openclaw/project-docs/adr/`
- `/home/your-user/.openclaw/project-docs/epics/`
- `/home/your-user/.openclaw/project-docs/stories/`

建议至少先写完：

- `PROJECT_CONTEXT.md`
- `ARCHITECTURE.md`

这是让多角色不打架的关键。

### 4. 先只让 main 对外

在飞书群里只保留一个 bot 身份：

- 人只 `@main`
- `main` 内部派工
- `main` 汇总结论

### 5. 跑稳后再做 Phase 2

给 `executor` 和 `reviewer` 各自再申请一个飞书应用和 bot 身份，然后合并 `config/phase-2-main-executor-reviewer.json5` 的账号和绑定思路。

## 群聊行为规则

先看这里：

- `protocols/FEISHU_GROUP_PROTOCOL.md`

这份协议是整套多角色能不能稳住的关键。

核心只有几条：

- 人默认只 `@main`
- worker 只接 main 的派单，或者只在被直接 `@` 时发言
- worker 不互相聊天
- 结案只由 `main` 发 `[FINAL]`
- `maxPingPongTurns = 0`

## BMAD 风格的共享文档链

这里借的是 BMAD 的精华，不是整套运行时。

推荐链路：

1. `PROJECT_CONTEXT.md`
2. `PRD.md`
3. `ARCHITECTURE.md`
4. `adr/ADR-xxxx-*.md`
5. `epics/*.md`
6. `stories/STORY-*.md`
7. 执行和审查记录写回 story

作用：

- `PROJECT_CONTEXT.md`
  约束全局规则，减少角色各自发明规范
- `PRD.md`
  约束目标和边界
- `ARCHITECTURE.md`
  约束实现方式
- `ADR`
  固化关键取舍，避免角色分叉
- `story`
  让执行和审查围绕同一张任务卡工作

## 你当前环境的建议映射

- `main`
  继续用你当前的飞书 bot 和现有 workspace
- `architect`
  负责架构方案、边界、ADR、跨角色一致性
- `executor`
  负责代码、命令、部署、VM、配置修改
- `operator`
  负责浏览器、桌面、页面点选、前台 UI 自动化
- `reviewer`
  负责测试、验收、风险扫描
- `research`
  负责资料、文档、方案收敛

## 关键原则

- 路由和身份是两回事
- 多角色不等于多 bot 自由群聊
- 能内部协作就不要先做外部群聊演出
- 每个角色独立 workspace
- 每个角色独立 `agentDir`
- 每个角色共享同一套 `project-docs`
- 先稳，再花

## 上线检查清单

- `openclaw agents list --bindings`
- `openclaw gateway status`
- `openclaw logs --follow`
- 飞书群只允许目标群 `chat_id`
- 飞书群先开启 `requireMention: true`
- 群成员 sender allowlist 先只放你自己
- 发一次 `@main` 简单任务，确认路由正常
- 发一次需要派工的任务，确认 main 会调用子角色

## 可见多 bot 的现实代价

如果你要让多个角色在同一个飞书群里显示成不同身份，需要：

- 一个角色一个飞书应用
- 一个应用一个 `accountId`
- 一个 `accountId` 一个对应 `agentId`

只换 prompt，不会自动变成不同可见身份。

## 下一步

如果你决定开始实装，建议先按下面顺序：

1. 备份当前 `openclaw.json`
2. 上 Phase 1
3. 创建五个新 workspace
4. 初始化 `project-docs`
5. 测试内部派工
6. 再上 Phase 2 的可见 bot
