%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Parser-yacc.tab.h"
int yylex();
%}

%union {int num; char* str;}
%token <num> NUMBER
%token <str> VARIABLE

%% 
expr: term exprbar
    ;

exprbar: '+' term exprbar { printf("+ "); }
    | '-' term exprbar { printf("- "); }
    | /* empty */ { printf("\n"); }
    ;

term: factor termbar
    ;

termbar: '*' factor termbar { printf("* "); }
    | /* empty */ { }
    ;

factor: NUMBER { printf("Number= %d ", $1); }
    | VARIABLE { printf("Variable = %s ", $1); free($1); }
    | '(' expr ')' { }
    ;
%%

int yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}

int main() {
    yyparse();  // Start the parsing process
    return 0;
}
