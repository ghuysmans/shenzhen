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
        let buf = Buffer.create 256 in
        Parser.program Lexer.tokenize lexbuf |>
          Format.(fprintf (formatter_of_buffer buf)) "%a@." Listing.pp;
        Buffer.contents buf
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
