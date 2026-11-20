#!/bin/bash
set -euo pipefail

# Only run in Claude Code cloud sessions
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install a skills.sh source globally (~/.agents/skills, symlinked into
# ~/.claude/skills) unless its marker skill is already present.
#   $1 - skills.sh source (owner/repo)
#   $2 - skill directory name used to detect an existing install
install_skills() {
  local source="$1"
  local marker="$2"

  if [ -f "$HOME/.agents/skills/$marker/SKILL.md" ]; then
    echo "$marker skill already installed" >&2
    return 0
  fi

  npx -y skills add "$source" -g -y >&2 || echo "warning: $source skill install failed" >&2

  if [ ! -f "$HOME/.claude/skills/$marker/SKILL.md" ]; then
    echo "warning: $marker skill not linked into ~/.claude/skills" >&2
  fi
}

# Hallmark design skill
install_skills nutlope/hallmark hallmark

# UI UX Pro Max (ui-ux-pro-max plus its companion design skills)
install_skills nextlevelbuilder/ui-ux-pro-max-skill ui-ux-pro-max
