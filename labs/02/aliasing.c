#include <iostream.h>
//Global Variable
int G_Var;

void AliasingFunction(int& InputVar) //InputVar becomes an alias fo G_Var
{
    G_Var = InputVar + 1;       //Uses Global Variable
                                //Same effect as G_Var = G_Var + 1
    cout << InputVar << endl;
    cout << G_Var << endl;
}

void main()
{
    G_Var = 2;
    /*calls SomeFunction with the global Variable as a parameter */
    AliasingFunction(G_Var);
}
