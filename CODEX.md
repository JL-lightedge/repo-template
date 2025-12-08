# CODEX.md

## Purpose
- Serves as the ChatGPT/Codex equivalent of CLAUDE.md.
- Provides a single, repo-wide reference for how to use Codex agents, models, and tooling in this codebase.
- Keep this file updated whenever architecture, workflows, or agent expectations change.

## Default Model
- Use `gpt-5.1` for all Codex tasks by default.
- If `gpt-5.1` is temporarily unavailable, document the constraint and the fallback choice before proceeding.
- Prefer `gpt-5.1` variants that satisfy latency or cost goals when selecting a faster tier; return to the default as soon as possible.

## How to Use This File
- Read this file before running any Codex-assisted workflow in the repo.
- Add links or short sections for:
  - Project architecture highlights or diagrams.
  - Key workflows (build, test, deploy) and required commands.
  - Agent dispatch rules (which agent handles what, escalation paths).
  - Known integration constraints (tooling limits, rate limits, environment notes).
- Keep guidance concise and action-oriented; link to source files instead of duplicating instructions.

## Maintenance Checklist
- Update model references here and in agent profiles when Codex defaults change.
- Reflect any new quality gates, security requirements, or testing expectations.
- Align examples with current prompt patterns and repository conventions.
- Review this file during each release cycle or after major architectural changes.
