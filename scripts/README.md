# Scripts

These scripts are meant to reduce manual setup work when applying the kit to a real OpenClaw installation.

## Available Scripts

### `bootstrap-openclaw-feishu-team.sh`

Creates the target directory layout under `~/.openclaw` or a custom target root, including:

- role workspaces
- agent directories
- shared project docs directories
- starter files copied from this repository

By default, it is safe:

- existing files are not overwritten
- existing directories are reused

Use `--force` if you want to overwrite files that already exist.

### `render-phase1-config.sh`

Renders `config/phase-1-single-visible-main.json5` for a specific machine by replacing generic placeholders such as the target OpenClaw root path.

It can also fill in common Feishu placeholders:

- group id
- owner open id
- app id
- app secret

## Recommended Flow

1. Run `bootstrap-openclaw-feishu-team.sh`
2. Edit the generated docs under `project-docs/`
3. Run `render-phase1-config.sh`
4. Merge the rendered config into `~/.openclaw/openclaw.json`

Recommended invocation style:

```bash
bash ./scripts/bootstrap-openclaw-feishu-team.sh --target-root "$HOME/.openclaw"
bash ./scripts/render-phase1-config.sh --target-root "$HOME/.openclaw"
```
