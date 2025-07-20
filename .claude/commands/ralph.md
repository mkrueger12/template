---
allowed-tools: Bash(grep:*), Bash(ls:*), Bash(tree), Bash(git:*), Bash(find:*)
description: Implement and issue from plan.md
---

## Context
- Current directory: !`pwd`
- plan.md location: !`find . -name "plan.md"`

## Primary Task
You are a very senior engineer. Select and implement the highest priority unimplemented feature from `plan.md` using Test-Driven Development (TDD) methodology.

## Step-by-Step Process

### 1. Analysis Phase
- Use a subagent to read `plan.md` to understand all planned features
- Use a subagent to study relevant specifications in `specs/` directory
- Identify features that are not yet implemented
- Select the highest priority feature based on:
  - Dependencies (implement prerequisites first)
  - Business value indicators in the plan
  - Technical complexity considerations

### 2. Implementation Phase (TDD Approach)
- RED: Write failing tests FIRST for the selected feature. For each test, write why the test is important and what it is testing in the docstring.
- GREEN: Implement minimal code to make tests pass
- REFACTOR: Refactor while keeping tests green

### 3. Completion Phase
- Update `plan.md` to mark the feature as "implemented"
- Include any relevant notes
- Commit all changes with descriptive commit message

## Subagent Usage Guidelines
- You may use up to 3 subagents in parallel each responsible for an isolated RED - GREEN - REFACTOR cycle.

## Success Criteria
- [ ] Items from `plan.md` is fully implemented with passing tests
- [ ] `plan.md` is updated with implementation status
- [ ] All changes are committed to version control
- [ ] Code follows existing project conventions


## Commit Message Format
```
feat: Implement [feature name] from plan.md

- Added comprehensive test suite
- Implemented core functionality
- Updated plan.md status to 'implemented'
- Follows TDD methodology
```

## Output
After completing a feature and committing the changes, create a status file called ```claude_status.json``` in the project root. This will provide a way to track the progress of the project. It should be in the format below:

If there are more features to implement, return:

```json
{
  "continue": "yes",
  "message": "There are more features to implement."
}
```

If there are are no more features to implement, return:
```json
{
  "continue": "no",
  "message": "All features from plan.md have been implemented."
}
```
THIS NEEDS TO BE A VALID JSON FILE.