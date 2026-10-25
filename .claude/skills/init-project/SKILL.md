---
name: init-project
description: Scaffold a new repository with the Agentic-Kit structure (CLAUDE.md, MEMORY.md, .claude/agents, .claude/skills, docs/). Use when the user asks to initialize or bootstrap a new project.
argument-hint: <target-dir> [project-name]
disable-model-invocation: true
---

# init-project

Scaffold a project at `$0` (name `$1`, defaults to the directory name).

1. If no target directory is given, ask for it.
2. Run: `bash "${CLAUDE_SKILL_DIR}/scripts/init-project.sh" $ARGUMENTS`
3. If the user described the project, fill the description in `README.md` and `docs/architecture/README.md`.
4. Report created and skipped files. Never overwrite existing files.
