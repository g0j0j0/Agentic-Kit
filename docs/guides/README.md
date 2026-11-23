# Guides

## Workflow
1. Open a session: context, agents and skills load automatically.
2. Make a change.
3. Run the `doc-keeper` agent (or update `docs/` and `MEMORY.md` manually).

## Use /init-project from any repo
```bash
ln -s "$PWD/.claude/skills/init-project" ~/.claude/skills/init-project
```

## Use ansible-expert and /ansible-bootstrap from any repo
New repos from `/init-project` already include both. For an existing repo, install them at user level (run from the kit root):
```bash
mkdir -p ~/.claude/agents
ln -s "$PWD/.claude/agents/ansible-expert.md" ~/.claude/agents/ansible-expert.md
ln -s "$PWD/.claude/skills/ansible-bootstrap" ~/.claude/skills/ansible-bootstrap
```
- Symlinks keep kit updates in sync; use `cp -R` for a frozen copy. Install both: the agent preloads the skill by name.
- In the kit itself, the project copies take precedence over the user ones.
- In the other repo, start a new session, check `/agents` lists `ansible-expert` (User), then ask for it by name ("use the ansible-expert agent to review roles/…"). Use `/ansible-bootstrap <dir>` only to scaffold a new Ansible project.

## Install the security-reviewer scanners
`security-reviewer` runs these tools when they are installed: `gitleaks`, `shellcheck`, `trivy`, `checkov`. Without them it falls back to manual review.

| Tool | macOS | Debian/Ubuntu | RHEL/Fedora/Rocky |
|---|---|---|---|
| `checkov` | `uv tool install checkov` | same | same |
| `shellcheck` | `brew install shellcheck` | `apt install shellcheck` | `dnf install ShellCheck` (EPEL on RHEL/Rocky) |
| `gitleaks` | `brew install gitleaks` | release binary (not in default apt) | release binary (not in default dnf) |
| `trivy` | `brew install trivy` | Aqua apt repo, or release binary | Aqua rpm repo, or release binary |

- Release binaries: download the archive for your OS and arch from the project's GitHub releases (`gitleaks/gitleaks`, `aquasecurity/trivy`), verify its checksum, and put the binary in `~/.local/bin` or `/usr/local/bin`.
- Homebrew on Linux also works for all three non-Python tools.
- Check each install page before use; package names and repos change.
- Subagents cannot answer permission prompts: pre-allow these commands in `.claude/settings.json`.
- Verify: `gitleaks version && shellcheck --version && trivy --version && checkov --version`.

## Add an agent or skill
Create the file, then list it in `docs/agents/` or `docs/skills/`.
