# User Flow: Syllabee

## Core Flow (happy path)

```
Visit site
    |
    v
[Passcode screen] --wrong passcode--> inline error --> try again
    |                                       |
    | correct passcode             repeated failures
    v                                       v
[Game screen]                      locked-out message
    |
    | (v0.2) type five letters, press Enter
    v
[Result per letter shown] --> more attempts left? --yes--> type next guess
    |                                  |
    | win or sixth attempt used        no
    v                                  v
[Win or lose message; answer shown on loss]
    |
    | (v0.3) refresh page
    v
[Game screen restored to the game in progress]
    |
    v
[Log out] --> [Passcode screen]
```

## Flow by Release

| Release | Flow covered |
|---------|--------------|
| v0.1 | Passcode, wrong passcode, empty game screen with "game coming soon" message, log out |
| v0.2 | Typing a guess, invalid-word message, per-letter results, win, lose with the answer shown |
| v0.3 | Refresh restores the game in progress; stats dialog shows wins and losses |

## Error and Edge Paths

- Wrong passcode: inline error on the passcode screen.
- Too many wrong passcodes: a locked-out message.
- Invalid word: a message is shown (ui-direction.md, section 2).
- Server error or slow loading: a clear message, with the player's progress kept.

## Information Architecture

- Two screens (Passcode, Game) and one dialog (Stats). Logging out leads back to Passcode.

## Assumptions & Open Questions

- Whether an invalid word uses up an attempt is a game-rule question for the requirements stage, not decided here.
