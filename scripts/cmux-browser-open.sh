#!/bin/bash
# Launch difit in the background and open it in a cmux browser pane.
# Restarts the process each time to refresh the diff; reuses the browser surface within the current workspace.
# Usage: cmux-browser-open.sh <project_dir> [difit args...]

PROJECT_DIR="$1"
shift
DIFIT_ARGS=("$@")

# Skip if not a git repository
if ! git -C "$PROJECT_DIR" rev-parse --git-dir &>/dev/null; then
  echo "skipped: not a git repository ($PROJECT_DIR)"
  exit 0
fi

# Assign a per-workspace port derived from the workspace ID
WS_ID="${CMUX_WORKSPACE_ID:-$(cmux current-workspace 2>/dev/null)}"
HASH=$(echo -n "$WS_ID" | cksum | awk '{print $1}')
PORT=$(( (HASH % 1000) + 4000 ))

# Find an existing difit browser surface in the current workspace
WS_REF=$(cmux tree 2>&1 | grep "workspace.*selected" | grep -oE 'workspace:[0-9]+' | head -1)
EXISTING=""
if [[ -n "$WS_REF" ]]; then
  EXISTING=$(cmux tree --workspace "$WS_REF" 2>&1 | grep '\[browser\]' | grep -i "difit" | grep -oE 'surface:[0-9]+' | head -1)
fi

# Stop the old difit process for this workspace
pkill -f "difit.*--port ${PORT}" 2>/dev/null
sleep 0.5

# Start difit
cd "$PROJECT_DIR" || exit 1
difit "${DIFIT_ARGS[@]}" --no-open --keep-alive --port "$PORT" --include-untracked </dev/null &>/dev/null &

# Wait for the server to come up
URL=""
for _ in {1..20}; do
  curl -s "http://localhost:${PORT}" >/dev/null 2>&1 && URL="http://localhost:${PORT}" && break
  sleep 0.3
done

if [[ -z "$URL" ]]; then
  echo "difit failed to start" >&2
  exit 1
fi

# Reuse existing surface (navigate) or create a new one
if [[ -n "$EXISTING" ]]; then
  cmux browser navigate "$URL" --surface "$EXISTING" 2>/dev/null
  echo "difit restarted at $URL (surface: $EXISTING)"
else
  cmux browser open "$URL" 2>/dev/null
  echo "difit started at $URL"
fi
