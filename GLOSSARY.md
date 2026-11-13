# Agentic-Kit

A reusable Claude Code skeleton (agents, skills, docs, session memory) that scaffolds new repos and ships a few kit-only tools.

## Language

**Kit**:
This repository, Agentic-Kit: the source of the Template and of the Kit-only skills and agents.
_Avoid_: Skeleton repo, boilerplate

**Template**:
The directory `.claude/skills/init-project/template/`, the single source of truth for what a Generated repo contains.
_Avoid_: Scaffold, starter

**Generated repo**:
A repository produced from the Template by `/init-project`.
_Avoid_: Child repo, new project

**Kit-only**:
Describes a skill or agent that is never copied to a Generated repo, as set by `KIT_ONLY_SKILLS` / `KIT_ONLY_AGENTS`. Using one elsewhere is a separate, deliberate user-level install.
_Avoid_: Internal, private

**Skill**:
A `/<name>` playbook in `.claude/skills/`. A skill never owns an Agent.
_Avoid_: Command, macro

**Agent**:
A delegated subagent defined in `.claude/agents/`. An Agent may preload Skills.
_Avoid_: Bot, worker

**Memory**:
`MEMORY.md`: the short, newest-first record of current state and recent changes.
_Avoid_: Notes, log

**Changelog**:
`docs/CHANGELOG.md`: the archive of entries moved out of Memory.
_Avoid_: History, archive file

**Agent skills config**:
The per-repo files in `docs/agents/` (`issue-tracker.md`, `triage-labels.md`, `domain.md`) that engineering skills read. Not Agent definitions.
_Avoid_: Agent docs
