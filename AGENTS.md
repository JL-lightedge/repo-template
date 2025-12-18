# AGENTS.md

This file defines how AI agents (Codex included) should work in this repository.
Project-specific instructions belong in folder-level */AGENTS.md or in
AGENTS.overrides.md (optional).

ASCII-only. No Unicode characters in code or docs.

----------------------------------------------------------------

## 1) Core Principles (Always)
- Prefer clarity over cleverness.
- Make small, reviewable changes.
- Do not guess requirements. Ask targeted questions before big edits.
- Propose a plan before multi-file changes.
- Keep humans in the loop for medium/high risk work.

----------------------------------------------------------------
## Roles (Mandatory)

This repo requires role files under /agents/ to guide multi-agent collaboration.
Before starting non-trivial work, the agent must:
1) Identify the primary role for the work
2) Identify 1-2 supporting roles (as needed)
3) Follow the role guidance during implementation and review

----------------------------------------------------------------

If required role files are missing or incomplete:
- STOP and ask the human to add them, or
- scaffold them using the templates in agents/README.md (if present),
  then ask for human approval before proceeding.

## 2) Non-trivial Work Requires a Spec (Mandatory)
A spec is required BEFORE implementation for any non-trivial change.

Non-trivial examples:
- New feature or new endpoint
- Any change to public behavior, inputs/outputs, or config
- Multi-file refactor
- Cross-cutting concerns (auth, payments, data model, caching, migrations)
- Performance work that changes algorithms or data access patterns
- Security-related changes
- Dependency additions or major version upgrades

Trivial examples (spec not required):
- Typos, formatting, comment fixes
- Small doc clarifications
- Narrow bug fix in one file with obvious expected behavior
- Test-only fixes that do not change behavior

If there is doubt: treat it as non-trivial.

----------------------------------------------------------------

## 3) Spec Structure (Source of Truth)
Create specs under:
specs/<spec-name>/
  - requirements.md
  - design.md
  - tasks.md

When a spec exists, it is the source of truth. Implementation must stay aligned.

Optional file references in specs:
#[[file:relative_file_path]]

### 3.1 requirements.md (What and Why)
Include user stories and acceptance criteria.

User story format:
- As a <user type>, I want <functionality>, so that <benefit>.

Acceptance criteria format (numbered):
- WHEN <condition> THEN the system SHALL <behavior>.

Acceptance criteria must cover:
- happy path
- error cases
- edge cases
- non-functional requirements when relevant (performance, security, etc.)

### 3.2 design.md (How)
Document:
- architecture and boundaries
- interfaces/contracts and data models
- error handling and recovery
- testing strategy
- key trade-offs and decisions

### 3.3 tasks.md (Execution Plan)
Break work into small tasks with clear completion criteria and traceability to
requirements.

Task conventions (ASCII-only):
- [ ] pending
- [x] completed

Use hierarchical numbering (1, 1.1, 1.2...) and keep tasks dependency-aware.

### 3.4 Spec Approval Checkpoint (Recommended)
For non-trivial work:
1) Draft requirements.md, design.md, tasks.md
2) Request human review/approval of the spec
3) Implement tasks sequentially
4) Validate against acceptance criteria
5) Update tasks.md progress as you go

## Roles (Mandatory, Auto-Selected)

This repo uses a role library plus a project-specific working set.

- agents_full/ is the full role library (do not modify during a project).
- agents/ is the streamlined set of roles selected for THIS project.

Workflow:
1) After the initial interview/clarifying questions, the agent must:
   a) scan agents_full/INDEX.md to understand available roles
   b) select the minimum set of roles needed for this project
   c) copy the selected role files from agents_full/ into agents/
   d) write agents/ROLESET.md describing what was selected and why

  Also record the selected roles in:
- DECISIONS.md (as an early decision), or
- specs/<spec-name>/design.md under a "Collaboration model" heading.


2) The agent must use agents/ as the active role source after selection.

Selection rules:
- Default to 3-8 roles total. Ask before selecting more than 8.
- Always include:
  - a primary builder role (implementation)
  - a reviewer role (code-reviewer or equivalent)
  - a test/quality role (qa/test engineer or equivalent)
  - a docs role when user-facing behavior exists

agents/ROLESET.md must include:
- Primary role: <filename>
- Supporting roles: <filenames>
- Reviewer role: <filename>
- For each role: 1-2 lines on why it was chosen
- Any missing roles from agents_full/ that would be useful

Stop condition:
- If agents/ is missing, or agents_full/ is missing, STOP and ask the human.
- Do not delete or overwrite existing agents/ files without asking first.


----------------------------------------------------------------

## 4) Quality Gates (Non-negotiable)
Every change must:
1) Build/compile (if applicable)
2) Pass tests (unit and integration where present)
3) Pass repo linters/typechecks/security checks (use existing config)
4) Update docs when behavior changes
5) Provide reproducible validation steps in the PR description

If a gate is missing in this repo, recommend a minimal addition rather than
assuming one.

Definition of done for non-trivial work:
- All acceptance criteria met
- Tests added/updated for critical behavior
- No new warnings/errors in CI-equivalent checks
- Docs updated for user-facing changes
- Rollback or revert plan documented for risky changes

----------------------------------------------------------------

## 5) Safety, Security, and Privacy (Always)
- Never introduce or print secrets (keys, tokens, passwords).
- Never commit .env files or credentials.
- Do not add telemetry, external calls, or data exfiltration.
- Validate inputs at boundaries (API, CLI, file parsing).
- Apply least privilege patterns where applicable.
- Prefer safe defaults. Fail closed rather than open when security is involved.

----------------------------------------------------------------

## 6) Stop Conditions (Ask First)
Ask for clarification before doing any of the following:
- deleting or renaming files/folders
- changing public APIs, config formats, or behavior
- database/schema migrations
- adding new dependencies or major upgrades
- changing authn/authz logic
- modifying CI/CD workflows
- introducing background jobs, scheduled tasks, or network egress

----------------------------------------------------------------

## 7) Tooling and Dependencies
- Use the repo's existing tooling and patterns.
- Do not add new frameworks/libraries unless clearly justified and requested.
- Prefer minimal dependencies.
- Keep changes portable (this is a starter template).

----------------------------------------------------------------

## 8) Communication Style
- Keep responses brief and specific.
- State assumptions explicitly.
- For non-trivial work, provide:
  - a short plan
  - expected impacted files
  - validation steps

See COMMUNICATION.md if present.

----------------------------------------------------------------

## 9) Pull Request Expectations (Agents and Humans)
PR title: imperative + scoped (example: "Add request validation to upload route")

PR body should include:
- context and goal
- approach and trade-offs
- validation steps (commands or actions)
- risks and rollback/revert plan (if applicable)
- spec path (if non-trivial): specs/<spec-name>/

PR checklist:
- [ ] linked issue/task or spec path
- [ ] tests added/updated
- [ ] lint/type/security checks pass
- [ ] docs updated where relevant
- [ ] acceptance criteria verified (non-trivial work)

----------------------------------------------------------------

## 10) Folder Overrides
This file is the repo default.
Folder-level */AGENTS.md may override these rules for that subtree.
If rules conflict, the closest folder-level AGENTS.md wins.

----------------------------------------------------------------

## 11) Optional Role Registry
If the repo uses roles, store them under /agents/.
Agents may suggest reviewers based on role fit.

----------------------------------------------------------------

## 12) Suggested Enforcement (Optional)
If enforcement is enabled, CI or pre-commit can verify:
- AGENTS.md exists
- specs exist for non-trivial changes (when applicable)
Suggested script path: scripts/verify-agents.sh
