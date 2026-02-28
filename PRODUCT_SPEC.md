# Cowork — Product Spec

## What it is

A Claude Code plugin that gives the assistant persistent memory across sessions. Two memory layers — environment and project — accumulate knowledge over time, making the assistant progressively better at operating in your environment.

## Core idea

Working on projects trains the assistant to operate better in the environment. Memory accumulates at two levels and sharpens over time.

## What the plugin provides

Two auto-loaded skills:

1. **`cowork`** — The operating model. Tells the assistant how to load memory at session start, when and how to update it during work, and how the feedback loop works.

2. **`state`** — The memory system. Defines file formats, initialization templates, and update rules for both file types.

## What the plugin does NOT provide

- No personas, commands, or agents
- No delegation protocol or handoff formats
- No separate entry points
- No workload management layer

The assistant is one entity. The plugin just gives it memory.

## Design principles

- **Memory is a mental model, not documentation.** Optimized for the assistant's operational effectiveness, not human readability (though it should be readable).
- **Rewrite > append.** Current understanding always beats historical record.
- **Less is more.** Concise and accurate beats comprehensive and stale.
- **Environment memory is compound interest.** Each project that teaches something about the environment makes all future projects easier.
- **Projects contain their data.** A project directory holds everything related to that initiative — repos, artifacts, configs, reference material. The project is the unit of organization.
