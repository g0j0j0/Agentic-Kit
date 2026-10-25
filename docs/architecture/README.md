# Architecture

> Describe components, data flow and key constraints of Agentic-Kit.

## Session loading
Diagram (Mermaid): [`docs/assets/structure.mmd`](../assets/structure.mmd)

At session start Claude Code reads `CLAUDE.md` (which imports `MEMORY.md`) and discovers `.claude/agents/*.md` and `.claude/skills/*/SKILL.md`.
