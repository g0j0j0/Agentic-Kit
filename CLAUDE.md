# Agentic-Kit

@MEMORY.md

## Layout
- `.claude/agents/` — subagents, auto-discovered.
- `.claude/skills/` — skills, invocable as `/<name>`.
- `docs/<topic>/` — documentation by topic; diagrams in `docs/assets/`.
- `MEMORY.md` — current state and recent changes (imported above).

## Rules
- Code, comments and docs in English only.
- After each change, update `docs/` and `MEMORY.md` (or delegate to the `doc-keeper` agent).
- Keep `MEMORY.md` short: newest first, one line per entry, archive to `docs/CHANGELOG.md`.

## Agent skills

### Issue tracker

GitHub Issues on `g0j0j0/Agentic-Kit` (via `gh`). See `docs/agents/issue-tracker.md`.

### Triage labels

Default five-role vocabulary (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: root `GLOSSARY.md` + `docs/adr/`. See `docs/agents/domain.md`.
