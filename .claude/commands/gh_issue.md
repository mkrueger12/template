---
description: Create a gh issue
---


# Research Codebase

You are tasked with conducting comprehensive research across the codebase in order to create a detailed GitHub issue. Your goal is to detail where the developer should look in the codebase to find implementation deatils. Never provide specific implementation details. Let the developer handle this. Your guiding question is "If I were to implement this, where should I look in the codebase and what external resources should I consult?"

## Initial Setup:

When this command is invoked, summarize the feature request and respond with:
```
You want to implement [description of feature]. Shall I proceed?
```

Then wait for the user's approval.

## Steps to follow after receiving the research query:

1. **Read any directly mentioned files first:**
   - If the user mentions specific files (tickets, docs, JSON), read them FULLY first
   - **IMPORTANT**: Use the Read tool WITHOUT limit/offset parameters to read entire files
   - **CRITICAL**: Read these files yourself in the main context before spawning any sub-tasks
   - This ensures you have full context before decomposing the research

2. **Analyze and decompose the research question:**
   - Break down the user's query into composable research areas
   - Take time to ultrathink about the underlying patterns, connections, and architectural implications the user might be seeking
   - Identify specific components, patterns, or concepts to investigate
   - Create a research plan using TodoWrite to track all subtasks
   - Consider which directories, files, or architectural patterns are relevant

3. **Spawn parallel sub-agent tasks for comprehensive research:**
   - Create multiple Task agents to research different aspects concurrently
   - We now have specialized agents that know how to do specific research tasks:

   **For codebase research:**
   - Use the **codebase-locator** agent to find WHERE files and components live
   - Use the **codebase-analyzer** agent to understand HOW specific code works
   - Use a seperate **codebase-locator** agent if you need examples of similar implementations
   - Use `ast-grep run [OPTIONS] --pattern <PATTERN> [PATHS]... --lang <LANG>` over `grep` or `sed`. Use `ast-grep run --help` to learn more. Use this tool to confirm file locations for changes.

   **For web research (only if user explicitly asks):**
   - Use the **general-purpose** agent for external documentation and resources
   - Instruct them to return LINKS with their findings, and please INCLUDE those links in the github issue

   The key is to use these agents intelligently:
   - Start with locator agents to find what exists
   - Then use analyzer agents on the most promising findings
   - Run multiple agents in parallel when they're searching for different things
   - Each agent knows its job - just tell it what you're looking for
   - Don't write detailed prompts about HOW to search - the agents already know

4. **Wait for all sub-agents to complete and synthesize findings:**
   - IMPORTANT: Wait for ALL sub-agent tasks to complete before proceeding
   - Prioritize live codebase findings as primary source of truth
   - Connect findings across different components
   - Include specific file paths and line numbers for reference
   - Highlight patterns, connections, and architectural decisions
   - Answer the user's specific questions with concrete evidence

5. **Generate the github issue:**
   - Use the metadata gathered in step 4
   - Structure the document with YAML frontmatter followed by content:
     ```markdown
     # Overview: [one sentence description of feature request]

     ## Summary
     [High-level findings supporting the feature request development.]

     ## Detailed Findings

     ## Code References
     - `path/to/file.py:123` - Description of what's there and why its relevant to this feature
     - `another/file.ts:45-67` - Description of the code block and why its relevant to this feature

     ## Architecture Insights
     [Patterns, conventions, and design decisions discovered. Review spec.txt for more details]

     ## Historical Context (from .sessions/)
     [Relevant insights from directory with references]

     ## Related Research
     [Links to other external research if relevant/available]

     ## Open Questions
     [Any areas that need further investigation]
     ```

## Important notes:
- Always use parallel Task agents to maximize efficiency and minimize context usage
- Always run fresh codebase research - never rely solely on existing research documents
- Focus on finding concrete file paths and line numbers for developer reference
- Research documents should be self-contained with all necessary context
- Each sub-agent prompt should be specific and focused on read-only operations
- Consider cross-component connections and architectural patterns
- Include temporal context (when the research was conducted)
- Link to GitHub when possible for permanent references
- Keep the main agent focused on synthesis, not deep file reading
- Encourage sub-agents to find examples and usage patterns, not just definitions
- Explore all of thoughts/ directory, not just research subdirectory
- **File reading**: Always read mentioned files FULLY (no limit/offset) before spawning sub-tasks
- **Critical ordering**: Follow the numbered steps exactly
  - ALWAYS read mentioned files first before spawning sub-tasks (step 1)
  - ALWAYS wait for all sub-agents to complete before synthesizing (step 4)
  - ALWAYS gather metadata before writing the document (step 5 before step 6)
  - NEVER write the research document with placeholder values
  - This ensures paths are correct for editing and navigation
- **Frontmatter consistency**:
  - Always include frontmatter at the beginning of research documents
  - Keep frontmatter fields consistent across all research documents
  - Update frontmatter when adding follow-up research
  - Use snake_case for multi-word field names (e.g., `last_updated`, `git_commit`)
  - Never include code blocks in the gh issue
  - Do NOT IMPLEMENT. Return once the issue is created.