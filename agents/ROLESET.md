# ROLESET

Use this template after the kickoff interview to select roles from `agents_full/` and copy them into `agents/`.

- Default to 3-8 roles total. Ask for approval before selecting more than 8.
- Record the chosen roles below and capture the same list in `DECISIONS.md` or `specs/<spec-name>/design.md` under "Collaboration model".

## Primary role
- prompt-engineer.md - Drives the kickoff prompt redesign and automates the GOALS.md interview flow with strong prompt-pattern expertise.

## Supporting roles
- documentation-expert.md - Keeps README language clear and user-friendly as we update the onboarding instructions.
- qa-expert.md - Ensures the new automated flow has unambiguous validation steps and edge-case coverage in the prompt.

## Reviewer role
- code-reviewer.md - Performs the final review for accuracy, style, and regression risks.

## Notes
- Missing roles from `agents_full/` that might help: codex-platform-specialist.md if we later extend tool-calling guidance.
- Context for how the roles will collaborate: Prompt Engineer drafts the new kickoff prompt, Documentation Expert polishes the README narrative, QA Expert sanity-checks interview coverage, and Code Reviewer signs off on the final wording.
