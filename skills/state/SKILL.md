# Cowork — Memory System

Rules and templates for the persistent memory files.

## Storage layout

```
.cowork/
├── environment/
│   └── memory.md
└── projects/
    └── <project-name>/
        ├── memory.md
        ├── data/            # Persistent project data (configs, reference docs)
        ├── repos/           # Cloned repositories (gitignored)
        └── scratch/         # Transient working files (gitignored)
```

Environment and projects each have a `memory.md`. Project data goes in `data/` (committed), cloned repos in `repos/` (gitignored), transient files in `scratch/` (gitignored).

## Bootstrapping

When `.cowork/` doesn't exist, create it with the environment directory:

```
mkdir -p .cowork/environment .cowork/projects
printf 'repos/\nscratch/\n' > .cowork/.gitignore
```

Then create `environment/memory.md` from the template below.

When starting a new project, create its directory and `memory.md`:

```
mkdir -p .cowork/projects/<project-name>/{data,repos,scratch}
```

Then create `memory.md` from the template below.

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

### Project data

Each project has three directories for non-memory content:

- **`data/`** — Persistent project data. Config files, reference docs, design artifacts. Committed.
- **`repos/`** — Cloned repositories. Already version-controlled elsewhere. Gitignored.
- **`scratch/`** — Transient working files. Build outputs, temp files, exploratory scripts. Gitignored.

```
.cowork/projects/api-redesign/
├── memory.md
├── data/
│   └── design.pdf           # A reference doc
├── repos/
│   └── service-api/         # A cloned repo
└── scratch/
    └── perf-results.csv     # Temporary analysis
```

The `memory.md` Context section should reference important data so the assistant knows what's in `data/` and `repos/` and why.

### Project names

Use lowercase, hyphenated names: `api-redesign`, `auth-migration`, `perf-fixes`. The project name becomes the directory name under `.cowork/projects/`.

### Initialization

When creating a new project memory, fill in what you know from the user's request. Don't leave all sections as empty comments — at minimum, write the Objective.

When bootstrapping environment memory for the first time, it's fine to leave sections empty or to omit them. They'll fill in naturally through work.
