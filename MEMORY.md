# Memory

<!-- Loaded every session via CLAUDE.md. Keep under ~60 lines.
Entry format: - YYYY-MM-DD [feat|fix|docs|refactor|chore|decision] summary (files)
Newest first. Max 30 recent entries; archive older ones to docs/changelog.md. -->

## Current state
- Status: v0.1 skeleton ready
- Next: add domain agents/skills as needed
- Next: /ansible-bootstrap: SKILL.md quotes "$0" so `~` is not expanded

## Decisions
- Template is the single source of truth for generated repos: `.claude/skills/init-project/template/`. Kit root docs add kit-only content (`/init-project`).
- Kit-only skills (`init-project`, `ansible-bootstrap`) are listed in `KIT_ONLY_SKILLS` in init-project.sh and never copied to generated repos.

## Recent changes
- 2026-10-26 [fix] ansible-bootstrap: check mode skips tasks needing pending packages (common, firewall, fail2ban); convention + troubleshooting row in SKILL.md
- 2026-10-26 [fix] ansible-bootstrap users role: check mode skips tasks for accounts/groups not created yet (template/roles/users/tasks/main.yml)
- 2026-10-26 [feat] ansible-bootstrap: host pre-flight, troubleshooting table, sudo-rs hint, resolute platform, ssh.socket port handler (.claude/skills/ansible-bootstrap/, docs/skills/README.md)
- 2026-10-26 [fix] ansible-bootstrap template: lint offline, skip encrypted vault.yml, ignore .ansible/ (template/dot-ansible-lint, template/dot-gitignore)
- 2026-10-25 [feat] /ansible-bootstrap skill: hardened Ansible template (SSH, firewall, fail2ban, users), kit-only (.claude/skills/ansible-bootstrap/, init-project.sh, docs/skills/README.md)
- 2026-10-25 [feat] init-project no longer propagates itself or its docs to generated repos (.claude/skills/init-project/, docs/skills/README.md)
- 2026-10-25 [docs] Added /init-project usage screenshots (docs/skills/README.md, docs/assets/skills/)
- 2026-10-24 [feat] Initial skeleton, doc-keeper agent, /init-project skill (all)
