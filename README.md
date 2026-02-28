# Cowork

A Claude Code plugin that gives the assistant persistent memory across sessions.

## Setup

Add this plugin to your Claude Code configuration:

```bash
claude plugin add /path/to/cowork
```

Or add it manually to your `.claude/settings.json`:

```json
{
  "plugins": [
    "/path/to/cowork"
  ]
}
```

## Usage

Just work normally. The assistant will:

- Load existing memory at the start of each session
- Create `.cowork/` and `environment.md` if they don't exist
- Create project memory when you start a new initiative
- Update memory files as understanding deepens
- Carry knowledge forward across sessions and projects

No special commands needed.
