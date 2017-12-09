%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern int yylex(void);
void yyerror(const char *str);
extern int yywrap();

//struct nodeType *ASTROOT;

%}
/*
%union
{
    struct nodeType *node;
    int number;
    char *string;
}
*/
%define parse.error verbose

%token AND ARRAY ASSIGNMENT CASE CHARACTER_STRING COLON COMMA CONST DIGSEQ
%token INTEGER REAL STRING DIV DO DOT DOTDOT DOWNTO ELSE END EQUAL EXTERNAL FOR FORWARD FUNCTION
%token GE GOTO GT IDENTIFIER IF IN LABEL LBRAC LE LPAREN LT MINUS MOD NIL NOT
%token NOTEQUAL OF OR OTHERWISE PACKED PBEGIN PFILE PLUS PROCEDURE PROGRAM RBRAC
%token REALNUMBER RECORD REPEAT RPAREN SEMICOLON SET SLASH STAR STARSTAR THEN
%token TO TYPE UNTIL UPARROW VAR WHILE WITH

%left MINUS ADD
%left STAR SLASH
%%

file: PROGRAM IDENTIFIER LPAREN identifier_list RPAREN SEMICOLON
  	    declarations
	    subprogram_declarations
	    compound_statement
	    DOT { printf("parse end\n"); }

identifier_list: IDENTIFIER { printf("R (identifier_list -> IDENTIFIER)\n"); }
	| identifier_list COMMA IDENTIFIER {printf("R (identifier_list -> identifier_list , IDENTIFIER)\n");}

declarations: declarations VAR identifier_list COLON type SEMICOLON { printf("R (declarations -> declarations VAR identifier_list : type)\n"); }
	|
    ;


type: standard_type { printf("R (type -> standard_type)\n"); }
	| ARRAY LBRAC num DOTDOT num RBRAC OF type { printf("R (type -> ARRAY [ num .. num ] OF type)\n"); }


standard_type: INTEGER  { printf("R (standard_type -> Integer)\n"); }
	| REAL  { printf("R (standard_type -> realnumber)\n"); }
    | STRING { printf("R (standard_type -> string)\n"); }


subprogram_declarations:
	subprogram_declarations subprogram_declaration SEMICOLON { printf("R (subprogram_declarations -> subprogram_declarations subprogram_declaration ;)\n"); }
	|
    ;


subprogram_declaration: subprogram_head	declarations compound_statement { printf("R (subprogram_declaration -> subprogram_head declarations compound_statement)\n"); }


subprogram_head: FUNCTION IDENTIFIER arguments COLON standard_type SEMICOLON { printf("R (subprogram_head -> FUNCTION IDENTIFIER arguments ; standard_type ;)\n"); }
	| PROCEDURE IDENTIFIER arguments SEMICOLON { printf("R (subprogram_head -> PROCEDURE IDENTIFIER arguments ;)\n"); }


arguments: LPAREN parameter_list RPAREN { printf("R (arguments -> ( parameter_list ) )\n"); }
	|
    ;


parameter_list: optional_var identifier_list COLON type more_parameter { printf("R (parameter_list -> optional_var identifier_list : more_parameter)\n"); }

more_parameter: SEMICOLON parameter_list { printf("R (more_parameter -> ; parameter_list)\n"); }
    |
    ;

optional_var: VAR { printf("R (optional_var -> VAR)\n"); }
    |
    ;

compound_statement: PBEGIN optional_statements END { printf("R (compund_statement -> PBEGIN optional_statements END)\n"); }

optional_statements: statement_list { printf("R (optional_statements -> statement_list)\n"); }
    |
    ;

statement_list: statement { printf("R (statement_list -> statement)\n"); }
	| statement_list SEMICOLON statement { printf("R (statement_list -> statement_list ; statement)\n"); }

statement: variable ASSIGNMENT expression { printf("R (statement -> variable ASSIGNMENT expression)\n"); }
	| procedure_statement { printf("R (statement -> procedure_statement)\n"); }
	| compound_statement { printf("R (statment -> compound_statement)\n"); }
	| IF expression THEN statement ELSE statement { printf("R (statement -> IF expression THEN statement ELSE statement)\n"); }
	| WHILE expression DO statement { printf("R (statement -> WHILE expression DO statement)\n"); }
    ;

variable: IDENTIFIER tail { printf("R (variable -> IDENTIFIER tail)\n"); }

tail: LBRAC expression RBRAC tail { printf("R (tail -> [ expression ] tail)\n"); }
	|
    ;

procedure_statement: IDENTIFIER { printf("R (procedure_statement -> IDENTIFIER)\n"); }
	| IDENTIFIER LPAREN expression_list RPAREN { printf("R (procedure_statement -> [ expression_list ] IDENTIFIER)\n"); }

expression_list: expression { printf("R (expression_list -> expression)\n"); }
	| expression_list COMMA expression { printf("R (expression_list -> expression_list , expression)\n"); }

expression: simple_expression { printf("R (expression -> simple_expression)\n"); }
    | simple_expression relop simple_expression { printf("R (expression -> simple_expression relop simple_expression)\n"); }
/*	| simple_expression relop simple_expression

more_expression: relop simple_expression
    |
    ;*/

simple_expression: term { printf("R (simple_expression -> term)\n"); }
	| simple_expression addop term { printf("R (simple_expression -> simple_expression addop term)\n"); }

term: factor { printf("R (term -> factor)\n"); }
	| term mulop factor { printf("R (term -> term mulop factor)\n"); }

factor: IDENTIFIER tail { printf("R (factor -> IDENTIFIER tail)\n"); }
	| IDENTIFIER LPAREN expression_list RPAREN { printf("R (factor -> IDENTIFIER ( expression_list ))\n"); }
	| num { printf("R (factor -> num)\n"); }
	| LPAREN expression RPAREN { printf("R (factor -> ( expression ) )\n"); }
	| NOT factor { printf("R (factor -> NOT factor)\n"); }

addop: PLUS { printf("R (addop -> PLUS)\n"); }
    | MINUS { printf("R (addop -> MINUS)\n"); }

mulop: STAR { printf("R (mulop -> STAR)\n"); }
    | SLASH { printf("R (mulop -> SLASH)\n"); }

relop: LT { printf("R (relop -> LT)\n"); }
	| GT { printf("R (relop -> GT)\n"); }
	| EQUAL { printf("R (relop -> EQUAL)\n"); }
	| LE { printf("R (relop -> LE)\n"); }
	| GE { printf("R (relop -> GE)\n"); }
    ;

num: DIGSEQ { printf("R (num -> Integer)\n"); }
    | MINUS DIGSEQ { printf("R (num -> - Integer)\n"); }
    | REALNUMBER { printf("R (num -> realnumber)\n"); }
%%

void yyerror(const char *str)
{
    fprintf(stderr, "Error | %s\n", str);
}

int main()
{
    yyparse();
    printf("---------------------------\n");
    //printTree(ASTROOT, 0);
    return 0;
}
