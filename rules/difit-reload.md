---
description: Run difit reload when all file additions, deletions, and edits are complete and waiting for user confirmation
globs: "*"
---

# Mandatory difit reload

When all file changes (additions, deletions, edits) are complete and you are waiting for user confirmation, always run:

```bash
difit-cmux-reload "$(git rev-parse --show-toplevel)" working --clean
```

## Important

- Execute regardless of file type (.md, .txt, .swift, etc.) or change size — no exceptions.
- Do not skip with reasoning like "this isn't implementation" or "minor change".
- Do not execute outside of a git repository.
