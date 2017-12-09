#!/bin/sh -e
flex own.l
bison -y -d tmpgrammer.y
gcc  lex.yy.c y.tab.c
rm y.tab.?
rm lex.yy.c
