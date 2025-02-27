%{
  open LMJ
  let swap = List.map (fun (x, y) -> (y, x))
%}

%token <int32> INT_CONST
%token <bool> BOOL_CONST
%token INTEGER BOOLEAN
%token <string Location.t> IDENT
%token CLASS PUBLIC STATIC VOID MAIN STRING EXTENDS RETURN
%token PLUS MINUS TIMES NOT LT GT LE GE AND EQ OR NE
%token COMMA SEMICOLON
%token ASSIGN PLUSPLUS MINUSMINUS PLUSEQ MINUSEQ
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE
%token THIS NEW DOT LENGTH
%token SYSO
%token IF ELSE WHILE FOR
%token EOF

%left AND
%nonassoc LT EQ GT LE GE NE
%left PLUS MINUS
%left TIMES
%nonassoc NOT
%nonassoc DOT LBRACKET

%start program

%type <LMJ.program> program

%%

program:
| m = main_class d = defs EOF
   {
     let c, a, i = m in
     {
       name = c;
       defs = d;
       main_args = a;
       main = i
     }
   }

main_class:
| CLASS c = IDENT
   LBRACE
   PUBLIC STATIC VOID MAIN LPAREN STRING LBRACKET RBRACKET a = IDENT RPAREN
   LBRACE
   i = instruction
   RBRACE
   RBRACE
   { (c, a, i) }

defs:
| c = list(clas)
   { c }

clas:
| CLASS name = IDENT e = option(preceded(EXTENDS, IDENT))
   LBRACE
   a = list(pair(typ, terminated(IDENT, SEMICOLON)))
   m = list(metho)
   RBRACE
   {
     name,
     {
       extends = e;
       attributes = swap a;
       methods = m;
     }
   }

metho:
| PUBLIC t = typ name = IDENT
   LPAREN
   f = separated_list(COMMA, pair(typ, IDENT))
   RPAREN
   LBRACE
   ds = declarations_and_statements
   RETURN e = expression SEMICOLON
   RBRACE
   {
     let d, s = fst ds, snd ds in
     name,
     {
       formals = swap f;
       result  = t;
       locals  = d;
       body    = s;
       return  = e;
     }
   }

declarations_and_statements:
| t = typ id = IDENT SEMICOLON r = declarations_and_statements
   {
     let d, s = r in
     ((id, t) :: d, s)
   }
| s = list(instruction)
   { ([], s) }

expression:
|  e = raw_expression
   { Location.make $startpos $endpos e }
| LPAREN e = expression RPAREN
   { e }

raw_expression:
| i = INT_CONST
   { EConst (ConstInt i) }

| b = BOOL_CONST
   { EConst (ConstBool b) }

| id = IDENT
   { EGetVar id }

| e1 = expression op = binop e2 = expression
   { EBinOp (op, e1, e2) }

| o = expression DOT c = IDENT LPAREN actuals = separated_list(COMMA, expression) RPAREN
   { EMethodCall (o, c, actuals) }

| a = expression LBRACKET i = expression RBRACKET
   { EArrayGet (a, i) }

| NEW INTEGER LBRACKET e = expression RBRACKET
   { EArrayAlloc e }

| a = expression DOT LENGTH
   { EArrayLength a }

| THIS
   { EThis }

| NEW id = IDENT LPAREN RPAREN
   { EObjectAlloc id }

| NOT e = expression
   { EUnOp (UOpNot, e) }

%inline binop:
| PLUS  { OpAdd }
| MINUS { OpSub }
| TIMES { OpMul }
| LT    { OpLt }
| GT    { OpGt }
| LE    { OpLe }
| GE    { OpGe }
| NE    { OpNe }
| AND   { OpAnd }
| EQ    { OpEq }
| OR    { OpOr }

assignation:
| id = IDENT ASSIGN e = expression
   { ISetVar (id, e) }

| id = IDENT PLUSPLUS
   { ISetVar (
      id, 
      Location.make $startpos $endpos (
         EBinOp (
            OpAdd,
            ( Location.make $startpos $endpos
               (EGetVar (id))
            ),
            ( Location.make $startpos $endpos
               (EConst (ConstInt 1l))
            )
         )
      ) 
   )
   }

| id = IDENT MINUSMINUS
   { ISetVar (
      id, 
      Location.make $startpos $endpos (
         EBinOp (
            OpSub,
            ( Location.make $startpos $endpos
               (EGetVar (id))
            ),
            ( Location.make $startpos $endpos
               (EConst (ConstInt 1l))
            )
         )
      ) 
   )
   }

| id = IDENT PLUSEQ i_const = INT_CONST
   { ISetVar (
      id, 
      Location.make $startpos $endpos (
         EBinOp (
            OpAdd,
            ( Location.make $startpos $endpos
               (EGetVar (id))
            ),
            ( Location.make $startpos $endpos
               (EConst (ConstInt i_const))
            )
         )
      ) 
   )
   }

| id = IDENT MINUSEQ i_const = INT_CONST
      { ISetVar (
      id, 
      Location.make $startpos $endpos (
         EBinOp (
            OpSub,
            ( Location.make $startpos $endpos
               (EGetVar (id))
            ),
            ( Location.make $startpos $endpos
               (EConst (ConstInt i_const))
            )
         )
      ) 
   )
   }

instruction:
| b = block
   { b }

| a = assignation SEMICOLON
   { IAssign (a) }

| a = IDENT LBRACKET i = expression RBRACKET ASSIGN e = expression SEMICOLON
   { IArraySet (a, i, e) }

| SYSO LPAREN e = expression RPAREN SEMICOLON
   { ISyso e }

| IF LPAREN c = expression RPAREN i1 = instruction ELSE i2 = instruction
   { IIf (c, i1, i2) }

| WHILE LPAREN c = expression RPAREN i = instruction
   { IWhile (c, i) }

| FOR LPAREN id1 = IDENT ASSIGN e1 = expression SEMICOLON c = expression SEMICOLON a = assignation RPAREN inc = instruction
   { IFor (id1, e1, c, a, inc) }

block:
| LBRACE is = list(instruction) RBRACE
   { IBlock is }

typ:
| INTEGER
   { TypInt }
| BOOLEAN
   { TypBool }
| INTEGER LBRACKET RBRACKET
   { TypIntArray }
| id = IDENT
   { Typ id }
