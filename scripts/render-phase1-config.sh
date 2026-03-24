#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE="$REPO_ROOT/config/phase-1-single-visible-main.json5"

TARGET_ROOT="${HOME}/.openclaw"
GROUP_ID="oc_TEAM_GROUP_ID"
OWNER_OPEN_ID="ou_OWNER_OPEN_ID"
APP_ID="cli_your_main_app_id"
APP_SECRET="your_main_app_secret"
BOT_NAME="OpenClaw 总控"
OUTPUT=""

usage() {
  cat <<'EOF'
Usage:
  render-phase1-config.sh [options]

Options:
  --target-root PATH      Target OpenClaw root. Default: ~/.openclaw
  --group-id ID           Feishu group id
  --owner-open-id ID      Feishu owner open id
  --app-id ID             Feishu app id for main
  --app-secret SECRET     Feishu app secret for main
  --bot-name NAME         Visible bot name. Default: OpenClaw 总控
  --output FILE           Write rendered config to file instead of stdout
  -h, --help              Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target-root)
      TARGET_ROOT="$2"
      shift 2
      ;;
    --group-id)
      GROUP_ID="$2"
      shift 2
      ;;
    --owner-open-id)
      OWNER_OPEN_ID="$2"
      shift 2
      ;;
    --app-id)
      APP_ID="$2"
      shift 2
      ;;
    --app-secret)
      APP_SECRET="$2"
      shift 2
      ;;
    --bot-name)
      BOT_NAME="$2"
      shift 2
      ;;
    --output)
      OUTPUT="$2"
      shift 2
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

escaped_root="$(printf '%s' "$TARGET_ROOT" | sed 's/[\/&]/\\&/g')"
escaped_group_id="$(printf '%s' "$GROUP_ID" | sed 's/[\/&]/\\&/g')"
escaped_owner_open_id="$(printf '%s' "$OWNER_OPEN_ID" | sed 's/[\/&]/\\&/g')"
escaped_app_id="$(printf '%s' "$APP_ID" | sed 's/[\/&]/\\&/g')"
escaped_app_secret="$(printf '%s' "$APP_SECRET" | sed 's/[\/&]/\\&/g')"
escaped_bot_name="$(printf '%s' "$BOT_NAME" | sed 's/[\/&]/\\&/g')"

rendered="$(
  sed \
    -e "s#/home/your-user/.openclaw#${escaped_root}#g" \
    -e "s#oc_TEAM_GROUP_ID#${escaped_group_id}#g" \
    -e "s#ou_OWNER_OPEN_ID#${escaped_owner_open_id}#g" \
    -e "s#cli_your_main_app_id#${escaped_app_id}#g" \
    -e "s#your_main_app_secret#${escaped_app_secret}#g" \
    -e "s#OpenClaw 总控#${escaped_bot_name}#g" \
    "$TEMPLATE"
)"

if [[ -n "$OUTPUT" ]]; then
  mkdir -p "$(dirname "$OUTPUT")"
  printf '%s\n' "$rendered" > "$OUTPUT"
  echo "Wrote $OUTPUT"
else
  printf '%s\n' "$rendered"
fi
