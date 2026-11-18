# glyph

A small, beginner-friendly ASCII art generator written purely in [Bend](https://bend-lang.com/).

## Goal

Convert text input into large fixed-width ASCII art letters printed to the terminal, focusing on Bend fundamentals:

- Functions and recursion
- Custom types (`type ... is Data`) and pattern matching
- Lists and `String` processing
- `IO` monad (`IO.args`, `IO.print`)
- Formal invariants with `LAWS.bend` and `PROOF.bend`
- Parallelism where independent computations can run concurrently

## Constraints

- Uppercase `A–Z` support (with graceful handling for spaces and unknown characters)
- Fixed-width, fixed-height character representation
- Terminal output only (no web UI, no external dependencies)
- Beginner-friendly, idiomatic Bend 2.0+

## Development Workflow

1. Run `bend guide` to review Bend 2.0+ syntax, affine/data rules, termination, and parallelism.
2. Record important invariants and type/function laws in `LAWS.bend`.
3. Verify proofs before committing:
   ```sh
   bend PROOF.bend
   ```
4. Parallelize independent work (e.g., glyph lookup/rendering) using Bend's parallel call notation where appropriate.

## Running (once implemented)

```sh
bend main.bend "HELLO"
```
