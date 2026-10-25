#!/usr/bin/env bash
# Scaffold a hardened Ansible project from the bundled template.
# Usage: ansible-bootstrap.sh <target-dir>
set -euo pipefail

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TARGET="${1:?Usage: ansible-bootstrap.sh <target-dir>}"
mkdir -p "$TARGET" && TARGET="$(cd -P "$TARGET" && pwd -P)"

# Copy template: map "dot-x" to ".x", never overwrite.
cd "$SKILL_DIR/template"
find . -type f | sed 's#^\./##' | sort | while read -r f; do
  rel="$(printf '%s' "$f" | sed -e 's#^dot-#.#' -e 's#/dot-#/.#g')"
  dst="$TARGET/$rel"
  if [ -e "$dst" ]; then echo "skip   $rel"; continue; fi
  mkdir -p "$(dirname "$dst")"
  cp "$f" "$dst"
  echo "create $rel"
done
