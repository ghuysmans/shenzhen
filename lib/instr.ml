type i = int (* from -999 to 999 *)

type p =
  | P0
  | P1
  | X0
  | X1
  | X2
  | X3

let show_p = function
  | P0 -> "p0"
  | P1 -> "p1"
  | X0 -> "x0"
  | X1 -> "x1"
  | X2 -> "x2"
  | X3 -> "x3"

type r =
  | Null
  | Acc
  | Dat
  | Pin of p

let show_r = function
  | Null -> "null"
  | Acc -> "acc"
  | Dat -> "dat"
  | Pin p -> show_p p

type ri =
  | Reg of r
  | Int of i

let show_ri = function
  | Reg r -> show_r r
  | Int i -> string_of_int i

type l = string

type a =
  | Nop
  | Mov of ri * r
  | Jmp of l
  | Slp of ri
  | Slx of p
  | Add of ri
  | Sub of ri
  | Mul of ri
  | Not
  | Dgt of ri
  | Dst of ri * ri
  | Teq of ri * ri
  | Tgt of ri * ri
  | Tlt of ri * ri
  | Tcp of ri * ri

let pp_a ch a =
  let f fmt = Format.fprintf ch fmt in
  match a with
  | Nop -> f "nop"
  | Mov (ri, r) -> f "mov %s %s" (show_ri ri) (show_r r)
  | Jmp l -> f "jmp %s" l
  | Slp ri -> f "slp %s" (show_ri ri)
  | Slx p -> f "slx %s" (show_p p)
  | Add ri -> f "add %s" (show_ri ri)
  | Sub ri -> f "sub %s" (show_ri ri)
  | Mul ri -> f "mul %s" (show_ri ri)
  | Not -> f "not"
  | Dgt ri -> f "dgt %s" (show_ri ri)
  | Dst (ri, ri') -> f "dst %s %s" (show_ri ri) (show_ri ri')
  | Teq (ri, ri') -> f "teq %s %s" (show_ri ri) (show_ri ri')
  | Tgt (ri, ri') -> f "tgt %s %s" (show_ri ri) (show_ri ri')
  | Tlt (ri, ri') -> f "tlt %s %s" (show_ri ri) (show_ri ri')
  | Tcp (ri, ri') -> f "tcp %s %s" (show_ri ri) (show_ri ri')

type c =
  | Always
  | Pos
  | Neg

type t = c * a

let pp ?(indent=false) ch (c, a) =
  let indent = if indent then "\t" else "" in
  let f fmt = Format.fprintf ch fmt in
  match c with
  | Always -> f "%s%a" indent pp_a a
  | Pos -> f "+%s%a" indent pp_a a
  | Neg -> f "-%s%a" indent pp_a a
