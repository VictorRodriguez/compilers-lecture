%{
	#include <stdio.h>
    #include <math.h> 
    double symtable[23];
%}

%union {
    double dval;
    int vblno;
}

%token  COMMENT INTDCL PRINT ASSIGN PLUS MINUS TIMES DIVIDE 
%token <dval> INUM
%token <vblno> ID
%type <dval> val
%type <dval> expr
%type <dval> denom
%%
	prog: dcls stmts
	dcls: dcl dcls
        |
		;
	dcl: INTDCL ID  { symtable[$2] = 0; } 
		;
    stmts: stmt stmts 
        |
        ;
    stmt: ID ASSIGN expr { symtable[$1] = $3; }
        | PRINT ID { printf("%g\n", symtable[$2]); }
        ;
    expr: val PLUS expr { $$+=$3; }
        | val MINUS expr { $$-=$3; }
        | val TIMES expr { $$*=$3; }
        | val DIVIDE denom { $$ /=$3; }
        | val { $$=$1; }
        ;
    denom: val { if($1 == 0.0) {yyerror("Math exception, divide by 0"); return;} else {$$ = $1;} }
        ;
    val: ID { $$ = symtable[$1]; } 
        | INUM { $$ = $1; } 
        ;
%%