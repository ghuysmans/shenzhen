open Shenzhen

let () =
  let lexbuf = Lexing.from_channel stdin in
  Parser.program Lexer.tokenize lexbuf |>
  List.iter (function
    | Listing.Label l -> print_endline (l ^ ":")
    | Instr (Always, _) -> print_endline "\tinstr"
    | Instr (Pos, _) -> print_endline "+\tinstr"
    | Instr (Neg, _) -> print_endline "-\tinstr"
  )
