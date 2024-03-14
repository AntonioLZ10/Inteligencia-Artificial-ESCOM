#include <stdio.h>
#include <stdlib.h>
#include "pila.h"

int main()
{
    Nodo *cima=NULL;
    int respuesta, ele, num;
    FILE *archivo=NULL;
    do
    {
        printf("\n1. Dar de alta un elemento en la cima de la pila\n");
        printf("\n2. Dar de baja un elemento en la cima de la pila\n");
        printf("\n3. Mostrar los elementos almacenados en la pila\n");
        printf("\n4. Mostrar el numero de elementos en la pila\n");
        printf("\n5. Leer archivo de texto y anadir a una pila\n");
        printf("\n6. Anadir elemento a pila y archivo de texto\n\n");
        printf("7. Salir del programa\n\n");
        scanf("%d",&respuesta);
        printf("\n");
        switch(respuesta)
        {
        case 1:
            printf("Digite el elemento para agregar en su pila: ");
            scanf("%d",&ele);
            cima=Push(cima,ele);
            printf("\nElemento agregado correctamente\n");
            system("pause");
            system("cls");
            break;
        case 2:
            cima=BorrarNodo(cima);
            printf("\nEl nodo de la cima a sido borrado correctamente\n");
            system("pause");
            system("cls");
            break;
        case 3:
            Show(cima);
            system("pause");
            system("cls");
            break;
        case 4:
            printf("\nLos nodos en la pila son: %d\n", ContarNodo(cima));
            system("pause");
            system("cls");
            break;
        case 5:
            cima=LeerArchivo(cima);
            system("pause");
            system("cls");
            break;

        case 6:
            GuardarenArchivo(cima);
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



/*archivo=fopen("archivo.txt", "w");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
            }
            else {
            printf("Digite el elemento para agregar en su pila y/o el archivo de texto: ");
            scanf("%d", &num);
            cima=Push(cima, num);
            fprintf(archivo, "%d ", num);*/

            /////////////////////////////////////////////////////

             /*archivo=fopen("archivo.txt", "r");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
            }
            else {
            while(!feof(archivo)){
            fscanf(archivo, "%d ", &num);
            cima=Push(cima,num);}
            }
            fclose(archivo);*/

            /////////////////////////////////////////////////////

            /*archivo=fopen("archivo.txt", "a");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
            }
            else {
            printf("Digite el elemento para agregar en su pila y/o el archivo de texto: ");
            scanf("%d",&num);
            fprintf(archivo, "%d ", num);
            cima=Push(cima,num);
            }
            fclose(archivo);*/

            ///////////////////////////////////////////////////////7
