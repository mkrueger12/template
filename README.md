# Claude Code Template

A starter template for Claude Code projects with pre-configured agents, commands, plugins, and environment variable handling.

## Features

- **Custom Agents**: Pre-built agents for coding, debugging, and codebase analysis
- **Commands**: Planning, spec updates, and GitHub issue creation
- **Plugins**: Bonfire sessions, TypeScript/Pyright LSP support
- **Environment Variables**: Automatic `.env` loading via hooks

## Setup

1. Clone this template
2. Create a `.env` file with your environment variables
3. Update `CLAUDE.md` with your project details

## Structure

```
.claude/
├── agents/          # Custom agent definitions
├── commands/        # Slash commands (/plan, /gh_issue, etc.)
├── plugins/         # Installed plugins and marketplaces
├── scripts/         # Shell scripts (env_vars.sh, etc.)
└── settings.local.json
```

## Environment Variables

The `.claude/scripts/env_vars.sh` script automatically loads variables from `.env` into Claude Code sessions via hooks. Variables in `.env` are exported and made available during your session.

## Configuration

Edit `CLAUDE.md` to configure:
- Project purpose and tech stack
- Build, test, and dev commands
- Session workflow preferences