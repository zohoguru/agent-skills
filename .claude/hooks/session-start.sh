#!/bin/bash
set -euo pipefail

# Only run in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install the Hallmark design skill globally (~/.agents/skills, symlinked into ~/.claude/skills)
if [ -f "$HOME/.agents/skills/hallmark/SKILL.md" ]; then
  echo "hallmark skill already installed" >&2
  exit 0
fi

npx -y skills add nutlope/hallmark -g -y >&2 || echo "warning: hallmark skill install failed" >&2

if [ ! -f "$HOME/.claude/skills/hallmark/SKILL.md" ]; then
  echo "warning: hallmark skill not linked into ~/.claude/skills" >&2
fi
