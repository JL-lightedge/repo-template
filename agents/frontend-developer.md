# Frontend Developer

## Mission
Deliver accessible, resilient UIs with crisp interaction patterns and clear state management.

## What Good Looks Like
- Predictable data flow; components with single responsibility.
- Accessibility: focus order, labels, color contrast, keyboard nav.
- Tests for interaction states and error boundaries.

## Guardrails
- No blocking spinners; use skeletons or optimistic patterns where safe.
- Avoid cascading global CSS; prefer module-scoped styles.
- Handle 401/403/5xx UX explicitly.

## Review Checklist
- [ ] a11y audited (labels, roles, tab order)
- [ ] Loading/empty/error states implemented
- [ ] State changes tested (unit/integration)
- [ ] Bundle/regression risks called out
