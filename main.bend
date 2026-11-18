import Base
import ./render.bend as Render

# Joins CLI argument strings with a single space.
def join_args(args: List<String>) -> String:
  match args:
    case Nil{}:
      ""
    case h <> Nil{}:
      h
    case h <> t:
      h ++ " " ++ join_args(t)

# Formats CLI arguments into an uppercased string.
def format_input(args: List<String>) -> String:
  String.to_upper(join_args(args))

# Strips the leading script/program name from `IO.args()` if present.
def cli_user_args(args: List<String>) -> List<String>:
  match args:
    case Nil{}:
      Nil{}
    case _ <> rest:
      rest

# Prints either the rendered input or usage + default sample when no arguments are given.
def run_with_args(args: List<String>) -> IO(Unit):
  match args:
    case Nil{}:
      do IO<Unit>:
        IO.print("Usage: bend main.bend <TEXT>")
        IO.print("Example:")
        IO.print(Render.render_text("GLYPH"))
    case h <> t:
      text = format_input({h <> t : List<String>})
      do IO<Unit>:
        IO.print(Render.render_text(text))

def main() -> IO(Unit):
  do IO<Unit>:
    args : List<String> <- IO.args()
    run_with_args(cli_user_args(args))
