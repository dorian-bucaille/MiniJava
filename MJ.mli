(** This is the same abstract syntax tree as in [LMJ.mli] but without position informations.
    After typechecking, we don't need to give feedbacks to the user. *)

type identifier = string

type expression =
  | EConst of constant
  | EGetVar of identifier
  | EUnOp of unop * expression
  | EBinOp of binop * expression * expression
  | EMethodCall of expression * identifier * expression list
  | EArrayGet of expression * expression
  | EArrayAlloc of expression
  | EArrayLength of expression
  | EThis
  | EObjectAlloc of identifier

and constant = LMJ.constant =
  | ConstBool of bool
  | ConstInt of int32

and binop = LMJ.binop =
  | OpAdd
  | OpSub
  | OpMul
  | OpLt
  | OpGt
  | OpLe
  | OpGe
  | OpNe
  | OpAnd
  | OpEq
  | OpOr

and unop = LMJ.unop = UOpNot

and assignation = 
  | ISetVar of identifier * expression
  | ISetVarPlus of identifier
  | ISetVarMinus of identifier

and instruction =
  | IBlock of instruction list
  | IIf of expression * instruction * instruction
  | IWhile of expression * instruction
  | IAssign of assignation
  | ISyso of expression
  | IFor of identifier * expression * expression * assignation * instruction
  | IArraySet of identifier * expression * expression

and typ =
  | TypInt
  | TypBool
  | TypIntArray
  | Typ of identifier

and metho = {
    formals: (identifier * typ) list;
    result: typ;
    locals: (identifier * typ) list;
    body: instruction list;
    return: expression
  }

and clas = {
    extends: identifier option;
    attributes: (identifier * typ) list;
    methods: (identifier * metho) list
  }

and program = {
    name: identifier;
    defs: (identifier * clas) list;
    main_args: identifier;
    main: instruction
  }
