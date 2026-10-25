# Ansible baseline

Hardened bootstrap for Debian/Ubuntu and RHEL/Rocky/Alma 9 servers.

| Role | What it does |
|---|---|
| `common` | Base packages, automatic security updates, chrony, timezone, kernel network hardening (sysctl), removes telnet/rsh |
| `users` | Admin user in `sudo`/`wheel` and `ssh_allow_group`, exclusive SSH public keys, sudo with password (optional NOPASSWD) |
| `ssh` | `00-hardening.conf` drop-in: no root login, key-only auth, `AllowGroups`, no forwarding; validated with `sshd -t`; host keys not world-readable |
| `firewall` | Default-deny inbound: ufw (Debian, SSH rate-limited) or firewalld (RedHat); SSH is allowed before deny is enabled |
| `fail2ban` | sshd jail (systemd backend); EPEL on RedHat |

## Setup
```bash
# ansible-core does not support Python 3.15 yet, hence the pin.
uv tool install --python 3.14 --with-executables-from ansible-core ansible-lint
ansible-galaxy collection install -r requirements.yml
cp inventories/production/group_vars/all/vault.yml.example inventories/production/group_vars/all/vault.yml
# set vault_admin_password_hash (mkpasswd -m sha-512), then:
ansible-vault encrypt inventories/production/group_vars/all/vault.yml
```
Edit `inventories/production/hosts.yml` and `group_vars/all/main.yml` (`admin_user`, `admin_authorized_keys`, `ssh_port`, `firewall_allowed_ports`).
Add each host's key to `~/.ssh/known_hosts` (`ssh-keyscan -H <ip>`, then verify the fingerprint with your provider) rather than disabling host key checking.

## Run
```bash
ansible-playbook playbooks/site.yml --syntax-check && ansible-lint

# First run: connect as the provider's initial user (root, ubuntu, rocky, ...).
ansible-playbook playbooks/site.yml -u root --ask-vault-pass --check --diff
ansible-playbook playbooks/site.yml -u root --ask-vault-pass

# Afterwards: root login and passwords are disabled; only admin_user can log in.
ansible-playbook playbooks/site.yml -u deploy --ask-become-pass --ask-vault-pass
```
Before closing the first session, open a second terminal and confirm `ssh deploy@<host>` and `sudo -v` work.

## Notes
- `--check` creates nothing, so on a fresh host tasks that need a not-yet-installed package (service, binary), the new admin user, `ssh_allow_group` or a new directory are skipped; they run on the real run.
- "Timeout waiting for privilege escalation prompt" on Ubuntu 26.04+: `sudo` is `sudo-rs`, which wraps Ansible's prompt. Set `ansible_become_exe: sudo.ws` (classic sudo, installed alongside) for that host.
- Ubuntu 22.10+ listens through `ssh.socket`: the `ssh` role restarts it (with daemon-reload) when `ssh_port` changes, since reloading sshd alone keeps the old port.
- Changing `ssh_port` takes effect on reload: set `ansible_port` to the new value for later runs.
- The initial user (e.g. `ubuntu`) is not in `ssh_allow_group` and loses SSH access after the first run.
- Debian images without `sudo`: the first run as root needs `-e ansible_become=false` until `common` installs it.
