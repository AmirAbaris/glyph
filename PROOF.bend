import Base
import ./glyph.bend as G
import ./LAWS.bend as LAWS

# Run `bend PROOF.bend` or `bend PROOF.bend --verdict` before committing.

def LAWS.glyph_rows_length(g):
  match g:
    case G.Glyph{r0, r1, r2, r3, r4}:
      {==}

def LAWS.glyph_blank_width():
  {==}

def main() -> IO(Unit):
  IO.print("glyph proofs ok")
