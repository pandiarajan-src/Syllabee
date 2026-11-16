#!/usr/bin/env bash
# Creates the Step-1 starter files in the git repo containing the current directory.
# Content mirrors the committed files; if you change one, change the other.
# Usage (from anywhere in the repo):  bash create-starter-files.sh [github-username]
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "Run this inside a git repository."; exit 1; }
cd "$ROOT"
OWNER="${1:-$(gh api user -q .login 2>/dev/null || true)}"
OWNER="${OWNER#@}"
[[ "$OWNER" =~ ^[A-Za-z0-9]([A-Za-z0-9-]{0,37}[A-Za-z0-9])?$ ]] || {
  echo "Pass a valid GitHub username: bash create-starter-files.sh <username>"; exit 1; }

mkdir -p .github

write() {  # write <path>  (content on stdin); never overwrites; writes atomically
  local target="$1" tmp
  if [ -e "$target" ]; then
    echo "SKIP  $target already exists"; cat >/dev/null
  else
    tmp="$(mktemp "$target.XXXXXX")"
    cat > "$tmp" && mv "$tmp" "$target" && echo "OK    $target"
  fi
}

write SECURITY.md <<'EOF'
# Security Policy

## Reporting a vulnerability
Please **do not** open a public issue for a security problem.

Use GitHub's private channel instead:
1. Open the **Security** tab of this repository.
2. Click **Report a vulnerability**.
3. Describe what you found, how to reproduce it, and the impact.

I will acknowledge your report within 7 days and aim to fix confirmed issues quickly. This is a personal learning project, so these are best-effort targets, not guarantees.

## Supported versions
Only the latest release on `main` is supported.

## Scope
In scope: the web app, its API, the build and deploy pipeline.
Out of scope: denial-of-service by volume, social engineering, third-party services (Fly.io, GitHub).

## What not to include
Never send real passcodes, tokens or secrets in a report.
EOF

write .github/CODEOWNERS <<EOF
*                              @${OWNER}
/.github/                      @${OWNER}
/scripts/                      @${OWNER}
/SECURITY.md                   @${OWNER}
/aidlc/spaces/*/memory/        @${OWNER}
/.claude/settings.json         @${OWNER}
/docs/sandbox-changelog.md     @${OWNER}
EOF

write .github/pull_request_template.md <<'EOF'
## What and why
<!-- One or two sentences. -->

## AI-DLC links
- Intent: #
- Unit: #
- Workflow profile: mvp / enterprise / feature / infra / bugfix / security-patch / express / poc / refactor / workshop / classic
- Autonomy: gated / autonomous

## Tests
- [ ] New or changed behaviour has an automated test (unit and/or E2E)
- [ ] Requirement-to-test mapping updated
- [ ] Bug fix? A failing regression test came first

## Gate evidence
- `make verify` exit status: <!-- paste: exit 0 -->
- CI run: <!-- link -->
- Coverage (backend / frontend): <!-- % / % -->

## Safety checks
- [ ] No secrets, passcodes or answer words in code, logs or screenshots
- [ ] Security-relevant change reviewed against `project.md` Security rules
- [ ] No sandbox or permission settings changed (or `docs/sandbox-changelog.md` updated)
- [ ] `aidlc/` records committed with the code

## Learning
- [ ] One learning saved in `LEARNING-LOG.md` (or "none this time")
EOF

write LEARNING-LOG.md <<'EOF'
# Learning Log

One entry per step or release. Keep it short: the point is to teach the team later.

| Date | Step / release | One surprise | One thing to teach the team |
|---|---|---|---|

## Longer notes (optional)
<!-- Dated paragraphs for anything that does not fit in the table. -->
EOF

echo; echo "Done. Review with: git status"
