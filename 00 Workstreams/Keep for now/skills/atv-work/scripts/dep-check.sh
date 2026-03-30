#!/usr/bin/env bash
# dep-check.sh — Check for unmerged dependency branches before execution.
#
# Usage: dep-check.sh <TICKET_KEY> <DEFAULT_BRANCH> <EPIC_KEY>
#
# Exits 0 with no output if all deps are merged or none exist.
# Exits 0 with JSON array on stdout when unmerged deps are found.
# Exits 1 on usage error.
#
# Output format (one JSON object per unmerged dep):
#   [{"blocker":"JMT-53","branch":"atv/jmt-53"}]

set -euo pipefail

TICKET_KEY="${1:?Usage: dep-check.sh <TICKET_KEY> <DEFAULT_BRANCH> <EPIC_KEY>}"
DEFAULT_BRANCH="${2:?Usage: dep-check.sh <TICKET_KEY> <DEFAULT_BRANCH> <EPIC_KEY>}"
EPIC_KEY="${3:-}"

if [ -z "$EPIC_KEY" ]; then
  exit 0
fi

DEP_GRAPH=$(atv dep graph --epic "$EPIC_KEY" 2>/dev/null || echo '{}')

BLOCKED_BY=$(echo "$DEP_GRAPH" | jq -r --arg KEY "$TICKET_KEY" \
  '.nodes[]? | select(.key == $KEY) | .blockedBy[]?' 2>/dev/null || true)

if [ -z "$BLOCKED_BY" ]; then
  exit 0
fi

UNMERGED=()
for BLOCKER in $BLOCKED_BY; do
  BLOCKER_BRANCH="atv/$(echo "$BLOCKER" | tr '[:upper:]' '[:lower:]')"
  if git rev-parse "$BLOCKER_BRANCH" >/dev/null 2>&1; then
    MERGED=$(git branch --merged "$DEFAULT_BRANCH" | grep -F "$BLOCKER_BRANCH" || true)
    if [ -z "$MERGED" ]; then
      UNMERGED+=("{\"blocker\":\"$BLOCKER\",\"branch\":\"$BLOCKER_BRANCH\"}")
    fi
  fi
done

if [ ${#UNMERGED[@]} -eq 0 ]; then
  exit 0
fi

printf '[%s]\n' "$(IFS=,; echo "${UNMERGED[*]}")"
