%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
//#define DEBUG
#include "debug.h"

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
    DBG( printf("Shift INTEGER\n"); )
    return(INTEGER);
}
{R}{E}{A}{L} {
    DBG( printf("Shift REAL\n"); )
    return(REAL);
}
[/]{2,}.*  /*{ fprintf(stderr, "%s", yytext); }*/
\"(\\.|[^\\\n"])*\" {
    DBG( printf("Shift STRING\n"); )
    return(STRING);
}
{A}{R}{R}{A}{Y} {
    DBG( printf("Shift ARRAY\n"); )
    return(ARRAY);
}
{D}{O} {
    DBG( printf("Shift DO\n"); )
    return(DO);
}
{E}{L}{S}{E} {
    DBG( printf("Shift ELSE\n"); )
    return(ELSE);
}
{E}{N}{D} {
    DBG( printf("Shift END\n"); )
    return(END);
}
{F}{U}{N}{C}{T}{I}{O}{N} {
    DBG( printf("Shift FUNCTION\n"); )
    return(FUNCTION);
}
{I}{F} {
    DBG( printf("Shift IF\n"); )
    return(IF);
}
{N}{O}{T} {
    DBG( printf("Shift NOT\n"); )
    return(NOT);
}
{O}{F} {
    DBG( printf("Shift OF\n"); )
    return(OF);
}
{B}{E}{G}{I}{N} {
    DBG( printf("Shift PBEGIN\n"); )
    return(PBEGIN);
}
{P}{R}{O}{C}{E}{D}{U}{R}{E} {
    DBG( printf("Shift PROCEDURE\n"); )
    return(PROCEDURE);
}
{P}{R}{O}{G}{R}{A}{M} {
    DBG( printf("Shift PROGRAM\n"); )
    return(PROGRAM);
}
{T}{H}{E}{N} {
    DBG( printf("Shift THEN\n"); )
    return(THEN);
}
{V}{A}{R} {
    DBG( printf("Shift VAR\n"); )
    return(VAR);
}
{W}{H}{I}{L}{E} {
    DBG( printf("Shift WHILE\n"); )
    return(WHILE);
}
[a-zA-Z]([a-zA-Z0-9])* {
    DBG( printf("Shift IDENTIFIER\n"); )
    return(IDENTIFIER);
}
":=" {
    DBG( printf("Shift ASSIGNMENT\n"); )
    return(ASSIGNMENT);
} 
'({NQUOTE}|'')+' {
    DBG( printf("Shift IDENTIFIER\n"); )
    return(IDENTIFIER);
}
":" {
    DBG( printf("Shift COLON\n"); )
    return(COLON);
}
"," {
    DBG( printf("Shift COMMA\n"); )
    return(COMMA);
}
[0-9]+ {
    DBG( printf("Shift DIGSEQ\n"); )
    return(DIGSEQ);
}
[-+]?[0-9]*\.[0-9]+([eE][-+]?[0-9]+)? {
    DBG( printf("Shift REALNUMBER\n"); )
    return(REALNUMBER);
}
"." {
    DBG( printf("Shift DOT\n"); )
    return(DOT);
}
".." {
    DBG( printf("Shift DOTDOT\n"); )
    return(DOTDOT);
}
"=" {
    DBG( printf("Shift EQUAL\n"); )
    return(EQUAL);
}
">=" {
    DBG( printf("Shift GE\n"); )
    return(GE);
}
">" {
    DBG( printf("Shift GT\n"); )
    return(GT);
}
"[" {
    DBG( printf("Shift LBRAC\n"); )
    return(LBRAC);
}
"<=" {
    DBG( printf("Shift LE\n"); )
    return(LE);
}
"(" {
    DBG( printf("Shift LPAREN\n"); )
    return(LPAREN);
}
"<" {
    DBG( printf("Shift LT\n"); )
    return(LT);
}
"-" {
    DBG( printf("Shift MINUS\n"); )
    return(MINUS);
}
"<>" {
    DBG( printf("Shift NOTEQUAL\n"); )
    return(NOTEQUAL);
}
"+" {
    DBG( printf("Shift PLUS\n"); )
    return(PLUS);
}
"]" {
    DBG( printf("Shift RBRAC\n"); )
    return(RBRAC);
}
")" {
    DBG( printf("Shift RPAREN\n"); )
    return(RPAREN);
}
";" {
    DBG( printf("Shift SEMICOLON\n"); )
    return(SEMICOLON);
}
"/" {
    DBG( printf("Shift SLASH\n"); )
    return(SLASH);
}
"*" {
    DBG( printf("Shift STAR\n"); )
    return(STAR);
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

