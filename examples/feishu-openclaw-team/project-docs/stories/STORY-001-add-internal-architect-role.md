# STORY-001: Add Internal Architect Role

## Status

Ready

## Goal

Introduce an internal `architect` role to reduce cross-role conflicts before execution begins.

## Source

- Architecture refs: `ARCHITECTURE.md`
- ADR refs: `ADR-0001-single-visible-coordinator.md`

## Acceptance Criteria

- AC-001: The runtime configuration includes an `architect` agent
- AC-002: The coordinator can delegate to `architect`
- AC-003: The architect workspace contains role instructions and identity files
- AC-004: Shared docs explicitly reference the architect role

## Execution Notes

- Files or services expected to change:
  - `config/phase-1-single-visible-main.json5`
  - `workspaces/architect/*`
  - `README.md`

## Verification Plan

- Check 1: `architect` appears in the config skeleton
- Check 2: README documents the role
- Check 3: workspace files exist for `architect`

## Dev Record

- Changes made:
- Commands run:
- Files touched:

## Review Record

- Findings:
- Residual risks:
- Validation result:

## Next Step

- Add a bootstrap script to create the role on a target machine
