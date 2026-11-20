# glyph

A small, beginner-friendly ASCII art generator written purely in [Bend](https://bend-lang.com/) (Bend 2.0+).

## Usage

Render text to the terminal:

```sh
bend main.bend "HELLO"
```

Example output:

```text
#   # ##### #     #      ### 
#   # #     #     #     #   #
##### ####  #     #     #   #
#   # #     #     #     #   #
#   # ##### ##### #####  ### 
```

Other examples:

```sh
# Lowercase and multi-word arguments (joined with spaces)
bend main.bend hello world

# Full A-Z alphabet
bend main.bend "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

# No arguments (prints usage and a default "GLYPH" sample)
bend main.bend
```

## Verifying Proofs & Type Checks

Run the formal proofs and edge-case invariants:

```sh
bend PROOF.bend
```

Type-check individual modules without running `main`:

```sh
bend glyph.bend --check-only
bend font.bend --check-only
bend render.bend --check-only
bend main.bend --check-only
bend PROOF.bend --check-only
```

If Lean / `$BENDTT` is installed, you can also run the kernel check:

```sh
bend PROOF.bend --verdict
```

## Project Layout

- `glyph.bend` — Core `Glyph` `Data` type (`5x5` character grid), `Glyph.rows`, and `Glyph.blank`.
- `font.bend` — Character-to-glyph map for `A–Z`, spaces, and `?` fallback (`font_unknown`), normalizing lowercase letters.
- `render.bend` — Recursive and parallel row-by-row text rendering (`string_to_glyphs`, `render_glyphs`, `render_lines`, `render_text`).
- `main.bend` — CLI entrypoint reading `IO.args()` and printing rendered ASCII art via `IO.print`.
- `LAWS.bend` — Formal invariants and `law` declarations (`glyph_width`, `glyph_height`, dimension, rendering, and CLI properties).
- `PROOF.bend` — Proofs for every law declared in `LAWS.bend`.

## Bend 2.0+ Fundamentals Demonstrated

1. **Custom `Data` types** (`glyph.bend`): `type Glyph is Data:` defines a reusable 5-row structure (`r0`..`r4`) that can be freely copied across functions and parallel branches.
2. **Pattern matching** (`font.bend`, `render.bend`, `main.bend`): `match` dispatches on characters (`'A'`..`'Z'`, `' '`, `_`), `Nat` row indices (`0n`..`4n`), `String` constructors (`SNil{}`, `SCon{h, t}`), and `List` shapes (`Nil{}`, `h <> t`).
3. **Structural recursion** (`render.bend`, `main.bend`): Functions like `string_to_glyphs`, `collect_row`, and `join_args` recurse on strictly smaller tails so Bend's termination checker proves every function halts.
4. **`List` & `String` processing** (`glyph.bend`, `render.bend`, `main.bend`): Uses `List<&2, String>`, `List.length`, `String.join`, and `String.to_upper` from Bend's `Base`.
5. **Parallel calls** (`render.bend`): Uses Bend's parallel let notation (`a b = f(x) g(y)`) to evaluate adjacent `font_lookup` calls in `string_to_glyphs` and independent rows in `render_glyphs` concurrently.
6. **`IO` monad** (`main.bend`): Uses `do IO<Unit>:` with `IO.args()` and `IO.print()` to keep side effects strictly at the CLI boundary.
7. **Law-driven verification** (`LAWS.bend` & `PROOF.bend`): Encodes dimension, empty-input, alphabet, multi-word, unknown-character, and CLI invariants as `law`s and proves them mechanically with `bend PROOF.bend`.
