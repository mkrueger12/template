# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**WHY**: Starter template for Claude Code projects with pre-configured agents, commands, and plugins.

**WHAT**:
- Tech stack: Bash, Markdown
- Architecture: Claude Code configuration template

**HOW**:
```bash
# Load environment variables manually
source .claude/scripts/env_vars.sh

# Or rely on the pre-prompt hook to load .env automatically
```

## Sessions Pattern (Optional)

If you've set up the Sessions Directory Pattern (`npx create-sessions-dir`):

- `/start-session` - Read context, fetch GitHub/Linear issues
- `/end-session` - Update context, detect merged PRs, auto-archive
- `/plan` - Create structured implementation plans
- `/document` - Topic-specific documentation with sub-agents
- `/change-git-strategy` - Change git strategy for .sessions/

Learn more: https://vieko.dev/sessions

## External Tools (Optional)

**For GitHub integration:**
```bash
gh auth login    # Required for PR/issue fetching
```

**For Linear integration:**
Configure the Linear MCP server in your Claude settings.
See: https://github.com/anthropics/claude-code/blob/main/docs/mcp.md

Commands will gracefully handle missing tools and prompt for manual input.

- Never echo sensative env vars directly. Instead

```bash
# Returns exit code 0 (true) if set, 1 (false) if not
  [ -n "$VARIABLE" ]
```
