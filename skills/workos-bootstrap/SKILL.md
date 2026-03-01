---
name: workos-bootstrap
description: Guided workflow to populate environment memory by exploring repos. Discovers tech stack, infrastructure, conventions, and patterns.
user-invokable: false
---

# WorkOS — Environment Bootstrap

A structured workflow for populating environment memory from codebases. This turns an empty environment into a rich context that helps with every future project.

## When to use

- First time setting up WorkOS in a workspace (the SessionStart hook will tell you)
- When a new repo is added to `config.yaml`
- When the user asks to bootstrap or refresh environment knowledge

## Setup (first time only)

If `.workos/` doesn't exist, set it up first using the `workos-memory` skill's bootstrapping instructions. That creates the directory structure, config, and template files.

Then continue to the exploration workflow below.

## Inputs

Before exploring, gather:
1. **Which repos to explore** — check `config.yaml` for declared repos. If none, ask the user.
2. **Local paths** — check `config.yaml` for `path` fields. If a repo isn't cloned locally, offer to clone it.
3. **Bootstrap plugins** — check `config.yaml` for `bootstrap.plugins`. Use them alongside standard exploration.

## Exploration workflow

For each repo (start with `primary: true` if set):

### Step 1: Explore structure
- List top-level directories and modules
- Identify the build system (Gradle, Bazel, etc.)
- Read product-spec.json, build files, and project config
- Note the language(s) and framework(s)

### Step 2: Map infrastructure
- Search for data stores (Espresso, Venice, Couchbase, MySQL, Pinot)
- Search for messaging/streaming (Kafka, Samza, Flink)
- Search for service frameworks (Rest.li, gRPC, D2)
- Search for caching, feature flags (LIX), config (cfg2), auth patterns
- Search for deployment configs (K8s, Helm, LARE)

### Step 3: Capture dependencies
- Read dependency specs or build files for MP dependencies
- Note key downstream and upstream services
- If `library-specs:generate_overview` is in bootstrap plugins, invoke it

### Step 4: Identify conventions
- Look for code style configs (.editorconfig, checkstyle, spotbugs)
- Check for test patterns and frameworks
- Note coverage requirements, CI commands
- Read any existing architecture or style docs (`.linkedin/ai-agent/`, docs/)

### Step 5: Write environment memory
- Populate each section of `environment/memory.md`:
  - **Landscape**: repos, services, team (from config), key dependencies
  - **How things work**: build system, deploy pipeline, testing, key commands
  - **Conventions**: code style, PR process, naming patterns
  - **Patterns**: architecture, infra systems in use, key libraries
  - **Gotchas**: coverage thresholds, config quirks, dual-protocol issues, etc.

## Multi-repo enrichment

When bootstrapping from additional repos after the first:
- Read existing `environment/memory.md` first
- **Merge** new findings into existing sections — don't overwrite what's already there
- Add the new repo to the Landscape section
- Note any differences in patterns or conventions between repos

## After bootstrap

- Tell the user what was discovered and written
- Suggest next steps (e.g., "want to start a project?" or "any other repos to add?")
- Check memory size guardrails per `workos-memory` rules
