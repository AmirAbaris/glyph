import Base
import ./glyph.bend as G
import ./font.bend as F
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

def main() -> IO(Unit):
  IO.print("glyph proofs ok")
