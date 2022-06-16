%token <string> LBL
%token COLON
%token <int> I
%token <Instr.p> P
%token NULL ACC DAT
%token NOP MOV JMP SLP SLX ADD SUB MUL NOT DGT DST TEQ TGT TLT TCP
%token PLUS MINUS
%token NL
%token EOF
%type <Listing.line list> program
%start program
%%

r:
  | NULL { Null }
  | ACC { Acc }
  | DAT { Dat }
  | p=P { Pin p }

ri:
  | r=r { Instr.Reg r }
  | i=I { Instr.Int i }

c:
  | { Always }
  | PLUS { Pos }
  | MINUS { Neg }

a:
  | NOP { Nop }
  | MOV ri=ri r=r { Mov (ri, r) }
  | JMP l=LBL { Jmp l }
  | SLP ri=ri { Slp ri }
  | SLX p=P { Slx p }
  | ADD ri=ri { Add ri }
  | SUB ri=ri { Sub ri }
  | MUL ri=ri { Mul ri }
  | NOT { Not }
  | DGT ri=ri { Dgt ri }
  | DST ri=ri ri2=ri { Dst (ri, ri2) }
  | TEQ ri=ri ri2=ri { Teq (ri, ri2) }
  | TGT ri=ri ri2=ri { Tgt (ri, ri2) }
  | TLT ri=ri ri2=ri { Tlt (ri, ri2) }
  | TCP ri=ri ri2=ri { Tcp (ri, ri2) }

line:
  | l=LBL COLON NL { Label l }
  | c=c a=a NL { Instr (c, a) }

program:
  | l=line p=program { l :: p }
  | NL p=program { p }
  | EOF { [] }
