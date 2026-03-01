# WorkOS

An operating system for working with Claude Code. Persistent memory that makes Claude progressively better at operating in your world, and project management that keeps your work organized across sessions.

## How it works

WorkOS gives Claude two kinds of memory that persist across sessions:

**Environment memory** — the overall landscape and how to operate in it.

**Project memory** — your ongoing projects in the environment.

Every Claude session has the latest understanding of all your projects and the environment.

## Why

### Context that evolves

```
Day 1:
  You: "help me set up my workspace"
  You: "I work on the payments service, here's the repo"
  Claude explores — learns the tech stack, build system, conventions, patterns.

Day 1:
  You: "start a project to fix the token refresh bug"
  Claude sets up the project. Creates a plan, you approve it, work begins.

Day 2:
  You: "let's keep going on the token refresh fix"
  Claude picks up exactly where you left off — objective, plan, progress, learnings.

Day 5:
  While fixing a bug, Claude discovers the DB migration tool has a quirk.
  It remembers that for next time.

Day 10:
  You: "start a project to redesign the payments API"
  New project, but Claude carries forward everything it learned.
  You never re-explain. Every project makes it smarter.
```

### Project management

```
You: "start a project for the API redesign"
  Claude creates the project — objective, plan, workspace. Ready to go.

You: "what am I working on?"
  Claude shows all your active projects — objective, status, current plan.

You: "let's work on the API redesign"
  Claude loads the full project context. Knows the plan, what's done, what's next.

You: "this approach won't work, let's pivot to GraphQL"
  Claude updates the plan, revises the project memory. Next session reflects the pivot.

You: "the API redesign is done, archive it"
  Claude promotes key learnings to environment memory and archives the project.
  What you learned carries forward. The project is cleanly closed.

Next session:
  Claude already knows all your projects and their status.
  No loading, no context-setting. You just say what you want to do.
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
