#include <stdio.h>
#include <stdlib.h>
#include "pila.h"

int main()
{
    Nodo *cima=NULL;
    Show(cima);
    cima= Push(cima,10);
    printf("Los nodos en la pila son: %d\n", ContarNodo(cima));
    cima=Push(cima,20);
    printf("Los nodos en la pila son: %d\n", ContarNodo(cima));
    Show(cima);
    //Esto para eliminar todo 7u7 while(cima!=NULL)
    cima=BorrarNodo(cima);
    cima=BorrarNodo(cima);
    Show(cima);
    printf("\n");
    cima=BorrarNodo(cima);
    Show(cima);

return 0;
}
