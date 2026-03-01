#!/bin/bash
# WorkOS SessionStart hook — injects environment and project context into every session.

# Find .workos/ by walking up from cwd
find_workos() {
  local dir="$PWD"
  while [ "$dir" != "/" ]; do
    if [ -d "$dir/.workos" ]; then
      echo "$dir/.workos"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

WORKOS_DIR=$(find_workos)

# === TRACK 1: ENVIRONMENT MEMORY ===

if [ -z "$WORKOS_DIR" ]; then
  cat <<'EOF'
=== WORKOS ===
WorkOS is not set up in this workspace.
1. Create the directory structure and config (see workos-memory skill for bootstrapping steps)
2. Explore repos and populate environment memory (see workos-bootstrap skill)
=== END WORKOS ===
EOF
  exit 0
fi

echo "=== WORKOS: ENVIRONMENT ==="

# Config
if [ -f "$WORKOS_DIR/config.yaml" ]; then
  echo ""
  echo "Config ($WORKOS_DIR/config.yaml):"
  cat "$WORKOS_DIR/config.yaml"
else
  echo ""
  echo "No config.yaml found. Ask the user about their repos, team, and tools to create one."
fi

# Environment memory
ENV_MEMORY="$WORKOS_DIR/environment/memory.md"
if [ -f "$ENV_MEMORY" ]; then
  # Check if it's just the empty template (only comments, no real content)
  CONTENT_LINES=$(grep -v '^\s*$' "$ENV_MEMORY" | grep -v '^\s*#' | grep -v -e '<!--' -e '-->' | wc -l | tr -d ' ')
  if [ "$CONTENT_LINES" -lt 3 ]; then
    echo ""
    echo "Environment memory exists but is mostly empty. Offer to run the bootstrap workflow (see workos-bootstrap skill) to populate it from the user's repos."
  else
    echo ""
    echo "Environment Memory ($ENV_MEMORY):"
    cat "$ENV_MEMORY"
  fi
else
  echo ""
  echo "No environment memory found. Offer to run the bootstrap workflow."
fi

echo ""
echo "=== END ENVIRONMENT ==="
