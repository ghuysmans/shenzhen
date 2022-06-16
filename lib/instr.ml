type i = int (* from -999 to 999 *)

type p =
  | P0
  | P1
  | X0
  | X1
  | X2
  | X3

type r =
  | Null
  | Acc
  | Dat
  | Pin of p

type ri =
  | Reg of r
  | Int of i

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

type c =
  | Always
  | Pos
  | Neg

type t = c * a
