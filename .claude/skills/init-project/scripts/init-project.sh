#!/usr/bin/env bash
# Scaffold a project with the Agentic-Kit structure.
# Usage: init-project.sh <target-dir> [project-name]
set -euo pipefail

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
SRC_CLAUDE="$(cd -P "$SKILL_DIR/../.." && pwd -P)"   # .claude/ of the source kit
TARGET="${1:?Usage: init-project.sh <target-dir> [project-name]}"
mkdir -p "$TARGET" && TARGET="$(cd -P "$TARGET" && pwd -P)"
NAME="${2:-$(basename "$TARGET")}"
DATE="$(date +%F)"

# 1. Render template: strip ".tmpl", map "dot-x" to ".x", never overwrite.
cd "$SKILL_DIR/template"
find . -type f -name '*.tmpl' | sed 's#^\./##' | while read -r f; do
  rel="$(printf '%s' "$f" | sed -e 's#\.tmpl$##' -e 's#^dot-#.#' -e 's#/dot-#/.#g')"
  dst="$TARGET/$rel"
  if [ -e "$dst" ]; then echo "skip   $rel"; continue; fi
  mkdir -p "$(dirname "$dst")"
  sed -e "s|{{PROJECT_NAME}}|$NAME|g" -e "s|{{DATE}}|$DATE|g" "$f" > "$dst"
  echo "create $rel"
done

# 2. Propagate agents and skills (incl. this one) so the new repo can scaffold others.
if [ "$SRC_CLAUDE" != "$TARGET/.claude" ]; then
  mkdir -p "$TARGET/.claude"
  cp -Rn "$SRC_CLAUDE/agents" "$SRC_CLAUDE/skills" "$TARGET/.claude/"
  echo "copy   .claude/agents .claude/skills"
fi

# 3. Initialize git.
if [ ! -d "$TARGET/.git" ]; then git -C "$TARGET" init -q && echo "git    init"; fi
