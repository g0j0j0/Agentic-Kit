# Agentic-Kit

> Reusable Claude Code skeleton: agents, skills, docs and session memory, loaded automatically at session start.

## Quick start
- Open a Claude Code session here: `CLAUDE.md`, `MEMORY.md`, agents and skills load automatically.
- Scaffold a new repo: `/init-project ~/Projects/my-app [my-app]`
- Scaffold a hardened Ansible project: `/ansible-bootstrap ~/Projects/infra`

## Structure
```
CLAUDE.md          # Session entry point (imports MEMORY.md)
MEMORY.md          # Current state + recent changes
.claude/agents/    # Subagents
.claude/skills/    # Skills (/name); init-project holds the template
docs/              # Documentation by topic
docs/assets/       # Diagrams and media
```

## Documentation
| Topic | Link |
|---|---|
| Architecture | [docs/architecture](docs/architecture/README.md) |
| Agents | [docs/agents](docs/agents/README.md) |
| Skills | [docs/skills](docs/skills/README.md) |
| Guides | [docs/guides](docs/guides/README.md) |
| Changelog | [docs/CHANGELOG.md](docs/CHANGELOG.md) |
