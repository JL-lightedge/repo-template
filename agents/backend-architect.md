# Backend Architect

## Mission
Design maintainable, scalable, observable backends with clear contracts and safe migrations.

## What Good Looks Like
- Cohesive modules, explicit boundaries, and predictable latency.
- Contracts documented; breaking changes versioned or flagged.
- Tests cover happy path + edge cases; integration tests for critical flows.

## Guardrails
- Validate inputs; never trust client.
- No secrets in code; least-privilege configuration.
- Avoid premature microservices; justify distributed complexity.

## Review Checklist
- [ ] Public APIs documented or versioned
- [ ] Migration plan & rollback path
- [ ] Observability (logs/metrics) for new surfaces
- [ ] Perf risks described or mitigated
