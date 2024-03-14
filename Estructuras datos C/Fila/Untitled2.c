#include <stdio.h>
#include <stdlib.h>
#include "fila.h"

int main()
{
    Nodo *frente=NULL;
    int respuesta, ele, num;
    FILE *archivo=NULL;
    do
    {
        printf("\n1. Agregar elemento en la fila\n");
        printf("\n2. Dar de baja un elemento de la fila\n");
        printf("\n3. Mostrar los elementos en la fila\n");
        printf("\n4. Mostrar el numero de elementos en la fila\n");
        printf("\n5. Leer archivo de texto y anadir a una fila\n");
        printf("\n6. Anadir elemento a fila y archivo de texto\n\n");
        printf("7. Salir del programa\n\n");
        scanf("%d",&respuesta);
        printf("\n");
        switch(respuesta)
        {
        case 1:
            printf("Digite el elemento para agregar en su fila: ");
            scanf("%d",&ele);
            frente=AgregarNodo(frente, ele);
            printf("\nElemento agregado correctamente\n");
            system("pause");
            system("cls");
            break;
        case 2:
            frente=BorrarNodo(frente);
            printf("\nEl elemento de la fila ha sido eliminado correctamente\n");
            system("pause");
            system("cls");
            break;
        case 3:
            MostrarFila(frente);
            system("pause");
            system("cls");
            break;
        case 4:
            printf("\nLos nodos en la pila son: %d\n", ContarNodos(frente));
            system("pause");
            system("cls");
            break;
        case 5:
            frente=LeerArchivo(frente);
            printf("\nArchivo leido correctamente\n");
            system("pause");
            system("cls");
            break;
        case 6:
            GuardarenArchivo(frente);
            printf("\nDatos guardados en el archivo de texto\n");
            system("pause");
            system("cls");
            break;
        case 7:
            break;
        default:
            printf("Opcion erronea");
        }
    }
    while(respuesta!=7);
    return 0;
}
