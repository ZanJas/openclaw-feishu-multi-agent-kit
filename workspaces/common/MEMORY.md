# MEMORY.md

## Stable context

- Main chat model should default to local `localhost/gpt-5.4`
- Memory retrieval uses `nvidia/nv-embed-v1`
- Feishu is the primary collaboration surface for this setup
- Favor incremental rollout: one visible coordinator first, more visible bots later
- Shared engineering truth should live in `~/.openclaw/project-docs`

## Lessons

- Routing isolation and visible bot identity are different problems
- Each agent must have its own workspace and its own `agentDir`
- In group chat, explicit dispatch beats free-form multi-agent chatter
- Cross-role rules should be written into shared docs, not only chat memory
- High-conflict technical decisions should go into ADRs
