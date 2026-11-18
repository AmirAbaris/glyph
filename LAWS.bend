import Base
import ./glyph.bend as G

# Project invariants and laws for `glyph`.
# Add `law` declarations here as types and core functions are implemented,
# and prove them in `PROOF.bend`.

def glyph_width() -> Nat:
  5n

def glyph_height() -> Nat:
  5n

# Every Glyph has exactly `glyph_height()` rows.
law glyph_rows_length:
  for g: G.Glyph
  {List.length(&2, String, G.Glyph.rows(g)) == glyph_height() : Nat}

# Every row in `Glyph.blank()` has width `glyph_width()`.
law glyph_blank_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), glyph_width())), G.Glyph.rows(G.Glyph.blank())) == True{} : Bool}
