---
name: workos-config
description: Workspace configuration schema for WorkOS — repos, team context, and integration settings.
user-invokable: false
---

# WorkOS — Configuration

Workspace-level configuration lives in `.workos/config.yaml`. This file tells WorkOS about the environment so it can operate with context from the first interaction.

## Location

```
.workos/config.yaml
```

If this file doesn't exist, WorkOS operates without pre-configured context — it will ask the user for information as needed.

## Schema

```yaml
# .workos/config.yaml

# Repos and multiproducts in this environment
repos:
  - name: <mp-or-repo-name>        # Required. Name used for cloning (e.g., mint clone <name>)
    path: <local-path>              # Optional. Absolute path if already cloned locally
    primary: true                   # Optional. Mark one repo as the main one to explore first
    description: <short-desc>       # Optional. What this repo is

# Team context
team:
  name: <team-name>                 # Optional. Team or crew name
  area: <ownership-description>     # Optional. What the team owns / area of responsibility

# Environment bootstrap configuration
bootstrap:
  plugins:                          # Optional. Plugins to use when exploring repos
    - <plugin-name:skill-name>      # e.g., linkedin-framework:map-infrastructure
```

## Field reference

### `repos`
List of repositories the user works on. Used to:
- Know what to explore when bootstrapping environment memory
- Locate local clones instead of re-cloning
- Prioritize which repo to explore first (`primary: true`)

### `team`
Team identity and ownership. Used to:
- Seed environment memory with team context
- Provide background when exploring codebases

### `bootstrap.plugins`
Plugins/skills to invoke during environment discovery. Used to:
- Run infrastructure mapping, library spec generation, etc.
- Suggest relevant tools without the user having to remember them

## Defaults

All fields are optional. When a field is missing:
- `repos`: WorkOS will ask the user which repos to explore
- `team`: No team context in environment memory
- `bootstrap.plugins`: WorkOS uses its own exploration (Glob, Grep, Read) without plugin-specific tools

## Example

```yaml
# .workos/config.yaml

repos:
  - name: messaging-mt
    path: ~/Work/messaging-mt
    primary: true
    description: Mid-tier API layer for LinkedIn Messaging
  - name: messaging-conversation-be
    description: Backend conversation persistence service

team:
  name: Messaging Platform
  area: Mid-tier orchestration layer for LinkedIn Messaging

bootstrap:
  plugins:
    - linkedin-framework:map-infrastructure
    - library-specs:generate_overview
    - linkedin-cli-tools:cli-tools
```

## Reading config

When processing any WorkOS command or skill:
1. Check if `.workos/config.yaml` exists
2. If yes, read it and use its contents to inform your actions
3. If no, proceed normally — ask the user for context as needed

Config is read-only during normal operation. It's written once during setup and updated by the user when their environment changes.
