#! /bin/bash

bison -d xd.y
flex xd.l
gcc -o compiler/kompajler lex.yy.c xd.tab.c
