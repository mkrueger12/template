---
allowed-tools: Bash(grep:*), Bash(ls:*), Bash(tree), Bash(git:*), Bash(find:*)
description: est-Driven Development Feature Implementation
---
# Context
- Feature: #ARGUEMENT

## Overview and Context

You are a senior software engineer tasked with implementing features from a project plan using Test-Driven Development (TDD) methodology. Your primary objective is to implement feature you are asked to implement.

### Environment Setup
<environment_setup>
- **Current working directory**: !`pwd`
- **Project plan location**: !`find . -name "plan.md"`
- **Technical specifications**: Review documentation in @/specs
- Implementation plan: @plan.md
<environment_setup>


## Steps
Your task involves several steps, which we'll break down in detail. Before each action, wrap your planning and reasoning in <reasoning> tags.

1. Review Specifications w/ @agent-sspec-implementation-reviewer (Run in Parallel):

<reasoning>
- How should I deploy the spec-implementation-reviewer agent?
- What key information should this agent extract from the specifications?
- How can I best map specifications to planned features?
- Create a mapping between specifications and features.
</reasoning>

Use the spec-implementation-reviewer agent to:
- Map specifications to planned features
- Identify technical constraints or requirements
- Note architectural decisions that impact implementation
- Document API contracts or interface definitions

2. Analyze the codebase with @agent-codebase-pattern-analyzer (Run in Parallel):
<reasoning>
- What is the current code structure and what patterns are used?
- Which specific modules will be affected by the changes?
- Are there any reusable components that can be leveraged?
- Is there a need for refactoring in any part of the codebase?
- How will the new changes impact the existing code architecture?
- Are there any naming conventions or coding standards to follow?
</reasoning>

Execute this agent to map the application. Select the most relevant items below given the scope:

**Potential Scope of Analysis:**
- Project structure and module organization
- Code style and conventions
- Design patterns implemented (e.g., MVC, microservices, event-driven)
- Middleware and interceptor chains
- Logging and observability patterns
- Data flow and state management
- API contract definitions
- Testing patterns and coverage areas

3. Review Git History with @agent-general-purpose (Run in Parallel):
<reasoning>
- Have there been recent attempts to address this feature?
- What recent changes might affect the implementation?
- Are there lessons from prior commits that would help us implement this more efficiently?
</reasoning>

Execute this general purpose subagent to review the recent git history to understand recent changes to the codebase.

**Scope of Analysis:**
- Recent Commits: Examine the most recent N commits to understand the chronological sequence of changes.
- Commit Messages: Analyze the commit messages to discern the purpose and context of each change (e.g., bug fixes, new features, refactoring).
- Files Changed: Identify the specific files and lines of code that were modified, added, or deleted in each commit.
- Branch and Merge History: Review the branching and merging patterns to understand the development workflow (e.g., feature branches, hotfixes).
- Do not run the test suite.

4. Lessons Learned File (Run in Parallel)
Execute a general purpose subagent To determine if there is a @LESSONS-LEARNED.md file present in the @specs directory. If there is not, then just return and end. If there is, study the lessons learned as it should help debug this issue. End the session if you don't find one.

5. Test-Driven Development Implementation:

For the given feature, follow this TDD cycle:

a. RED Phase - Write MINIMAL Critical Tests:
<reasoning>
- What is the CORE business logic that must work correctly?
- What is the happy path for this code?
- What would cause the most damage if it failed?
- Can I test this with just 1-3 focused tests?
- Skip tests for: trivial getters/setters, simple data transformation, UI rendering, configuration loading
</reasoning>
Write tests ONLY for:

Core business logic that could fail in non-obvious ways
Critical data validation or security checks
Complex algorithms or calculations
Integration points that are prone to errors

Test Guidelines:

Write 1-3 tests maximum for the critical path
Focus on the "happy path" and one critical edge case
Skip comprehensive edge case testing
Avoid testing implementation details
Don't test third-party libraries or framework code

b. GREEN Phase - Minimal Implementation:

<reasoning>
- What is the simplest code that will make all tests pass?
- How can I avoid premature optimization?
- What subagents can I delegate implementation tasks to?
</reasoning>

Write code that:
- Makes all tests pass
- Is simple and straightforward
- Avoids unnecessary features or optimizations

c. REFACTOR Phase - Improve Code Quality:

<reasoning>
- What aspects of the code can be improved?
- How can I enhance readability and maintainability?
- What design patterns might be applicable?
- What linting or formatting tools are my disposal?
</reasoning>

Run the project lint commands targeted at the files you changed.

Refactor to:
- Improve code readability
- Extract common functionality
- Apply appropriate design patterns
- Ensure consistent coding style
- Add necessary documentation
- Run the available linting or formatting tools for the codebase on the specific changes.

6. Update Project Plan:

<reasoning>
- What changes need to be made to plan.md?
- How can I clearly document the implementation and any decisions made?
</reasoning>

Modify `plan.md` to:
- Change feature status to "implemented"
- Add implementation date
- Include notes about decisions or trade-offs
- Document discovered dependencies or follow-up tasks

7. Create Commit:

<reasoning>
- What key information should be included in the commit message?
- How can I ensure the commit message is clear and informative?
</reasoning>

Create a commit with this format:

```
feat: Implement [feature name] from plan.md

- Added comprehensive test suite covering [list key test scenarios]
- Implemented core functionality for [brief feature description]
- Updated plan.md status to 'implemented'
- Follows TDD methodology (RED-GREEN-REFACTOR)

Technical notes:
- [Any important implementation decisions]
- [Performance considerations]
- [Known limitations]
```

8. Verify Build:

<reasoning>
- What steps are necessary to verify the build?
- How can I ensure the feature works as expected in the built application?
</reasoning>

For compiled languages:
- Build the entire application
- Fix any compilation errors
- Run the full test suite
- Verify the feature in the built application

Remember:
1. Focus on implementing exactly ONE feature per cycle.
2. Always verify implementation status in the codebase.
3. Never write implementation code before tests.
4. Write the least code necessary to fulfill feature requirements. Do not overengineer. 
5. Provide clear documentation for future reference.
6. Always delegate logic tasks to subagents when possible.

If you encounter any situations not covered by these instructions, or if you need to make important decisions, use <reasoning> tags to reason through the problem before proceeding.