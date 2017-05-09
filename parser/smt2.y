%{
  #include <stdio.h>
  #include <parser/ast.h>
  #include <parser/parser.h>
  /* C3 Theorem Prover - Apache v2.0 - Copyright 2017 - rkx1209 */
  extern char* yytext;
  extern int yylineno;

  int yyerror(const char *s) {
    printf ("syntax error: line %d token: %s\n", yylineno, yytext);
    return 1;
  }
%}

%union {
  unsigned uintval;
  char *str;
  ASTNode *node;
  ASTVec *vec;
};

%start cmd

%type <node> status
%type <vec> an_formulas an_terms function_params an_mixed
%type <node> an_term  an_formula function_param

%token <uintval> NUMERAL_TOK
%token <str> BVCONST_DECIMAL_TOK
%token <str> BVCONST_BINARY_TOK
%token <str> BVCONST_HEXIDECIMAL_TOK

 /* We have this so we can parse :smt-lib-version 2.0 */
%token  DECIMAL_TOK

%token <node> FORMID_TOK TERMID_TOK
%token <str> STRING_TOK BITVECTOR_FUNCTIONID_TOK BOOLEAN_FUNCTIONID_TOK

/* set-info tokens */
%token SOURCE_TOK
%token CATEGORY_TOK
%token DIFFICULTY_TOK
%token VERSION_TOK
%token STATUS_TOK
/* ASCII Symbols */
/* Semicolons (comments) are ignored by the lexer */
%token UNDERSCORE_TOK
%token LPAREN_TOK
%token RPAREN_TOK
/* Used for attributed expressions */
%token EXCLAIMATION_MARK_TOK
%token NAMED_ATTRIBUTE_TOK

/*BV SPECIFIC TOKENS*/
%token BVLEFTSHIFT_1_TOK
%token BVRIGHTSHIFT_1_TOK
%token BVARITHRIGHTSHIFT_TOK
%token BVPLUS_TOK
%token BVSUB_TOK
%token BVNOT_TOK //bvneg in CVCL
%token BVMULT_TOK
%token BVDIV_TOK
%token SBVDIV_TOK
%token BVMOD_TOK
%token SBVREM_TOK
%token SBVMOD_TOK
%token BVNEG_TOK //bvuminus in CVCL
%token BVAND_TOK
%token BVOR_TOK
%token BVXOR_TOK
%token BVNAND_TOK
%token BVNOR_TOK
%token BVXNOR_TOK
%token BVCONCAT_TOK
%token BVLT_TOK
%token BVGT_TOK
%token BVLE_TOK
%token BVGE_TOK
%token BVSLT_TOK
%token BVSGT_TOK
%token BVSLE_TOK
%token BVSGE_TOK
%token BVSX_TOK
%token BVEXTRACT_TOK
%token BVZX_TOK
%token BVROTATE_RIGHT_TOK
%token BVROTATE_LEFT_TOK
%token BVREPEAT_TOK
%token BVCOMP_TOK
/* Types for QF_BV and QF_AUFBV. */
%token BITVEC_TOK
%token ARRAY_TOK
%token BOOL_TOK
/* CORE THEORY pg. 29 of the SMT-LIB2 standard 30-March-2010. */
%token TRUE_TOK;
%token FALSE_TOK;
%token NOT_TOK;
%token AND_TOK;
%token OR_TOK;
%token XOR_TOK;
%token ITE_TOK;
%token EQ_TOK;
%token IMPLIES_TOK;
/* CORE THEORY. But not on pg 29. */
%token DISTINCT_TOK;
%token LET_TOK;
%token COLON_TOK
// COMMANDS
%token ASSERT_TOK
%token CHECK_SAT_TOK
%token CHECK_SAT_ASSUMING_TOK
%token DECLARE_CONST_TOK
%token DECLARE_FUNCTION_TOK
%token DECLARE_SORT_TOK
%token DEFINE_FUNCTION_TOK
%token DECLARE_FUN_REC_TOK
%token DECLARE_FUNS_REC_TOK
%token DEFINE_SORT_TOK
%token ECHO_TOK
%token EXIT_TOK
%token GET_ASSERTIONS_TOK
%token GET_ASSIGNMENT_TOK
%token GET_INFO_TOK
%token GET_MODEL_TOK
%token GET_OPTION_TOK
%token GET_PROOF_TOK
%token GET_UNSAT_ASSUMPTION_TOK
%token GET_UNSAT_CORE_TOK
%token GET_VALUE_TOK
%token POP_TOK
%token PUSH_TOK
%token RESET_TOK
%token RESET_ASSERTIONS_TOK
%token NOTES_TOK
%token LOGIC_TOK
%token SET_OPTION_TOK

/* Functions for QF_ABV. */
%token SELECT_TOK;
%token STORE_TOK;
%token END 0 "end of file"

%%
cmd: commands END
{
  YYACCEPT;
}
;

commands: commands LPAREN_TOK cmdi RPAREN_TOK
| LPAREN_TOK cmdi RPAREN_TOK
{

}
;

cmdi:
    ASSERT_TOK an_formula:
{

}
;
an_mixed:
an_formula
{

}
|
an_term
{

}
|
an_mixed an_formula
{

}
|
an_mixed an_term
{

}
;

