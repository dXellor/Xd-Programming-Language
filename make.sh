#! /bin/bash

bison -d xd.y && flex xd.l && gcc -o compiler/xd_compiler lex.yy.c xd.tab.c
