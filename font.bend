import Base
import ./glyph.bend as GlyphMod

# Returns a 5x5 '?' fallback Glyph for unsupported characters.
def font_unknown() -> GlyphMod.Glyph:
  GlyphMod.Glyph{
    " ### ",
    "#   #",
    "  ## ",
    "     ",
    "  #  "
  }

# Maps an uppercase ASCII character (or space) to its 5x5 Glyph.
# Unknown characters fall back to `font_unknown()`.
def font_lookup_upper(c: Char) -> GlyphMod.Glyph:
  match c:
    case ' ':
      GlyphMod.Glyph.blank()
    case 'A':
      GlyphMod.Glyph{" ### ", "#   #", "#####", "#   #", "#   #"}
    case 'B':
      GlyphMod.Glyph{"#### ", "#   #", "#### ", "#   #", "#### "}
    case 'C':
      GlyphMod.Glyph{" ####", "#    ", "#    ", "#    ", " ####"}
    case 'D':
      GlyphMod.Glyph{"#### ", "#   #", "#   #", "#   #", "#### "}
    case 'E':
      GlyphMod.Glyph{"#####", "#    ", "#### ", "#    ", "#####"}
    case 'F':
      GlyphMod.Glyph{"#####", "#    ", "#### ", "#    ", "#    "}
    case 'G':
      GlyphMod.Glyph{" ####", "#    ", "#  ##", "#   #", " ####"}
    case 'H':
      GlyphMod.Glyph{"#   #", "#   #", "#####", "#   #", "#   #"}
    case 'I':
      GlyphMod.Glyph{"#####", "  #  ", "  #  ", "  #  ", "#####"}
    case 'J':
      GlyphMod.Glyph{"#####", "   # ", "   # ", "#  # ", " ##  "}
    case 'K':
      GlyphMod.Glyph{"#   #", "#  # ", "###  ", "#  # ", "#   #"}
    case 'L':
      GlyphMod.Glyph{"#    ", "#    ", "#    ", "#    ", "#####"}
    case 'M':
      GlyphMod.Glyph{"#   #", "## ##", "# # #", "#   #", "#   #"}
    case 'N':
      GlyphMod.Glyph{"#   #", "##  #", "# # #", "#  ##", "#   #"}
    case 'O':
      GlyphMod.Glyph{" ### ", "#   #", "#   #", "#   #", " ### "}
    case 'P':
      GlyphMod.Glyph{"#### ", "#   #", "#### ", "#    ", "#    "}
    case 'Q':
      GlyphMod.Glyph{" ### ", "#   #", "# # #", "#  # ", " ## #"}
    case 'R':
      GlyphMod.Glyph{"#### ", "#   #", "#### ", "#  # ", "#   #"}
    case 'S':
      GlyphMod.Glyph{" ####", "#    ", " ### ", "    #", "#### "}
    case 'T':
      GlyphMod.Glyph{"#####", "  #  ", "  #  ", "  #  ", "  #  "}
    case 'U':
      GlyphMod.Glyph{"#   #", "#   #", "#   #", "#   #", " ### "}
    case 'V':
      GlyphMod.Glyph{"#   #", "#   #", "#   #", " # # ", "  #  "}
    case 'W':
      GlyphMod.Glyph{"#   #", "#   #", "# # #", "## ##", "#   #"}
    case 'X':
      GlyphMod.Glyph{"#   #", " # # ", "  #  ", " # # ", "#   #"}
    case 'Y':
      GlyphMod.Glyph{"#   #", " # # ", "  #  ", "  #  ", "  #  "}
    case 'Z':
      GlyphMod.Glyph{"#####", "   # ", "  #  ", " #   ", "#####"}
    case _:
      font_unknown()

# Looks up the 5x5 Glyph for any character, normalizing lowercase a-z to uppercase.
def font_lookup(c: Char) -> GlyphMod.Glyph:
  font_lookup_upper(Char.to_upper(c))
