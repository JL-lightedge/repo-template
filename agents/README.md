# `/agents` – Role Docs for Codex

This folder contains **role profiles** (“agents”) that Codex consults in this repo. Keep each role **short, actionable, and evergreen**.

## How this fits together
- **Repo rules:** `AGENTS.md` at repo root (quality gates, PR standards, Role Registry).
- **Role details:** One file per role here under `/agents/` (e.g., `backend-architect.md`).
- **Folder overrides:** If a submodule needs stack‑specific rules, add `*/AGENTS.md` in that folder.

## Authoring a role doc
Use this skeleton and keep it to ~150–250 lines:

```md
# <Role Name>

## Mission
One sentence on what this role optimizes (e.g., "scalable APIs, clear boundaries, safe migrations").

## What Good Looks Like
- Observable behavior/criterion
- Tests/validation expectations
- Non‑negotiables

## Guardrails
- Security/perf pitfalls, inputs that must be validated, things to never do.

## Review Checklist
- [ ] Contracts stable or versioned
- [ ] Tests added/updated
- [ ] Lint/type/security passes
- [ ] Docs touched if behavior changed

## Playbook (Optional)
- Common refactors, patterns, or commands **for this repo only**.
```

## Naming & linking
- File names: **kebab‑case** (e.g., `python-pro.md`, `cloud-architect.md`).
- Display names in the Role Registry can be title‑cased (e.g., “Python Pro”).

## Linting & enforcement
- CI (or pre‑commit) should **fail** if `AGENTS.md` is missing or any roles referenced in its Role Registry are absent.
- Recommended script: `scripts/verify-agents.sh`

```bash
#!/usr/bin/env bash
set -euo pipefail
ROOT_AGENTS="AGENTS.md"
[ -f "$ROOT_AGENTS" ] || { echo "Missing $ROOT_AGENTS"; exit 1; }
MISSING=0
# Find role paths in the Role Registry lines
AGENTS=$(sed -n 's/.*→ `\(.*\)`/\1/p' "$ROOT_AGENTS")
for f in $AGENTS; do
  if [ ! -f "$f" ]; then echo "Missing role doc: $f"; MISSING=1; fi
done
exit $MISSING
```

## GitHub Action (optional)
Create `.github/workflows/agents-guard.yml` to enforce presence.

```yaml
name: agents-guard
on: [push, pull_request]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Verify agents
        run: bash scripts/verify-agents.sh
```
