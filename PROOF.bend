import Base
import ./glyph.bend as G
import ./font.bend as F
import ./render.bend as R
import ./LAWS.bend as LAWS

# Run `bend PROOF.bend` or `bend PROOF.bend --verdict` before committing.

def LAWS.glyph_rows_length(g):
  match g:
    case G.Glyph{r0, r1, r2, r3, r4}:
      {==}

def LAWS.glyph_blank_width():
  {==}

def LAWS.font_lookup_rows_length(c):
  LAWS.glyph_rows_length(F.font_lookup(c))

def LAWS.font_unknown_width():
  {==}

def LAWS.font_lookup_space():
  {==}

def LAWS.font_lookup_lowercase():
  {==}

def LAWS.font_lookup_width():
  {==}

def LAWS.render_empty_lines():
  {==}

def LAWS.render_empty_text():
  {==}

def LAWS.string_to_glyphs_length(s):
  match s:
    case SNil{}:
      {==}
    case SCon{c, SNil{}}:
      {==}
    case SCon{c1, SCon{c2, rest}}:
      %LAWS.string_to_glyphs_length(rest) : {2n+List.length(&2, G.Glyph, R.string_to_glyphs(rest)) == 2n+_ : Nat}
      {==}

def LAWS.render_non_empty_lines_length(c, rest):
  match rest:
    case SNil{}:
      {==}
    case SCon{c2, tail}:
      {==}

def LAWS.render_two_char_line_width():
  {==}

def main() -> IO(Unit):
  IO.print("glyph proofs ok")
