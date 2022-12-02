%option noyywrap yylineno

%{
    #include <string.h>
%}

%%

"int"               { return _TYPE; }
"float"             { return _TYPE; }
"char"              { return _TYPE; }
"string"            { return _TYPE; }
"bool"              { return _TYPE; }
"void"              { return _TYPE; }

"[def]"             { return _DEF; }
"[!def]"            { return _DEFE; }
"[program]"         { return _MAIN; }
"[!program]"        { return _MAINE; }
"const"             { return _CONST; }
"as"                { return _AS; }
"task"              { return _TASK; }
"takes"             { return _TAKE; }
"returns"           { return _RETURNS; }

"if"                { return _IF; }
"else"              { return _ELSE; }
"then"              { return _THEN; }
"loop"              { return _LOOP; }
"for"               { return _FOR; }
"until"             { return _UNTIL; }

"("                 { return _LPAREN; }
")"                 { return _RPAREN; }
"{"                 { return _LBRACKET; }
"}"                 { return _RBRACKET; }
"["                 { return _LSBRACKET; }
"]"                 { return _RSBRACKET; }
":"                 { return _COL; }
";"                 { return _SEMICOLON; }
","                 { return _COMMA; }
"="                 { return _ASSIGN; }

"+"                 { return _AROP; }
"-"                 { return _AROP; }
"*"                 { return _AROP; }
"/"                 { return _AROP; }
"%"                 { return _AROP; }

"<"                 { return _RELOP; }
">"                 { return _RELOP; }
"<="                { return _RELOP; }
">="                { return _RELOP; }
"=="                { return _RELOP; }
"!="                { return _RELOP; }

[a-zA-Z][a-zA-Z0-9[_-]]*   { return _ID; }
["].+["]                   { return _STRING; }
"true"                     { return _BOOL_VAL; }
"false"                    { return _BOOL_VAL; }
[-]?[1-9][0-9]*            { return _INT_NUMBER; }
[-]?([0-9]*[.])?[0-9]*     { return _FLOAT_NUMBER; }
['].[']                    { return _CHAR_VAL; }

%%
