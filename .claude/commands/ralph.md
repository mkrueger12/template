---
allowed-tools: Bash(grep:*), Bash(ls:*), Bash(tree), Bash(git:*)
description: Implement and issue from plan.md
---

## Context
- Review the development plan located at: `plan.md`
- Specification documents are located in: `specs/` directory

## Primary Task
Select and implement the highest priority unimplemented feature from `plan.md` using Test-Driven Development (TDD) methodology.

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
- [ ] Feature is fully implemented with passing tests
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