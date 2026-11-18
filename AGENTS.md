# AGENTS.md

Guidance for coding agents working on `glyph`.

## Project Overview

`glyph` is a small, beginner-friendly ASCII art generator written purely in [Bend](https://bend-lang.com/) (Bend 2.0+). It converts text input into large fixed-width ASCII art letters printed to the terminal.

## Scope & Requirements

### In Scope
- **Character support**: Uppercase `A–Z`, with graceful handling for spaces and unknown characters.
- **Fixed dimensions**: Fixed-width, fixed-height character representation (`glyph_width` = `5n`, `glyph_height` = `5n` in `LAWS.bend`).
- **Terminal-only IO**: CLI input and output using `IO` (`IO.args`, `IO.print`).
- **Idiomatic Bend 2.0+**:
  - Functions and recursion
  - Custom types (`type ... is Data`) and pattern matching
  - Lists and `String` processing
  - Parallelism via Bend's parallel call notation where independent computations (such as glyph lookup/rendering) can run concurrently
- **Formal verification**: Record invariants and `law` declarations in `LAWS.bend` and prove them in `PROOF.bend`.

### Out of Scope
- No web UI or browser bundling.
- No external dependencies beyond Bend's `Base`.
- Do not commit compiled artifacts (`*.c`, `*.js`, `*.mjs`, `*.out`, `main` — ignored in `.gitignore`).

## Repository Layout

- `README.md` — Project goals, constraints, and usage.
- `LAWS.bend` — Project invariants (`glyph_width`, `glyph_height`) and `law` declarations.
- `PROOF.bend` — Proofs for the laws declared in `LAWS.bend`.
- `main.bend` — CLI entry point (once implemented; run with `bend main.bend "HELLO"`).

## Development Workflow

1. **Review Bend 2.0+ conventions first**:
   ```sh
   bend guide
   ```
   Use `bend base [--types|<name>]` to inspect `Base` types and functions.
2. **Keep invariants & proofs in sync**:
   When adding new types or core functions, add corresponding invariants/`law` declarations in `LAWS.bend` and prove them in `PROOF.bend`.
3. **Verify before committing**:
   ```sh
   bend PROOF.bend
   bend PROOF.bend --verdict # requires Lean / $BENDTT
   ```
   When `main.bend` or additional `.bend` modules exist, also run:
   ```sh
   bend <file.bend> --check-only
   bend main.bend "HELLO"
   ```
