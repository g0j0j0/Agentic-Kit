# Memory

<!-- Loaded every session via CLAUDE.md. Keep under ~60 lines.
Entry format: - YYYY-MM-DD [feat|fix|docs|refactor|chore|decision] summary (files)
Newest first. Max 30 recent entries; archive older ones to docs/CHANGELOG.md. -->

## Current state
- Status: v0.1 skeleton ready
- Next: add domain agents/skills as needed

## Decisions
- Template is the single source of truth for generated repos: `.claude/skills/init-project/template/`. Kit root docs add kit-only content (`/init-project`).
- Kit-only skills (`init-project`) and agents (none) are listed in `KIT_ONLY_SKILLS` / `KIT_ONLY_AGENTS` in init-project.sh and never copied to generated repos. `ansible-expert` and `ansible-bootstrap` are copied.

## Recent changes
- 2026-11-20 [feat] ansible-expert aligned with other specialists: repo conventions first, Acceptance criteria, safety, git, report with pre-existing issues (.claude/agents/ansible-expert.md, docs/agents, template docs)
- 2026-11-20 [feat] init-project now also copies ansible-expert and ansible-bootstrap into generated repos; only init-project stays kit-only (init-project.sh, docs/agents, docs/skills, docs/guides, template docs, GLOSSARY.md)
- 2026-11-20 [fix] init-project.sh no longer aborts on macOS when `cp -n` finds an existing agent/skill (.claude/skills/init-project/scripts/init-project.sh)
- 2026-11-16 [docs] Logo replaced by a chibi cat crew in hard hats under a neon AGENTIC-KIT sign (JPEG, 249 KB); sticker SVG removed (docs/assets/logo.jpg, README.md)
- 2026-11-14 [docs] Project logo: pastel chibi calico cat sticker in hard hat and hi-vis vest, hand-written SVG (docs/assets/logo.svg, README.md)
- 2026-11-14 [feat] kubernetes-engineer specialist (manifests, Helm, Kustomize, network policies, GitOps with FluxCD/ArgoCD); devops-engineer keeps Terraform, CI/CD, git (.claude/agents/, docs/agents, init-project template docs)
- 2026-11-14 [fix] ansible-bootstrap.sh expands a leading `~` in the target path (skill passes it quoted) (.claude/skills/ansible-bootstrap/scripts/ansible-bootstrap.sh)
- 2026-11-14 [fix] qa-reviewer: fixed severity rule for not-verifiable criteria (blocking only if an available tool was not run) (.claude/agents/qa-reviewer.md)
- 2026-11-14 [fix] manager asks the Requester when issue-tracker.md is missing; documented subagent permission pre-allow (.claude/agents/manager.md, docs/agents, init-project template docs)
- 2026-11-13 [feat] Workflow agents: manager (main-thread, `claude --agent manager`), devops-engineer, qa-reviewer, security-reviewer; propagated to generated repos (.claude/agents/, docs/agents, init-project template docs, GLOSSARY.md)
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
