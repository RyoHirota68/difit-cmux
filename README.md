# difit-cmux

Auto-reload [difit](https://github.com/nicolo-ribaudo/difit) (Git diff viewer) in a [cmux](https://cmux.dev) browser pane after every implementation change.

## Features

- Launches difit in the background and opens it in a cmux browser pane
- Reuses the existing browser surface — no extra panes are created
- Isolates ports per workspace so multiple workspaces don't conflict
- Automatically reloads the diff when implementation is complete

## Prerequisites

- [cmux](https://cmux.dev)
- [difit](https://github.com/nicolo-ribaudo/difit) (`npm install -g difit`)
- [Claude Code](https://claude.ai/code)

## Why manual setup?

Rules may not load correctly when distributed as a Claude Code plugin. To ensure reliable behavior, this project uses manual file placement under `~/.claude/` instead.

## Setup

1. Save `cmux-browser-open.sh` to `~/.claude/scripts/` and make it executable:

```bash
mkdir -p ~/.claude/scripts
cp scripts/cmux-browser-open.sh ~/.claude/scripts/
chmod +x ~/.claude/scripts/cmux-browser-open.sh
```

2. Save `SKILL.md` to `~/.claude/skills/difit-cmux/`:

```bash
mkdir -p ~/.claude/skills/difit-cmux
cp skills/difit-cmux/SKILL.md ~/.claude/skills/difit-cmux/
```

3. Save `difit-reload.md` to `~/.claude/rules/`:

```bash
mkdir -p ~/.claude/rules
cp rules/difit-reload.md ~/.claude/rules/
```

## File overview

| File | Destination | Role |
|------|-------------|------|
| `scripts/cmux-browser-open.sh` | `~/.claude/scripts/` | Launch/restart difit and manage cmux browser surface |
| `skills/difit-cmux/SKILL.md` | `~/.claude/skills/difit-cmux/` | Skill definition for `/difit-cmux` and natural language triggers |
| `rules/difit-reload.md` | `~/.claude/rules/` | Rule that auto-reloads difit after implementation changes |

## How it works

1. **Skill (`/difit-cmux`)** — Invoke manually via slash command or triggered automatically by natural language like "review changes" or "show me the diff".
2. **Rule (`difit-reload.md`)** — Instructs Claude to run the reload script automatically after all file changes are complete, before waiting for user confirmation.
3. **Script (`cmux-browser-open.sh`)** — Manages the difit process and cmux browser surface. Restarts difit to refresh the diff and reuses the browser surface within the current workspace.

## License

MIT
