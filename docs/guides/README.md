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
Both are kit-only, so install them at user level (run from the kit root):
```bash
mkdir -p ~/.claude/agents
ln -s "$PWD/.claude/agents/ansible-expert.md" ~/.claude/agents/ansible-expert.md
ln -s "$PWD/.claude/skills/ansible-bootstrap" ~/.claude/skills/ansible-bootstrap
```
- Symlinks keep kit updates in sync; use `cp -R` for a frozen copy. Install both: the agent preloads the skill by name.
- In the kit itself, the project copies take precedence over the user ones.
- In the other repo, start a new session, check `/agents` lists `ansible-expert` (User), then ask for it by name ("use the ansible-expert agent to review roles/…"). Use `/ansible-bootstrap <dir>` only to scaffold a new Ansible project.

## Add an agent or skill
Create the file, then list it in `docs/agents/` or `docs/skills/`.
