# Feishu Group Protocol

这份协议是给 `main / research / executor / operator / reviewer` 共用的群聊协作规则。

## 目标

让多个角色在同一个飞书群里协作时：

- 不抢话
- 不串任务
- 不互相客套刷屏
- 不把最终结论搞丢

## 角色分工

- `main`
  唯一默认发言者。负责接任务、拆任务、派工、汇总、结案。
- `research`
  只做资料和方案，不直接结案。
- `executor`
  只做代码、命令、配置、部署。
- `operator`
  只做浏览器、桌面、页面交互、UI 操作。
- `reviewer`
  只做测试、审查、风险检查、验收。

## 发言总规则

- 未被直接点名时，worker 默认不发言。
- `main` 是唯一可以主动汇总和结案的角色。
- worker 不与 worker 互相聊天。
- worker 如果需要别的角色协助，向 `main` 回报，不直接越级派单。
- 一个任务最多同时激活 2 到 3 个 worker。

## 推荐消息格式

### 用户给 main

```text
@main 帮我把 OpenClaw 飞书多角色方案落地
```

### main 派工

```text
@executor [TASK:T20260324-001][TYPE:EXECUTE][FROM:main]
目标：评估配置改动点并准备落地步骤

@reviewer [TASK:T20260324-001][TYPE:REVIEW][FROM:main]
目标：检查环路、权限和路由风险
```

### worker 回报

```text
[TASK:T20260324-001][DONE][ROLE:executor]
结果：已完成配置评估，建议先做单可见 bot 版本

[TASK:T20260324-001][RISK][ROLE:reviewer]
发现：如果多个 bot 同群同时开放非 mention 响应，会出现抢话风险
```

### main 结案

```text
[TASK:T20260324-001][FINAL]
结论：先做 Phase 1，再升级 Phase 2
```

## 群内触发规则

- 人默认只 `@main`
- `main` 可以不 `@` 也响应，前提是这个群只服务主控场景
- 其他可见 worker 必须被 `@` 才响应
- 所有群先保持 `requireMention: true`

## 反死循环规则

- `session.agentToAgent.maxPingPongTurns = 0`
- worker 不回应别的 worker 的自然语言消息
- worker 只处理：
  - `main` 的明确派单
  - 用户直接 `@` 自己的请求
- 不发送无意义确认，如“收到”“好的”“感谢配合”

## 长任务汇报规则

- 不要每一步都播报
- 只在这些节点发消息：
  - 开始执行
  - 发现阻塞
  - 发现关键风险
  - 完成

## 对外说话规则

- 群里的最终答案、总计划、统一解释，默认由 `main` 输出
- worker 的输出尽量是片段结果，不要抢最终结论

## 失败处理

如果 worker 无法完成任务，统一用下面格式：

```text
[TASK:T20260324-001][BLOCKED][ROLE:operator]
原因：目标页面未加载完成，当前无法继续点击
下一步：需要 main 决定是否重试或切换到手工处理
```
