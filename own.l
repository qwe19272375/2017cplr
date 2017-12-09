%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int line_no = 1;
int commenteof(void);
int yywrap(void);
%}

%option yylineno

A [aA]
B [bB]
C [cC]
D [dD]
E [eE]
F [fF]
G [gG]
H [hH]
I [iI]
J [jJ]
K [kK]
L [lL]
M [mM]
N [nN]
O [oO]
P [pP]
Q [qQ]
R [rR]
S [sS]
T [tT]
U [uU]
V [vV]
W [wW]
X [xX]
Y [yY]
Z [zZ]
NQUOTE [^']

%%
{I}{N}{T}{E}{G}{E}{R} {
    printf("Shift INTEGER\n");
    return(INTEGER);
}
{R}{E}{A}{L} {
    printf("Shift REAL\n"); return(REAL);
}
[/]{2,}.*  /*{ fprintf(stderr, "%s", yytext); }*/
\"(\\.|[^\\\n"])*\" {
    printf("Shift STRING\n"); return(STRING);
}
{A}{N}{D} {
    printf("Shift AND\n"); return(AND);
}
{A}{R}{R}{A}{Y} {
    printf("Shift ARRAY\n"); return(ARRAY);
}
{D}{I}{V} {
    printf("Shift DIV\n"); return(DIV);
}
{D}{O} {
    printf("Shift DO\n"); return(DO);
}
{D}{O}{W}{N}{T}{O} {
    printf("Shift DOWNTO\n"); return(DOWNTO);
}
{E}{L}{S}{E} {
    printf("Shift ELSE\n"); return(ELSE);
}
{E}{N}{D} {
    printf("Shift END\n"); return(END);
}
{E}{X}{T}{E}{R}{N} |
{E}{X}{T}{E}{R}{N}{A}{L} {
    printf("Shift EXTERNAL\n"); return(EXTERNAL);
}
{F}{O}{R} {
    printf("Shift OR\n"); return(FOR);
}
{F}{O}{R}{W}{A}{R}{D} {
    printf("Shift FORWARD\n"); return(FORWARD);
}
{F}{U}{N}{C}{T}{I}{O}{N} {
    printf("Shift FUNCTION\n"); return(FUNCTION);
}
{I}{F} {
    printf("Shift IF\n"); return(IF);
}
{I}{N} {
    printf("Shift IN\n"); return(IN);
}
{L}{A}{B}{E}{L} {
    printf("Shift LABEL\n"); return(LABEL);
}
{M}{O}{D} {
    printf("Shift MOD\n"); return(MOD);
}
{N}{I}{L} {
    printf("Shift NIL\n"); return(NIL);
}
{N}{O}{T} {
    printf("Shift NOT\n"); return(NOT);
}
{O}{F} {
    printf("Shift OF\n"); return(OF);
}
{O}{R} {
    printf("Shift OR\n"); return(OR);
}
{O}{T}{H}{E}{R}{W}{I}{S}{E} {
    printf("Shift OTHERWISE\n"); return(OTHERWISE);
}
{P}{A}{C}{K}{E}{D} {
    printf("Shift PACKED\n"); return(PACKED);
}
{B}{E}{G}{I}{N} {
    printf("Shift PBEGIN\n"); return(PBEGIN);
}
{F}{I}{L}{E} {
    printf("Shift PFILE\n"); return(PFILE);
}
{P}{R}{O}{C}{E}{D}{U}{R}{E} {
    printf("Shift PROCEDURE\n"); return(PROCEDURE);
}
{P}{R}{O}{G}{R}{A}{M} {
    printf("Shift PROGRAM\n"); return(PROGRAM);
}
{R}{E}{C}{O}{R}{D} {
    printf("Shift RECORD\n"); return(RECORD);
}
{R}{E}{P}{E}{A}{T} {
    printf("Shift REPEAT\n"); return(REPEAT);
}
{S}{E}{T} {
    printf("Shift SET\n"); return(SET);
}
{T}{H}{E}{N} {
    printf("Shift THEN\n"); return(THEN);
}
{T}{O} {
    printf("Shift TO\n"); return(TO);
}
 /*{T}{Y}{P}{E}   return(TYPE);*/
{U}{N}{T}{I}{L} {
    printf("Shift UNTIL\n"); return(UNTIL);
}
{V}{A}{R} {
    printf("Shift VAR\n"); return(VAR);
}
{W}{H}{I}{L}{E} {
    printf("Shift WHILE\n"); return(WHILE);
}
{W}{I}{T}{H} {
    printf("Shift WITH\n"); return(WITH);
}
[a-zA-Z]([a-zA-Z0-9])* {
    printf("Shift IDENTIFIER\n"); return(IDENTIFIER);
}
":=" {
    printf("Shift ASSIGNMENT\n"); return(ASSIGNMENT);
} 
'({NQUOTE}|'')+' {
    printf("Shift IDENTIFIER\n"); return(IDENTIFIER);
}
":" {
    printf("Shift COLON\n"); return(COLON);
}
"," {
    printf("Shift COMMA\n"); return(COMMA);
}
[0-9]+ {
    printf("Shift DIGSEQ\n"); return(DIGSEQ);
}
[-+]?[0-9]*\.[0-9]+([eE][-+]?[0-9]+)? {
    printf("Shift REALNUMBER\n"); return(REALNUMBER);
}
"." {
    printf("Shift DOT\n"); return(DOT);
}
".." {
    printf("Shift DOTDOT\n"); return(DOTDOT);
}
"=" {
    printf("Shift EQUAL\n"); return(EQUAL);
}
">=" {
    printf("Shift GE\n"); return(GE);
}
">" {
    printf("Shift GT\n"); return(GT);
}
"[" {
    printf("Shift LBRAC\n"); return(LBRAC);
}
"<=" {
    printf("Shift LE\n"); return(LE);
}
"(" {
    printf("Shift LPAREN\n"); return(LPAREN);
}
"<" {
    printf("Shift LT\n"); return(LT);
}
"-" {
    printf("Shift MINUS\n"); return(MINUS);
}
"<>" {
    printf("Shift NOTEQUAL\n"); return(NOTEQUAL);
}
"+" {
    printf("Shift PLUS\n"); return(PLUS);
}
"]" {
    printf("Shift RBRAC\n"); return(RBRAC);
}
")" {
    printf("Shift RPAREN\n"); return(RPAREN);
}
";" {
    printf("Shift SEMICOLON\n"); return(SEMICOLON);
}
"/" {
    printf("Shift SLASH\n"); return(SLASH);
}
"*" {
    printf("Shift STAR\n"); return(STAR);
}
"->" |
"^" {
    printf("Shift UPARROW\n"); return(UPARROW);
}
"(*" |
"{" {
    register int c;
    while ((c = input())) {
        if (c == '}')
            break;
        else if (c == '*') {
            if ((c = input()) == ')')
                break;
            else
            unput (c);
        }
       else if (c == '\n')
           line_no++;
       else if (c == 0)
           commenteof();
    }
}
[ \t\f] ;

\n line_no++;

. {
    fprintf (stderr, "'%c' (0%o): illegal charcter at line %d\n",
    yytext[0], yytext[0], line_no);
}

%%

int commenteof() {
    fprintf (stderr, "unexpected EOF inside comment at line %d\n",
             line_no);
    exit (1);
}

int yywrap () {
    return (1);
}

