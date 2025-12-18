# COMMUNICATION.md

This repo follows strict, minimal, human-first communication. Keep it clear and ASCII-only.

## Defaults (always)
- **No Unicode** in code or docs (use plain ASCII).
- **Minimal responses** - answer the question, nothing extra.
- **Confirm before creating/changing files** (list the files you plan to touch).
- **Do not remove functionality** unless explicitly requested.
- **No AI-sounding prose** - natural tone, concise.

## When asking Codex for changes
- State the **intent** ("Implement X" / "Refactor Y" / "Review Z").
- Call out **constraints** (compatibility, security posture, perf targets).
- Ask for a short **plan** before multi-file edits.
- Require a **PR with checklist** for risky work.

## When Codex responds
- Expect a **diff summary**, **impacted files**, and **repro steps**.
- If anything is ambiguous, Codex should ask **one or two targeted questions** before proceeding.

## Violations
- If these rules are violated (e.g., surprise file changes, verbose essays, Unicode), revert and restate the request.

