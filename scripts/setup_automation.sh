#!/bin/bash
# Jarvis automation for Codex.

set -euo pipefail

echo ""
echo "=== Research Jarvis: Codex Automation Setup ==="
echo ""

CODEX_BIN=$(command -v codex 2>/dev/null || true)
if [ -z "$CODEX_BIN" ]; then
  echo "Error: 'codex' CLI not found in PATH."
  exit 1
fi
echo "Found codex CLI at: $CODEX_BIN"

read -r -p "What time should the digest run daily? (e.g. 08:00, default 08:00): " RUN_TIME
RUN_TIME=${RUN_TIME:-08:00}
HOUR=$(printf "%s" "$RUN_TIME" | cut -d: -f1)
MINUTE=$(printf "%s" "$RUN_TIME" | cut -d: -f2)

read -r -p "Path to your papers folder (press Enter to skip): " PAPERS_FOLDER
PAPERS_FOLDER=${PAPERS_FOLDER:-""}

DATA_DIR="$HOME/.codex/jarvis"
DIGEST_DIR="$DATA_DIR/digests"
PROFILE_FILE="$DATA_DIR/profile.md"

mkdir -p "$DIGEST_DIR"
echo "Digests will be saved to: $DIGEST_DIR"

if [ ! -f "$PROFILE_FILE" ]; then
  echo ""
  echo "Error: No profile found at $PROFILE_FILE"
  echo "Run the skill manually once first to complete setup, for example:"
  echo "  codex --search -C \$HOME 'Use \$jarvis to build my research profile and produce today\\''s digest.'"
  exit 1
fi
echo "Profile found at: $PROFILE_FILE"

PROMPT="Use \$jarvis. Load my profile from ~/.codex/jarvis/profile.md and config from ~/.codex/jarvis/config.md. Generate today\\''s research digest and save it to ~/.codex/jarvis/digests/\$(date +%Y-%m-%d).md."

if [ -n "$PAPERS_FOLDER" ]; then
  PROMPT="$PROMPT My papers are in $PAPERS_FOLDER."
fi

CMD="$CODEX_BIN exec --search --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox -C \$HOME"
if [ -n "$PAPERS_FOLDER" ]; then
  CMD="$CMD --add-dir \"$PAPERS_FOLDER\""
fi
CMD="$CMD \"$PROMPT\" >> \"$DIGEST_DIR/cron-jarvis.log\" 2>&1"

EXISTING=$(crontab -l 2>/dev/null | grep "jarvis" || true)
if [ -n "$EXISTING" ]; then
  echo ""
  echo "Existing jarvis cron job found:"
  echo "  $EXISTING"
  read -r -p "Replace it? (y/n, default y): " REPLACE
  REPLACE=${REPLACE:-y}
  if [ "$REPLACE" != "y" ]; then
    echo "Skipping cron setup. Existing job kept."
    exit 0
  fi
  crontab -l 2>/dev/null | grep -v "jarvis" | crontab -
fi

(crontab -l 2>/dev/null; echo "# jarvis daily digest"; echo "$MINUTE $HOUR * * * $CMD") | crontab -

echo ""
echo "=== Setup complete ==="
echo "Runs daily at:      $RUN_TIME"
echo "Digest directory:   $DIGEST_DIR"
echo "Cron log:           $DIGEST_DIR/cron-jarvis.log"
echo ""
echo "Review the installed cron job with:"
echo "  crontab -l"
echo ""
echo "Remove it with:"
echo "  crontab -l | grep -v jarvis | crontab -"
