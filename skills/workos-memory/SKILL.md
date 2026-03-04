---
name: workos-memory
description: File formats, templates, and update rules for persistent environment and project memory.
user-invokable: true
---

# WorkOS — Memory System

Rules and templates for the persistent memory files.

## Storage layout

```
.workos/
├── config.yaml              # Workspace configuration (repos, team, bootstrap plugins)
├── environment/             # Environment-level memory
│   └── memory.md
└── projects/
    └── <project-name>/
        ├── memory.md        # Project-level memory
        ├── plan.md          # Project plan (tracks, tasks, status)
        ├── data/            # Persistent project data (configs, reference docs)
        ├── repos/           # Cloned repositories (gitignored)
        └── scratch/         # Transient working files (gitignored)
```

`config.yaml` declares the environment upfront — repos, team context, and tools for discovery. See the `workos-config` skill for the full schema.

Environment and projects each have a `memory.md`. Project data goes in `data/` (committed), cloned repos in `repos/` (gitignored), transient files in `scratch/` (gitignored).

## Bootstrapping

When `.workos/` doesn't exist, create the full structure:

1. Create directories: `mkdir -p .workos/environment .workos/projects`
2. Create gitignore: `printf 'repos/\nscratch/\n' > .workos/.gitignore`
3. Ask the user about their repos, team, and preferred tools
4. Create `.workos/config.yaml` from their answers (see `workos-config` skill for schema)
5. Create `environment/memory.md` from the template below
6. Add `workos.md` to workspace root with an overview of the operating model
7. Offer to explore repos and populate environment memory (see `workos-bootstrap` skill)

### Starting a new project

When the user wants to start a project (e.g., "start a project for X", "let's work on X"):

1. Derive the project name — lowercase, hyphenated (e.g., `api-redesign`, `fix-auth-bug`). Confirm with the user if ambiguous.
2. Create the directory structure:
   ```
   mkdir -p .workos/projects/<project-name>/{data,repos,scratch}
   ```
3. Create `memory.md` from the template below. **Fill in the Objective** from the user's request — don't leave it as a comment placeholder.
4. Create an empty `plan.md` (plans get written when non-trivial work begins).
5. Tell the user what was created and confirm the objective is right.

Don't skip steps or leave the directory partially created.

## File formats

### `environment/memory.md` — Environment Memory

```markdown
# Environment

## Landscape
<!-- What exists here — repos, services, tools, infra, key people/teams -->

## How things work
<!-- Build systems, deploy pipelines, testing, CI/CD, local dev setup -->

## Conventions
<!-- Code style, PR process, branch naming, review norms -->

## Patterns
<!-- Architectural patterns, common solutions, preferred libraries -->

## Gotchas
<!-- Things that burned us, anti-patterns, traps, workarounds -->
```

Starts with empty sections. Sections get filled in as you discover things through project work. Delete sections that remain empty — they can be added back when there's something to say.

### `memory.md` — Project Memory

```markdown
# <Project Name>

## Objective
<!-- What we're trying to accomplish -->

## Status
<!-- Where things stand right now -->

## Context
<!-- Background, constraints, decisions made -->

## Plan
<!-- Current tracks and tasks, if applicable -->

## Learnings
<!-- What we've discovered — technical details, gotchas, decisions and rationale -->
```

All sections are optional. Start with what you know (usually Objective). Fill in the rest as understanding develops. Remove sections that aren't useful for this project.

## Update rules

### Rewrite, don't append

Both files are rewritable narratives. When you update them, rewrite the relevant section to reflect your *current* understanding. Don't add timestamps, don't keep history, don't append bullet points to a growing list.

**Good:**
```markdown
## Status
The API is implemented and tested. Frontend integration is next.
```

**Bad:**
```markdown
## Status
- 2024-01-15: Started working on API
- 2024-01-16: API endpoints done
- 2024-01-17: Tests passing, moving to frontend
```

### Keep it concise

Memory files should be quick to read. A good `memory.md` is typically 20-80 lines. A good `environment/memory.md` might grow to 100-200 lines for a complex environment, but should stay scannable.

If a section is getting long, that's a signal to distill rather than to keep adding.

### Size guardrails

After rewriting any memory file, check its length:
- **Environment memory > 200 lines**: Warn the user and suggest condensing. Look for sections that can be distilled, details that belong in project memory instead, or content that duplicates what's in code/docs.
- **Project memory > 80 lines**: Warn the user and suggest condensing. Move detailed findings to `data/` files and reference them from memory. Keep memory scannable.

Don't silently truncate — tell the user what's too long and why it should be shortened.

### Project data

Each project has three directories for non-memory content:

- **`data/`** — Persistent project data. Config files, reference docs, design artifacts. Committed.
- **`repos/`** — Cloned repositories. Already version-controlled elsewhere. Gitignored.
- **`scratch/`** — Transient working files. Build outputs, temp files, exploratory scripts. Gitignored.

```
.workos/projects/api-redesign/
├── memory.md
├── plan.md
├── data/
│   └── design.pdf           # A reference doc
├── repos/
│   └── service-api/         # A cloned repo
└── scratch/
    └── perf-results.csv     # Temporary analysis
```

The `memory.md` Context section should reference important data so the assistant knows what's in `data/` and `repos/` and why.

### Project names

Use lowercase, hyphenated names: `api-redesign`, `auth-migration`, `perf-fixes`. The project name becomes the directory name under `.workos/projects/`.

### Initialization

When creating a new project memory, fill in what you know from the user's request. Don't leave all sections as empty comments — at minimum, write the Objective.

When bootstrapping environment memory for the first time, it's fine to leave sections empty or to omit them. They'll fill in naturally through work.
