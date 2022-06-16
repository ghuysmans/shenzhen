open Shenzhen

let () =
  match Sys.argv with
  | [| _ |] | [| _; "-h" |] | [| _; "--help" |] ->
    Printf.printf "usage: %s input.s...\n" Sys.argv.(0);
    exit 1
  | _ ->
    let ct = Array.length Sys.argv - 1 in
    let ok = ref true in
    Printf.printf "1..%d\n" ct;
    for i = 1 to ct do
      let inp = Sys.argv.(i) in
      let process lexbuf =
        Parser.program Lexer.tokenize lexbuf |>
        Format.(asprintf "%a@." Listing.pp)
      in
      try
        let s = open_in inp |> Lexing.from_channel |> process in
        let s' = Lexing.from_string s |> process in
        if s = s' then
          Printf.printf "ok - %s\n" inp
        else
          let len = String.length in
          Printf.printf "not ok - %s: %d <-> %d\n" inp (len s) (len s');
      with e ->
        Printf.printf "not ok - %s: %s\n" inp (Printexc.to_string e);
        ok := false
    done;
    if not !ok then exit 2
