#!/usr/bin/env bash
# Claude Code hook script: toggles a green bullet in tmux when user action is needed.
# Usage: tmux-indicator.sh on|off

set -euo pipefail

ACTION="${1:-}"

# Bail out if not inside tmux
if [ -z "${TMUX:-}" ] || [ -z "${TMUX_PANE:-}" ]; then
  exit 0
fi

# Use TMUX_PANE to target the window where Claude is running,
# not the currently active window.
WINDOW_ID=$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')

case "$ACTION" in
  on)
    tmux set -w -t "$WINDOW_ID" @claude_waiting 1 2>/dev/null || true
    ;;
  off)
    tmux set -wu -t "$WINDOW_ID" @claude_waiting 2>/dev/null || true
    ;;
  *)
    echo "Usage: $0 on|off" >&2
    exit 1
    ;;
esac
