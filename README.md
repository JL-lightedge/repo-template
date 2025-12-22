# Codex Repo Skeleton

> A sane, lightweight template for repos that use **Codex** (ChatGPT) as a coding partner. It gives you: rules, roles, CI enforcement, and docs that help you ship.

This README is the human-facing quickstart for the Vibe Coding workflow so you can take this template from idea to shippable code. For instructions on curating role docs or extending the agent workflow, read `agents/README.md`.

---

## Quickstart

### Step 1: Start the AI kickoff interview
Open your AI coding agent (Codex or another agent) and paste the Kickoff Prompt below. The agent now runs a short interview,
captures all goal details, and writes/updates `GOALS.md` for you.

Expect questions covering:
- one-sentence summary
- primary/secondary users
- the core problem
- success criteria
- constraints (security, cost, time, tech preferences, deployment)
- non-goals and nice-to-haves

Answer in plain text. The agent will echo a summary for approval before saving `GOALS.md`.

Important:
- The agent reads `AGENTS.md` and `COMMUNICATION.md` before touching code.
- Non-trivial work still requires a spec in `specs/<spec-name>/`.
- Expect 3-7 clarifying questions; answer those first to avoid rework.

### Step 2: Approve the plan and spec
After clarifying questions, the agent should propose:
- 2-3 approaches with trade-offs
- a recommended approach
- a spec directory under `specs/<spec-name>/`
- the first 3-10 tasks

Review the spec and initial tasks. If the scope looks right, let the agent implement in small slices.

### Step 3: Build in small slices
Have the agent do 1-3 tasks at a time, then:
- run tests/checks
- update `specs/<spec-name>/tasks.md`
- update `TODO.md` as the roadmap
- update `DECISIONS.md` when design choices change

### Step 4: Ship
A first shippable version usually means:
- acceptance criteria met
- tasks completed (or explicitly deferred)
- tests passing
- `README.md` includes run instructions for the chosen stack

---

## Kickoff prompt (paste into your AI agent session)

You are an AI engineering collaborator working inside this repo.

First, read and follow:
- `AGENTS.md` (repo rules, quality gates, stop conditions)
- `COMMUNICATION.md` (minimal, ASCII-only communication)
- `CODEX.md` (Codex usage notes, if relevant)

Project goal workflow:
- Check whether `GOALS.md` exists and appears current.
- If it is missing or the human requests an update, run a structured interview to collect:
  - one-sentence summary
  - primary and secondary users
  - problem statement
  - measurable success criteria
  - constraints (security, cost, time, tech preferences, deployment)
  - non-goals
  - nice-to-haves
- Ask one topic at a time, paraphrase what you heard, and confirm before moving on.
- Present the full summary for approval, then write all answers into `GOALS.md` using this template:

```
# Goals

## One sentence
<text>

## Users
- Primary user: <text>
- Secondary user: <text or N/A>

## Problem
<text>

## Success criteria (measurable)
- <item>
- <item>

## Constraints (non-negotiable)
- Security: <text>
- Cost: <text>
- Time: <text>
- Tech preferences: <text>
- Deployment environment: <text>

## Non-goals (explicitly out of scope)
- <item>
- <item>

## Nice-to-haves (only if time)
- <item>
- <item>
```

- If `GOALS.md` already exists and the human confirms it is still accurate, summarize it back so you both share context before moving on.

Now continue the kickoff:
1. Ask 3-7 targeted clarifying questions (only what is necessary).
2. Propose 2-3 viable approaches (stack + architecture) with trade-offs.
3. Choose a recommended approach and record key choices in `DECISIONS.md`.
4. Decide whether this is non-trivial:
   - If non-trivial: create a spec under `specs/<spec-name>/` with:
     - `requirements.md` (user stories + WHEN/THEN/SHALL acceptance criteria)
     - `design.md` (architecture, interfaces, data models, error handling, testing strategy)
     - `tasks.md` (small tasks with [ ] / [x], numbered, dependency-aware)
   - If trivial: explain why no spec is needed and proceed with a small plan.
5. Create or update `TODO.md` with phases, deliverables, success criteria, dependencies, and rollback notes.
6. Output:
   - a short plan
   - the spec path (if created)
   - the first 3-10 tasks you propose to execute next
   - how we will validate (tests, lint, manual repro steps)

Rules:
- ASCII only. No Unicode.
- Do not delete/rename files, change public behavior, add dependencies, or change CI without asking first.
- Keep diffs small and reviewable.
- Always include validation steps.

---

## Coding sessions (repeatable loop)

Use `docs/coding-session-template.md` as the guide for each working block.
- **Start:** confirm goal, constraints, and the next tasks in `specs/<spec-name>/tasks.md`.
- **Work:** implement 1-3 tasks at a time (small diffs).
- **Verify:** run tests and checks.
- **End:** update `tasks.md`, `TODO.md`, `DECISIONS.md`, and append to `FAILURE.log` if something broke.

Tip: For prompt quality and structured outputs, the `agents/codex-platform-specialist.md` role doc is handy.

---

## Definition of done

A project is considered "done" (for a first shippable version) when:
- all acceptance criteria in `requirements.md` are met
- `tasks.md` is fully checked off (or remaining tasks are explicitly deferred)
- tests pass (and new tests exist for key behavior)
- `README.md` has run instructions for the chosen stack
- risks and rollback notes exist for anything that could bite later

---

## Repo map

