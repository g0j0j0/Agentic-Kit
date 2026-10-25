---
name: ansible-bootstrap
description: Scaffold a hardened Ansible project for Debian/Ubuntu and RHEL/Rocky/Alma servers - roles for base packages and automatic security updates, an admin user with SSH keys, hardened sshd (no root, no passwords, strict file permissions), default-deny firewall (ufw/firewalld) and fail2ban, plus ansible.cfg, inventory, vault and lint config. Use whenever the user wants to start an Ansible repo, bootstrap or provision servers/VPS with Ansible, or asks for a secure baseline playbook (firewall, SSH hardening, sudo user), even if they don't say "bootstrap".
argument-hint: <target-dir>
---

# ansible-bootstrap

Scaffold a vetted Ansible project at `$0`, then tailor it to the user's servers.
The template is the source of truth: adjust variables, don't rewrite roles unless the user asks.

## Steps
1. If no target directory is given, ask for it.
2. Run: `bash "${CLAUDE_SKILL_DIR}/scripts/ansible-bootstrap.sh" "$0"`. It never overwrites existing files; report what it created and skipped.
3. Fill from what the user said (ask only for what is missing and needed):
   - `inventories/production/hosts.yml`: hosts and `ansible_host`.
   - `inventories/production/group_vars/all/main.yml`: `admin_user`, `admin_authorized_keys` (public keys only), `ssh_port`, `firewall_allowed_ports`, `common_timezone`.
   Never write a private key, password or plaintext secret into the repo. Secrets go in `group_vars/all/vault.yml`, encrypted with `ansible-vault` (see `vault.yml.example`).
4. Pre-flight each host the user can already reach over SSH, read-only, so host vars match reality instead of the template's assumptions:
   `ssh -o BatchMode=yes <user>@<host> 'grep -E "^(ID|VERSION_ID)=" /etc/os-release; sudo --version | head -1; systemctl is-enabled ssh.socket'`
   - `sudo-rs` → set `ansible_become_exe: sudo.ws` on that host (see Troubleshooting).
   - Unsupported OS family or version → tell the user before going further.
   - `Permission denied (publickey...)` → the user logs in with a password today; tell them to `ssh-copy-id` first, since the `ssh` role disables passwords.
   Skip the step if the host isn't reachable yet; mention the checks in the hand-off instead.
5. If `ansible-playbook` / `ansible-lint` are installed, run from the project dir:
   `ansible-galaxy collection install -r requirements.yml`, `ansible-playbook playbooks/site.yml --syntax-check`, `ansible-lint`. Fix findings; report anything not run.
6. Tell the user the run order from the project README (first run as the provider's initial user, then as `admin_user`). Do not run against real hosts unless asked.

## Conventions when editing roles
Hardening SSH and enabling a firewall on a remote box can cut off the only way in. The template guards against it; keep these guards when editing:
- `users` runs before `ssh`: the admin user and its key exist before root login and passwords are disabled, and `ssh` asserts `admin_authorized_keys` is non-empty.
- sshd config is validated (`sshd -t`) before it is written, and reloaded, not restarted, so the current session survives.
- The firewall allows `ssh_port` before default-deny is enabled. On RHEL a non-default `ssh_port` is also labeled for SELinux.
- If the user changes `ssh_port`, the new port must be reachable before the next connection; mention updating `ansible_port`.
- Keep `--check` usable on a fresh host: check mode creates nothing, so a task that needs something an earlier task only *would* create (package → service/binary, user, group, directory) gets `when: not (ansible_check_mode and <that_result> is changed)`. Register Debian/RedHat variants under distinct names, because skipped tasks register too. New roles follow the same rule.
- On socket-activated sshd (Ubuntu 22.10+), the port lives in `ssh.socket`. The `ssh` role restarts it in a handler, so the port moves at play end, like a reload.

## Troubleshooting
Known failures on real hosts. Fix them in inventory/host vars, not by weakening the roles.

| Symptom | Cause | Fix |
|---|---|---|
| `Timeout (12s) waiting for privilege escalation prompt` right after SSH connects | Ubuntu 26.04+ uses `sudo-rs`, which prints `[sudo: <prompt>] Password:`; Ansible only matches lines starting with its prompt | `ansible_become_exe: sudo.ws` for that host (classic sudo, installed alongside). Not in `ansible.cfg`: other distros have no `sudo.ws` |
| `Attempting to decrypt but no vault secrets found` | `vault.yml` is encrypted and the run got no vault password | Add `--ask-vault-pass` (`-J`) or a git-ignored `vault_password_file` |
| `ansible-lint`: `yaml[document-start]` on `vault.yml` | Encrypted file isn't YAML | Already excluded in `.ansible-lint`; restore the exclusion if it was removed |
| New `ssh_port` not listening on Ubuntu | Socket activation: the port comes from `ssh.socket`, not the sshd reload | The `ssh` role handles it; on hand-edited hosts run `systemctl daemon-reload && systemctl restart ssh.socket` |
| `--check` only: `Could not find the requested service`, `Group ... does not exist`, `Destination ... does not exist`, `Unable to change directory` | The earlier task that would create it is only simulated | Guard the dependent task (see Conventions); a real run is unaffected |
| `Permission denied (publickey)` after the first run | Password login is now off, and the user isn't in `ssh_allow_group` or has no key | Connect as `admin_user`; add other accounts to `ssh_allow_group` with a key |

## Security choices (explain if the user questions them)
- `PermitRootLogin no`, `PasswordAuthentication no`, `KbdInteractiveAuthentication no`, `AllowGroups` restricts SSH to `ssh_allow_group`. The drop-in is `00-hardening.conf` because sshd uses the first value it reads, so it wins over cloud-init's `50-cloud-init.conf`.
- Ciphers and KEX are left to the distro (OpenSSH defaults, RHEL crypto-policies); pinning lists tends to rot.
- sudo requires a password by default (`admin_password_hash` from vault). `admin_sudo_nopasswd: true` exists for automation-only hosts; call out the trade-off.
- `host_key_checking` stays on. Never suggest disabling it; tell the user to add host keys to `known_hosts` instead.
- Automatic security updates are on (unattended-upgrades / dnf-automatic, security only).

## Out of scope
Application roles, Molecule tests, CIS benchmark coverage, and non-Debian/RHEL distros. Suggest them as follow-ups rather than adding them unasked.
