# Project Kickoff Checklist (Codex)

A lightweight checklist to bootstrap a new repo so Codex can ship on day one.

1) **AGENTS.md** (repo rules + Role Registry)
   - Copy the repo starter version. Keep it provider-agnostic.

2) **TODO.md** (roadmap & phases)
   - Split into phases; for each: feature, deliverable, success criteria, deps, rollback plan.

2.5) **DECISIONS.md** (architecture choices)
   - Record decisions with rationale and alternatives considered.

3) **CI** (`.github/workflows/main.yml` or equivalent)
   - Install deps; run tests and linters on every push/PR.

4) **Dependencies** (`package.json` / `requirements.txt` / etc.)
   - Declare minimal starting deps; let PRs expand as needed.

4.5) **Config** (`config/` + `config.example` + `.env.example`)
   - Document required settings; keep secrets out of VCS.

5) **.gitignore**
   - Use language-appropriate ignores.

6) **README.md**
   - One-liner to run locally; link to docs.

6.5) **FAILURE.log** (empty)
   - Append crash/errors during Cycle C to speed up iteration.

7) **Create working branch** (e.g., `phase-1`)
   - Keep main clean; merge when a phase completes.

---

## Success criteria
- CI green from the first commit.
- Clear plan (TODO) and decisions (DECISIONS).
- Minimal local run instructions in README.
- No secrets committed; config templates exist.
