# ARCHITECTURE.md

## Overview

- Objective: Create a stable Feishu-facing OpenClaw team with one public coordinator and internal worker agents
- Scope: Group routing, role separation, shared docs, and execution flow
- Key constraints: Keep the chat readable, prevent agent loops, preserve role boundaries

## System Topology

- Gateway: One OpenClaw gateway process
- Channel: Feishu
- Default visible speaker: `main`
- Internal specialists: `architect`, `research`, `executor`, `operator`, `reviewer`

## Routing Design

- Group chat routes to `main`
- `main` delegates internally
- Optional Phase 2 allows visible `executor` and `reviewer`

## Session Strategy

- Group collaboration is explicit
- `maxPingPongTurns = 0`
- Stories act as work units for execution and review

## Shared Docs Strategy

- `PROJECT_CONTEXT.md` defines shared rules
- `ARCHITECTURE.md` defines implementation boundaries
- ADRs record major design choices
- Stories define concrete execution units

## Risks

- Too many visible bots will reduce chat quality
- Missing shared docs will cause role drift
- Free-form agent chatting will create noisy loops
