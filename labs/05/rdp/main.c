#include <stdio.h>

//FIXME

/***************************
Example:
Grammar: E --> i E'
E' --> + i E' | e
***************************/

int main()
{
    // E is a start symbol.
    E();

    // if lookahead = $, it represents the end of the string
    // Here l is lookahead.
    if (l == '$')
        printf("Parsing Successful");
}

// Definition of E, as per the given production
E()
{
    if (l == 'i') {
        match('i');
        E'();
    }
}

// Definition of E' as per the given production
E'()
{
    if (l == '+') {
        match('+');
        match('i');
        E'();
    }
    else
        return ();
}

// Match function
match(char t)
{
    if (l == t) {
        l = getchar();
    }
    else
        printf("Error");
}

