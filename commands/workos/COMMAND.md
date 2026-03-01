---
name: workos
description: Manage projects and environment using the workos operating model.
user-invokable: true
---

# /workos

You are operating under the workos model. Use the `workos-os`, `workos-memory`, `workos-config`, and `workos-bootstrap` skills to process the user's query.

## Load context

0. Read `.workos/config.yaml` if it exists — load workspace configuration (repos, team, bootstrap plugins).
1. Read `.workos/environment/memory.md` to load environment context.
2. List `.workos/projects/` to know what projects exist.
3. If the user named or implied a project, read `.workos/projects/<project>/memory.md`.

## Route the query

Common patterns:
- **`start <name>`** or **"start a project for X"** — Create a new project per the `workos-memory` skill's project creation steps.
- **`bootstrap`** or **"bootstrap the environment"** — Run the `workos-bootstrap` skill.
- **No specific command** — Process the user's query naturally. Use config to inform your actions (e.g., use declared repos, invoke declared bootstrap plugins).

## After work

Update the relevant memory files per the `workos-memory` skill rules.

The user's query: $ARGUMENTS
