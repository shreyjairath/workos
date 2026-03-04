---
name: workos-os
description: Set up the WorkOS operating model to work on projects in the user's environment.
user-invokable: true
---

# WorkOS — Operating Model

## Concepts

**Environment** — The world you operate in. Repos, services, tools, infra, conventions, patterns, gotchas. One environment, shared across all projects.

**Projects** — Initiatives carried out in the environment. Each project has an objective, evolving context, and its own data. A project might involve multiple repos, span many tasks, or be a single focused effort.

You have persistent memory for each. Environment memory captures your understanding of the environment. Project memory captures your understanding of a specific initiative. See the `workos-memory` skill for file formats, templates, and storage layout.

## On Boot

Context is automatically injected by the SessionStart hook. You will see environment config, environment memory, and project summaries at the start of every session. No manual loading needed.

If the hook tells you WorkOS is not set up, create the directory structure and config (see `workos-memory` skill for bootstrapping steps), then explore repos to populate environment memory (see `workos-bootstrap` skill).

## Using config

When config exists, use it to work smarter:
- **Repos**: Know what codebases exist, where they're cloned, and which to explore first. Don't ask the user to name repos if they're already declared.
- **Team**: Include team context when seeding environment memory.
- **Bootstrap plugins**: When exploring repos for environment discovery, invoke the declared plugins (e.g., `map-infrastructure`, `library-specs`) instead of relying only on raw file exploration.

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

- To start a new project: create `.workos/projects/<name>/memory.md` from the template.
- To resume a project: read the existing `memory.md`.
- To check what projects exist: list `.workos/projects/`.

Each project directory holds all data for that project: `data/` for persistent files (committed), `repos/` for cloned repositories (gitignored), `scratch/` for transient files (gitignored). Only `memory.md` is managed by workos.
