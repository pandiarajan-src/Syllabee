# Project-Level Rules

> Project-specific specialisation and corrections. Loaded after `org.md` and
> `team.md` as strict-additive guidance.
> Populated by practices-discovery and the self-learning loop.
>
> Use sparingly: most teams don't need a project layer. Reach for it
> only when this specific project needs stable, durable guidance beyond the
> team practice (for example, package-specific release checks or an additional
> regression suite for a legacy component).

## Guard Policy

Mode: strict

## Tech Stack

- Backend: Python (current stable), FastAPI, Pydantic, SQLite via SQLAlchemy, Alembic migrations.
- Frontend: React with TypeScript, built with Vite. No UI framework beyond plain CSS modules.
- Tests: pytest (backend), Vitest + React Testing Library (frontend), Playwright with TypeScript (E2E).
- Packaging: one Docker image; FastAPI serves the built frontend. Multi-stage build, non-root user.
- Hosting: Fly.io, one machine, one volume mounted at /data for the SQLite file.
- Licences: MIT or similarly permissive dependencies only.
- Record exact versions in lock files; never use unpinned dependencies.

## Way of Working

- Trunk-based: short branches, one pull request per unit, squash merge.
- Every release is a vertical slice: backend, frontend, unit tests and an E2E test together.
- Every pull request links its intent and unit, and updates the aidlc/ records.
- Conventional Commits for commit messages.
- Architecture decisions list at least two alternatives.
- Ask before adding any new dependency or external service.
- "make verify" is the single verification command and must exit 0.

## Walking Skeleton

- First unit is the thinnest end-to-end slice: passcode login, empty game page, logout.
- It must include: one FastAPI route, one React page, one SQLite table, one unit test per side, one Playwright test, the Docker build, and a green CI run.
- The skeleton is deployed to staging before any other unit starts.

## Testing Posture

- Test-first for game rules (guess evaluation, duplicate letters, win/lose).
- Coverage floors: backend lines 85%, frontend lines 75%. Game-rule module 100% branches.
- Every requirement maps to at least one automated test; the mapping is written down.
- Every bug fix starts with a failing regression test.
- E2E: Playwright covers login, wrong passcode, full winning game, full losing game, logout, refresh mid-game.
- E2E tests select by role and label, not CSS classes.
- Tests never call real external services; the LLM is always faked in CI.
- A test report produced by an agent is not evidence until the suite passes in CI.

## Code Style

- Python: ruff (lint + format), mypy strict, type hints everywhere, pathlib, no bare except.
- TypeScript: strict mode, ESLint, Prettier, function components and hooks only.
- Small modules: routes thin, rules in pure functions, storage behind a repository layer.
- No commented-out code, no TODO without an issue number.
- Public functions have a docstring with one example.

## Security

- The passcode is never stored or logged in plain text; only an Argon2 hash, supplied as a secret.
- Compare secrets in constant time. Rate-limit login attempts and back off after repeated failures.
- Sessions: random server-side session id in SQLite; cookie HttpOnly, Secure, SameSite=Strict; idle and absolute expiry; logout deletes the session.
- State-changing requests require CSRF protection.
- The answer word never leaves the server before the game ends.
- Validate all input with Pydantic; accept exactly five letters A–Z.
- Send security headers: Content-Security-Policy, Strict-Transport-Security, X-Content-Type-Options, Referrer-Policy, frame-ancestors none.
- No secrets in the repository, images, logs or error messages. Configuration comes from environment variables.
- Parameterised queries only.
- Dependencies are scanned in CI; High or Critical findings block the merge.

## Sandbox (strict)

- The Claude Code sandbox is the default and only execution environment for shell commands.
- Never run or retry a command outside the sandbox. Never use dangerouslyDisableSandbox.
- Never edit, create or propose bypassing .claude/settings.json, .claude/settings.local.json or ~/.claude settings. Only the human changes them.
- Never work around a block with another tool (file tools, WebFetch, MCP servers, hooks, a different command, a script, a container).
- When the sandbox or a permission rule blocks an action: stop that action, post a SANDBOX BLOCKED report, and wait for the human. Continue only with work that does not depend on the blocked action.
- A SANDBOX BLOCKED report states: the exact command; what was denied (host, path, or tool); why the task needs it; the settings file, key and exact value to add; the risk of adding it; and an alternative that needs no change.
- Ask for the narrowest change: one host, one path, one command pattern. Never ask for wildcards.
- Commands needing accounts, tokens or production access (fly, gh, docker login, git push) are run by the human, not requested as sandbox changes.
- In automatic Construction mode a sandbox block counts as a failure: halt and report.

## Deployment

- Environments: staging and production on Fly.io, separate apps and volumes.
- Only GitHub Actions deploys. Merge to main deploys staging; production needs a tagged release and manual approval.
- Deploy tokens are app-scoped and stored as GitHub environment secrets.
- Database migrations run automatically at start-up and are backwards compatible for one release.
- Every deploy runs a smoke test; a failed smoke test triggers rollback to the previous image.
- /healthz endpoint for Fly health checks; structured JSON logs without personal or secret data.
- SQLite file is backed up off the machine.

## Definition of Done

- Code, tests, docs and aidlc/ records merged through a pull request with all checks green.
- Deployed to staging and smoke-tested.
- Requirement-to-test mapping updated.
- No open High or Critical security findings.

## Decided

<!-- Decisions made in earlier stages that should not be re-asked. -->
<!-- Format: DECIDED: [decision] (Stage [slug], [date]) -->

## Scope Overrides

<!-- Custom scope rules for this project. -->

## Forbidden

<!-- Populated by practices-discovery affirmation gate. -->
<!-- Format: - NEVER [behavior] (affirmed [date]) -->
<!-- Example: - NEVER throw exceptions across service layer boundaries (affirmed 2026-05-17) -->

## Mandated

<!-- Populated by practices-discovery affirmation gate. -->
<!-- Format: - ALWAYS [behavior] (affirmed [date]) -->
<!-- Example: - ALWAYS use Result<T,E> for fallible operations in service layer (affirmed 2026-05-17) -->

## Corrections

<!-- Project-specific corrections from human feedback. -->
<!-- Format: NEVER/ALWAYS [behavior] (learned [date]) -->
