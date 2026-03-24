# PROJECT_CONTEXT.md

## Project

- Name: Feishu OpenClaw Team
- Goal: Run OpenClaw in a Feishu group with one visible coordinator and multiple internal specialist agents
- Owner: Example owner
- Main environment: Linux VM
- Primary channel: Feishu group chat

## Runtime

- OpenClaw gateway host: single VM
- Main chat model: provider-defined
- Memory retrieval model: provider-defined
- Main execution machine: Linux VM
- Secondary machines: optional Windows host for browser or desktop control

## Agent Topology

- Visible agents: `main`
- Internal-only agents: `architect`, `research`, `executor`, `operator`, `reviewer`
- Default coordinator: `main`
- Group collaboration mode: explicit dispatch only

## Channel Rules

- Humans normally talk to `main`
- Workers do not talk to each other in the group
- Final answers come from `main`
- Visible specialist bots require direct mention

## Coding and Change Rules

- All roles use shared project docs before significant execution
- Every role has its own workspace and `agentDir`
- High-conflict decisions must be recorded in ADRs
- Execution and review should be tied to stories

## Current Constraints

- Group readability is more important than visible multi-bot theatrics
- Stability is preferred over maximum agent autonomy
