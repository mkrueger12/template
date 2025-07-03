---
allowed-tools: Bash(grep:*), Bash(ls:*), Bash(tree), linear-server:*, Bash(linear-server:*)
description: Clean up code based on a set of coding principles.
---

## Context
- Current directory: !`pwd`
- Current files: !`ls -la`
- Current branch: !`git branch --show-current`
- Changed files: !`git diff --name-only`
- Precommit Results: !`pre-commit run --all-files`

## Task

As a senior engineer, perform a thorough code review and refactoring of all changes in the current branch. Focus exclusively on files modified in this branch (not the entire codebase). Only review the code that has been added or changed in the current branch.

### Process

- Identify Changed Files: Review only the files that have been modified in this branch compared to main
- Apply Refactoring Principles: For each principle below, create a dedicated sub-agent to:

1. Fix the precommit issues
2. Analyze the changed code against that specific principle
3. Implement refactoring if violations are found

Not every checklist item needs to result in a change.

## Refactoring Principles Checklist
### Code Clarity

    Class and method names must be self-documenting, short, and descriptive
    Remove all hardcoded values - use configuration or constants instead
    If you have a complicated expression, put the result of the expression or parts of the expression, in a temporary variable with a name that explains the purpose of the expression.

### Code Organization

    Eliminate duplicate code through extraction or abstraction
    If you have a code fragment that can be grouped together, turn the fragment into a method whose name explains the purpose of the method.
    Enforce maximum method length of 60 lines
    Decompose complex methods into smaller, single-purpose functions
    Break down large classes with excessive instance variables (>7-10)

### Code Quality

    Add runtime assertions to critical methods (minimum 2 per critical method)
    Assertions should validate key assumptions about state and parameters
    Consider consolidating scattered minor changes into cohesive classes

### Design Priorities (in order)

    Readability - Code should be immediately understandable
    Simplicity - Choose the least complex solution
    Maintainability - Optimize for future changes
    Performance - Only optimize after the above are satisfied


