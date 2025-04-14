//Ariel Alvarez Cortes A01378734
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

/***************************
Grammar:
S -> aBc
B -> bc | b
***************************/

char l;
bool B();
bool b();
bool c();
FILE * file;
bool success;
struct nodo {   // Structure declaration
    char estado;
    struct nodo* hijo1;
    struct nodo* hijo2;
    struct nodo* hijo3;
}; 

struct nodo* newNode(char estado)
{
    // Allocate memory for new node
    struct nodo* nodo
        = (struct nodo*)malloc(sizeof(struct nodo));

    // Assign data to this node
    nodo->estado = estado;

    nodo->hijo1 = NULL;
    nodo->hijo2 = NULL;
    nodo->hijo3 = NULL;
    return (nodo);
}



void error()
{
    printf("Cannot generate AST\n");
}

// Match function
bool match(char t) 
{
    if (l == t) 
    {
        l = fgetc(file);
        return true;
    }
    else
        //necesito ver uno adelante, por eso quité el error aquí
        return false;
}

bool bc() 
{
    if (l == 'b') 
    {
        if(match('b') && match('c'))

            return true;
    }
    else
    {
        return false;
    }
}

bool b() 
{
    if (l == 'b')
    {
        match('b');
        return true;
    }
    else
    {
        return false;
    }
}

bool c()
{
    if(match('c'))
    {
        return true;
    }
    else
    {
        return false;
    }
}

bool a(struct nodo* nodo)
{
    if(match('a'))
    {
        nodo->hijo1 = newNode('a');
        return true;
    }
    else
    {
        return false;
    }
}

bool B(struct nodo* nodo) 
{
    nodo->hijo2 = newNode('B');
    if(b())
    {
        nodo->hijo2->hijo1 = newNode('b');
        //ambos casos van a 'c'
        c();

        //uno toma otra 'c', cualquier caso es correcto
        if(c())
           nodo->hijo2->hijo2 = newNode('c');

        nodo->hijo3 = newNode('c');
        success = true;
        return true;
    }
    else
    {
        return false;
    }
}

bool imprimir_arbol(struct nodo* nodo, FILE* f)
{
    if(nodo->hijo1 != NULL)
    {
        fprintf(f ,"\"%s\" -> \"%s\"\n",&(nodo->estado), &(nodo->hijo1->estado));
        imprimir_arbol(nodo->hijo1,f);
    }
    if(nodo->hijo2 != NULL)
    {
        fprintf(f ,"\"%s\" -> \"%s\"\n",&(nodo->estado), &(nodo->hijo2->estado));
        imprimir_arbol(nodo->hijo2,f);
    }
    if(nodo->hijo3 != NULL)
    {
        fprintf(f, "\"%s\" -> \"%s\"\n",&(nodo->estado), &(nodo->hijo3->estado));
        imprimir_arbol(nodo->hijo3,f);
    }
    return true;
}


// Definition of S
bool S(struct nodo* nodo) 
{

    if (l == 'a') 
    {
        //la c la incluí en B
        if (a(nodo) && B(nodo))
        {
            return true;
        }
    }

}

int main() 
{
    file = fopen("tokens.txt", "r");
    int counter = 0;
    struct nodo* cabeza;
    while(true) 
    {    
        counter++;
        cabeza = newNode('S'); 
        do 
        {
            success = false;
            l = fgetc(file); 
            if (l == EOF) 
            {
                break; 
            }
            S(cabeza);

        } while (l != '\n' && l != EOF);

        char filename[10];
        snprintf(filename, sizeof(filename), "graph%i.gv.txt", counter);
        
        if(success)
        {
            FILE *f = fopen(filename, "w");
            fprintf(f ,"digraph G {\n");
            imprimir_arbol(cabeza, f);
            fprintf(f ,"}");
            fclose(f);
        }
        
        
        if (l == EOF) 
        {
            break; 
        }
    }

    fclose(file);
    return 0;
}