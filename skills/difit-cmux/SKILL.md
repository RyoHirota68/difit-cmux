---
name: difit-cmux
description: Launch difit in a cmux browser pane. Use this instead of the built-in difit/difit-review skills when running inside cmux. Triggers on diff review, code review, "show me the diff", "review changes", etc.
allowed-tools: Bash
---

# difit-cmux

Launch difit in the background and display it in a cmux browser pane.
If difit is already running, the browser surface is reused — no extra panes are created.

## Dynamic context

- git root: !`git rev-parse --show-toplevel 2>/dev/null`

## Steps

1. Determine the project directory (git root above) and difit arguments.
2. Run:

```bash
bash ~/.claude/scripts/cmux-browser-open.sh <project_dir> [difit-args...]
```

- If `$ARGUMENTS` is empty, default to `working --clean`.
- For reviews with `--comment`, follow the comment JSON format from the official difit-review skill.

## Examples

```bash
bash ~/.claude/scripts/cmux-browser-open.sh <project_dir> working --clean
bash ~/.claude/scripts/cmux-browser-open.sh <project_dir> working --clean --comment '{"type":"thread","filePath":"src/foo.swift","position":{"side":"new","line":10},"body":"Needs fix"}'
```
