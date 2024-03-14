#include <stdio.h>
#include <stdlib.h>
#include "lista.h"

int main()
{
    Nodo *inicio=NULL;
    int respuesta, ele, num, pos;
    do
    {
        printf("\n1. Insertar un elemento al inicio de la lista\n");
        printf("\n2. Insertar un elemento al final de la lista\n");
        printf("\n3.Insertar en una posición dada de la lista\n");
        printf("\n4.Borrar al incio de la lista\n");
        printf("\n5.Borrar al final de la lista\n");
        printf("\n6.Borrar en posicion de la lista\n");
        printf("\n7. Mostrar los elementos almacenados en la lista\n");
        printf("\n8. Mostrar el numero de elementos en la lista\n");
        printf("\n9. Leer archivo de texto y anadir a una lista\n");
        printf("\n10. Anadir elemento a pila y archivo de lista\n\n");
        printf("11. Salir del programa\n\n");
        scanf("%d",&respuesta);
        printf("\n");
        switch(respuesta)


        {
        case 1:
            printf("Digite el elemento para agregar en el inicio de la lista: ");
            scanf("%d",&ele);
            inicio=InsertarAlInicio(inicio, ele);
            printf("\nElemento agregado correctamente\n");
            system("pause");
            system("cls");
            break;
        case 2:
            printf("Digite el elemento para agregar en el final de la lista: ");
            scanf("%d", &ele);
            inicio=InsertarAlFinal(inicio, ele);
            printf("\nElemento agregado correcto correctamente\n");
            system("pause");
            system("cls");
            break;
        case 3:
            printf("Digite el elemento para agregar en la fila: ");
            scanf("%d", &ele);
            printf("\nDigite la posicion en donde quiere insertar el elemento en su lista: ");
            scanf("%d", pos);
            inicio=InsertarEnPosicion(inicio,ele,pos);
            printf("\nElemento agregado correcto correctamente\n");
            system("pause");
            system("cls");
            break;
        case 4:
            inicio=BorrarAlInicio(inicio);
            printf("\nElemento eliminado correctamente: %d\n");
            system("pause");
            system("cls");
            break;
        case 5:
            inicio=BorrarAlFinal(inicio);
            printf("\nElemento eliminado correctamente: %d\n");
            system("pause");
            system("cls");
            break;
        case 6:
            Show(inicio);
            printf("\nInserte la posición donde se va a eliminar un nodo: ");
            scanf("%i", pos);
            inicio=BorrarEnPosicion(inicio,pos);
            system("pause");
            system("cls");
            break;
        case 7:
            Show(inicio);
            system("pause");
            system("cls");
            break;
        case 8:
            printf("\nEl numero de elementos en la lista es de: %i", ContarNodo(inicio));
            system("pause");
            system("cls");
            break;
        case 9:
            Show(inicio);
            system("pause");
            system("cls");
            break;
        case 10:
            Show(inicio);
            system("pause");
            system("cls");
            break;
        case 11:
            Show(inicio);
            system("pause");
            system("cls");
            break;
        default:
            printf("Opcion erronea");
        }
    }
    while(respuesta!=11);
 /*       Show(inicio);
    inicio = InsertarAlInicio(inicio, 5);
    inicio = InsertarAlInicio(inicio, 10);
    inicio = InsertarAlFinal(inicio, 15);
    Show(inicio);*/
    return 0;
}

////////////////////////////////////////////////
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

////////////////////////////////////////////////


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

/////////////////////////////////////////////////