an_formulas:
an_formula
{

}
|
an_formulas an_formula
{

}
;

an_formula:
TRUE_TOK
{

}
| FALSE_TOK
{

}
| FORMID_TOK
{

}
| LPAREN_TOK EQ_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK DISTINCT_TOK an_terms RPAREN_TOK
{

}
| LPAREN_TOK DISTINCT_TOK an_formulas RPAREN_TOK
{

}
| LPAREN_TOK BVSLT_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVSLE_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVSGT_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVSGE_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVLT_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVLE_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVGT_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK BVGE_TOK an_term an_term RPAREN_TOK
{

}
| LPAREN_TOK an_formula RPAREN_TOK
{
  $$ = $2;
}
| LPAREN_TOK NOT_TOK an_formula RPAREN_TOK
{

}
| LPAREN_TOK IMPLIES_TOK an_formula an_formula RPAREN_TOK
{

}
| LPAREN_TOK ITE_TOK an_formula an_formula an_formula RPAREN_TOK
{

}
| LPAREN_TOK AND_TOK an_formulas RPAREN_TOK
{

}
| LPAREN_TOK OR_TOK an_formulas RPAREN_TOK
{

}
| LPAREN_TOK XOR_TOK an_formula an_formula RPAREN_TOK
{

}
| LPAREN_TOK EQ_TOK an_formula an_formula RPAREN_TOK
{

}
| LPAREN_TOK BOOLEAN_FUNCTIONID_TOK an_mixed RPAREN_TOK
{

}
| BOOLEAN_FUNCTIONID_TOK an_mixed RPAREN_TOK
{

}
| BOOLEAN_FUNCTIONID_TOK
{

}
;

an_terms:
an_term
{
  $$ = ast_vec_new ();
  if ($1 != NULL) {
    ast_vec_add ($$, $1);
  }
}
|
an_terms an_term
{
  if ($1 != NULL && $2 != NULL) {
    add_vec_add ($$, $2);
    $$ = $1;
  }
}
;

an_term:
TERMID_TOK
{
  $$ = $1;
}
| LPAREN_TOK an_term RPAREN_TOK
{
  $$ = $2;
}
| SELECT_TOK an_term an_term
{

}
| STORE_TOK an_term an_term an_term
{

}
| LPAREN_TOK UNDERSCORE_TOK BVEXTRACT_TOK  NUMERAL_TOK  NUMERAL_TOK RPAREN_TOK an_term
{

}
| LPAREN_TOK UNDERSCORE_TOK BVZX_TOK  NUMERAL_TOK  RPAREN_TOK an_term
{
}
| LPAREN_TOK UNDERSCORE_TOK BVSX_TOK  NUMERAL_TOK  RPAREN_TOK an_term
{
}
| ITE_TOK an_formula an_term an_term
{

}
| BVCONCAT_TOK an_term an_term
{
}
| BVNOT_TOK an_term
{
}
| BVNEG_TOK an_term
{
}
| BVAND_TOK an_term an_term
{

}
| BVOR_TOK an_term an_term
{

}
| BVXOR_TOK an_term an_term
{

}
| BVXNOR_TOK an_term an_term
{

}
| BVCOMP_TOK an_term an_term
{

}
| BVSUB_TOK an_term an_term
{

}
| BVPLUS_TOK an_term an_term
{

}
| BVMULT_TOK an_term an_term
{

}
| BVDIV_TOK an_term an_term
{

}
| BVMOD_TOK an_term an_term
{

}
| SBVDIV_TOK an_term an_term
{

}
| SBVREM_TOK an_term an_term
{

}
| SBVMOD_TOK an_term an_term
{

}
| BVNAND_TOK an_term an_term
{

}
| BVNOR_TOK an_term an_term
{

}
| BVLEFTSHIFT_1_TOK an_term an_term
{

}
| BVRIGHTSHIFT_1_TOK an_term an_term
{

}
| BVARITHRIGHTSHIFT_TOK an_term an_term
{

}
| LPAREN_TOK UNDERSCORE_TOK BVROTATE_LEFT_TOK  NUMERAL_TOK  RPAREN_TOK an_term
{

}
| LPAREN_TOK UNDERSCORE_TOK BVROTATE_RIGHT_TOK  NUMERAL_TOK  RPAREN_TOK an_term
{

}
| LPAREN_TOK UNDERSCORE_TOK BVREPEAT_TOK  NUMERAL_TOK RPAREN_TOK an_term
{

}
| UNDERSCORE_TOK BVCONST_DECIMAL_TOK NUMERAL_TOK
{

}
| BVCONST_HEXIDECIMAL_TOK
{

}
| BVCONST_BINARY_TOK
{

}
| LPAREN_TOK BITVECTOR_FUNCTIONID_TOK an_mixed RPAREN_TOK
{

}
| BITVECTOR_FUNCTIONID_TOK
{

}
| LPAREN_TOK EXCLAIMATION_MARK_TOK an_term NAMED_ATTRIBUTE_TOK STRING_TOK RPAREN_TOK
{

}
| LPAREN_TOK LET_TOK LPAREN_TOK
{

}
;
%%
