%{
//Renet de Jesús Pérez Gómez | A01640555
#include <iostream>
using namespace std;
%}

DIGIT           [0-9]
LETTER          [a-zA-Z]
FLOAT           {DIGIT}*\.{DIGIT}{1,5}
INTEGER         {DIGIT}+
ID              {LETTER}({LETTER}|{DIGIT})*
COMMENT         (\/\/).*


%%
{INTEGER}         { cout << "integer "; }
{FLOAT}           { cout << "float "; }
p                 { cout << "keyprint "; }
f                 { cout << "keyfloat "; }
i                 { cout << "keyinteger " ; }
{ID}              { cout << "id "; }
\+                { cout << "addition "; }
\-                { cout << "subtraction "; }
\*                { cout << "multiplication "; }
\=                { cout << "assignation " ; }
{COMMENT}         { cout << "comment " << endl; }
\/                { cout << "division "; }
\n                /*Do Nothing*/
%%
