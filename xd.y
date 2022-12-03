%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "xdheader.h"

    int yyparse(void);
    int yylex(void);
    int yyerror(char *s);
    void warning(char *s);

    extern int yylineno;
    char char_buffer[CHAR_BUFFER_SIZE];
    int error_count = 0;
    int warning_count = 0;
%}

%union{
    int i;
    char *s;
}

/*TOKENS*/

%token <i> _TYPE
%token _DEF
%token _DEFE
%token _MAIN
%token _MAINE
%token _CONST
%token _AS
%token _TASK
%token _TAKES
%token _RETURNS
%token _RETURN

%token _IF
%token _ELSE
%token _THEN
%token _LOOP
%token _FOR
%token _UNTIL

%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _LSBRACKET
%token _RSBRACKET
%token _COL
%token _SEMICOLON
%token _COMMA
%token _ASSIGN

%token <i> _AROP
%token <i> _RELOP
%token <i> _BITOP

%token <s> _ID
%token <s> _STRING
%token <i> _BOOL_VAL
%token <s> _INT_NUMBER
%token <s> _FLOAT_NUMBER
%token <s> _CHAR_VAL

%%

program
  : def_sector program_sector
  ;

def_sector
  : _DEF def_statement_list _DEFE
  ;

program_sector
  : _MAIN statement_list _MAINE
  ;

def_statement_list
  : /* empty */
  | def_statement_list def_variable_statement
  | def_statement_list def_constant_statement
  | def_statement_list def_task_statement
  ;

def_variable_statement
  : ids _AS _TYPE _SEMICOLON
  ;

def_constant_statement
  : _CONST _ID _ASSIGN literal _AS _TYPE _SEMICOLON
  ;

def_task_statement
  : _TASK _ID _TAKES _LPAREN parameters _RPAREN compound_statement _RETURNS _TYPE _SEMICOLON
  ;

statement_list
  : /* empty */
  ;

compound_statement
  : _LBRACKET _RBRACKET
  ;

ids
  : _ID
  | ids _COMMA _ID
  ;

parameters
  : /* empty */
  | _ID _COL _TYPE
  | parameters _COMMA _ID _COL _TYPE
  ;

literal
  : _INT_NUMBER
  | _FLOAT_NUMBER
  | _BOOL_VAL
  | _STRING
  | _CHAR_VAL
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;

  yyparse();

  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count)
    printf("\n%d error(s).\n", error_count);

  if(synerr)
    return -1; //syntax error
  else
    return error_count; //semantic errors
}
