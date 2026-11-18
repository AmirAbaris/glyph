import Base

# A fixed-height (5-row) ASCII art glyph.
# Each row should have width `glyph_width()` (5n), as specified in `LAWS.bend`.
type Glyph is Data:
  Glyph{r0: String, r1: String, r2: String, r3: String, r4: String}

# Returns the 5 rows of a Glyph as a reusable list of strings (top to bottom).
def Glyph.rows(g: Glyph) -> List<&2, String>:
  match g:
    case Glyph{r0, r1, r2, r3, r4}:
      [r0, r1, r2, r3, r4]

# Returns a 5x5 blank Glyph filled with spaces (used for spaces and padding).
def Glyph.blank() -> Glyph:
  Glyph{"     ", "     ", "     ", "     ", "     "}
