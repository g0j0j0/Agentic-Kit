# Memory

<!-- Loaded every session via CLAUDE.md. Keep under ~60 lines.
Entry format: - YYYY-MM-DD [feat|fix|docs|refactor|chore|decision] summary (files)
Newest first. Max 30 recent entries; archive older ones to docs/CHANGELOG.md. -->

## Current state
- Status: v0.1 skeleton ready
- Next: add domain agents/skills as needed
- Next: /ansible-bootstrap: SKILL.md quotes "$0" so `~` is not expanded

## Decisions
- Template is the single source of truth for generated repos: `.claude/skills/init-project/template/`. Kit root docs add kit-only content (`/init-project`).
- Kit-only skills (`init-project`, `ansible-bootstrap`) and agents (`ansible-expert`) are listed in `KIT_ONLY_SKILLS` / `KIT_ONLY_AGENTS` in init-project.sh and never copied to generated repos.

## Recent changes
- 2026-11-13 [docs] Added GLOSSARY.md (Kit, Template, Generated repo, Kit-only, Skill, Agent, Memory, Changelog, Agent skills config)
- 2026-11-13 [docs] /setup-matt-pocock-skills config: GitHub issues, default triage labels, single-context domain docs (CLAUDE.md, docs/agents/)
- 2026-11-04 [docs] Guide: install ansible-expert + /ansible-bootstrap at user level via symlinks (docs/guides/README.md)
- 2026-11-03 [feat] ansible-expert agent (sonnet, preloads /ansible-bootstrap, uv tooling), kit-only via KIT_ONLY_AGENTS (.claude/agents/ansible-expert.md, init-project.sh, docs/agents, docs/skills)
- 2026-10-30 [docs] Renamed docs/changelog.md to docs/CHANGELOG.md (kit + init-project template)
- 2026-10-26 [fix] ansible-bootstrap: check mode skips tasks needing pending packages (common, firewall, fail2ban); convention + troubleshooting row in SKILL.md
- 2026-10-26 [fix] ansible-bootstrap users role: check mode skips tasks for accounts/groups not created yet (template/roles/users/tasks/main.yml)
- 2026-10-26 [feat] ansible-bootstrap: host pre-flight, troubleshooting table, sudo-rs hint, resolute platform, ssh.socket port handler (.claude/skills/ansible-bootstrap/, docs/skills/README.md)
- 2026-10-26 [fix] ansible-bootstrap template: lint offline, skip encrypted vault.yml, ignore .ansible/ (template/dot-ansible-lint, template/dot-gitignore)
- 2026-10-25 [feat] /ansible-bootstrap skill: hardened Ansible template (SSH, firewall, fail2ban, users), kit-only (.claude/skills/ansible-bootstrap/, init-project.sh, docs/skills/README.md)
- 2026-10-25 [feat] init-project no longer propagates itself or its docs to generated repos (.claude/skills/init-project/, docs/skills/README.md)
- 2026-10-25 [docs] Added /init-project usage screenshots (docs/skills/README.md, docs/assets/skills/)
- 2026-10-24 [feat] Initial skeleton, doc-keeper agent, /init-project skill (all)
