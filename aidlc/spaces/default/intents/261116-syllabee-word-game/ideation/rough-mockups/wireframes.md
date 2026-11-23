# Wireframes: Syllabee

Low-fidelity concept sketches for releases v0.1 to v0.3. Sources: ui-direction.md (sections 1, 2, 6, 7), rough-mockups Q1 to Q4. A finished visual mockup is to be supplied before the refined mockups stage (Q4), so shapes below are provisional.

Upstream artifacts: the three releases and their order come from scope-document and intent-backlog; the players and the product name come from intent-statement.

Accessibility target: WCAG 2.1 level AA (Q2).

## Screen 1: Passcode (v0.1)

```
+------------------------------------------+
|                                          |
|               Syllabee                   |
|                                          |
|   Passcode                               |
|   [ ******************************** ]   |
|   (error message appears here)           |
|                                          |
|              [   Enter   ]               |
|                                          |
+------------------------------------------+
```

- States: ready, entering, wrong passcode (inline error), locked out (message), loading, server error.
- Accessibility: page title is the h1 "Syllabee"; landmark: main; keyboard entry point is the passcode field, and Enter submits. The field has a visible label, and its error is announced.

## Screen 2: Game (v0.1 empty, v0.2 playable, v0.3 resumable)

```
+------------------------------------------+
|  Syllabee                    [ Log out ] |
+------------------------------------------+
|                                          |
|        [ ] [ ] [ ] [ ] [ ]               |
|        [ ] [ ] [ ] [ ] [ ]               |
|        [ ] [ ] [ ] [ ] [ ]               |
|        [ ] [ ] [ ] [ ] [ ]               |
|        [ ] [ ] [ ] [ ] [ ]               |
|        [ ] [ ] [ ] [ ] [ ]               |
|                                          |
|   (message area)                         |
|                                          |
|   Q W E R T Y U I O P                    |
|    A S D F G H J K L                     |
|   Enter Z X C V B N M Back               |
+------------------------------------------+
```

- v0.1: the empty grid with a short "game coming soon" message (Q3); no playable keyboard behaviour is promised.
- v0.2: typing fills tiles; Enter submits a guess; each checked letter shows one of three results (correct, present, absent) by colour plus a marker, never colour alone.
- v0.3: a page refresh returns the player to the game in progress; a stats dialog shows wins and losses.
- States: empty board, typing, invalid-word message, win, lose (the answer is shown), loading, server error.
- Accessibility: heading level h1 "Syllabee" in the header; landmarks: header, main; keyboard entry point is the first control in the header, then the keys; typed letters from a physical keyboard also work. Each checked tile has a spoken name such as "R, correct".

## Screen 3: Stats dialog (v0.3)

```
+------------------------------+
|  Your record           [ X ] |
|                              |
|   Games played    __         |
|   Wins            __         |
|   Losses          __         |
|                              |
+------------------------------+
```

- Accessibility: dialog heading h2 "Your record"; focus moves into the dialog and returns to the button that opened it; Escape closes it.

## Screen 4: Log out

No separate screen: choosing Log out returns to the Passcode screen with no confirmation (ui-direction.md, section 2).

## Information Hierarchy

1. The grid of attempts (primary).
2. The message area (feedback on the last action).
3. The keyboard (input).
4. The header with Log out (secondary).

No size or difficulty options appear anywhere.

## Assumptions & Open Questions

- The exact visual style is provisional until the finished mockup arrives (Q4).
- The content of the stats dialog beyond wins and losses is not defined; the sketch shows games played, wins and losses only as a placeholder and the scope names only win/loss stats.
