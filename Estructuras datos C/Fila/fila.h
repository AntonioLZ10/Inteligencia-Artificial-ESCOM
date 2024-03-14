#ifndef FILA_H_INCLUDED
#define FILA_H_INCLUDED
#include <stdio.h>
#include <stdlib.h>

typedef struct _Nodo {
    char dato;
    struct _Nodo *siguiente;
}Nodo;

Nodo *CrearNodito(int d){
    Nodo *nuevo;
    nuevo = (Nodo *)malloc (sizeof(Nodo));
    nuevo->dato = d;
    nuevo ->siguiente = NULL;
    return nuevo;
}

Nodo *AgregarNodo(Nodo *frente, int d){
    Nodo *nuevo, *aux;
    nuevo = CrearNodito(d);
    if(frente==NULL){
        return nuevo;
    }
    else{
        aux=frente;
        while(aux->siguiente!=NULL){
            aux = aux->siguiente;
        }
        aux->siguiente=nuevo;
        return frente;
    }
}

void MostrarFila(Nodo *frente){
    if(frente==NULL){
        printf("Fila vacia\n");
    }
    else{
        while(frente!=NULL){
            printf("%d ", frente ->dato);
            frente=frente->siguiente;
        }
    }
}

Nodo *BorrarNodo(Nodo *frente){
    Nodo *aux;
    aux=frente;
    if(frente==NULL){
        printf("\nNo se pudo borrar. Fila vacia");
        return frente;
    }
    else{
        frente=frente->siguiente;
        free(aux);
        return frente;
    }
}

int ContarNodos(Nodo *frente){
    int numero=0;
    if(frente!=NULL){
        while(frente!=NULL){
            numero ++;
            frente=frente->siguiente;

        }

    }
    return numero;
}

Nodo *LeerArchivo(Nodo *frente){
    int num = 0;
    FILE *archivo=fopen("archivo.txt", "r");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
            }
            else {
            while(!feof(archivo)){
            fscanf(archivo, "%d ", &num);
            frente=AgregarNodo(frente,num);}
            }
            fclose(archivo);
            return frente;
}

void GuardarenArchivo(Nodo *frente){

    FILE *archivo = fopen("archivo.txt", "w");
            if(archivo==NULL){
                printf("Error al abrir el archivo");
        }
            else{
            while(frente!= NULL)
            {fprintf(archivo, "%d ", frente->dato);
            frente=frente->siguiente;}
    }
}


#endif // FILA_H_INCLUDED
