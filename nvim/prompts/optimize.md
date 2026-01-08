---
name: Better Optimization
interaction: chat
description: Make the selected code more efficient
opts:
  alias: better_optimize
  auto_submit: false
  is_slash_cmd: false
  modes:
    - v
---

## user

Act as a senior engineer optimizing the selected code.

Goals:
- Improve performance (time and memory where applicable).
- Reduce unnecessary computations and allocations.
- Simplify logic and remove redundancy.
- Improve readability without harming performance.

Instructions:
- Identify bottlenecks or inefficient patterns.
- Propose optimized alternatives with explanations.
- Provide revised code snippets where helpful.
- Preserve existing behavior and public interfaces.
- Mention any trade-offs introduced by the optimization.

Output:
- Short list of optimization opportunities.
- Optimized version of the code (if changes are non-trivial).
- Brief explanation of why the changes are better.

```${context.filetype}
${context.code}
```


