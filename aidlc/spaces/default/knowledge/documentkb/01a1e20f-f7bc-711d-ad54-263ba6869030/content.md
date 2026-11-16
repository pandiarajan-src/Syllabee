# Game Rules – Syllabee

**Status:** v1, 2026-11-15. This is the single source of truth for game logic. The game-engine unit implements it; tests in "Test vectors" below are mandatory and must be copied into the pytest suite.

## 1. Basics
- The answer is one secret word of exactly **5 letters, A–Z** (English, no accents, no hyphens, no proper nouns).
- The player has **6 attempts**.
- Guesses are evaluated **on the server only**. The answer never leaves the server before the game ends.

## 2. What counts as a valid guess
A guess is valid only if **all** are true:
1. Exactly 5 characters after trimming whitespace.
2. Only letters A–Z (case-insensitive; normalised to upper case on the server).
3. The word is in the **allowed-guess list** (the allowed list is a superset of the answer list).

An invalid guess is rejected with a clear message and **does not use up an attempt**. Reject reasons are distinct: `wrong_length`, `invalid_characters`, `not_in_word_list`.
Guesses after the game has ended are rejected (`game_over`).

## 3. Colouring algorithm (two passes)
Each guess letter gets one state:
- `correct` – right letter, right position
- `present` – letter is in the answer, wrong position
- `absent` – letter is not in the answer, or all its copies are already accounted for

**Pass 1 – correct.** For each position, if guess[i] == answer[i], mark `correct`. Remove that answer letter from the pool of available letters.
**Pass 2 – present/absent.** Go left to right over the remaining (unmarked) guess letters. If the letter is still in the pool, mark `present` and remove one copy from the pool; otherwise mark `absent`.

Consequences (this is where bugs hide):
- A letter is never marked `present` more times than it occurs in the answer.
- `correct` always wins over `present` for the same letter.
- Surplus copies are `absent` even though the letter exists in the answer.
- Among `present` copies, the leftmost ones are marked first.

## 4. Test vectors (G = correct, Y = present, X = absent)
| Answer | Guess | Result | What it proves |
|---|---|---|---|
| CRANE | CRANE | GGGGG | exact match |
| CRANE | SLATE | XXGXG | simple greens, no yellows |
| ABIDE | SPEED | XXYXY | second E is absent (answer has one E) |
| ROBOT | FLOOR | XXYGY | green consumes an O before the yellow pass |
| ABBEY | BOBBY | YXGXG | two Bs in answer; one green, one yellow, extra B absent |
| CRANE | EERIE | XXYXG | green E consumes the only E; earlier Es are absent |

Add property-style checks: result length is always 5; count(correct)+count(present) for any letter never exceeds its count in the answer; evaluating the answer itself gives GGGGG.

## 5. Win, lose, end of game
- **Win:** a valid guess evaluates to GGGGG on attempt 1–6. Game ends; answer shown.
- **Lose:** attempt 6 is valid and not GGGGG. Game ends; the answer is revealed.
- After the game ends no further guesses are accepted.
- The answer is revealed only at game end, and only to the session that played it.

## 6. Keyboard state
Each on-screen key shows the best state seen so far for that letter: `correct` > `present` > `absent`. A key never downgrades.

## 7. Resume (from v0.3)
Refreshing the page restores the in-progress game (guesses and their results) from the server. Stats are updated once, when the game ends.

## 8. Word lists
- Answer list and allowed-guess list are our own files in the repo, with a recorded source and a **permissive (MIT-compatible) licence**.
- Answer list: common five-letter words only, no offensive words. Allowed list: answer list plus less-common valid words.
- A test checks both lists: every entry is 5 letters A–Z, upper case, no duplicates, and every answer is in the allowed list.

## 9. Test mode
E2E and unit tests need a **fixed answer**. A test-only setting (never enabled in staging or production) fixes the answer word. CI must fail if this setting is on in a deploy config.

## 10. Open decisions (Product hat, Mob Elaboration)
- Daily word vs new random word per game.
- Whether a started game expires and after how long.
