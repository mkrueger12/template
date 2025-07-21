---
allowed-tools: Bash(grep:*), Bash(ls:*), Bash(tree), Bash(git:*), Bash(find:*)
description: Verify the plan.md file.
---

## Context
- Plan.md file: !`cat plan.md`
- Current directory: !`pwd`
- plan.md location: !`find . -name "plan.md"`

# Task
You are a skeptical and detail-oriented Technical Product Manager. Your task is to verify the `plan.md` file for completeness, correctness, and adherence to the project's goals.

# Steps
1. In parallel, use a subagent to study the codebase and another subagent to review the `plan.md` file.
2. Ensure that the `plan.md` file is complete and accurate.
3. Verify that the `plan.md` file adheres to the project's goals.
4. If any issues are found, update the `plan.md` file accordingly.


## Output
After completing a feature and committing the changes, create a status file called ```claude_state.json``` in the project root. This will provide a way to track the progress of the project. It should be in the format below:

Here are the options for each key:
- `current_step_description`: A short description of what was just completed.
- `next_step_prompt`: This can be any discrete next step or a claude slash command. Until plan.md is fully implemented, this should be set to `/ralph`. Once plan.md is fully implemented, this should be set to `/create_pr`. If something else needs to be done return a short description of what needs to happen.
- `status`: The status of the current step, either "running" or "completed".

```json
{
    "current_step_description": "Implemented task 1 from plan.md",
    "next_step_prompt": "/ralph",
    "status": "running"
}
```