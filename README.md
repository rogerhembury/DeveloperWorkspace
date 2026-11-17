# Developer Workspace

**Developer Workspace** is a lightweight .NET project template that gives development context a proper home 
alongside the code it describes.

It grew out of a simple problem: plans, architectural decisions, AI prompts, investigations, notes, and 
half\-finished ideas tend to end up scattered across Solution Items, chat histories, temporary files, and people's heads.

Developer Workspace puts that material into a **real, Git\-tracked project with real physical folders** 
that sits alongside the application projects in a Visual Studio solution.

## The idea

A typical solution might contain:

MyProject.Api

MyProject.Admin

MyProject.Tests

MyProject.Database

MyProject.Workspace

MyProject.Workspace isn't application code. It is the development memory for the project.

Because it is an ordinary project containing real files:

- Git tracks everything normally.
- Visual Studio displays the physical folder hierarchy.
- New files added beneath the project directory appear automatically.
- Markdown files can be edited directly in Visual Studio.
- AI coding agents can be given stable file paths to plans and prompts.
- Development context evolves alongside the code instead of disappearing into chat history.

## What it creates

A new workspace contains:

AI Prompts/

    Analysis/

    Chores/

    Features/

    Fixes/

Architecture/

    Decisions/

Checkpoints/

Ideas/

Investigations/

Notes/

Plans/

Each folder contains an example Markdown document demonstrating one possible way to use that area.

The structure is deliberately lightweight. Keep the folders that help your project, change them where 
necessary, and don't create documentation merely for the sake of having documentation.

## AI\-assisted development

One of the original motivations for Developer Workspace was working with AI coding agents.

Instead of repeatedly pasting a large implementation prompt into a chat window, store it as a normal 
version\-controlled file:

MyProject.Workspace/AI Prompts/Features/client\-search.md

Then give the coding agent a short instruction such as:

Read MyProject.Workspace/AI Prompts/Features/client\-search.md in full and follow it exactly.

This has several advantages:

- substantial prompts are easier to write and review;
- the exact instructions given to the coding agent are preserved;
- prompts can be matched to Git branches;
- plans and checkpoints can provide context to fresh AI sessions;
- Git records both the implementation and the specification that led to it.

A useful convention is:

Branch:

feature/client\-search

Prompt:

MyProject.Workspace/AI Prompts/Features/client\-search.md

## Suggested uses

### AI Prompts

Store substantial instructions for AI coding agents.

The default categories are:

- **Features** for new functionality.
- **Fixes** for tightly scoped bug fixes.
- **Chores** for maintenance and housekeeping.
- **Analysis** for read\-only investigation before implementation.

### Architecture / Decisions

Record important architectural decisions, alternatives considered, trade\-offs, and circumstances that might 
justify revisiting the decision.

### Plans

Capture workstreams that span more than one implementation step or Git branch.

### Ideas

A deliberately informal place for things that might be useful later.

An idea is not automatically a requirement.

### Checkpoints

Record the state of a larger piece of work so that a developer or a fresh AI session can quickly understand:

- what now exists;
- important decisions;
- known limitations;
- deliberately deferred work;
- the logical next step.

### Investigations

Keep the evidence and conclusions from debugging or technical investigations, including causes that were 
considered and ruled out.

### Notes

Keep useful project knowledge that doesn't justify a more formal plan, decision, investigation, or checkpoint.

## Installation

### From a release package

Download DeveloperWorkspace.Templates.x.y.z.nupkg from the appropriate release, then install it with:

dotnet new install path\\to\\DeveloperWorkspace.Templates.x.y.z.nupkg

Confirm the template is installed with:

dotnet new list developer\-workspace

### Create a workspace

Create a workspace with:

dotnet new developer\-workspace \-n MyProject.Workspace

Or explicitly choose the output directory:

dotnet new developer\-workspace \-n MyProject.Workspace \-o MyProject.Workspace

The generated project can then be added to an existing Visual Studio solution.

## Updating or uninstalling

Remove the installed template package with:

dotnet new uninstall DeveloperWorkspace.Templates

A newer package can then be installed using the same installation process.

## How it works

Developer Workspace currently uses a deliberately small SDK\-style .NET project.

That gives the workspace first\-class Visual Studio project behaviour, automatic physical\-file discovery, 
Git integration, and normal solution support without requiring a custom Visual Studio extension or project 
system.

There is currently no application code in the generated workspace.

Because it uses the standard .NET SDK project system, Visual Studio still displays normal .NET project 
infrastructure such as **Dependencies**, and building the project produces an otherwise unused assembly.

Those are accepted trade\-offs in the current implementation in exchange for keeping the project simple, 
portable, and dependency\-free.

## Development and testing

The repository includes an automated smoke test for the template:

    .\scripts\Test-DeveloperWorkspace.ps1

Run the script from the repository root before preparing a release.

The test:

- packs `DeveloperWorkspace.Templates`;
- verifies the expected NuGet package was created;
- inspects the package contents;
- verifies required template files are present;
- checks that `bin` and `obj` files have not leaked into the package;
- installs the newly built template package;
- generates a fresh workspace in the system temporary directory;
- verifies the expected workspace folders exist;
- verifies `.template.config` has not leaked into the generated workspace or project file;
- builds the generated workspace;
- removes the temporary test workspace after a successful run.

A successful run finishes with:

    ========================================
    Developer Workspace template test PASSED
    ========================================

The smoke test should pass before a package is tagged or published as a release.

## Current status

The current private preview is **0.1.1**.

Version 0.1.1 has been tested by:

- packaging the template as a NuGet template package;
- installing the packaged template;
- creating new workspace projects;
- building generated workspace projects;
- adding generated workspaces to .slnx solutions;
- verifying the physical folder hierarchy in Visual Studio;
- adding files outside Visual Studio and confirming they appear automatically;
- downloading the release package and repeating installation and generation from that release artifact.

The project is still an early preview.

The folder structure, documentation, packaging, and implementation may change as it is used in real projects.

## License

Developer Workspace is available under the **MIT License**.

See LICENSE for the full license text.

