# Developer Workspace

Developer Workspace is a lightweight .NET project template for keeping development context alongside 
source code in a real, Git-tracked project.

It provides a structured home for the information that normally ends up scattered across solution items, 
temporary notes, chat histories, and miscellaneous files.

## What it creates

A workspace project contains:

- **AI Prompts**
  - Features
  - Fixes
  - Chores
  - Analysis
- **Architecture**
  - Decisions
- **Plans**
- **Ideas**
- **Checkpoints**
- **Investigations**
- **Notes**

Each folder contains an example Markdown file showing a suggested structure and purpose.

## Why use a project?

The workspace is implemented as a lightweight SDK-style .NET project.

This means the workspace:

- uses real physical folders and files;
- is naturally tracked by Git;
- appears as a normal project in Visual Studio;
- automatically reflects new files added beneath the project directory;
- provides stable file paths for AI coding agents and development tools;
- can live alongside application, test, and database projects in an existing solution.

It is intended for development context and documentation rather than application code.

## Install

Install the template package:

    dotnet new install DeveloperWorkspace.Templates

## Create a workspace

For example:

    dotnet new developer-workspace -n MyProject.Workspace

This creates a new physical directory and project containing the workspace structure.

The generated project can then be added to an existing solution.

## Example

A solution might contain:

    MyProject.Api
    MyProject.Admin
    MyProject.Tests
    MyProject.Database
    MyProject.Workspace

The workspace provides a version-controlled home for plans, decisions, prompts, investigations, 
and project knowledge without mixing those files into application projects.

## AI-assisted development

The AI Prompts folders are intended for storing substantial coding-agent instructions as normal Markdown files.

For example:

    MyProject.Workspace/AI Prompts/Features/client-search.md

An AI coding agent can then be instructed to read that file rather than requiring a large prompt to be 
pasted repeatedly into a chat interface.

Because the prompt is committed alongside the resulting source changes, Git provides a useful history 
of both the implementation and the instructions that led to it.

## Status

Developer Workspace is currently an early-release project.

The folder structure and template behaviour may evolve based on real-world use.

## License

See the repository license for licensing information.