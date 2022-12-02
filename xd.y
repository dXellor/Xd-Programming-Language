%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yyparse(void);
    int yylex(void);
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
epic
: _ID
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
//   init_symtab();

  synerr = yyparse();

//   clear_symtab();

  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count)
    printf("\n%d error(s).\n", error_count);

  if(synerr)
    return -1; //syntax error
  else
    return error_count; //semantic errors
}
