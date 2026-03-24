#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_ROOT="${HOME}/.openclaw"
FORCE=0

usage() {
  cat <<'EOF'
Usage:
  bootstrap-openclaw-feishu-team.sh [--target-root PATH] [--force]

Options:
  --target-root PATH   Target OpenClaw root. Default: ~/.openclaw
  --force              Overwrite files if they already exist
  -h, --help           Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root)
      TARGET_ROOT="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

copy_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -f "$dest" && "$FORCE" -ne 1 ]]; then
    echo "SKIP  $dest"
    return 0
  fi

  cp "$src" "$dest"
  echo "WRITE $dest"
}

mkdir_if_missing() {
  local dir="$1"
  mkdir -p "$dir"
  echo "DIR   $dir"
}

ROLE_WORKSPACES=(main architect research executor operator reviewer)
SECONDARY_ROLES=(architect research executor operator reviewer)

mkdir_if_missing "$TARGET_ROOT/project-docs/adr"
mkdir_if_missing "$TARGET_ROOT/project-docs/epics"
mkdir_if_missing "$TARGET_ROOT/project-docs/stories"
mkdir_if_missing "$TARGET_ROOT/agents"
mkdir_if_missing "$TARGET_ROOT/workspaces"
mkdir_if_missing "$TARGET_ROOT/workspace/memory"

for role in "${ROLE_WORKSPACES[@]}"; do
  if [[ "$role" == "main" ]]; then
    mkdir_if_missing "$TARGET_ROOT/agents/main/agent"
  else
    mkdir_if_missing "$TARGET_ROOT/workspaces/$role/memory"
    mkdir_if_missing "$TARGET_ROOT/agents/$role/agent"
  fi
done

copy_file "$REPO_ROOT/workspaces/main/AGENTS.md" "$TARGET_ROOT/workspace/AGENTS.md"
copy_file "$REPO_ROOT/workspaces/main/SOUL.md" "$TARGET_ROOT/workspace/SOUL.md"
copy_file "$REPO_ROOT/workspaces/main/IDENTITY.md" "$TARGET_ROOT/workspace/IDENTITY.md"
copy_file "$REPO_ROOT/workspaces/common/USER.md" "$TARGET_ROOT/workspace/USER.md"
copy_file "$REPO_ROOT/workspaces/common/MEMORY.md" "$TARGET_ROOT/workspace/MEMORY.md"

for role in "${SECONDARY_ROLES[@]}"; do
  copy_file "$REPO_ROOT/workspaces/$role/AGENTS.md" "$TARGET_ROOT/workspaces/$role/AGENTS.md"
  copy_file "$REPO_ROOT/workspaces/$role/SOUL.md" "$TARGET_ROOT/workspaces/$role/SOUL.md"
  copy_file "$REPO_ROOT/workspaces/$role/IDENTITY.md" "$TARGET_ROOT/workspaces/$role/IDENTITY.md"
  copy_file "$REPO_ROOT/workspaces/common/USER.md" "$TARGET_ROOT/workspaces/$role/USER.md"
  copy_file "$REPO_ROOT/workspaces/common/MEMORY.md" "$TARGET_ROOT/workspaces/$role/MEMORY.md"
done

copy_file "$REPO_ROOT/project-docs/templates/PROJECT_CONTEXT.template.md" \
  "$TARGET_ROOT/project-docs/PROJECT_CONTEXT.md"
copy_file "$REPO_ROOT/project-docs/templates/PRD.template.md" \
  "$TARGET_ROOT/project-docs/PRD.md"
copy_file "$REPO_ROOT/project-docs/templates/ARCHITECTURE.template.md" \
  "$TARGET_ROOT/project-docs/ARCHITECTURE.md"
copy_file "$REPO_ROOT/project-docs/templates/adr/ADR-0000-template.md" \
  "$TARGET_ROOT/project-docs/adr/ADR-0000-template.md"
copy_file "$REPO_ROOT/project-docs/templates/epics/EPIC.template.md" \
  "$TARGET_ROOT/project-docs/epics/EPIC.template.md"
copy_file "$REPO_ROOT/project-docs/templates/stories/STORY.template.md" \
  "$TARGET_ROOT/project-docs/stories/STORY.template.md"

echo
echo "Bootstrap complete."
echo
echo "Next steps:"
echo "1. Edit $TARGET_ROOT/project-docs/PROJECT_CONTEXT.md"
echo "2. Edit $TARGET_ROOT/project-docs/ARCHITECTURE.md"
echo "3. Render a machine-specific phase-1 config with:"
echo "   $REPO_ROOT/scripts/render-phase1-config.sh --target-root $TARGET_ROOT"
echo "4. Merge the rendered config into $TARGET_ROOT/openclaw.json"
