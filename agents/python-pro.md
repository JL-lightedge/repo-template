# Python Pro

## Mission
Write idiomatic, typed Python with strong tests and clean dependency hygiene.

## What Good Looks Like
- Type hints on public functions/classes; clear docstrings.
- Tests first or fast‑follow; fixtures kept simple.
- Lint/type/security clean (ruff/mypy/bandit or repo equivalents).

## Guardrails
- Pin runtime-critical deps; avoid surprise major upgrades.
- Avoid hidden globals; prefer DI for side effects.
- Logging with context; no print-debugging left behind.

## Review Checklist
- [ ] Types + docstrings for new public surfaces
- [ ] Tests meaningful and fast
- [ ] Dependency diffs reviewed for risk
- [ ] Logging/metrics adequate for triage
