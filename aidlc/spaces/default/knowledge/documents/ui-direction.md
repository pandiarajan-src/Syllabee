# UI Direction – Syllabee

**Status: PROVISIONAL (2026-11-15).** No Claude Design mockup was available when this file was written, so the tokens below are a reasoned starting set. When you produce the Claude Design mockup, replace the values in sections 3–5 with the exported ones, change this status to `FINAL`, and keep the accessibility rules in section 6 (they are requirements, not style).

## 1. Personality
Calm, warm, a little playful. The name is a bee pun, so honey/amber is the accent. Lots of whitespace, one centred column, no clutter. Feels like a quiet puzzle, not a casino.

## 2. Screens in scope (v0.1–v0.3)
1. **Passcode** – logo/name, one password field, one "Enter" button, inline error area.
2. **Game** – header (name, log-out button), 6x5 tile grid, on-screen keyboard, message area. Later: stats dialog.
3. **Log out** – returns to the passcode screen; no confirmation dialog.
States to design: empty board, typing, invalid-word message, locked-out message, win, lose (answer revealed), loading, server error. No size or difficulty options anywhere.

## 3. Colour tokens
Contrast ratios were computed (WCAG 2.x). Body text must stay at or above 4.5:1; tile letters at or above 7:1.

| Token | Light | Dark | Notes |
|---|---|---|---|
| `--color-bg` | `#FFF8E7` | `#1E1E22` | page background |
| `--color-surface` | `#FFFFFF` | `#2B2B30` | cards, dialogs, keys |
| `--color-text` | `#1A1A1A` | `#F5F1E6` | 16.4:1 on light bg, 12.5:1 on dark surface |
| `--color-text-muted` | `#8A4B00` | `#C9C2B0` | 6.4:1 on light bg |
| `--color-accent` | `#FFC83D` | `#FFC83D` | honey; buttons, focus accents |
| `--color-on-accent` | `#1A1A1A` | `#1A1A1A` | 11.3:1 on accent |
| `--tile-correct-bg` | `#FFC83D` | `#FFC83D` | letter `#1A1A1A`, 11.3:1 |
| `--tile-present-bg` | `#6CB4EE` | `#6CB4EE` | letter `#1A1A1A`, 7.8:1 |
| `--tile-absent-bg` | `#4A4A52` | `#4A4A52` | letter `#FFFFFF`, 8.8:1 |
| `--tile-empty-border` | `#C9BFA5` | `#55555C` | empty / typing tile outline |
| `--color-error` | `#B3261E` | `#F2B8B5` | error text, with an icon |
| `--color-focus-ring` | `#1A1A1A` | `#FFFFFF` | 3px, offset 2px |

Why amber + blue: they stay distinct for the most common colour-vision deficiencies, unlike red/green. They still must not be the only signal (section 6).

## 4. Typography
- Font stack (no web fonts, so no licence or loading cost): `system-ui, -apple-system, "Segoe UI", Roboto, sans-serif`.
- Tile letters: 700 weight, upper case, `clamp(1.5rem, 6vw, 2rem)`.
- Title: 700, 1.75rem. Body: 400, 1rem, line-height 1.5. Small/help text: 0.875rem.

## 5. Spacing, size, shape, motion
| Token | Value |
|---|---|
| Spacing scale | 4, 8, 12, 16, 24, 32, 48 px (`--space-1`…`--space-7`) |
| Tile size | 56 px (52 px under 360 px wide); gap 6 px |
| Key | min 44 x 56 px (touch target at least 44 px) |
| Max content width | 480 px, centred |
| Radius | tiles 4 px, keys 6 px, buttons 8 px |
| Border | 2 px tile outline |
| Flip animation | 300 ms per tile, 100 ms stagger |
| Shake (invalid word) | 250 ms |

## 6. Accessibility rules (required)
1. **Colour is never the only signal.** Each evaluated tile also has an accessible name ("R, correct", "A, present", "N, absent") and a small corner marker: filled dot = correct, ring = present, none = absent.
2. A high-contrast / colour-blind toggle may swap to orange `#F5793A` (correct) and blue `#85C0F9` (present); design it, ship later if needed.
3. Everything works with keyboard only: physical keys type, Enter submits, Backspace deletes; visible focus ring on every control.
4. Messages (invalid word, win, lose, lockout) are announced via an `aria-live="polite"` region.
5. `prefers-reduced-motion`: no flip or shake; state changes appear instantly.
6. `prefers-color-scheme` selects light/dark; both must meet the contrast values above.
7. Passcode input: `type="password"`, `autocomplete="current-password"`, visible label (not placeholder-only), error linked with `aria-describedby`.
8. E2E tests select by role and label, so these names are part of the contract.

## 7. Implementation notes
- Plain CSS modules; tokens are CSS custom properties defined once at `:root` and in a `[data-theme="dark"]`/media-query block.
- No UI framework, no icon font; inline SVG for icons.
- Mobile first, portrait; desktop is the same column, centred.

## 8. How this file is used
- Stage 2.5 Refined Mockups must match these tokens and screens.
- Stage 2.5 output and the final implementation are compared to this file in the Construction review.
- Any deviation is written back here (one source of truth for colours).
