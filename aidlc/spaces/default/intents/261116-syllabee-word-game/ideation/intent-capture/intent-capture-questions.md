# Intent Capture Questions

## Sources

- [desc] Initial description: "A production-ready five-letter word game web app Syllabee. A user enters a shared passcode, then sees one game page (six attempts, five letters only, no size options), and can log out. FastAPI backend, React frontend, SQLite. Read the knowledge documents for rules, threat model and UI direction. Deliver in small vertical releases: v0.1 login/empty board/logout, v0.2 playable game, v0.3 resume + stats. AI hints are out of scope for this intent."
- [scope] Workflow-selected scope: `mvp`.

## Q1. [Product owner] What your documents already answer

Your documents already cover these points. Please confirm them so I do not ask each one separately.

- Who it is for: a small private audience (family, friends, team) who are given one shared passcode; no accounts, no sign-up, no personal data collected (product-brief.md, "Users").
- What it is: a five-letter word-guessing web game called Syllabee. A player enters the passcode, plays one game on one page (six attempts, five letters, no size or difficulty options) and logs out (product-brief.md, "One-line description" and "Scope").
- Name rule: the product is called Syllabee and never "Wordle"; it uses its own word list (product-brief.md, "Naming").
- Left out of this first version: multiple word lengths, hard mode, theme picker, leaderboards, social sharing, user accounts or per-user passcodes, AI hints, multiple machines or replicas, any paid third-party service (product-brief.md, "Out of scope").
- Release order: v0.1 enter passcode, see an empty board, log out; v0.2 play one full game with correct colouring; v0.3 resume a game after refresh and see win/loss stats (product-brief.md, "Releases").

- A. All correct
- B. Some need changing (say which and how)
- X. Other (please specify)

[Answer]: A. All correct

## Q2. [Product owner] Why is this being built now?

Your documents do not say what triggered this work. The answer frames the problem statement.

- A. A personal or hobby project for a private group
- B. A practice run for building software with the AI-DLC process
- C. Replacing a word game the group uses today
- D. Not yet defined
- X. Other (please specify)

[Answer]: B. A practice run for building software with the AI-DLC process

## Q3. [Product owner] What does success look like?

Your documents set a quality bar (tested, scanned, deployed through the pipeline) but no measurable success outcome for the product itself. Pick the closest, or give your own numbers under Other.

- A. Each release (v0.1, v0.2, v0.3) is live on staging, smoke-tested, with all checks green
- B. A, plus production is live at v1.0 and the invited group actually plays it
- C. A specific measurable target (give it under Other, for example "10 players finish a game in the first month")
- D. Not yet defined
- X. Other (please specify)

[Answer]: B. A, plus production is live at v1.0 and the invited group actually plays it

## Q4. [Product owner] Who decides scope and priority?

Your documents do not name who settles scope questions or priority conflicts.

- A. You alone
- B. You, with one named co-owner
- C. A small group decides together
- D. Not yet defined
- X. Other (please specify)

[Answer]: A. You alone

## Q5. [Product owner] Who else has a stake in this work? (select all that apply)

Your documents name the players and the shared passcode, but not who looks after the passcode or who signs off a production release.

- A. Only you and the players
- B. A separate person who holds or rotates the shared passcode
- C. A separate person who gives the manual production-release approval
- D. None identified yet
- X. Other (please specify)

[Answer]: A. Only you and the players

## Q6. [Product owner] How do you want progress reported?

Your documents say every pull request updates the aidlc/ records, but not whether anyone needs a separate update.

- A. The pull request per unit and its updated records are enough
- B. A, plus a short written note when each release ships
- C. A regular written update (say how often under Other)
- D. No reporting needed
- X. Other (please specify)

[Answer]: B. A, plus a short written note when each release ships

## Q7. [Product owner] Beyond the list in Q1, is there anything else this first version should NOT do?

This asks only about the product, not the plan you chose.

- A. Nothing more than the list in Q1
- B. Something more (say what under Other)
- C. Not yet defined
- X. Other (please specify)

[Answer]: A. Nothing more than the list in Q1

## Consolidated Summary Confirmation

- Looks correct
- Request changes

[Answer]: Looks correct
