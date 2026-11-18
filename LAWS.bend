import Base
import ./glyph.bend as G
import ./font.bend as F
import ./render.bend as R
import ./main.bend as M

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

# Every Glyph returned by `font_lookup` has `glyph_height()` rows.
law font_lookup_rows_length:
  for c: Char
  {List.length(&2, String, G.Glyph.rows(F.font_lookup(c))) == glyph_height() : Nat}

# Every row in `font_unknown()` has width `glyph_width()`.
law font_unknown_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), glyph_width())), G.Glyph.rows(F.font_unknown())) == True{} : Bool}

# Space maps to `Glyph.blank()`.
law font_lookup_space:
  {F.font_lookup(' ') == G.Glyph.blank() : G.Glyph}

# Lowercase letters normalize to their uppercase glyphs.
law font_lookup_lowercase:
  {F.font_lookup('a') == F.font_lookup('A') : G.Glyph}

# Every row in `font_lookup` for space, A-Z, a-z, and sample unknown characters has width `glyph_width()`.
law font_lookup_width:
  {List.all(~&2, ~Char, ~(c => List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), glyph_width())), G.Glyph.rows(F.font_lookup(c)))), [' ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '?', '0', '!']) == True{} : Bool}

# Empty input renders to an empty list of lines and an empty String.
law render_empty_lines:
  {R.render_lines("") == Nil{} : List<&2, String>}

law render_empty_text:
  {R.render_text("") == "" : String}

# Converting any String to Glyphs preserves its length.
law string_to_glyphs_length:
  for s: String
  {List.length(&2, G.Glyph, R.string_to_glyphs(s)) == String.length(s) : Nat}

# Rendering any non-empty String produces exactly `glyph_height()` lines.
law render_non_empty_lines_length:
  for c: Char
  for rest: String
  {List.length(&2, String, R.render_lines(SCon{c, rest})) == glyph_height() : Nat}

# Rendering a 2-character string produces lines of width 2 * glyph_width() + 1 = 11n.
law render_two_char_line_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), 11n)), R.render_lines("HI")) == True{} : Bool}

# Full A-Z alphabet renders with `glyph_height()` lines, each of width 26 * 5 + 25 = 155n.
law render_alphabet_height:
  {List.length(&2, String, R.render_lines("ABCDEFGHIJKLMNOPQRSTUVWXYZ")) == glyph_height() : Nat}

law render_alphabet_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), 155n)), R.render_lines("ABCDEFGHIJKLMNOPQRSTUVWXYZ")) == True{} : Bool}

# Lowercase input renders identically to uppercase input.
law render_lowercase_matches_upper:
  {R.render_text("hello") == R.render_text("HELLO") : String}

# Spaces and multi-word strings preserve fixed-width alignment across every line.
law render_space_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), 17n)), R.render_lines("A B")) == True{} : Bool}

law render_multi_word_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), 65n)), R.render_lines("HELLO WORLD")) == True{} : Bool}

# Unknown/punctuation characters render via the '?' fallback glyph with fixed width.
law render_unknown_punctuation:
  {R.render_text("HI!") == R.render_text("HI?") : String}

law render_unknown_punctuation_width:
  {List.all(~&2, ~String, ~(r => Nat.is_eq(String.length(r), 17n)), R.render_lines("HI!")) == True{} : Bool}

# CLI argument helpers handle empty, script-only, and multi-word inputs cleanly.
law cli_user_args_empty:
  {M.cli_user_args(Nil{}) == Nil{} : List<String>}

law cli_user_args_script_only:
  {M.cli_user_args(["main.bend"]) == Nil{} : List<String>}

law cli_user_args_strips_program:
  {M.cli_user_args(["main.bend", "hello", "world"]) == ["hello", "world"] : List<String>}

law cli_format_input_multi_word:
  {M.format_input(["hello", "world"]) == "HELLO WORLD" : String}
