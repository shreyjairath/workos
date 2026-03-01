# WorkOS

An operating system for working with Claude Code. Two layers of persistent memory — environment and project — that make the assistant progressively better at operating in your world.

## How it works

WorkOS gives Claude two kinds of memory that persist across sessions:

**Environment memory** — the overall landscape and how to operate in it.

**Project memory** — your ongoing projects in the environment.

Both memory layer always captures the current understanding of your environment and your projects.

## Why

- **Better context from the start.** Claude knows your repos, tools, and conventions without being told every session.
- **Gets better over time.** Every project teaches Claude something about the environment. Knowledge compounds.
- **Project continuity.** Pick up where you left off. Claude reads the project memory and knows the objective, status, and plan.
- **Two-way feedback loop.** Environment discoveries during project work flow back to environment memory, making all future projects better.

## End-to-end flow

**First time — bootstrap your environment:**
```
You: "let's set up workos"
  → Claude creates .workos/ structure
  → Asks about your repos, team, tools
  → Creates config.yaml
  → Explores your repos and populates environment memory
```

**Starting a project:**
```
You: "start a project for migrating the auth system"
  → Claude creates .workos/projects/auth-migration/
  → Fills in memory.md with the objective
  → Creates empty plan.md
  → Ready to work
```

**Working on a project:**
```
You: "let's work on auth migration"
  → Claude reads project memory + plan → knows where you left off
  → Does the work
  → Updates project memory with new understanding
  → Discovers a build quirk → promotes it to environment memory
```

**Next session — everything is there:**
```
Session starts
  → Hook injects environment config + memory
  → Hook lists all projects with status
  → Claude already knows your world and your projects
  → You just say what you want to do
```

## Setup

```bash
git clone https://github.com/shreyjairath/workos.git
claude --plugin-dir ./workos
```

## Configuration

Optionally create `.workos/config.yaml` to declare your environment upfront:

```yaml
repos:
  - name: my-service
    path: ~/Work/my-service
    primary: true

team:
  name: My Team
  area: What we own
```

This tells the plugin about your repos and team so it can work smarter from the first interaction.

## What's in .workos/

```
.workos/
├── config.yaml              # Your repos, team, tools
├── environment/
│   └── memory.md            # What Claude knows about your environment
└── projects/
    └── <project-name>/
        ├── memory.md        # What Claude knows about this project
        ├── plan.md          # Implementation plan
        ├── data/            # Persistent project files
        ├── repos/           # Cloned repos (gitignored)
        └── scratch/         # Temp files (gitignored)
```
