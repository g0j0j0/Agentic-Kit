# Agents

Subagents live in `.claude/agents/<name>.md` (frontmatter: `name`, `description`, `tools`, `model`).

| Agent | Purpose |
|---|---|
| `doc-keeper` | Syncs `docs/` and `MEMORY.md` after each change. |
| `ansible-expert` | Writes, reviews and tests Ansible (FQCN, idempotence, role layout, `requirements.yml`, yamllint/ansible-lint, syntax-check, Molecule). Model `sonnet`; tools `Read, Edit, Write, Glob, Grep, Bash`. Preloads the `ansible-bootstrap` skill for new projects. Tooling via `uv`. Kit-only. |

Kit-only agents are listed in `KIT_ONLY_AGENTS` in `.claude/skills/init-project/scripts/init-project.sh` and not copied to generated repos.
