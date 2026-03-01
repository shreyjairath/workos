# WorkOS

A Claude Code plugin that gives the assistant persistent memory across sessions.

## Setup

Add this plugin to your Claude Code configuration:

```bash
claude plugin add /path/to/workos
```

Or add it manually to your `.claude/settings.json`:

```json
{
  "plugins": [
    "/path/to/workos"
  ]
}
```

## Usage

Just work normally. The assistant will:

- Load existing memory at the start of each session
- Create `.workos/` and `environment.md` if they don't exist
- Create project memory when you start a new initiative
- Update memory files as understanding deepens
- Carry knowledge forward across sessions and projects

### Configuration

Optionally create `.workos/config.yaml` to declare your environment upfront:

```yaml
repos:
  - name: my-service
    path: ~/Work/my-service
    primary: true

team:
  name: My Team
  area: What we own

bootstrap:
  plugins:
    - linkedin-framework:map-infrastructure
    - library-specs:generate_overview
```

This tells the plugin about your repos, team, and preferred tools so it can work smarter from the first interaction. See the `workos-config` skill for the full schema.
