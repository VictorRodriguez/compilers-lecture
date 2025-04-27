/* Actividad 3.2: Gramáticas Libres De Contexto | Lab 07 */
/* Alumno: León Emiliano García Pérez [A00573074] */
/* Fecha de Entrega: Viernes 31 de Mayo de 2024 */

%{
#include "y.tab.h"
%}

%option case-insensitive

%%

h+i+([!?])*                                                 { return HELLO; }
h+e+y+([!?])*                                               { return HELLO; }
h+e+l+o+([!?])*                                             { return HELLO; }

g+o+d+b+y+e+([!?])*                                         { return GOODBYE; }
b+y+e+([!?])*                                               { return GOODBYE; }
c+u+([!?])*                                                 { return GOODBYE; }

t+i+m+e+([!?])*                                             { return TIME; }
w+e+a+t+h+e+r+([!?])*                                       { return WEATHER; }

j+o+k+e+([!?])*                                             { return JOKE; }

y+o+u+r+[' ']*n+a+m+e([!?])*                                { return NAME; }
w+h+a+t+[' ']*i+s+[' ']*y+o+u+r+[' ']*n+a+m+e+([!?])*       { return NAME; }

w+h+a+t+[' ']*i+s+[' ']*t+h+e+[' ']*t+i+m+e+([!?])*         { return TIME; }
w+h+a+t+[' ']*t+i+m+e+[' ']*i+s+[' ']*i+t+([!?])*           { return TIME; }

h+o+w+[' ']*i+s+[' ']*t+h+e+[' ']*w+e+a+t+h+e+r+([!?])*     { return WEATHER; }

h+o+w+[' ']*a+r+e+[' ']*y+o+u+([!?])*                       { return HOWAREYOU; }
h+o+w+[' ']*y+o+u+[' ']*d+o+i+n+g+([!?])*                   { return HOWYOUDOING; }

t+e+l+[' ']*m+e+[' ']*a+[' ']*j+o+k+e+([!?])*               { return JOKE; }
m+a+k+e+[' ']*m+e+[' ']*l+a+u+g+h+([!?])*                   { return JOKE; }

\n                                                          { return 0; }

.                                                           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}