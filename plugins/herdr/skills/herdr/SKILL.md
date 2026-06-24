---
name: herdr
description: >-
  Drive Herdr, the terminal workspace manager for AI coding agents, from the
  command line. Manage persistent sessions, workspaces, git worktrees, tabs, and
  panes, and orchestrate agent terminals (start, send input, read output, wait on
  status) over Herdr's socket API. Use when working inside a Herdr session or
  scripting agent orchestration with the `herdr` CLI.
---

# Herdr

`herdr` is a terminal workspace manager for AI coding agents (https://herdr.dev).
A headless server owns the persistent state (sessions, workspaces, tabs, panes,
agents) and the `herdr` CLI talks to it over a Unix socket. Use this skill to
inspect and control that state — especially to **orchestrate multiple agent
terminals**: start an agent, send it input, read what it printed, and block until
it goes idle.

## Orientation first

Before issuing API commands, confirm the server is reachable. Socket subcommands
(`workspace`, `worktree`, `tab`, `agent`, `pane`, `wait`, `notification`) require
a **running server** — they fail if one isn't up.

```bash
herdr --version            # CLI version
herdr status --json        # client + server status; check server.running == true
```

If `server.running` is `false`, the user must launch a session first (`herdr`, or
`herdr --session <name>`). Don't try to start the server yourself unless asked —
launching the app is an interactive action the user owns.

Most read subcommands accept `--json`; prefer it when parsing output
programmatically.

## Command surface (herdr 0.7.0, protocol 14)

Run any command with `--help` to see exact flags. The full surface:

### Sessions — persistent named workspaces
```bash
herdr                          # launch or attach to the default session
herdr --session <name>         # use/create a named session
herdr session list [--json]
herdr session attach <name>
herdr session stop <name> [--json]      # use 'default' to target the default session
herdr session delete <name> [--json]
```

### Workspaces
```bash
herdr workspace list
herdr workspace create [--cwd PATH] [--label TEXT] [--env KEY=VALUE] [--focus|--no-focus]
herdr workspace get <workspace_id>
herdr workspace focus <workspace_id>
herdr workspace rename <workspace_id> <label>
herdr workspace close <workspace_id>
```

### Git worktrees
```bash
herdr worktree list [--workspace ID | --cwd PATH] [--json]
herdr worktree create [--workspace ID | --cwd PATH] [--branch NAME] [--base REF] [--path PATH] [--label TEXT] [--focus|--no-focus] [--json]
herdr worktree open [--workspace ID | --cwd PATH] (--path PATH | --branch NAME) [--label TEXT] [--focus|--no-focus] [--json]
herdr worktree remove --workspace ID [--force] [--json]
```

### Tabs
```bash
herdr tab list [--workspace <workspace_id>]
herdr tab create [--workspace <workspace_id>] [--cwd PATH] [--label TEXT] [--env KEY=VALUE] [--focus|--no-focus]
herdr tab get <tab_id>
herdr tab focus <tab_id>
herdr tab rename <tab_id> <label>
herdr tab close <tab_id>
```

### Agents — the orchestration core
A "target" accepts terminal ids, unique agent names, detected/reported agent
labels, and legacy pane ids.
```bash
herdr agent list
herdr agent get <target>
herdr agent read <target> [--source visible|recent|recent-unwrapped] [--lines N] [--format text|ansi] [--ansi]
herdr agent send <target> <text>        # writes LITERAL text (no Enter); use `pane run` for command+Enter
herdr agent rename <target> <name>|--clear
herdr agent focus <target>
herdr agent wait <target> --status <idle|working|blocked|unknown> [--timeout MS]
herdr agent attach <target> [--takeover]
herdr agent start <name> [--cwd PATH] [--workspace ID] [--tab ID] [--split right|down] [--env KEY=VALUE] [--focus|--no-focus] -- <argv...>
herdr agent explain <target> [--json]
herdr agent explain --file PATH --agent LABEL [--json]
```

### Panes — fine-grained terminal layout control
```bash
herdr pane list [--workspace <workspace_id>]
herdr pane current [--pane ID|--current]
herdr pane get <pane_id>
herdr pane layout|process-info|edges [--pane ID|--current]
herdr pane neighbor --direction left|right|up|down [--pane ID|--current]
herdr pane focus  --direction left|right|up|down [--pane ID|--current]
herdr pane resize --direction left|right|up|down [--amount FLOAT] [--pane ID|--current]
herdr pane zoom [<pane_id>|--pane ID|--current] [--toggle|--on|--off]
herdr pane rename <pane_id> <label>|--clear
herdr pane read <pane_id> [--source visible|recent|recent-unwrapped] [--lines N] [--format text|ansi]
herdr pane split [<pane_id>|--current] --direction right|down [--ratio FLOAT] [--cwd PATH] [--env KEY=VALUE] [--focus|--no-focus]
herdr pane swap --direction left|right|up|down [--pane ID|--current]
herdr pane swap --source-pane ID --target-pane ID
herdr pane move <pane_id> --tab <tab_id> --split right|down [--target-pane ID] [--ratio FLOAT] [--focus|--no-focus]
herdr pane move <pane_id> --new-tab|--new-workspace [...]
herdr pane close <pane_id>
herdr pane send-text <pane_id> <text>          # literal text
herdr pane send-keys <pane_id> <key> [key ...] # key names
herdr pane run <pane_id> <command>             # command text + Enter
```
(`pane report-agent`, `report-agent-session`, `release-agent`, `report-metadata`
exist for integrations reporting agent state — rarely needed by hand.)

### Blocking waits
```bash
herdr wait output <pane_id> --match <text> [--source visible|recent|recent-unwrapped] [--lines N] [--timeout MS] [--regex] [--raw]
herdr wait agent-status <pane_id> --status <idle|working|blocked|done|unknown> [--timeout MS]
```

### Notifications, integrations, config, channel
```bash
herdr notification show <title> [--body TEXT] [--position top-left|top-right|bottom-left|bottom-right] [--sound none|done|request]

herdr integration status [--outdated-only]
herdr integration install   <pi|omp|claude|codex|copilot|devin|droid|kimi|opencode|kilo|hermes|qodercli|cursor>
herdr integration uninstall  <same set>

herdr config reset-keys                 # back up config.toml, remove custom keybindings
herdr channel show
herdr channel set <stable|preview>

herdr server stop
herdr server reload-config              # reload config.toml in the running server
herdr update [--handoff]                # download & install latest
```

## Orchestration recipe

The common multi-agent loop — start an agent, hand it a task, wait for it to
finish, read the result:

```bash
# 1. Start a Claude agent in a new split, capture its id from the output
herdr agent start claude --split right --no-focus -- --help

# 2. Send it a task (literal text, then press Enter via send-keys, OR use pane run)
herdr agent send <target> "summarize the changes in this repo"
herdr pane send-keys <pane_id> Enter

# 3. Block until it goes idle (with a timeout so you never hang forever)
herdr agent wait <target> --status idle --timeout 600000

# 4. Read what it produced
herdr agent read <target> --source recent --lines 100
```

Notes:
- `agent send` writes **literal text without a trailing Enter**. To submit a
  command in one shot use `pane run <pane_id> <command>` (text + Enter), or follow
  `send` with `pane send-keys <pane_id> Enter`.
- Always pass `--timeout` (milliseconds) to `wait`/`agent wait` so a stuck agent
  can't block your script indefinitely.
- Use `--no-focus` when scripting so spawning agents doesn't steal the user's
  focus.
- Prefer `--json` on read/list commands and parse ids rather than scraping
  human-readable output.

## Reference
- Home: https://herdr.dev
- Config: `~/.config/herdr/config.toml` (override with `HERDR_CONFIG_PATH`)
- Logs: `~/.config/herdr/herdr.log` (plus `herdr-client.log`, `herdr-server.log`)
- Socket: `~/.config/herdr/herdr.sock`
