import Base
import ./glyph.bend as GlyphMod
import ./font.bend as Font

# Looks up the 5x5 Glyph for each character in a String.
# Adjacent character lookups run in parallel using Bend's parallel call notation.
def string_to_glyphs(s: String) -> List<&2, GlyphMod.Glyph>:
  match s:
    case SNil{}:
      Nil{}
    case SCon{c, SNil{}}:
      [Font.font_lookup(c)]
    case SCon{c1, SCon{c2, rest}}:
      g1 g2 = Font.font_lookup(c1) Font.font_lookup(c2)
      g1 <> g2 <> string_to_glyphs(rest)

# Extracts a single row (0n..4n) from a Glyph.
def glyph_row(g: GlyphMod.Glyph, idx: Nat) -> String:
  match g idx:
    case GlyphMod.Glyph{r0, _, _, _, _} 0n:
      r0
    case GlyphMod.Glyph{_, r1, _, _, _} 1n:
      r1
    case GlyphMod.Glyph{_, _, r2, _, _} 2n:
      r2
    case GlyphMod.Glyph{_, _, _, r3, _} 3n:
      r3
    case GlyphMod.Glyph{_, _, _, _, r4} _:
      r4

# Collects row `idx` across all Glyphs in a list.
def collect_row(gs: List<&2, GlyphMod.Glyph>, +idx: Nat) -> List<&2, String>:
  match gs:
    case Nil{}:
      Nil{}
    case g <> rest:
      glyph_row(g, idx) <> collect_row(rest, idx)

# Joins row `idx` across all Glyphs horizontally with a 1-space gap.
def render_row(gs: List<&2, GlyphMod.Glyph>, +idx: Nat) -> String:
  String.join(collect_row(gs, idx), " ")

# Renders a list of Glyphs into 5 horizontal lines (or Nil{} for an empty list).
# Independent row renders run in parallel.
def render_glyphs(gs: List<&2, GlyphMod.Glyph>) -> List<&2, String>:
  match gs:
    case Nil{}:
      Nil{}
    case g <> rest:
      +all_gs = {g <> rest : List<&2, GlyphMod.Glyph>}
      l0 l1 = render_row(all_gs, 0n) render_row(all_gs, 1n)
      l2 l3 = render_row(all_gs, 2n) render_row(all_gs, 3n)
      l4 = render_row(all_gs, 4n)
      [l0, l1, l2, l3, l4]

# Renders an input String into a list of ASCII art lines.
def render_lines(text: String) -> List<&2, String>:
  render_glyphs(string_to_glyphs(text))

# Renders an input String into a single newline-joined ASCII art String.
# Empty input "" returns "".
def render_text(text: String) -> String:
  String.join(render_lines(text), "\n")
