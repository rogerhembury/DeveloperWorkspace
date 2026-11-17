# Developer Workspace

This project is a version-controlled home for development context that belongs alongside the source code but isn't itself 
application code.

Use it to keep plans, architectural decisions, investigations, notes, checkpoints, and AI coding prompts in one 
predictable place.

## Folders

### AI Prompts

Reusable instructions for AI coding agents.

- **Features** - implementation prompts for new functionality.
- **Fixes** - tightly scoped debugging and regression-fix prompts.
- **Chores** - maintenance, imports, upgrades, and housekeeping.
- **Analysis** - read-only investigation and analysis prompts.

A useful convention is to match the prompt filename to the Git branch:

    feature/client-search
    AI Prompts/Features/client-search.md

This makes it easier to see what an AI coding agent was asked to do alongside the code changes that resulted.

### Architecture / Decisions

Record important architectural decisions, alternatives considered, trade-offs, and reasons for choosing a particular approach.

### Plans

Use for work that spans multiple implementation steps or branches.

### Ideas

Capture possibilities without turning them into requirements.

An idea recorded here is only an idea until somebody deliberately decides to implement it.

### Checkpoints

Summarise completed work so a developer or a fresh AI session can quickly understand:

- what now exists;
- important decisions;
- known limitations;
- deliberately deferred work;
- the logical next step.

### Investigations

Record debugging and technical investigations, including evidence, suspected causes, things ruled out, conclusions, 
and resolutions.

### Notes

Keep useful information that doesn't justify a formal plan, decision, investigation, or checkpoint.

## Keep it useful

This workspace is intended to reduce lost context, not create documentation work for its own sake.

Use the folders that help the project. Remove or rename folders that don't.

Keep documents current when the information matters, but don't attempt to document every development action.

## Source remains authoritative

Plans, prompts, notes, checkpoints, and architectural documents provide development context.

The current source code, database definitions, tests, and configuration remain the authoritative description of what the 
system actually does.

If documentation and implementation disagree, investigate the difference rather than assuming the documentation is correct.

## AI-assisted development

For substantial AI-assisted work, prompts can be stored as Markdown rather than repeatedly pasted into a chat interface.

For example:

    AI Prompts/Features/client-search.md

A coding agent can then be instructed:

    Read AI Prompts/Features/client-search.md in full and follow it exactly.

This preserves the instructions in Git alongside the implementation and gives future AI sessions useful project context 
without relying on chat history.