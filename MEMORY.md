# Memory

<!-- Loaded every session via CLAUDE.md. Keep under ~60 lines.
Entry format: - YYYY-MM-DD [feat|fix|docs|refactor|chore|decision] summary (files)
Newest first. Max 30 recent entries; archive older ones to docs/changelog.md. -->

## Current state
- Status: v0.1 skeleton ready
- Next: add domain agents/skills as needed

## Decisions
- Template is the single source of truth for generated repos: `.claude/skills/init-project/template/`. Kit root docs add kit-only content (`/init-project`).
- `init-project` is kit-only: the script copies agents and all other skills, never itself.

## Recent changes
- 2026-10-25 [feat] init-project no longer propagates itself or its docs to generated repos (.claude/skills/init-project/, docs/skills/README.md)
- 2026-10-25 [docs] Added /init-project usage screenshots (docs/skills/README.md, docs/assets/skills/)
- 2026-10-24 [feat] Initial skeleton, doc-keeper agent, /init-project skill (all)
