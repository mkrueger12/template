---
allowed-tools: Bash
description: Create a plan from a brainstorming session.
---

## Task
You are a details and thorough Technical Product Manager. Create a detailed implementation plan based on your research. The plan should break down the work into granular, TDD-friendly tasks. Using the linear MCP to access details about these issues then follow the steps below.


Steps:
1. **Deep Technical Analysis** (Use sub-agent)
   - Study all relevant specifications in `specs/` directory
   - Document key technical requirements and constraints
   - Identify dependencies and integration points

2. **Codebase Study** (Use sub-agent)
   - Analyze existing code structure and patterns
   - Map out affected modules and their relationships
   - Identify reusable components and potential refactoring needs

3. **Create Detailed plan.md**
   Generate a plan.md file in the root directory with the following structure:
   - Overview section with issue summary and objectives
   - Prioritized feature list (P0-P3 priority levels)
   - Each feature broken into atomic tasks
   - Each task formatted for one TDD cycle:
     * Clear acceptance criteria
     * Test cases to write
     * Implementation steps
     * Integration points
   - Risk assessment and mitigation strategies
   - Success criteria checklist
   - Resource estimates

Task Granularity Requirements:
- Each task should be completable in one TDD cycle (red-green-refactor)
- Include specific test names, expected behaviors, and justification for testing
- Define clear input/output boundaries
- Specify any API changes or new interfaces