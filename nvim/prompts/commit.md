---
name: Better Commit
interaction: chat
description: Generate a Better commit message
opts:
  alias: better_commit
  auto_submit: true
  is_slash_cmd: false
---

## user

Analyze the git diff below and generate a Conventional Commit message.
- Use the appropriate type (feat, fix, chore, docs, style, refactor, perf,
  test, build, ci, etc.).
- Include a scope if relevant: <type>(<scope>): <description>.
- Write a short, imperative description, max 72 characters per line.
- If needed, add a body with details or context, wrapped at 72 chars.
- Add footers if relevant (e.g., breaking changes, issues closed).
- Output only the commit message inside a markdown code block.

```diff
${utils.git_diff}
```


