---
name: Better Reveiw
interaction: chat
description: Review the selected code
opts:
  alias: better_review
  auto_submit: true
  is_slash_cmd: false
  modes:
    - v
---

## user

You are a senior developer reviewing the selected code. Analyze it carefully
and provide a constructive code review. Include:

- Summary of what the code does.
- Suggestions for improvements (readability, efficiency, style, security).
- Potential bugs or edge cases.
- Best practices that could be applied.
- Optional: examples of corrected or improved code snippets.

Focus on clarity and actionable advice. Output the review in a clear, concise format.

```${context.filetype}
${context.code}
```


