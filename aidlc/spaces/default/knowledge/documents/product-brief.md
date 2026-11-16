# Product Brief – Syllabee

**Status:** v1 of the brief, 2026-11-15. Source: `02-Wordle-Plan/00-README.md`. Agents read this before writing requirements; if it conflicts with a user answer in Mob Elaboration, the user answer wins and this file gets updated.

## One-line description
Syllabee is a five-letter word-guessing web game. A player enters a shared passcode, plays one game on one page, and logs out.

## Naming
"Wordle" is a New York Times trademark. The product is called **Syllabee**. Never use "Wordle" in UI text, repo name, domain, or marketing. Use our own word list, not a copy of the NYT lists.

## Users
- Small private audience (family, friends, team) who are given one shared passcode.
- No accounts, no sign-up, no email, no personal data collected.

## Scope (what the product is)
| Item | Decision |
|---|---|
| Flow | Passcode screen -> game page -> log out |
| Passcode | One shared passcode, stored only as an Argon2 hash in a secret |
| Game | Five letters, six attempts, no size or difficulty options |
| Backend | FastAPI + SQLite (single Fly.io machine, one volume) |
| Frontend | React, Vite, TypeScript, plain CSS modules |
| Hosting | Fly.io staging + production, deployed only by GitHub Actions |
| Tests | pytest, Vitest + React Testing Library, Playwright E2E |
| AI hints | Later (v1.1), local Ollama only, switched off in production |

## Out of scope (until a later intent says otherwise)
- Multiple word lengths, hard mode, themes picker, leaderboards, social sharing
- User accounts or per-user passcodes
- AI hints (v1.1 only; not part of the MVP intent)
- Multiple machines / replicas (SQLite allows one writer)
- Any paid third-party service

## Releases (small, complete vertical slices)
| Release | User can... | Expected units |
|---|---|---|
| v0.1 Walking skeleton | Enter passcode, see an empty board, log out | `auth-session` |
| v0.2 Playable | Play one full game with correct colouring | `game-engine`, `game-ui` |
| v0.3 Complete | Resume a game after refresh; see win/loss stats | `persistence-stats` |
| v1.0 | Same as v0.3 after production-readiness sign-off | – |
| v1.1 | Ask for a hint (local only) | `hints` |

Every release ships backend + frontend + unit tests + an E2E test together.

## Quality bar
Production ready: every release is tested, scanned, deployed through the pipeline. Coverage floors, security rules and Definition of Done live in `project.md`; this file does not repeat them.

## Open product decisions (settle in Mob Elaboration, Product hat)
1. One shared daily word, or a new random word per game?
2. Which stats are shown at v0.3 (played, win %, current streak, guess distribution)?
3. Exact wording of error messages (wrong passcode, invalid word, locked out).

Do not guess these. Ask.