### Directory layout
```
AGENTS.md                     # how we work in this repo (rules + role workflow)
COMMUNICATION.md              # plain ASCII, confirm before touching files, etc.
AGENTS.overrides.md           # fill in project-specific commands (build/test/lint/CI)
.gitignore                    # sensible defaults
TODO.md, DECISIONS.md         # roadmap + architecture log
FAILURE.log                   # quick capture during failure/debug cycles
MODEL_VERSION                 # current GPT model (synced from gpt-model-registry)

agents_full/                  # full role library (do not edit during a project)
  INDEX.md                    # catalog of available roles

agents/                       # curated role profiles (copied from agents_full/ for this repo)
  ROLESET.md                  # manifest/template for selected roles
  backend-architect.md
  frontend-developer.md
  full-stack-developer.md
  python-pro.md
  code-reviewer.md
  documentation-expert.md
  README.md                   # authoring guidance for role docs

docs/
  project-kickoff-checklist.md
  coding-session-template.md

scripts/
  verify-agents.sh            # CI guard: ensures role workflow files and ASCII checks
  refresh-model.sh            # syncs MODEL_VERSION from the registry

.github/
  pull_request_template.md    # PR checklist mirrors AGENTS.md
  workflows/
    agents-guard.yml          # runs verify-agents.sh on push/PR
    refresh-model.yml         # weekly/manual model sync that opens a PR
```

### Key files
- `AGENTS.md`: rules for agents and humans (quality gates, stop conditions, PR expectations).
- `COMMUNICATION.md`: minimal communication rules.
- `CODEX.md`: how Codex operates in this repo (model defaults, workflow guidance).
- `GOALS.md`: your project goal and constraints (kickoff source of truth).
- `TODO.md`: roadmap template.
- `DECISIONS.md`: architecture decision log.
- `FAILURE.log`: append errors, dead ends, and crash notes.
- `specs/`: spec directories (`requirements.md`, `design.md`, `tasks.md`).
- `agents/`: curated role docs (see `agents/README.md` for maintenance guidance).
- `docs/`: workflow templates (`project-kickoff-checklist.md`, `coding-session-template.md`).
- `scripts/`: helpers such as `verify-agents.sh`.

---

## Why this template?
- **Clarity over chaos.** A short `AGENTS.md` sets universal rules and quality gates.
- **Roles, not soup.** `/agents/*.md` holds focused role profiles (Backend Architect, etc.).
- **Enforced by CI.** GitHub Action fails if required agent files are missing.
- **Docs that matter.** `COMMUNICATION.md`, a project kickoff checklist, and a coding session loop.

---

## Template setup (GitHub + local)

**Use on GitHub:**
1. Click **Use this template** -> **Create a new repository**.
2. Read `AGENTS.md` and `COMMUNICATION.md` for rules.
3. Review `agents_full/INDEX.md`, copy the needed role files into `agents/`, fill `agents/ROLESET.md`, and log the selection in `DECISIONS.md` or the active spec under "Collaboration model".
4. Fill in `AGENTS.overrides.md` with this repo's build/test/lint/CI commands.
5. Confirm **GitHub Actions** is enabled for the repo.
6. Add a repo secret `REGISTRY_TOKEN` with read access to `Connectria/gpt-model-registry` (fine-grained PAT with `contents:read` is enough).
7. Commit + push. The `agents-guard` workflow will enforce the role workflow and ASCII checks.
8. Run the **Refresh Model Version** workflow (manual or wait for the schedule) to sync `MODEL_VERSION`.

**Local:**
```bash
# after cloning
chmod +x scripts/verify-agents.sh
bash scripts/verify-agents.sh   # should exit 0
```

---

## How Codex uses this
- Codex reads `AGENTS.md` for rules, scans `agents_full/INDEX.md`, then copies a focused set of roles into `/agents/` and records them in `agents/ROLESET.md` plus `DECISIONS.md` or the active spec.
- For risky changes, Codex proposes a short plan first, then opens a PR with a diff summary, impacted files, repro steps, and rollback notes if needed.
- The PR template mirrors the checklist in `AGENTS.md`.

---

## Customize per repo
- Copy only the needed role files from `agents_full/` into `/agents/` and keep the curated set short.
- Put stack specifics in `AGENTS.overrides.md` (not in the global rules).
- Use `docs/project-kickoff-checklist.md` to bootstrap structure/CI quickly.
- Use `docs/coding-session-template.md` for the A->F dev loop.

---

## CI guard
The workflow at `.github/workflows/agents-guard.yml` runs the verify script:

```bash
bash scripts/verify-agents.sh
```

It fails the build if:
- `AGENTS.md`, `agents_full/`, `agents_full/INDEX.md`, or `agents/ROLESET.md` are missing
- roles listed in `agents/ROLESET.md` are not present in both `agents/` and `agents_full/`
- `agents/` contains files that do not exist in `agents_full/`
- ASCII-only checks fail for core docs or agent files

> Update the badge at the top of this README with your `<org>/<repo>`.

---

## FAQ
- **Why keep `/agents` small?** Signal > soup. Fewer active roles mean cleaner guidance for Codex and less drift.
- **Where do I put stack commands?** `AGENTS.overrides.md`. If a folder needs custom rules, add `*/AGENTS.md` in that folder.
- **What about company-wide rules?** Use `~/.codex/AGENTS.md`. Repo files win when they conflict.

---

## Contributing
PRs welcome. Please follow the PR template and keep changes small with clear validation steps.

---

## License
Choose a license (MIT/Apache-2.0/etc.) and drop it in `LICENSE`.
