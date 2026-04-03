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

## Installation

```bash
claude plugin marketplace add RyoHirota68/difit-cmux
claude plugin install difit-cmux
```

## How it works

1. **Skill (`/difit-cmux`)** — Invoke manually via slash command or triggered automatically by natural language like "review changes" or "show me the diff".
2. **Rule (`difit-reload.md`)** — Instructs Claude to run the reload script automatically after all file changes are complete, before waiting for user confirmation.
3. **Script (`cmux-browser-open.sh`)** — Manages the difit process and cmux browser surface. Restarts difit to refresh the diff and reuses the browser surface within the current workspace.

## File overview

| File | Role |
|------|------|
| `scripts/cmux-browser-open.sh` | Launch/restart difit and manage cmux browser surface |
| `skills/difit-cmux/SKILL.md` | Skill definition for `/difit-cmux` and natural language triggers |
| `rules/difit-reload.md` | Rule that auto-reloads difit after implementation changes |

## License

MIT
