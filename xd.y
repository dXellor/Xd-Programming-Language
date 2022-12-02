%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yyparse(void);
    int yylex(void);
    int yyerror(char *s);
    void warning(char *s);

    extern int yylineno;
    char char_buffer[100];
    int error_count = 0;
    int warning_count = 0;
%}

/*union*/

/*TOKENS*/

%token _TYPE
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

%token _AROP
%token _RELOP

%token _ID
%token _STRING
%token _BOOL_VAL
%token _INT_NUMBER
%token _FLOAT_NUMBER
%token _CHAR_VAL

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
  | def_statement_list def_task_statement
  ;

def_variable_statement
  : const_keyword _ID _AS _TYPE _SEMICOLON // Treba dodati i pridodavanje vrednosti
  ;

def_task_statement
  : _TASK _ID _TAKES _LPAREN parameters _RPAREN compound_statement _RETURNS _TYPE _SEMICOLON
  ;

const_keyword
  : /* empty */
  | _CONST
  ;

statement_list
  : /* empty */
  ;

compound_statement
  : _LBRACKET _RBRACKET
  ;

parameters
  : /* empty */
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
