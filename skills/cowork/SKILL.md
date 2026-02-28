# Cowork — Operating Model

## Concepts

**Environment** — The world you operate in. Repos, services, tools, infra, conventions, patterns, gotchas. One environment, shared across all projects.

**Projects** — Initiatives carried out in the environment. Each project has an objective, evolving context, and its own data. A project might involve multiple repos, span many tasks, or be a single focused effort.

You have persistent memory for each. Environment memory captures your understanding of the environment. Project memory captures your understanding of a specific initiative. See the `state` skill for file formats, templates, and storage layout.

## Boot

1. Read `.cowork/environment/memory.md` if it exists — this is your understanding of the environment.
2. If the user names a project, read `.cowork/projects/<project>/memory.md` — this is where you left off.
3. If `.cowork/` doesn't exist, bootstrap it (see the `state` skill).

## While working

Do the work the user asks for. As you work, notice two kinds of things:

- **Project-specific understanding**: decisions made, context discovered, status changes, things learned about this particular effort. Update `memory.md` when your understanding meaningfully evolves — not after every small action.

- **Environment-level understanding**: how the build system works, what tools are available, coding conventions, architectural patterns, traps to avoid. Update `environment/memory.md` when you discover something that would help with *any* project in this environment.

## Updating memory

Memory files are **rewritten, not appended to**. Each update should reflect your *current* understanding, not a changelog. If a previous understanding was wrong, replace it. If status changed, update it. Keep the files concise and useful.

**When to update:**
- `memory.md`: When your understanding of the project meaningfully changes — new decisions, shifted plans, important discoveries. Not after every file edit.
- `environment/memory.md`: When you learn something about the environment that transcends the current project — a build quirk, a naming convention, a useful tool, a gotcha.

**When NOT to update:**
- Don't update memory for trivial or temporary observations.
- Don't update mid-thought — finish the task or reach a stopping point first.
- Don't duplicate information that's already in the files you're working on (code comments, READMEs, etc.).

## The feedback loop

```
Work on project
  → discover something about the environment
    → update environment/memory.md
      → next project starts with richer context
```

```
Work on project
  → understanding deepens
    → rewrite memory.md to reflect current state
```

Working on projects trains you to operate better in the environment. Knowledge accumulates at two levels and sharpens over time.

## Managing projects

- To start a new project: create `.cowork/projects/<name>/memory.md` from the template.
- To resume a project: read the existing `memory.md`.
- To check what projects exist: list `.cowork/projects/`.

Each project directory holds all data for that project: `data/` for persistent files (committed), `repos/` for cloned repositories (gitignored), `scratch/` for transient files (gitignored). Only `memory.md` is managed by cowork.
