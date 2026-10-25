# Skills

Skills live in `.claude/skills/<name>/SKILL.md` and are invoked as `/<name>`.

| Skill | Usage | Purpose |
|---|---|---|
| `init-project` | `/init-project <dir> [name]` | Scaffolds a repo with this structure. Template: `.claude/skills/init-project/template/` (`*.tmpl`, `dot-` → `.`). Kit-only: not copied into generated repos. |
| `ansible-bootstrap` | `/ansible-bootstrap <dir>` | Scaffolds a hardened Ansible project (Debian/Ubuntu + RHEL 9): `common`, `users`, `ssh`, `firewall`, `fail2ban` roles, vault, lint config. Template: `.claude/skills/ansible-bootstrap/template/` (`dot-` → `.`, never overwrites). Kit-only. |

Kit-only skills are listed in `KIT_ONLY_SKILLS` in `.claude/skills/init-project/scripts/init-project.sh`.

## `/ansible-bootstrap`
- Lockout safety: `users` runs before `ssh` (admin key asserted), sshd config is validated with `sshd -t` and reloaded, SSH is allowed before the firewall goes default-deny. On socket-activated sshd (Ubuntu 22.10+), a handler restarts `ssh.socket` when `ssh_port` changes.
- Pre-flight: before tailoring, the skill checks reachable hosts read-only (OS, `sudo` implementation, `ssh.socket`) and sets host vars, e.g. `ansible_become_exe: sudo.ws` for `sudo-rs` (Ubuntu 26.04+).
- Troubleshooting: `SKILL.md` maps known run errors (become timeout, vault, lint on vault, socket port, lockout) to fixes.
- Evals: `.claude/skills/ansible-bootstrap/evals/` (run with `claude plugin eval .` from the skill directory).
- Generated project usage (first run as the provider's user, then as `admin_user`): see the template `README.md`.

## `/init-project` usage
1. Type `/init-project`: the skill appears in autocomplete with its description.

   ![init-project autocomplete](../assets/skills/init-project-autocomplete.png)

2. Select it, then pass `<target-dir> [project-name]` as shown by the argument hint.

   ![init-project arguments](../assets/skills/init-project-arguments.png)
