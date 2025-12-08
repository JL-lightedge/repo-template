# Coding Session Template - Codex-First Development

# Use ChatGPT `gpt-5.1` as the default model unless otherwise noted.

## Cycle A - Conversation
**What to Do:**
1. Talk to Codex in the repo's root folder (or on ChatGPT Web)
2. Ask clarifying questions, e.g., "Should I use TypeScript or JavaScript?"
3. Record key decisions in CODEX.md or a dedicated DECISIONS.md

**Tools / Commands:**
```bash
codex: "What language should we use?"
```

## Cycle B - Autonomy
**What to Do:**
1. Give Codex the next phase from TODO.md
2. Let it create files, install deps, write tests
3. Do not interrupt until you're ready to review

**Tools / Commands:**
```bash
codex: "Run Phase 1"
git status
```

## Cycle C - Review & Failure Capture
**What to Do:**
1. Run the repo (npm test, etc.)
2. If something breaks, capture the error in a Failure Log file (e.g., FAILURE.log)
3. Tell Codex "It failed because ..." and let it redesign

**Tools / Commands:**
```bash
codex: "Fix this failure"
```

## Cycle D - Iteration
**What to Do:**
1. Create a new TODO for the next feature (TODO_FEATURE.md)
2. Add a brief description + acceptance criteria
3. Update TODO_PROJECT_TRACKING.md with time estimates vs actuals
4. Document any architectural decisions made in DECISIONS.md or CODEX.md
5. Push the file; Codex will pick up the next task automatically

**Tools / Commands:**
```bash
git add TODO_NEWFEATURE.md && git commit -m "Add new feature TODO"
```

## Cycle E - Analytics
**What to Do:**
1. Run TODO_AI_INSIGHTS.md (weekly)
2. Review insights: code coverage, time per phase, common errors
3. Adjust future phases accordingly

**Tools / Commands:**
```bash
codex: "Run AI Insights"
```

## Cycle F - Session End
**What to Do:**
1. Update SESSION_NOTES.md with current status and any blocking questions
2. Run tests to ensure nothing is broken before ending session
3. Commit all progress with descriptive message
4. Note performance benchmarks if applicable (LLM response times, vector DB queries)

**Tools / Commands:**
```bash
git add . && git commit -m "End session: [brief summary]"
```
