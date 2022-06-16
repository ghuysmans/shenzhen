open Shenzhen

let () =
  let lexbuf = Lexing.from_channel stdin in
  Parser.program Lexer.tokenize lexbuf |>
  Format.printf "%a@." Listing.pp
