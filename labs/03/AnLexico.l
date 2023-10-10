%{
#include <stdio.h>
%}

%%
^"//".*					/* Ignorar la línea completa */;

f[ \t]*					printf("floatdcl ");
i[ \t]*					printf("intdcl ");
p[ \t]*					printf("print ");

[a-zA-Z^fip][ \t]*		printf("id ");

[+][ \t]*				printf("plus ");
[=][ \t]*				printf("assign ");
[-][ \t]*				printf("minus ");
[*][ \t]*				printf("times ");
[/][ \t]*				printf("divided ");

[0-9]+[ \t]*			printf("inum ");
[0-9]+\.[0-9]+[ \t]*	printf("fnum ");


%%
