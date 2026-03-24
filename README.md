# OpenClaw Feishu Multi-Agent Kit

Build a multi-agent OpenClaw setup for Feishu with:

- one visible coordinator bot
- multiple specialist agents behind it
- shared project docs to keep agents aligned
- a practical operating model inspired by BMAD

This repository is not a replacement for OpenClaw. It is a reusable starter kit for people who want to run OpenClaw as a small AI team in Feishu instead of a single all-purpose bot.

## What This Solves

Most OpenClaw multi-agent experiments hit the same problems:

- agents talk over each other
- roles blur together after a few tasks
- execution agents invent rules while coding
- review happens without a shared standard
- chat history becomes the only source of truth

This kit addresses those problems with two layers:

- Runtime layer: OpenClaw + Feishu + multi-workspace + multi-agent routing
- Operating model layer: shared docs, role boundaries, architecture decisions, and story-driven execution

## Who This Is For

This project is a good fit if you want to:

- run OpenClaw in Feishu group chats
- split work across planner, architect, executor, operator, and reviewer roles
- keep one clean public-facing bot while still using multiple internal agents
- reuse a repeatable project structure across deployments

This project is not the best fit if you only need:

- a single personal assistant bot
- free-form multi-bot roleplay with no engineering discipline
- a desktop automation framework by itself

## Core Idea

Start with one visible bot, not five.

The recommended deployment is:

- `main` is the only default speaker in Feishu
- `architect`, `research`, `executor`, `operator`, and `reviewer` work behind the scenes
- shared project documents define the rules before multiple agents start executing

Once that is stable, you can expose selected specialist bots such as `executor` and `reviewer`.

## Roles

| Role | Purpose |
| --- | --- |
| `main` | Coordinator, dispatcher, summarizer, final reply |
| `architect` | Architecture, boundaries, ADRs, conflict prevention |
| `research` | Research, documentation, option comparison |
| `executor` | Code, config, deployment, CLI work |
| `operator` | Browser, UI, desktop, visible interaction flows |
| `reviewer` | Validation, code review, regression, risk checks |

## Architecture

### Phase 1

Recommended first deployment:

- one visible Feishu bot: `main`
- internal-only workers: `architect`, `research`, `executor`, `operator`, `reviewer`
- explicit dispatch
- `maxPingPongTurns = 0`

### Phase 2

Optional upgrade after Phase 1 is stable:

- visible `main`
- visible `executor`
- visible `reviewer`
- `architect`, `research`, and `operator` remain internal

This keeps the group readable while still allowing specialized visible roles when needed.

## BMAD-Inspired Layer

This repo borrows the most useful parts of BMAD without trying to copy its whole runtime model.

What is reused:

- role discipline
- staged project flow
- architecture-first conflict prevention
- ADRs for high-impact decisions
- story-based execution and review

What is not reused:

- BMAD installer
- IDE-centric command system
- party-mode as the main runtime

OpenClaw stays the runtime and channel layer. BMAD contributes the operating model.

More detail: [docs/BMAD_TO_OPENCLAW.md](docs/BMAD_TO_OPENCLAW.md)

## Repository Layout

```text
.
├── config/
│   ├── phase-1-single-visible-main.json5
│   └── phase-2-main-executor-reviewer.json5
├── docs/
│   └── BMAD_TO_OPENCLAW.md
├── project-docs/
│   ├── README.md
│   └── templates/
│       ├── PROJECT_CONTEXT.template.md
│       ├── PRD.template.md
│       ├── ARCHITECTURE.template.md
│       ├── adr/
│       ├── epics/
│       └── stories/
├── protocols/
│   └── FEISHU_GROUP_PROTOCOL.md
└── workspaces/
    ├── architect/
    ├── common/
    ├── executor/
    ├── main/
    ├── operator/
    ├── research/
    └── reviewer/
```

## Suggested Target Layout

On the target machine, a practical layout looks like this:

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
  workspace/
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

## Quick Start

