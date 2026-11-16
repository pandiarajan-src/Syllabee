# Threat Model Seed – Syllabee

**Status:** seed, 2026-11-15. A starting point for the Security hat in Mob Elaboration, not a finished model. The Security stage should extend it, not replace it. Rules that mitigate each threat live in `project.md` (Security section); the "Check" column says how we prove the mitigation.

## 1. Assets (what we protect)
| Asset | Why it matters | Where it lives |
|---|---|---|
| Shared passcode | Only gate to the game | Argon2 hash in `PASSCODE_HASH` secret; plain text only in the human's head |
| `SESSION_SECRET` | Forging sessions or CSRF tokens | Fly secret / GitHub environment secret |
| Session ids | Impersonating a logged-in player | `sessions` table (SQLite); cookie in browser |
| The answer word | Cheating ruins the game | Server memory/DB; never sent before game end |
| SQLite file + volume | Games, stats, sessions | Fly volume `/data`, off-machine backup |
| Deploy tokens | Production takeover | App-scoped, GitHub environment secrets |
| Source repo + CI | Supply-chain entry | Public GitHub repo, rulesets, Actions |
| Developer machine | Agents run shell commands | Claude Code strict sandbox |
| Ollama endpoint (v1.1) | Unauthenticated local LLM | localhost only; off in production |

Not stored, by design: emails, names, passwords per user, payment data.

## 2. Actors
| Actor | Goal | Capability |
|---|---|---|
| Anonymous internet visitor | Get in without the passcode | Scripts, brute force, scanners |
| Passcode holder who shares it | (Unintentional) wider access | Valid passcode |
| Logged-in cheater | Learn the answer or play unlimited | Browser dev tools, API calls |
| Bot / scanner | Find known vulnerabilities | Automated, high volume |
| Malicious dependency or action | Run code in build/runtime | Supply chain |
| Misbehaving AI agent | Exceed its permissions, leak secrets | Shell, file tools in dev environment |
| Prompt-injection source (v1.1) | Make the hint model leak the answer | Crafted user chat text |

## 3. Top abuse cases
| # | Abuse case | Main mitigation (rule) | Check |
|---|---|---|---|
| A1 | Brute-force the passcode | Rate limit + back-off after repeated failures; constant-time compare; strong passcode | Unit test for lockout; E2E wrong passcode; production check |
| A2 | Stolen or leaked passcode hash | Argon2 with tuned cost; hash only in secrets; no hash in repo/logs | Secret scan in CI; log review |
| A3 | Session theft or fixation | Random server-side id; cookie HttpOnly, Secure, SameSite=Strict; rotate id on login; idle + absolute expiry; logout deletes session | Skeleton eval: inspect cookie flags; expiry test |
| A4 | CSRF on state-changing calls | CSRF token on POST; SameSite=Strict | Test: POST without token is rejected |
| A5 | Reading the answer from API/JS/storage | Evaluate guesses on the server; answer absent from payloads, bundles, logs, errors until game over | Test: scan responses and built assets for the answer |
| A6 | Skipping attempts limit (replay, parallel requests) | Server-side attempt counter in a transaction; reject after game over | Concurrency test: two simultaneous 6th guesses |
| A7 | Malformed or oversized input, injection | Pydantic validation (5 letters A–Z); parameterised queries only | Fuzz/negative tests; SAST |
| A8 | Missing security headers / XSS | CSP, HSTS, X-Content-Type-Options, Referrer-Policy, frame-ancestors none; React escaping, no `dangerouslySetInnerHTML` | Header test; ZAP/headers scan on staging |
| A9 | Secrets leaking into repo, image, logs, errors | Env-var config only; secret scanning + push protection; generic error messages | CI secret scan; image inspection |
| A10 | Vulnerable or malicious dependency | Pinned lock files, Dependabot, dependency scan blocks High/Critical, MIT-compatible licences only | CI scan job; ruleset requires it |
| A11 | CI/CD abuse (token theft, rogue workflow) | App-scoped deploy tokens in environment secrets; production needs tag + manual approval; least-privilege `GITHUB_TOKEN` | Review workflow permissions; environment rules |
| A12 | Agent exceeds its sandbox or exfiltrates data | Strict sandbox; SANDBOX BLOCKED protocol; only the human edits settings | Step 2b eval checklist |
| A13 | Data loss or corruption of SQLite | Off-machine backup; migrations backward compatible for one release; restore drill | Restore test before v1.0 |
| A14 | Denial of service via request flood | Rate limits; small machine limits; health check + auto-restart | Basic load check on staging |
| A15 | Hint abuse / prompt injection (v1.1) | Feature flag off in production; backend builds prompt; answer not echoable; max hints per game; output leak check | `evals/hints/` leak test |

## 4. Trust boundaries
1. Browser <-> FastAPI (everything from the browser is untrusted).
2. FastAPI <-> SQLite file (trusted, but protect from corruption).
3. GitHub Actions <-> Fly.io (tokens cross this line).
4. Developer machine <-> agents (the sandbox is the boundary).
5. FastAPI <-> Ollama (v1.1; local only).

## 5. Questions the Security hat must settle
- Idle and absolute session lifetimes.
- Lockout thresholds (attempts, window, per IP and/or global) and what a locked-out user sees.
- What is logged (never the passcode, hash, session id, or answer).
- Passcode rotation process and who may do it.
- Whether one shared passcode needs a global (not only per-IP) failure limit, since all players share it.

## 6. Out of scope for now
Per-user accounts, MFA, multi-region failover, formal penetration test, DDoS protection beyond Fly defaults.
