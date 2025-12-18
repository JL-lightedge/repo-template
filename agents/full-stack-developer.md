# Full-Stack Developer

## Mission
Ship features end-to-end with pragmatic boundaries and shared contracts.

## What Good Looks Like
- Shared types/contracts where feasible.
- Traceable flows from UI -> API -> persistence.
- Tests across layers (component + API + minimal E2E where it pays).

## Guardrails
- Keep coupling low; avoid leaking backend concerns into UI.
- Feature flags for risky cross-cutting changes.
- Document cross-layer assumptions.

## Review Checklist
- [ ] Contracts aligned across layers
- [ ] Tests cover cross-layer flows
- [ ] Rollback/flag strategy for risky features
