# ADR-0001: Use a Single Visible Coordinator in Phase 1

## Status

Accepted

## Context

The system needs to support multiple roles in one Feishu group while keeping the chat readable and avoiding message loops.

## Options Considered

1. One visible coordinator plus internal worker agents
2. Multiple visible bots from the beginning
3. One monolithic all-purpose bot

## Decision

Use one visible coordinator in Phase 1 and keep worker roles internal.

## Rationale

- Simplifies routing and identity alignment
- Reduces message noise in the Feishu group
- Makes failure analysis easier
- Preserves specialist roles without exposing all of them immediately

## Consequences

- Internal orchestration becomes more important
- Public roleplay feel is reduced in Phase 1
- Visible specialist bots can still be added later in Phase 2