### 1. Prepare OpenClaw and Feishu

Make sure you already have:

- a working OpenClaw gateway
- a working Feishu channel
- one bot identity that can receive and send messages

### 2. Apply Phase 1

Merge the relevant parts of:

- `config/phase-1-single-visible-main.json5`

into your existing `~/.openclaw/openclaw.json`.

Do not overwrite your whole file. Only merge the relevant blocks such as:

- `agents`
- `bindings`
- `session.agentToAgent`
- `channels.feishu`

### 3. Create role workspaces

Copy the role templates under `workspaces/` into your OpenClaw installation.

Each role should have its own:

- `AGENTS.md`
- `SOUL.md`
- `IDENTITY.md`
- `USER.md`
- `MEMORY.md`
- `memory/`

Never share the same `workspace` or `agentDir` between roles.

### 4. Initialize shared project docs

Copy the templates from `project-docs/templates/` into:

- `~/.openclaw/project-docs/PROJECT_CONTEXT.md`
- `~/.openclaw/project-docs/PRD.md`
- `~/.openclaw/project-docs/ARCHITECTURE.md`
- `~/.openclaw/project-docs/adr/`
- `~/.openclaw/project-docs/epics/`
- `~/.openclaw/project-docs/stories/`

At minimum, fill out:

- `PROJECT_CONTEXT.md`
- `ARCHITECTURE.md`

before asking multiple agents to collaborate on real execution.

### 5. Test the coordinator path

In Feishu:

- mention `main`
- ask for a simple task
- confirm the route is correct
- then ask for a task that requires delegation

### 6. Upgrade to Phase 2 if needed

Only after Phase 1 is stable, add more visible bot identities and merge:

- `config/phase-2-main-executor-reviewer.json5`

## Shared Docs Chain

The shared docs chain is the most important non-runtime part of this repository:

1. `PROJECT_CONTEXT.md`
2. `PRD.md`
3. `ARCHITECTURE.md`
4. `adr/ADR-xxxx-*.md`
5. `epics/EPIC-*.md`
6. `stories/STORY-*.md`

Why it matters:

- `PROJECT_CONTEXT.md` keeps all roles on the same baseline
- `PRD.md` defines what should be built
- `ARCHITECTURE.md` defines how it should be built
- `ADR` records high-impact decisions
- `story` gives execution and review a shared unit of work

## Feishu Group Rules

The group protocol is intentionally strict:

- humans normally talk to `main`
- workers do not free-chat with each other
- final answers come from `main`
- specialist bots should require mention
- agent-to-agent ping-pong should be disabled

See: [protocols/FEISHU_GROUP_PROTOCOL.md](protocols/FEISHU_GROUP_PROTOCOL.md)

## Design Principles

- Routing and identity are different problems
- One stable coordinator is better than many noisy visible bots
- Internal collaboration should come before visible multi-bot theatrics
- Shared docs beat hidden chat memory
- High-conflict decisions belong in ADRs
- Every role needs its own workspace and `agentDir`

## Current Scope

This repository currently provides:

- config skeletons
- role workspace templates
- shared project doc templates
- a Feishu group protocol
- a BMAD-to-OpenClaw operating model

This repository does not yet provide:

- a one-click installer
- automated patch/merge scripts for `openclaw.json`
- a complete deployment script for a fresh VM

## Recommended Next Steps

If you want to turn this into a more complete public project, the next most valuable additions are:

1. A safe config merge script for `openclaw.json`
2. A bootstrap script that creates role workspaces and `project-docs`
3. One real example project under `examples/`
4. Validation commands or smoke tests for Feishu routing

## Related Files

- [docs/BMAD_TO_OPENCLAW.md](docs/BMAD_TO_OPENCLAW.md)
- [project-docs/README.md](project-docs/README.md)
- [protocols/FEISHU_GROUP_PROTOCOL.md](protocols/FEISHU_GROUP_PROTOCOL.md)

## License

No project-specific license file has been added yet. Add one before encouraging broad reuse.
