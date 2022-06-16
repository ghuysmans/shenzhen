type line =
  | Label of Instr.l
  | Instr of Instr.t

let pp_line ?indent ch = function
  | Label l -> Format.fprintf ch "%s:" l
  | Instr i -> Instr.pp ?indent ch i

type t = line list

let pp ch l =
  Format.(fprintf ch "@[<v>%a@]@." (pp_print_list (pp_line ~indent:true)) l)
