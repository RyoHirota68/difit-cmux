---
description: Run difit reload when all file additions, deletions, and edits are complete and waiting for user confirmation
globs: "*"
---

# Mandatory difit reload

When all file changes (additions, deletions, edits) are complete and you are waiting for user confirmation, always run:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/cmux-browser-open.sh" <project_dir> working --clean
```

Replace `<project_dir>` with the output of `git rev-parse --show-toplevel`.

## Important

- Execute regardless of file type (.md, .txt, .swift, etc.) or change size — no exceptions.
- Do not skip with reasoning like "this isn't implementation" or "minor change".
- Do not execute outside of a git repository.
