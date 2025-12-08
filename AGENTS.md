# AGENTS.md (Repo Starter — Provider-agnostic)

> One file that teaches Codex **how we work in this repository**. Keep it short, strict, and universal. Project/stack specifics go in `AGENTS.overrides.md` (optional) or subfolder `*/AGENTS.md` files.

---

## 1) Purpose & Scope
- Establish **engineering principles** for this repo.
- Define **quality gates** and **review expectations**.
- Centralize a **Role Registry** without bloating this file.

**Out of scope:** language/framework commands, Docker/K8s specifics, cloud/IaC details, secrets.

---

## 2) How Codex Should Behave (Always)
- **Bias to clarity over cleverness.** Explain trade‑offs for non‑obvious changes.
- **Work in small slices.** Minimal diffs and incremental PRs.
- **Interrogate the brief.** Ask targeted questions before large edits.
- **Propose, then apply.** Show a short plan before multi‑file changes.
- **Keep humans in the loop.** If risk > medium, open a PR instead of auto‑applying.

---

## 3) Quality Gates (Non‑negotiable)
Every change must:
1) **Build/Compile** (if applicable)
2) **Pass Tests** (unit & integration where present)
3) **Pass Linters/Types/Security** (use existing repo config)
4) **Update Docs** (README/CHANGELOG or module docs) when behavior changes
5) **Include Repro Steps** in the PR description

> If a gate is missing in this repo, recommend a minimal addition rather than assuming one.

---

## 4) Decision Priorities (Tie‑breaker order)
1. **Testability** → easy to verify?
2. **Readability** → future devs won’t swear at it?
3. **Consistency** → matches established patterns?
4. **Simplicity** → fewest moving parts?
5. **Reversibility** → easy to roll back?

---

## 5) Communication & Change‑Control (always)
- **Plain ASCII** in code/docs; **no Unicode**.
- **Minimal responses**; answer the question, nothing extra.
- **Confirm before creating/changing files**.
- **Don’t remove functionality** unless explicitly requested.

See `COMMUNICATION.md` for details.

---

## 6) Pull Request Expectations (Codex & Humans)
- **Title:** imperative + scoped (e.g., “Add optimistic updates to totals”).
- **Body:** context → approach → validation → risks/next steps.
- **Checklist:**
  - [ ] Linked issue/task or brief
  - [ ] Tests added/updated
  - [ ] Lint/type/security clean
  - [ ] Docs updated where relevant
  - [ ] Rollback plan or feature flag if risky

> Codex should attach: diff summary, impacted files, and quickstart to reproduce.

---

## 7) Code Review Standard (what Codex enforces when asked to review)
- **Correctness:** edge cases & failure modes considered
- **API/Contract safety:** backward‑compatible or versioned
- **Security:** no secrets; least privilege; input validation
- **Performance:** hotspots called out with alternatives
- **Docs:** public surface documented; comments explain intent, not trivia

---

## 8) Role Registry (Your “Agents”)
Codex should assume **one primary role** per task and propose additional reviewers from related roles. Roles are stored as **separate Markdown files** under `/agents/`.

### Core roles (included in this repo)
- **Backend Architect** → `/agents/backend-architect.md`
- **Frontend Developer** → `/agents/frontend-developer.md`
- **Full‑Stack Developer** → `/agents/full-stack-developer.md`
- **Python Pro** → `/agents/python-pro.md`
- **Code Reviewer** → `/agents/code-reviewer.md`
- **Documentation Expert** → `/agents/documentation-expert.md`

> **Usage:** Select the role that best matches the task. If multiple roles apply, pick **one lead** and list others as requested reviewers.

---

## 9) Minimal Task Template (Codex should preface work with this)
**Context:** what’s changing and why  
**Constraints:** non‑negotiables (e.g., must be backward‑compatible)  
**Plan:** small steps with expected diffs  
**Tests:** what proves it works  
**Risks & Rollback:** feature flag or revert path

See `docs/coding-session-template.md` for the A→F cycle and examples.

---

## 10) Documentation Rules (Always‑on)
- Any new public surface or behavior change requires a doc touch.
- Keep docs close to code and update examples when APIs shift.
- Prefer plain language and short sections over exhaustive prose.

If missing, Codex should scaffold:
- `docs/project-kickoff-checklist.md`
- `docs/coding-session-template.md`

---

## 11) What Not To Do (Anywhere)
- Don’t introduce toolchains/infra that aren’t already in the repo **without** an RFC/PR.
- Don’t bypass tests/linters “just this once.”
- Don’t land breaking API changes without a migration note and versioning plan.

---

## 12) Local vs. Folder‑level Rules
This file is the **repo default**. Folders may add a `*/AGENTS.md` with more specific rules (commands, stack, cloud).  
- If there’s a conflict: **Folder overrides win**. Keep overrides factual; don’t duplicate universal rules.

---

## 13) How to Ask Codex (Prompt Patterns)
- **Implement:** “Make the cart totals update optimistically; add tests; no breaking API changes; if risky, propose a flag.”
- **Refactor:** “Extract payment gateway adapters; keep behavior; fail if coverage drops.”
- **Review:** “Review for security regressions, public API changes, and perf hotspots; suggest fixes inline.”

For session flow, see `docs/coding-session-template.md`.

---

## 14) Bootstrap & Enforcement
- If roles listed above are missing in `/agents/`, Codex should **scaffold** them using the skeleton in `/agents/README.md`.
- Codex should also scaffold `COMMUNICATION.md` and the two docs in §10 if absent.
- CI or pre‑commit must **fail** when: (a) this `AGENTS.md` is missing, or (b) any Role Registry file is missing.
- Enforcement script: `scripts/verify-agents.sh` (currently invoked manually). Add a CI workflow to call it when CI is introduced.

