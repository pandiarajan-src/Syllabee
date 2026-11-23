# Scope Document: Syllabee

## Minimum Viable Scope

Three releases, each building on the one before, all must-have (Q3):

| Release | What a player can do |
|---------|----------------------|
| v0.1 | Enter the shared passcode, see an empty game board, and log out |
| v0.2 | Play one full game (six attempts, five letters) with correct letter colouring |
| v0.3 | Resume a game after refreshing the page, and see win/loss stats |

Source: Q1 (confirmed), intent-statement.md.

## In Scope

- One shared passcode for a small private group; no accounts and no personal data
- One game page with six attempts and five letters; no size or difficulty options
- The three releases above, in that order (dependency-first, Q4)

## Out of Scope

Multiple word lengths, hard mode, theme picker, leaderboards, social sharing, accounts or per-user passcodes, AI hints, multiple machines or replicas, and any paid third-party service. Source: Q1 (confirmed).

## Dependencies

- Each release needs the one before it (Q4).
- v0.2 needs the word list, which the owner supplies (constraint-register.md, C-10).
- Going live needs the hosting account the owner has yet to create (constraint-register.md, C-09).

## Success Measures

- Each release is live on staging, smoke-tested, with all checks green (intent-statement.md).
- Production is live at v1.0 and each invited person has played at least one full game (Q5).

## Deadlines

None; each release ships when ready (feasibility Q4).

## Assumptions & Open Questions

- Open: what v1.0 contains beyond v0.3 is not yet defined (Q2). Until decided, v1.0 is treated as a label for production going live, not as new scope.
