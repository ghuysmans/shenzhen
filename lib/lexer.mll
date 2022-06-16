let id = ['0'-'9''A'-'Z''a'-'z''_']+
let nl = '\r'? '\n'
let digit = ['0'-'9']
let smallint = '0'* digit? digit? digit

rule tokenize = parse
| '-'? smallint as n { Parser.I (int_of_string n) }
| "p0" { P P0 }
| "p1" { P P1 }
| "x0" { P X0 }
| "x1" { P X1 }
| "x2" { P X2 }
| "x3" { P X3 }
| "null" { NULL }
| "acc" { ACC }
| "dat" { DAT }
| "nop" { NOP }
| "mov" { MOV }
| "jmp" { JMP }
| "slp" { SLP }
| "slx" { SLX }
| "add" { ADD }
| "sub" { SUB }
| "mul" { MUL }
| "not" { NOT }
| "dgt" { DGT }
| "dst" { DST }
| "teq" { TEQ }
| "tgt" { TGT }
| "tlt" { TLT }
| "tcp" { TCP }
| id as l { LBL l }
| ':' { COLON }
| "+" { PLUS }
| "-" { MINUS }
| [' ''\t']+ { tokenize lexbuf }
| '#' [^'\r''\n']* { tokenize lexbuf }
| nl { Lexing.new_line lexbuf; NL }
| eof { EOF }
