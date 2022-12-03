%option noyywrap yylineno

%{
    #include <string.h>
    #include "xd.tab.h"
    #include "xdheader.h"
%}

%%

[ \t\n]+                    { /* skip */ }

"int"                       { yylval.i = INT; return _TYPE; }
"float"                     { yylval.i = FLOAT; return _TYPE; }
"char"                      { yylval.i = CHAR; return _TYPE; }
"string"                    { yylval.i = STRING; return _TYPE; }
"bool"                      { yylval.i = BOOL; return _TYPE; }
"void"                      { yylval.i = VOID; return _TYPE; }

"[def]"                     { return _DEF; }
"[!def]"                    { return _DEFE; }
"[program]"                 { return _MAIN; }
"[!program]"                { return _MAINE; }
"const"                     { return _CONST; }
"as"                        { return _AS; }
"task"                      { return _TASK; }
"takes"                     { return _TAKES; }
"returns"                   { return _RETURNS; }
"return"                    { return _RETURN; }

"if"                        { return _IF; }
"else"                      { return _ELSE; }
"then"                      { return _THEN; }
"loop"                      { return _LOOP; }
"for"                       { return _FOR; }
"until"                     { return _UNTIL; }

"("                         { return _LPAREN; }
")"                         { return _RPAREN; }
"{"                         { return _LBRACKET; }
"}"                         { return _RBRACKET; }
"["                         { return _LSBRACKET; }
"]"                         { return _RSBRACKET; }
":"                         { return _COL; }
";"                         { return _SEMICOLON; }
","                         { return _COMMA; }
"="                         { return _ASSIGN; }

"+"                         { yylval.i = ADD; return _AROP; }
"-"                         { yylval.i = SUB; return _AROP; }
"*"                         { yylval.i = MUL; return _AROP; }
"/"                         { yylval.i = DIV; return _AROP; }
"%"                         { yylval.i = MOD; return _AROP; }
"++"                        { yylval.i = INC; return _AROP; }
"--"                        { yylval.i = DEC; return _AROP; }

"|"                         { yylval.i = OR; return _BITOP; }
"&"                         { yylval.i = AND; return _BITOP; }
"^"                         { yylval.i = XOR; return _BITOP; }
"~"                         { yylval.i = NOT; return _BITOP; }

"<"                         { yylval.i = LT; return _RELOP; }
">"                         { yylval.i = GT; return _RELOP; }
"<="                        { yylval.i = LE; return _RELOP; }
">="                        { yylval.i = GE; return _RELOP; }
"=="                        { yylval.i = EQ; return _RELOP; }
"!="                        { yylval.i = NE; return _RELOP; }

"true"                      { yylval.i = TRUE; return _BOOL_VAL; }
"false"                     { yylval.i = FALSE; return _BOOL_VAL; }
[a-zA-Z][a-zA-Z0-9\_-]*     { yylval.s = strdup(yytext); return _ID; }
["].*["]                    { yylval.s = strdup(yytext); return _STRING; }
[-]?[1-9][0-9]*             { yylval.s = strdup(yytext); return _INT_NUMBER; }
[-]?([0-9]*[.])?[0-9]*      { yylval.s = strdup(yytext); return _FLOAT_NUMBER; }
['].[']                     { yylval.s = strdup(yytext); return _CHAR_VAL; }

\/\/.*                      { /* skip */ }
.                           { printf("Line %d: LEXICAL ERROR on char %c\n", yylineno, *yytext); }

%%
