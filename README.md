# Codex Repo Skeleton

> A sane, lightweight template for repos that use **Codex** (ChatGPT) as a coding partner. It gives you: rules, roles, CI enforcement, and docs that help you ship.

[![agents-guard](https://github.com/<org>/<repo>/actions/workflows/agents-guard.yml/badge.svg)](https://github.com/<org>/<repo>/actions/workflows/agents-guard.yml)

---

## Why this template?
- **Clarity over chaos.** A short `AGENTS.md` sets universal rules and quality gates.
- **Roles, not soup.** `/agents/*.md` holds focused role profiles (Backend Architect, etc.).
- **Enforced by CI.** GitHub Action fails if required agent files are missing.
- **Docs that matter.** `COMMUNICATION.md`, a project **kickoff checklist**, and a **coding session** loop.

---

## What’s inside
```
AGENTS.md                     # how we work in this repo (rules + Role Registry)
COMMUNICATION.md              # plain ASCII, confirm before touching files, etc.
AGENTS.overrides.md           # fill in project-specific commands (build/test/lint/CI)
.gitignore                    # sensible defaults
TODO.md, DECISIONS.md         # roadmap + architecture log
FAILURE.log                   # quick capture during failure/debug cycles

agents/                       # role profiles (keep this list tight per repo)
  backend-architect.md
  frontend-developer.md
  full-stack-developer.md
  python-pro.md
  code-reviewer.md
  documentation-expert.md
  README.md                   # how to author roles + verify script example

docs/
  project-kickoff-checklist.md
  coding-session-template.md

scripts/
  verify-agents.sh            # CI guard: fails if Role Registry files are missing

.github/
  pull_request_template.md    # PR checklist mirrors AGENTS.md
  workflows/
    agents-guard.yml          # runs verify-agents.sh on push/PR
```

---

## Quick start
**Use on GitHub:**
1. Click **Use this template** → **Create a new repository**.
2. Open `AGENTS.md` and **keep the Role Registry lean** (only roles you want active here).
3. Fill in `AGENTS.overrides.md` with this repo’s **build/test/lint/CI** commands.
4. Confirm **GitHub Actions** is enabled for the repo.
5. Commit + push. The `agents-guard` workflow will enforce presence.

**Local:**
```bash
# after cloning
chmod +x scripts/verify-agents.sh
bash scripts/verify-agents.sh   # should exit 0
```

---

## How Codex uses this
- Codex reads **`AGENTS.md`** for rules → picks a **primary role** from `/agents/*.md` for the task.
- For risky changes, Codex proposes a **short plan** first, then opens a PR with:
  - diff summary, impacted files, repro steps, and a rollback plan/flag if needed.
- The **PR template** mirrors the checklist in `AGENTS.md`.

---

## Customize per repo
- Add/remove role files under `/agents/` to match the project. Keep the registry short.
- Put stack specifics in **`AGENTS.overrides.md`** (not in the global rules).
- Use `docs/project-kickoff-checklist.md` to bootstrap structure/CI quickly.
- Use `docs/coding-session-template.md` for the A→F dev loop.

---

## CI guard
The workflow at `.github/workflows/agents-guard.yml` runs the verify script:
```bash
bash scripts/verify-agents.sh
```
It fails the build if:
- `AGENTS.md` is missing, or
- any **Role Registry** path points to a non-existent file.

> Update the badge at the top of this README with your **<org>/<repo>**.

---

## FAQ
**Why keep `/agents` small?**  Signal > soup. Fewer active roles mean cleaner guidance for Codex and less drift.

**Where do I put stack commands?**  `AGENTS.overrides.md` (repo-specific). If a folder needs custom rules, add a `*/AGENTS.md` in that folder.

**What about company-wide rules?**  Use `~/.codex/AGENTS.md` (global). The repo files override global when they conflict.

---

## Contributing
PRs welcome. Please follow the **PR template** and keep changes small with clear validation steps.

---

## License
Choose a license (MIT/Apache-2.0/etc.) and drop it in `LICENSE`.

